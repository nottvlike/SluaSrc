using UnityEngine;
using System.Collections;
using SLua;

public class Skynet : MonoBehaviour {

	LuaSvr svr;
	LuaTable self;
	LuaFunction update;
	void Start () {
		svr = new LuaSvr();
		svr.init(null, () =>
		         {
			self = (LuaTable)svr.start("skynet/main");
		},LuaSvrFlag.LSF_EXTLIB);
	}
}
