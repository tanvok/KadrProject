using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;

namespace APG.CodeHelper.ContextMenuHelper
{
    public class ContextMenuBuilder
    {
        private object receiver;
        private System.Windows.Forms.ToolStripItem ownerToolStripItem;
        private System.Windows.Forms.ContextMenuStrip contextMenuStrip;
        private System.Windows.Forms.ToolStripItemCollection toolStripItemCollection;

        private object userData;
        
        /// <summary>
        /// �������� ��� ������������� ���������������� ������ 
        /// </summary>
        public object UserData
        {
            get { return userData; }
            set { userData = value; }
        }
        

        /// <summary>
        /// �������� ��� ������������� ��������� ��������� ����, ���� ����� ��������� ����� ��������
        /// </summary>
        public System.Windows.Forms.ToolStripItemCollection ToolStripItemCollection
        {
            get { return toolStripItemCollection; }
            set { toolStripItemCollection = value; }
        }

        /// <summary>
        ///  �������� ��� ������������� ����������� ����
        /// </summary>
        public System.Windows.Forms.ContextMenuStrip ContextMenuStrip
        {
            get { return contextMenuStrip; }
            set { contextMenuStrip = value; }
        }
        /// <summary>
        /// �������� ��� ������������� ������������ ������� ToolStripItem
        /// </summary>
        public System.Windows.Forms.ToolStripItem OwnerToolStripItem
        {
            get { return ownerToolStripItem; }
            set { ownerToolStripItem = value; }
        }

        /// <summary>
        /// �������� ��� ������������� ������ ������ � ��������-�������������
        /// </summary>
        public object Receiver
        {
            get { return receiver; }
            set { receiver = value; }
        }

        /// <summary>
        /// ������ ����� ��������� ������ ContextMenuBuilder
        /// </summary>
        /// <param name="contextMenuStrip">����������� ����, ���� ����� ��������� ��������</param>
        /// <param name="receiver">������-���������� ��������� ������ ��������� ����</param>
        /// <param name="ownerToolStripItem">������������ ������� ���� ���� ����� ��������� ��������</param>
        public ContextMenuBuilder(System.Windows.Forms.ContextMenuStrip contextMenuStrip, object receiver, System.Windows.Forms.ToolStripItem ownerToolStripItem)
        {
            InitInstance(contextMenuStrip, receiver, ownerToolStripItem);
        }

        /// <summary>
        /// ������ ����� ��������� ������ ContextMenuBuilder
        /// </summary>
        /// <param name="contextMenuStrip">����������� ����, ���� ����� ��������� ��������</param>
        /// <param name="receiver">������-���������� ��������� ������ ��������� ����</param>
        public ContextMenuBuilder(System.Windows.Forms.ContextMenuStrip contextMenuStrip, object receiver)
        {
            InitInstance(contextMenuStrip, receiver, null);
        }

        /// <summary>
        /// ������ ����� ��������� ������ ContextMenuBuilder
        /// </summary>
        /// <param name="toolStripItemCollection">��������� ��������� ����, ���� ����� ����������� ����� ��������</param>
        /// <param name="receiver">������-���������� ��������� ������ ��������� ����</param>
        public ContextMenuBuilder(System.Windows.Forms.ToolStripItemCollection toolStripItemCollection, object receiver)
        {
            this.ToolStripItemCollection = toolStripItemCollection;
            this.Receiver = receiver;
        }

        private void InitInstance(System.Windows.Forms.ContextMenuStrip contextMenuStrip, object receiver, System.Windows.Forms.ToolStripItem ownerToolStripItem)
        {
            this.ContextMenuStrip = contextMenuStrip;
            this.Receiver = receiver;
            this.OwnerToolStripItem = ownerToolStripItem;
        }

        public void PopupMenu(System.Windows.Forms.Control parent, int X, int Y)
        {

            CheckArguments();
                
            System.Windows.Forms.ToolStripItemCollection itemCollection;
            
            if (OwnerToolStripItem == null) 
                itemCollection = ContextMenuStrip.Items;
            else
                itemCollection = ((System.Windows.Forms.ToolStripMenuItem)OwnerToolStripItem).DropDownItems;

            if (itemCollection == null)
               throw new NullReferenceException("��������� ��������� ���� �� ����������������.");

            BuildItemCollection(itemCollection);

            ContextMenuStrip.Show(parent, new System.Drawing.Point(X, Y));
        }

        /// <summary>
        /// ��������� ��������� ���������� ����������
        /// </summary>
        public void BuildToolStripItemCollection()
        {
            BuildItemCollection(toolStripItemCollection);
        }


        private void BuildItemCollection(System.Windows.Forms.ToolStripItemCollection itemCollection)
        {
            ContextMenuMethodAttribute[] menuAttributes;
            System.Windows.Forms.ToolStripMenuItem tsmItem;
            
            if (Receiver == null) return;

            MemberInfo[] members = Receiver.GetType().FindMembers(MemberTypes.Method, BindingFlags.Public | BindingFlags.Instance | BindingFlags.NonPublic, new MemberFilter(MethodFilter), null);
            
            itemCollection.Clear();

            foreach (MethodInfo methodInfo in members)
            {
                menuAttributes = (ContextMenuMethodAttribute[])methodInfo.GetCustomAttributes(typeof(ContextMenuMethodAttribute), false);

                if (menuAttributes.Length == 1)
                {
                    if (menuAttributes[0].InsertSeparator)
                    {
                        InsertSeparator(itemCollection);
                    }
                    MenuCommand command = new MenuCommand(Receiver, methodInfo);
                    EventHandler clickHandler = new EventHandler(command.Execute);

                    tsmItem = new System.Windows.Forms.ToolStripMenuItem(menuAttributes[0].ItemCaption);
                    tsmItem.Enabled = menuAttributes[0].ItemEnabled;
                    tsmItem.ImageIndex = menuAttributes[0].ItemImageIndex;
                    tsmItem.Click += clickHandler;
                    if (menuAttributes[0].DefaultItem)
                        tsmItem.Font = new System.Drawing.Font(tsmItem.Font.FontFamily, tsmItem.Font.SizeInPoints, System.Drawing.FontStyle.Bold);

                    itemCollection.Add(tsmItem);
                }
            }
        }

        private void InsertSeparator(System.Windows.Forms.ToolStripItemCollection itemCollection)
        {
            System.Windows.Forms.ToolStripSeparator tss = new System.Windows.Forms.ToolStripSeparator();
            itemCollection.Add(tss);
        }

        private void CheckArguments()
        {
            string InvalidParam = "";
            if (ContextMenuStrip == null)
                InvalidParam = "ContextMenuStrip";
            if (Receiver == null)
                InvalidParam += " Receiver";
            if (InvalidParam != "")
                throw new ArgumentNullException(InvalidParam.TrimStart(), "���� ��������� ���������� �� ������.");
        }

        private bool MethodFilter(MemberInfo member, object criteria)
        {
            
            bool bInclude = false;
            MethodInfo method = member as MethodInfo;

            if (method != null)
            {
                if (method.ReturnType == typeof(void))
                {
                    ParameterInfo[] param = method.GetParameters();
                    if (param.Length == 1)
                    {
                        if (param[0].ParameterType == typeof(object))
                        {
                            object[] attribs = method.GetCustomAttributes(typeof(ContextMenuMethodAttribute), true);
                            bInclude = (attribs.Length == 1);
                        }
                    }
                }
            }
            return bInclude;
        }

    }
}
