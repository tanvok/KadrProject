using System;
using System.Collections.Generic;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.Common;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace APG.CodeHelper.ExceptionHandler
{
    public class ExceptionHandler
    {
        private const string NotAllowedExceptionMessage = " ��� ������ �� ������ ����������� � �������. ������� ��������� ����� �� ������ ������������.";

        /// <summary>
        /// ���������� �������������� ��������
        /// </summary>
        /// <param name="e">����������</param>
        public static void HandleApplicationException(object sender, Exception e)
        {

            if (e is System.Data.SqlClient.SqlException)
            {
                HandleSqlClientException(sender, e as System.Data.SqlClient.SqlException);
                return;
            }

            if (e is NoNullAllowedException)
            {
                HandleNoNullAllowedException(e as NoNullAllowedException);
                return;
            }

            if (e is DataException)
            {
                HandleDataException(e as DataException);
                return;
            }

            if (e is ReadOnlyException)
            {
                HandleReadOnlyException(e as ReadOnlyException);
                return;
            }

            if (e is DBConcurrencyException)
            {
                HandleDBConcurrencyException(e as DBConcurrencyException);
                return;
            }

            if (e is DeletedRowInaccessibleException)
            {
                HandleDeletedRowInaccessibleException(e as DeletedRowInaccessibleException);
                return;
            }

            if (e is DuplicateNameException)
            {
                HandleDuplicateNameException(e as DuplicateNameException);
                return;
            }

            if (e is EvaluateException)
            {
                HandleEvaluateException(e as EvaluateException);
                return;
            }

            if (e is InRowChangingEventException)
            {
                HandleInRowChangingEventException(e as InRowChangingEventException);
                return;
            }

            if (e is InvalidConstraintException)
            {
                HandleInvalidConstraintException(e as InvalidConstraintException);
                return;
            }

            if (e is MissingPrimaryKeyException)
            {
                HandleMissingPrimaryKeyException(e as MissingPrimaryKeyException);
                return;
            }

            if (e is OperationAbortedException)
            {
                HandleOperationAbortedException(e as OperationAbortedException);
                return;
            }

            if (e is RowNotInTableException)
            {
                HandleRowNotInTableException(e as RowNotInTableException);
                return;
            }

            if (e is StrongTypingException)
            {
                HandleStrongTypingException(e as StrongTypingException);
                return;
            }

            if (e is SyntaxErrorException)
            {
                HandleSyntaxErrorException(e as SyntaxErrorException);
                return;
            }

            if (e is TypedDataSetGeneratorException)
            {
                HandleTypedDataSetGeneratorException(e as TypedDataSetGeneratorException);
                return;
            }

            if (e is VersionNotFoundException)
            {
                HandleVersionNotFoundException(e as VersionNotFoundException);
                return;
            }

            // System exceptions

            if (e is System.ArgumentException)
            {
                HandleArgumentException(e as ArgumentException);
                return;
            }

            if (e is ArgumentNullException)
            {
                HandlArgumentNullException(e as ArgumentNullException);
                return;
            }

            if (e is NullReferenceException)
            {
                HandleNullReferenceException(e as NullReferenceException);
                return;
            }


            if (e is System.ComponentModel.Win32Exception)
            {
                HandleWin32Exception(e as Win32Exception);
                return;
            }
            if (e is ApplicationException)
            {
                HandleApplicationException(e as ApplicationException);
            }

            // ��������� ����������� ����������
            HandleUnhandledException(e);
   
        }

        private static void HandleApplicationException(ApplicationException e)
        {
            ShowExceptionDialog(e, "��� �������������� �������� ������������� ����������� � ������� ����� �������� �� ������������� ��������� ���� ��������.", "��������������� ����������", MessageBoxIcon.Information, true);
        }

        private static void HandleUnhandledException(Exception e)
        {
            ShowExceptionDialog(e, "� ������� ��������� �������������� �������������� ��������. ���� ��� ������ ����� ����������� ���������� � ������������.", "�������������� ����������", MessageBoxIcon.Warning, true);
        }

        private static void HandleWin32Exception(Win32Exception win32Exception)
        {
            ShowExceptionDialog(win32Exception, "������ ��� ������� � ����� �� �������� ���������� Win32. ��������� �������� �� ��� ����������� ������ � ��������� �������.", "������ Win32", MessageBoxIcon.Exclamation, true);
        }

        private static void HandleNullReferenceException(NullReferenceException nullReferenceException)
        {
            ShowExceptionDialog(nullReferenceException, "������� ������� � ��������������������� (null) �������. " + NotAllowedExceptionMessage, "������������ ������", MessageBoxIcon.Information, true);
    
        }

        private static void HandlArgumentNullException(ArgumentNullException argumentNullException)
        {
            ShowExceptionDialog(argumentNullException, "����������� ������������ ������� (null) �������� ��������� ������ ������. " + NotAllowedExceptionMessage, "����������� ������", MessageBoxIcon.Information, true);
        }

        private static void HandleArgumentException(ArgumentException argumentException)
        {
            ShowExceptionDialog(argumentException, "������ � ����� ��� ���������� ���������� ������ ������. " + NotAllowedExceptionMessage, "����������� ������", MessageBoxIcon.Information, true);
        }

        private static void ShowExceptionDialog(Exception exception, string exceptionMessage, string aboutMessage, MessageBoxIcon messageBoxIcon, bool bShowSendButton, System.Type detailDialogType)
        {
            ExceptionDialog exceptionDialog = new ExceptionDialog(exception);
            exceptionDialog.DetailDialogType = detailDialogType;
            exceptionDialog.ExceptionMessage = exceptionMessage;
            exceptionDialog.AboutMessage = aboutMessage;
            exceptionDialog.MessageIcon = messageBoxIcon;
            exceptionDialog.Text = Application.ProductName;
            exceptionDialog.BtnRaport.Visible = bShowSendButton;

            exceptionDialog.ShowDialog();
        }

        private static void ShowExceptionDialog(Exception exception, string exceptionMessage, string aboutMessage, MessageBoxIcon messageBoxIcon, bool bShowSendButton)
        {
            ShowExceptionDialog(exception, exceptionMessage, aboutMessage, messageBoxIcon, 
                bShowSendButton, typeof(MoreExceptionDialog));
        }

        /// <summary>
        /// ���������� ���������� �� SQL Server 2005
        /// </summary>
        /// <param name="e"></param>
        private static void HandleSqlClientException(object sender, System.Data.SqlClient.SqlException e)
        {
            const int MSSQL_CONNECTION_ERROR = -1;
            const int MSSQL_SERVICE_STOPED = 2;
            const int MSSQL_SERVICE_PAUSED = 17142;
            const int MSSQL_CONSTRAINT_VIOLATED = 547;
            const int MSSQL_NULL_NOT_ALLOWED = 515;
            const int MSSQL_MSDTC_NOT_RUNNING = 8501;
            const int MSSQL_UNIQUE_VIOLATED = 2627;
            const int MSSQL_LOGIN_FAILED = 4060;
            const int MSSQL_FILE_ACCESS_DENIED = 5120;
            const int MSSQL_LOGIN_DENIED = 18456;
            const int MSSQL_CONNECTION_FAILED = 53;
            const int MSSQL_EXECUTE_TIMEOUT = 30;
            const int MSSQL_PERMISSION_DENIED = 229;
            const int MSSQL_CLR_DISABLED = 6263;

            string errorMessage = "�������������� ���������� �� ������ �����������.";
            
            switch (e.Number)
            {
                case MSSQL_CONNECTION_ERROR:
                    errorMessage = "������ ����������� � ������ SQL Server. ���������, ��� �� ��������� ������� ��� ������� � ��� ������ ��������� �����������. ���������� �� ������� � �������������� ��� ������."; break;
                case MSSQL_SERVICE_STOPED: 
                    errorMessage = "������ Microsoft SQL Server ����������� ��� ������� �������� ��� �������. ���������, ��� ������ �������� � ������� ������ ��� �������. ���������� �� ������� � �������������� ���� ������."; break;
                case MSSQL_SERVICE_PAUSED:
                    errorMessage = "������ Microsoft SQL Server �������������� ��� ���������� � ����� offline. ��������� ������ � ��������� �������. ���������� �� ������� � �������������� ��� ������."; break;
                case MSSQL_CONSTRAINT_VIOLATED:
                    errorMessage = "���������� ������� ���� �������� � ���������� ������������ �����������. ���� �� ��������� �������� ���������� ��� ��������� ������, �� ���������, ��� �� ��������� ��� ����������� ����, ������ ����� ���������� ������ � �������� � ���������� �������� ��������. �������� �������� ����� ���� �������� � ���������� ������� ����������� �� ������. ������� ��� ��������� ������ � ��������� ������� ��������."; break;
                case MSSQL_NULL_NOT_ALLOWED:
                    errorMessage = "���������� �������� ���� ��������, ��� ��� �� ������ �������� � ����� ��� ���������� ����������� � ���������� �����. ��������� ����������� ���� � ��������� ��������."; break;
                case MSSQL_MSDTC_NOT_RUNNING:
                    errorMessage = "������ ������������ ������������� ���������� �� ��������. �������������� ��������� ����������������� \"������\" (������ ���������� -> ����������������� -> ������) ��� �������."; break;
                case MSSQL_UNIQUE_VIOLATED:
                    errorMessage = "���������� �������� ���� �������� � ���������� ������������ ����������� �� ������������. ��� ������ ���������, ���� �� ��������� �������� � ������� ������, ���������� � ������� ��� ������������ � ���� ������. ��������� ������������ �������� � ��������� �������."; break;
                case MSSQL_LOGIN_FAILED:
                    errorMessage = "���������� � �������� �����������, �� ���� ������ �� ������� �����������. ��������, ��� ����� ��� ������ ���� ����������� �� �������. ��� ���������� ���� ������ ���������� � ��������������."; break;
                case MSSQL_FILE_ACCESS_DENIED:
                    errorMessage = "������ � ������ ��� ���� ������ ��������. �������� ����� ������� � ������ ��������� ��� ��� ��� ��������� ������� \"������ ��� ������\". ���� ������������ �������� ������� NTFS ��������� ����� ������� ��������������� ���� ��� ������� � ������. ���������� � �������������� �� �������."; break;
                case MSSQL_LOGIN_DENIED:
                    errorMessage = "��� �������� � ������� � ������ ��� ��������� ������. ��������, ��������� ������������� �� ��� ��� � ������ ������������� ������� ��� ������ ��� ��������� ������. ��� ������� �������� ���������� � ��������������."; break;
                case MSSQL_CONNECTION_FAILED:
                    errorMessage = "�� ������ ���������� ����� � �������� ��� ������ SQL Server. ���������, ��� �� ��������� ������� ��� ������� � ��� ������ ��������� �����������. ���������� �� ������� � �������������� ��� ������."; break;
                case MSSQL_EXECUTE_TIMEOUT:
                    errorMessage = "�������� ������ ����� ������� � ������ ������� � ����������. ��� ������ ����� ����������� ��� ������� �������� ������� ��� ���������� �������� ��� ������� ����������� �������� ���� ������. ���������� ������� ���� ������� �������� �� ���������. ��������� �������� �������� �� ������� � ��������� �������.";
                    break;
                case MSSQL_PERMISSION_DENIED:
                    errorMessage ="��� �������� � ������� � ������ �� �������� ���� ������. ��� ������� �������� ���������� � ���������� ��������������.";
                    break;
                case MSSQL_CLR_DISABLED:
                    errorMessage = "��� ������� ���� ������ �������� ������������� CLR. ��� ��������� ��������� CLR ����������� ����� 'clr enable' ��������� sp_configure. ������ �������������:\nsp_configure 'clr enabled', 1\nGO\nRECONFIGURE\nGO\n���������� �� ������� � ��������������.";
                    break;
            }
           
            ShowExceptionDialog(e, errorMessage, "Microsoft SQL Server", MessageBoxIcon.Information, true);
        }

        // ���������� ���������� ������ ������� � �������� ������ ������ ������
        private static void HandleVersionNotFoundException(VersionNotFoundException versionNotFoundException)
        {
            ShowExceptionDialog(versionNotFoundException, NotAllowedExceptionMessage, "����������� ������", MessageBoxIcon.Information, true);
        }

        
        // ���������� ���������� ��������� ��� � ������-�������������� ������ ������
        private static void HandleTypedDataSetGeneratorException(TypedDataSetGeneratorException typedDataSetGeneratorException)
        {
            ShowExceptionDialog(typedDataSetGeneratorException, "�������� ��� �������� � ������-�������������� ������ ������. " + NotAllowedExceptionMessage, "����������� ������", MessageBoxIcon.Information, true);
        }

        // ���������� ���������� �������������� ������ � ����������� ���������
        private static void HandleSyntaxErrorException(SyntaxErrorException syntaxErrorException)
        {
            ShowExceptionDialog(syntaxErrorException, "�������������� ������ � ����������� ���� ������ ������. " + NotAllowedExceptionMessage, "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }

        //���������� ���������� ������-��������������� ������ ������ ��� ������� ������� � DBNull
        private static void HandleStrongTypingException(StrongTypingException strongTypingException)
        {
            ShowExceptionDialog(strongTypingException, "������ � ������-�������������� ������ ������. " + NotAllowedExceptionMessage, "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }

        // ���������� ���������� ������� � ������, ������������� � ������ ������
        private static void HandleRowNotInTableException(RowNotInTableException rowNotInTableException)
        {
            ShowExceptionDialog(rowNotInTableException, "���� ������� ������� � ������ ������ � �������, ������� �� �� �����������. " + NotAllowedExceptionMessage, "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }

        // ���������� ���������� ����������� ������� ������ ��� ������
        private static void HandleReadOnlyException(ReadOnlyException readOnlyException)
        {
            ShowExceptionDialog(readOnlyException, "������� ����������� ����, �� ���������������� ��� ��������� ���� ��������. " + NotAllowedExceptionMessage, "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }

        //���������� ���������� ������ ��������
        private static void HandleOperationAbortedException(OperationAbortedException operationAbortedException)
        {
            ShowExceptionDialog(operationAbortedException, "�������� ���� ��������.", "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }

        // ���������� ���������� �������������� ������� NULL
        private static void HandleNoNullAllowedException(NoNullAllowedException noNullAllowedException)
        {
            ShowExceptionDialog(noNullAllowedException, "���������� �������� ���� ��������, ��� ��� �� ������ �������� � ����� ��� ���������� ����������� � ���������� �����. ��������� ����������� ���� � ��������� ��������.", "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }

        // ���������� ���������� ������� � ������� ��� ���������� �����
        private static void HandleMissingPrimaryKeyException(MissingPrimaryKeyException missingPrimaryKeyException)
        {
            ShowExceptionDialog(missingPrimaryKeyException, "� ������ ������ ����������� ��������� ����. " + NotAllowedExceptionMessage, "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }

        // ���������� ���������� ������������� ��������� ��� ������������� �����������
        private static void HandleInvalidConstraintException(InvalidConstraintException invalidConstraintException)
        {
            ShowExceptionDialog(invalidConstraintException, "������ ��� ���������� ��� ������������� ����������� � ������ ������. " + NotAllowedExceptionMessage, "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }

        // ���������� ���������� ������ ������ EndEdit
        private static void HandleInRowChangingEventException(InRowChangingEventException inRowChangingEventException)
        {
            ShowExceptionDialog(inRowChangingEventException, "��������� ������ ��� ������ ������ EndEdit(). " + NotAllowedExceptionMessage, "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }


        // ���������� ���������� ������ ���������� ��������� � ����������� ���� ������ ������
        private static void HandleEvaluateException(EvaluateException evaluateException)
        {
            ShowExceptionDialog(evaluateException, "������ ���������� ��������� � ���� ������� ������ ������. " + NotAllowedExceptionMessage, "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }

        // ���������� ���������� ������������� ��� � ������ ������
        private static void HandleDuplicateNameException(DuplicateNameException duplicateNameException)
        {
            ShowExceptionDialog(duplicateNameException, "������ ������� �������� ������������� ��� �������� � ������ ������. " + NotAllowedExceptionMessage, "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }


        //���������� ���������� ������� � �������� ������ ������ (DataRow)
        private static void HandleDeletedRowInaccessibleException(DeletedRowInaccessibleException deletedRowInaccessibleException)
        {
            ShowExceptionDialog(deletedRowInaccessibleException, "������ ������� � ������ ������ �������, ������� ���� �� �� ���������. " + NotAllowedExceptionMessage, "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }

        // ���������� ���������� ��������, ���� �������� Insert, Update, Delete ������� 0 ������������ �����
        private static void HandleDBConcurrencyException(DBConcurrencyException dBConcurrencyException)
        {
            ShowExceptionDialog(dBConcurrencyException, "���������� ��������� �������� ��� ��� ��� ������ ���� �������������� ����� ����������� ��������������. �������� ���������� ���� ��� �������� ��������� ������ ������ � ��������� ������� �����������.", "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }

        // ���������� ���������� ADO.NET
        private static void HandleDataException(DataException dataException)
        {
            ShowExceptionDialog(dataException, "��� ������ �����������, ���� ������������ �������� �� ��� ������ ���� �����, ���� ��� ������������ ��� ���� ��������. ��������� ������������ �������� � ��������� ������� ����� ������.", "����������� ���� ������ ��������", MessageBoxIcon.Information, true);
        }

    }
}
