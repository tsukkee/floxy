using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Sockets;
using System.IO;
using System.Net;
using System.Threading;

namespace SwfServer
{
    class ObservableSocketServer
    {
        private int port = 30095;

        public int Port
        {
            get
            {
                return port;
            }
        }

        public IEnumerable<byte[]> Start()
        {
            Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

            socket.Bind(new IPEndPoint(IPAddress.Parse("127.0.0.1"), port));
            socket.Listen(5);

            while (true)
            {
                Socket client = socket.Accept();

                MemoryStream ms = new MemoryStream();

                byte[] buffer = new byte[16384];

                int byteCount = client.Receive(buffer);

                ms.Write(buffer, 0, byteCount);

                yield return ms.ToArray();
            }

            /*return Observable.FromAsyncPattern<Socket>(socket.BeginAccept, socket.EndAccept)()
                .SelectMany(x =>
                    {
                        Thread.Sleep(1000);

                        MemoryStream ms = new MemoryStream();

                        byte[] buffer = new byte[16384];

                        //socket.BeginReceive(buffer, 0, buffer.Length, SocketFlags.None, new AsyncCallback(a => { }), null);

                        return Observable.FromAsyncPattern<byte[], int, int, SocketFlags, int>(socket.BeginReceive, socket.EndReceive)(buffer, 0, buffer.Length, SocketFlags.None)
                            .Do(b => ms.Write(buffer, 0, b))
                            //.Repeat()
                            //.TakeWhile(_ => x.Connected)
                            //.TakeLast(1)
                            .Select(_ => ms.ToArray());
                    });
              */  
                
        }
    }
}
