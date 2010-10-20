using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Diagnostics;

namespace SwfServer
{
    class Program
    {
        static void Main(string[] args)
        {
            ObservableSocketServer socketServer = new ObservableSocketServer();

            foreach (byte[] file in socketServer.Start())
            {
                Console.WriteLine("Data received at {0} ({1} bytes)", DateTime.Now, file.Length);

                string rawFilename = DateTime.Now.ToString("yyyyMMddhhmmss");

                File.WriteAllBytes(Path.ChangeExtension(rawFilename, ".swf"), file);

                ProcessStartInfo psi = new ProcessStartInfo()
                {
                    FileName = "swfdump.exe",
                    Arguments = "--full " + Path.ChangeExtension(rawFilename, ".swf"),

                    RedirectStandardError = true,
                    RedirectStandardOutput = true,
                    UseShellExecute = false
                };

                using (Process process = Process.Start(psi))
                {
                    string output = process.StandardOutput.ReadToEnd();

                    File.WriteAllText(Path.ChangeExtension(rawFilename, ".txt"), output);
                }
            }
        }
    }
}
