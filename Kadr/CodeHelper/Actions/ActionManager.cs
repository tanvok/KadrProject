using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;

namespace APG.CodeHelper.Actions
{
    /// <summary>
    /// ��������� ������
    /// </summary>
    public interface IAction
    {
        /// <summary>
        /// ��������� �������
        /// </summary>
        /// <param name="sender">������, ��������� ���������</param>
        void Execute(object sender);

        /// <summary>
        /// �������� �������
        /// </summary>
        /// <param name="sender">������, ��������� ���������</param>
        void Rollback(object sender);

        /// <summary>
        /// ��������� ��� �������
        /// </summary>
        string ActionHint
        {
            get;
        }

        /// <summary>
        /// �������� ����� �� ����������� ������� ���� ��������
        /// </summary>
        bool CanBeRollbacked
        {
            get;
        }
    }

    /// <summary>
    /// �������� ������
    /// ���������� ������ ��� ���������� ����������� � ������� ������
    /// </summary>
    public class ActionManager
    {
        private Stack<IAction> executedActions = new Stack<IAction>();
        private Stack<IAction> rollbackedActions = new Stack<IAction>();

        public event EventHandler OnExecute;
        public event EventHandler OnRollback;

        /// <summary>
        /// ���� ����������� ������
        /// </summary>
        public Stack<IAction> Executed
        {
            get
            {
                return executedActions;
            }
        }

        /// <summary>
        /// ���� ��������� ������
        /// </summary>
        public Stack<IAction> Rollbacked
        {
            get
            {
                return rollbackedActions;
            }
        }

        
        /// <summary>
        /// ������ ������ �������� �������, 
        /// ��������� ������� � �������� ������ � ���� ����������� ������
        /// </summary>
        /// <param name="sender">������, ���������� ���������</param>
        /// <param name="actionType">����� �������, ��������� ������� ����� ������</param>
        /// <param name="actionParams">��������� ������������. 
        ///  ����� ���� null ��� ������ ������� ������������</param>
        public void Execute(object sender, System.Type actionType, params object[] actionParams)
        {
            IAction action = Activator.CreateInstance(actionType, actionParams) as IAction;
            action.Execute(sender);
            Executed.Push(action);
            OnExecute(this, new EventArgs());
        }

        /// <summary>
        /// �������� ��������� �������
        /// </summary>
        /// <param name="sender">������, ��������� ���������</param>
        public void Rollback(object sender)
        {
            if (Executed.Count != 0)
            {
                IAction action = Executed.Pop();
                action.Rollback(sender);
                Rollbacked.Push(action);
                OnRollback(this, new EventArgs());
            }
        }

        /// <summary>
        /// ��������� ��������� �������
        /// </summary>
        /// <param name="sender">������, ��������� ���������</param>
        public void Redo(object sender)
        {
            if (Rollbacked.Count != 0)
            {
                IAction action = Rollbacked.Pop();
                action.Execute(sender);
                Executed.Push(action);
                OnExecute(this, new EventArgs());
            }
        }
    }
}
