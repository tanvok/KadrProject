using System;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Soap;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Net.Mail;
using System.Net;

namespace APG.CodeHelper.ExceptionHandler
{
    /// <summary>
    /// 
    /// </summary>
    class ObjectStream
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static MemoryStream SerializeObjectToXML(Exception obj)
        {
            MemoryStream stream = null;
            
            // ��������� �������� �� obj �������������
            stream = new MemoryStream();                
            if (IsSerializable(obj))
            {
                IFormatter formatter = new SoapFormatter();
                formatter.Serialize(stream, obj);
            }
            else
            {
                foreach (char c in obj.Message)
                    stream.WriteByte((byte)c);
            }

            return stream;   
        }

        private static bool IsSerializable(object obj)
        {

            return (obj != null) ? obj.GetType().IsSerializable : false;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    public class LogException
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="e"></param>
        /// <returns></returns>
        public static string LogExceptionToFile(Exception e)
        {
            //���������� ������� ���� � �����
            DateTime et = DateTime.Now;
            //� ���������� LocalSetting\ApplicationData �������� ������������ �������� ����� ISGB
            string path = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData) + "\\ISGB";
            Directory.CreateDirectory(path);
            //�������� �������� ����� (ISGB-����.�����.��� ���.������.�������-LOG.XML) 
            string FileName = path + string.Format("\\{0}-{1}.{2}.{3} {4}.{5}.{6}-LOG.XML",
            AppDomain.CurrentDomain.FriendlyName, et.Day, et.Month, et.Year, et.Hour, et.Minute, et.Second);
            //�������� ������ ������        
            FileStream fs = new FileStream(FileName, FileMode.CreateNew);            
            Stream stream = ObjectStream.SerializeObjectToXML(e);
            byte[] buff = new byte[stream.Length];                        
            stream.Position = 0;
            stream.Read(buff, 0, (int)stream.Length);
            fs.Position = 0;
            fs.Write(buff, 0, (int)stream.Length);
            fs.Close();
            
            return FileName;
        }

        /// <summary>
        /// �������� ����� �� ������ ����� ������ Outlook
        /// </summary>
        /// <param name="LogFileName">���� �������� � ������� �� ������</param>
        public static void SendFileToEmail(string LogFileName)
        {
            /* --- ���������� � TEMP ������� ------*/
            string tempPath = Environment.GetEnvironmentVariable("TEMP")+"\\";
            
            
            //�������� ��� �����
            string ZipFileName = tempPath+LogFileName.Remove(0, LogFileName.LastIndexOf("\\")+1);
            ZipFileName = ZipFileName.Substring(0, ZipFileName.LastIndexOf('.'))+".ZIP";

            // ��������� �����
            APG.CodeHelper.CompressionHelper.CompressFile(LogFileName, ZipFileName);

            const string messageBody = "��� ������ �������� ���������� �� �������������� ��������, ��������� ��� ���������� ����������";
            const string messageSubj =  "����� �� ������";
            

            try
            {
                APG.CodeHelper.MAPIHelper.SendMAPIMessage(ZipFileName, ZipFileName, messageBody, messageSubj, "support@ist.ugtu.net");
            }
            finally
            {
                File.Delete(ZipFileName);
            }

        }
      
    }

}
