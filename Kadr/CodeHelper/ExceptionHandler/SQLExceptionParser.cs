using System;
using System.Collections.Generic;
using System.Text;

/*
 * SQL Server ������ ���, ��� ��� ��������� � ����������� ������������ ������� 
 * � ���������������� ��������� �����. ��������:
 * 
 *  (ErrCode: 547) The DELETE statement conflicted with the REFERENCE constraint "FK_Visa_DaylyReport". 
 *  The conflict occurred in database "ISGBDB", table "dbo.Visa", column 'DailyReportID'.
 * 
 *  (ErrCode: 547) The INSERT statement conflicted with the FOREIGN KEY SAME TABLE constraint "FK_TVNode_TVNode". 
 *  The conflict occurred in database "AjaxTV", table "dbo.TVNode", column 'ID'.
 * 
 *  (ErrCode: 547) The UPDATE statement conflicted with the CHECK constraint "CK_Income". 
 *  The conflict occurred in database "ISGBDB", table "dbo.Income", column 'Count'.
 *
 * ����� SQL2005ExceptionParser ������������ ��� 
 * ��������� �� ������ ���������� ������ � ����������� ������������� �����������.
 * ����� ������������� ��� �����, ����������� ���������, �.�. �� ������� ������ �������
 * ������ ������ SQL2005ExceptionParser, ������ �������� SqlExceptionToParse, ������� �����
 * Parse().
 */

namespace APG.CodeHelper.ExceptionHandler
{
    
    /// <summary>
    /// ����� ��������������� ������� ���������� SQL Server 2005
    /// </summary>
    public class SQL2005ExceptionParser
    {
        /// <summary>
        /// ����� ��� �������� �������������� ����������� �� ������� ��
        /// </summary>
        public class Constraint
        {

            private ConstraintExceptionType constraintType = ConstraintExceptionType.UnknownConstraintException;
            private string constraintName = "";

            /// <summary>
            /// ��� �������������� ����������� �� ������� ��
            /// </summary>
            public enum ConstraintExceptionType
            {
                UniqueConstraintException,
                ForeignKeyConstraintException,
                PrimaryKeyConstraintException,
                UnknownConstraintException
            }

            /// <summary>
            /// ���������� ��� ������������ �������������� �����������
            /// </summary>
            public ConstraintExceptionType ConstraintType
            {
                get
                {
                    return constraintType;
                }
            }

            /// <summary>
            /// ���������� ������ ���������� �� SQL Server 2005
            /// </summary>
            /// <param name="e">��������� ������ � ���������� SQL Server 2005</param>
            /// <returns>������, ���� ������ ���������� ������. 
            /// � ��������� ������ ������������ ����, �������� �������� ConstaintType 
            /// ��������������� ��� ConstraintExceptionType.UnknownConstraintException. �������� �������� ConstraintName �� ����������.</returns>
            public bool ParseConstraint(System.Data.SqlClient.SqlException e)
            {
                constraintName = "";
                return true;
            }

            /// <summary>
            /// ���������� ��� ������������ �������������� �����������
            /// </summary>
            public string ConstraintName
            {
                get
                {
                    return constraintName;
                }
            }
        }

        private System.Data.SqlClient.SqlException sqlExceptionToParse;
        private string messageToParse;
        
        private string tableName;

        private Constraint exceptionConstraint = new Constraint();

        private string databaseName;

        private string columnName;

        private bool isParsed = false;

        private SqlCommandType commandType = SqlCommandType.SqlUnknownCommand;

        /// <summary>
        /// ��������� ��� �������, ������� ������� � ������� ����������
        /// </summary>
        public enum SqlCommandType
        {
            SqlInsertCommand,
            SqlDeleteCommand,
            SqlUpdateCommand,
            SqlUnknownCommand
        }

        /// <summary>
        /// ���������� ������� ��, � ������� ������� ����������
        /// </summary>
        public string TableName
        { 
            get
            {
                return tableName;
            }
        }

        /// <summary>
        /// ������������� ��� ���������� ������-��������� ��� �������� ���������� ������
        /// </summary>
        public System.Data.SqlClient.SqlException SqlExceptionToParse
        {
            get { return sqlExceptionToParse; }
            set 
            { 
                sqlExceptionToParse = value;
                tableName = "";
                columnName = "";
                databaseName = "";

                if (sqlExceptionToParse != null)
                    messageToParse = sqlExceptionToParse.Message;


            }
        }

        /// <summary>
        /// ���������� �������� �������������� �����������
        /// </summary>
        public Constraint ExceptionConstraint
        {
            get
            {
                return exceptionConstraint;
            }
        }

        /// <summary>
        ///  ���������� ��� ���� ������, ��������� � ������������� ������������
        /// </summary>
        public string DatabaseName
        {
            get
            {
                return databaseName;
            }
        }
        /// <summary>
        /// ���������� ��� �������, ��������� � ������������� ������������
        /// </summary>
        public string ColumnName
        {
            get
            {
                return columnName;
            }
        }

        /// <summary>
        /// ���������� ������, ���� ��������� ����� ������ Parse ��� ��������
        /// </summary>
        public bool IsParsed
        {
            get
            {
                return isParsed;
            }
        }

        private enum ParsingState
        {
            InitParsingState,
            ParsedParsingState,
            CheckParsingSuperstate,
            ActionParsedState,
            UnParsedParsingState

        }

        ParsingState parsingState;
        
        /// <summary>
        /// ���������� ������ ���������� ��� ��������� ������ � ����������� �����������
        /// </summary>
        /// <returns>������, ���� ������ ��������� �������</returns>
        public bool Parse()
        {
            isParsed = false;
            parsingState = ParsingState.InitParsingState;

            if (SqlExceptionToParse == null)
                throw new ArgumentException("SqlExceptionToParse �� �����.");

            while ((parsingState != ParsingState.ParsedParsingState) || (parsingState != ParsingState.UnParsedParsingState))
            {
                switch (parsingState)
                {
                    case ParsingState.InitParsingState:
                        InitParsingStateParse(); 
                        break;
                    case ParsingState.CheckParsingSuperstate:
                        CheckParsingSupersateParse();
                        break;

                }
            }
            return isParsed;
        }

        
        private void CheckParsingSupersateParse()
        {
            string[] actions = new string[3]{ "INSERT", "DELETE", "UPDATE" };    
            string actionTemplate = "The {0} statement conflicted with the";
            string action;
            parsingState = ParsingState.UnParsedParsingState;

            for (int i = 0; i < actions.Length; i++)
            {
                action = string.Format(actionTemplate, actions[i]);
                if (messageToParse.IndexOf(action, 0) != -1)
                {
                    parsingState = ParsingState.ActionParsedState;
                    commandType = (SqlCommandType)i;
                    break;
                }
            }
        }

        private void InitParsingStateParse()
        {
            if (SqlExceptionToParse.ErrorCode == 547)
            {
                parsingState = ParsingState.CheckParsingSuperstate;
            }
            else
                parsingState = ParsingState.UnParsedParsingState;

        }
        
    }
}
