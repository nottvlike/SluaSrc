using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Net;
using System.Threading;
using System.Net.Sockets;
using SLua;

public class TcpSocket : MonoBehaviour {

	const int CACHE_SIZE = 4069;
	const int WAIT_OUT_TIME = 5000;

	List<string> _messageList = new List<string> ();

	Thread _recvThread;
	Socket _socket;
	string _ip;
	int _port;
	LuaFunction _recvCallback;

	void Destroy()
	{
		_recvThread.Abort ();
	}

	public void Init(string ip, int port, LuaFunction recvCallback)
	{
		_ip = ip;
		_port = port;
		_recvCallback = recvCallback;

		_socket = new Socket (AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
	}

	public void Connect()
	{
		IPAddress address = IPAddress.Parse (_ip);
		IPEndPoint ipEnterPoint = new IPEndPoint (address, _port);
		IAsyncResult result = _socket.BeginConnect(ipEnterPoint, new AsyncCallback(ConnectSuccess), _socket);

		bool success = result.AsyncWaitHandle.WaitOne (WAIT_OUT_TIME, true);
		if (!success)
		{
			Debug.LogWarning(string.Format ("Connect to {0}:{1} Failed!", _ip, _port));
			Close();
		}
		else
		{
			_recvThread = new Thread(new ThreadStart(Receive));
			_recvThread.IsBackground = true;
			_recvThread.Start();
		}
	}

	void Receive()
	{
		while (true) 
		{
			if (!_socket.Connected)
			{
				_socket.Close();
				break;
			}

			try
			{
				Byte[] bytes = new Byte[CACHE_SIZE];
				int length = _socket.Receive(bytes);

				if (length <= 0)
				{
					_socket.Close();
					break;
				}
				if (length > 2)
				{
					UpackPackage(bytes, 0);
				}
				else
				{
					Debug.LogWarning("Reveive Bytes is not larger than 2!");
				}
			}
			catch
			{
				Debug.Log ("Receive Msg Error!");
			}
		}
	}

	void UpackPackage(Byte[] bytes, int index)
	{
		while (true) {
			Byte[] head = new Byte[2];
			int headLengthIndex = index + 2;
			//Array.Copy (bytes, index, head, 0, 2);
			head[0] = bytes[index+1];
			head[1] = bytes[index];
			short length = BitConverter.ToInt16(head, 0);
			if (length > 0)
			{
				Byte[] data = new Byte[length+2];
				Array.Copy (bytes, headLengthIndex, data, 0, length+2);
				lock (_messageList)
				{
					// Access thread-sensitive resources.
					_messageList.Add (System.Text.Encoding.ASCII.GetString(data));
				}
				index = headLengthIndex + length;
			}
			else
			{
				break;
			}
		}
	}

	public void Send(string str)
	{
		Byte[] msg = System.Text.Encoding.UTF8.GetBytes (str);

		if (!_socket.Connected) 
		{
			_socket.Close();
			return;			
		}

		try
		{
			IAsyncResult result = _socket.BeginSend(msg, 0, msg.Length, SocketFlags.None, new AsyncCallback(SendCallback), _socket);
			bool success = result.AsyncWaitHandle.WaitOne(WAIT_OUT_TIME, true);
			if(!success)
			{
				_socket.Close();
				Debug.Log (string.Format("Send Msg Failed {0} !", str));
			}
		}
		catch
		{
			Debug.Log("send message error" ); 
		}
	}

	void SendCallback(IAsyncResult result)
	{
		//Debug.Log ("Send MSG Success!");
	}

	public void Close()
	{
		if (_socket != null && _socket.Connected) 
		{
			lock (_messageList)
			{
				_messageList.Clear();
			}

			_socket.Shutdown(SocketShutdown.Both);
			_socket.Close();
		}
		_socket = null;
	}

	void ConnectSuccess(IAsyncResult result)
	{
		//Debug.Log ("Connect Success!");
	}

	void Update()
	{
		lock (_messageList)
		{
			if (_messageList.Count > 0) 
			{
				string data = _messageList[0];
				_recvCallback.call(data);
				_messageList.RemoveAt(0);
			}
		}
	}
}
