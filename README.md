#slua-skynet

最近想写一个skynet的客户端socket模块，原本的设想是这样的

*	添加slua对于lua5.3的支持
*	将skynet中的lualib和skynet-src中的代码以so的形式给lua调用，就像skynet那样处理

不过后来发现使用unity的话，这样处理有一个问题，就是unity中的lua如何调用so文件，unity中的lua文件互相调用(require)其实如果使用了Resources目录，就是使用Resources.Load<TextAsset>来加载的，如果放在SteamAssetPath里面的话，则是使用自己实现的方式加载（看看OpenWorldGame里面有，使用了FileManager.cs来读取SteamAssetPath里面的文件），如果想支持so文件读取的话，我得实现读取txt资源和读取so资源，我暂时不想搞那么麻烦。

所以我现在将lua5.3 + lualib + skynet-src + lpeg的所有代码都打进了一个slua库中了，我只实现了android(x86和armeabi-v7a)和macos（slua.bundle）这两个平台，并且只测试了mac平台，还好slua作者添加了lua5.3的支持，所以过程并不复杂，下面讲些细节吧。

在build文件夹里，有两个脚本需要注意

*	make_osx.sh 编译mac平台下的slua.bundle脚本
*	skynet_build_android.sh 编译android平台的库

在build文件夹里，我加了个skynet文件夹，里面有三个子文件夹

*	jni : 主要是用来编译android平台的，编译时会将上级目录的slua.c拷贝进来
*	skynet : 我自己fork的云大的skynet的submodule
*	slua : mac工程，添加了云大的skynet的源代码和slua.c

云大的源代码我并没有全部加进去，只加了大部分，主要有这几个

*	3rd/lpeg
*	3rd/lua :  排除lua.c和luac.c文件
*	lualib-src :
*	skynet-src : 排除skynet_main.c文件，添加了NOUSE_JEMALLOC宏定义

lualib里面的代码需要先注册才能够使用，注册的代码都在build/slua.c文件中

	int
	luaopen_sproto_core(lua_State *L);
	int luaopen_lpeg (lua_State *L);
	
	static const luaL_Reg s_lib_preload[] = {	
	        {"sproto.core", luaopen_sproto_core},
	        { "lpeg", luaopen_lpeg },
			// { "pb",    luaopen_pb }, // any 3rd lualibs added here
			{ NULL, NULL }
	};
lualib里面都没得头文件，所以我先定义了一下，让后再放进s_lib_preload里面（这里我只导出了sproto.core和lpeg两个库（其实我想到出clientsocket库的，结果无法运行，一注册就奔溃，应该是pthread那一块，具体不好查）。

我在slua的example里面加了一个Skynet的sample，把云大的sproto相关的代码放进去了，自己加了个main.txt，代码如下：

	if _VERSION ~= "Lua 5.3" then
		error "Use lua 5.3"
	end

	local sproto = require 'skynet.sproto'
	local proto = require 'skynet.proto'
	local host = sproto.new(proto.s2c):host "package"
	local request = host:attach(sproto.new(proto.c2s))
	local str = request("set", { what = "hello", value = "world" }, 1)
	print(str)
	
最后，其实原本是想能不改skynet的话，就不改，不过最后还是在skynet中添加了几个android.mk文件。云大的skynet是以submodule的方式放在build/skynet里面的，所以记得用submodule下载一下，我对于submodule也不熟，不过进入到build/skynet/skynet里，这样应该可以：
	
	git submodule update --init --recursive 
	
好吧，还有点忘说了，需要在unity中添加LUA_5_3宏来使slua支持lua5.3
