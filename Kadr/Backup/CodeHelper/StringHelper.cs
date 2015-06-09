using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

namespace APG.CodeHelper
{
    /// <summary>
    /// ��������������� ����� ������ �� ��������
    /// </summary>
    public class StringHelper
    {
        /// <summary>
        /// ����������� ��� ��������
        /// </summary>
        /// <param name="humanName">���</param>
        /// <returns>��������������� ���</returns>
        public static string CorrectHumanName(string humanName)
        {
            string result = "";

            if (humanName != "")
            {
                result += char.ToUpper(humanName[0]);

                for (int i = 1; i < humanName.Length; i++)
                {
                    result += char.ToLower(humanName[i]);
                }
            }
            if (result.Trim()=="") throw new ApplicationException();
            else return result;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="incorrectString"></param>
        /// <returns></returns>
        public static string CorrectCase(string incorrectString)
        {
            string result = "";

            if (incorrectString != "")
            {
                result += char.ToUpper(incorrectString[0]);

                for (int i = 1; i < incorrectString.Length; i++)
                {
                    result += incorrectString[i];
                }
            }
            return result;
        }

        /// <summary>
        /// ������� ������������ ������� ���� � ������, ������� �� �� ��������
        /// </summary>
        /// <param name="incorrectFileName"></param>
        /// <returns></returns>
        public static string CorrectFileName(string incorrectFileName, string substStr)
        {
            
            const string pattern = "\\\x2F|\\\x3C|\\\x3E|\\\\|\\\x3F|\\\x3A|\\\x2A|\\\"|\\\x7C";
            return Regex.Replace(incorrectFileName, pattern, substStr);            
        }

        /// <summary>
        /// ������� ������� �� ������ ������������� ���� ������ ���� ����� "\" 
        /// � ��������� � ����� ������ "\", ���� �� ��� �����������. ���������� ���������� ���� � ������� 
        /// UNC (������ ���������� � "\\")
        /// </summary>
        /// <param name="incorrectPath">����</param>
        /// <returns></returns>
        public static string CorrectPath(string incorrectPath)
        {
            string pattern = "\\\\{2,}|(?<tail>[^\\\\]$)";

            Uri uri = new Uri(incorrectPath);
            
            if (uri.IsUnc) 
                pattern = "(?<tail>[^\\\\]$)";    
            
            return Regex.Replace(incorrectPath, pattern, "${tail}\\");   
            
        }
    }
}
