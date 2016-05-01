using UnityEngine;
using System.Collections;
using SLua;

public class Skynet : MonoBehaviour {

	public TcpSocket MySocket;
	LuaSvr svr;
	LuaTable self;
	LuaFunction dispatch;
	void Start () {
		svr = new LuaSvr();
		svr.init(null, () =>
		         {
			self = (LuaTable)svr.start("skynet/main");
		},LuaSvrFlag.LSF_EXTLIB);
	}
}
