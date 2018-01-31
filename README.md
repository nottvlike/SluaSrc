#slua-skynet

slua-skynet是针对skynet服务器框架写的unity3d客户端lua库。

对于slua的更改：

1, 仅使用skynet的lua库，删除了其它所有的lua库，skynet服务器和客户端共用一套lua库代码。

2，构建系统更改为cmake，mac平台依旧使用xcode工程，几大平台的测试情况：
*	android：已测试
*	windows: 已测试
*	macosx : 已测试
*	ios    : 未测试(我没有ios开发者账号)

3，在build/slua.c文件中注册了sproto和lpeg库

	int
	luaopen_sproto_core(lua_State *L);
	int luaopen_lpeg (lua_State *L);
	
	static const luaL_Reg s_lib_preload[] = {	
	        {"sproto.core", luaopen_sproto_core},
	        { "lpeg", luaopen_lpeg },
			// { "pb",    luaopen_pb }, // any 3rd lualibs added here
			{ NULL, NULL }
	};
	
对于skynet的更改：

1，lua库添加的代码：

*	3rd/lpeg
*	3rd/lua :  排除lua.c和luac.c文件
*	lualib-src : 


TODO：
*	cmake构建系统里，MAC的宏可以不要的，因为现在是用的xcode工程打的bundle包，没用cmake那一套；
*	skynet的submodule版本不对，我更改cmake构建系统的那个版本应该没上传，好吧，疏忽了，才发现。

##关于编译

在windows平台，我使用推荐设置的tdm-gcc来实行.bat脚本，你可以在[这里](http://tdm-gcc.tdragon.net/)下载到相关的编译器。

当然你也可以使用msys2来执行.sh脚本，你可以在[这里](http://msys2.github.io/)下载到相关的软件，目前应该还有些坑未填。对于msys的配置，你也可以参考下我的[文章](http://www.cnblogs.com/nottvlike/articles/5787142.html)。


##2018.1.31更新：

近期清理github时，失误清理了自己fork出来的skynet库，好在自己电脑上还有备份，看了看发现自己基本没改过skynet代码，后来还是决定清理了，我对于skynet的改动只有两个地方：

*   添加skynet的cmake打包配置；

*   更改了luaconf.h文件，加了这一句：

        #define lua_getlocaledecpoint()		"."
