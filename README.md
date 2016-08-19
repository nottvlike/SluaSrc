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


	
	
	
