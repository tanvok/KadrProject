using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

namespace APG.CodeHelper.DBTreeView
{
    /// <summary>
    /// ������� ����� ��� �������� ��� ���������� DBTreeView
    /// </summary>
    public abstract class DBTreeNodeObject:IEnumerable<DBTreeNodeObject>
    {
                                
        private bool isTerminalNode = false;

        // ���� �� ������ ��������� �������� �����
        // ��� �������� ���������������� ������ ����������� �������� ����
        /// <summary>
        /// ����������, �������� �� ���� ������������
        /// </summary>
        public bool IsTerminalNode
        {
            get 
            { 
                return isTerminalNode; 
            }
            protected set 
            { 
                isTerminalNode = value; 
            }
  
        }

        private TreeNode treeNode;
        
        private object objectTag;

        private bool bChildAdded = false;

        private string key;

        public string Key
        {
            get
            {
                return key;
            }
            set
            {
                key = value;
            }
        }

        private TreeNode GetParentNode()
        {
            TreeNode treeNode = null;
            if (Node != null)
                treeNode = Node.Parent;
            return treeNode;
        }

        private System.Type objectViewType;
        private object objectView;

        /// <summary>
        /// �������� ������������� (�����, ����), ������� ������� � �����.
        /// </summary>
        public object ObjectView
        {
            get 
            { 
                return objectView; 
            }
            set
            {
                objectView = value;
            }
        }
        private System.Collections.IDictionary store;

        /// <summary>
        /// ��������� ��������� �������� ��������� ��� ��������� ��� ����������� ������������� (Pattern Memento)
        /// </summary>
        public System.Collections.IDictionary Store
        {
            get 
            {
                if (store == null)
                    store = new System.Collections.Hashtable();
                return store; 
            }           
        }


        /// <summary>
        /// ������� ������� ���� ����������� � ����������� ������
        /// </summary>
        /// <param name="node">���� ������ � ������� ������ ���� ������</param>
        protected DBTreeNodeObject(TreeNode node)
        {
            if (node != null)
            {
                node.Tag = this;
                treeNode = node;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        private DBTreeNodeObject GetParentObject()
        {
            DBTreeNodeObject nodeObj = null;
            if (GetParentNode() != null)
                nodeObj = GetParentNode().Tag as DBTreeNodeObject;
            return nodeObj;
        }

        
        /// <summary>
        /// �������������� � ����������� ������ ��� ���������� �������� �����
        /// </summary>
        /// <returns></returns>
        protected abstract bool DoAddChildNodes();
        
        /// <summary>
        /// ��������� �������� ����
        /// </summary>
        public void AddChildNodes()
        {
            
            // ���� �������� ���� ��� �� ���������
            if (!bChildAdded)
            {
                treeView.BeginUpdate();

                try
                {
                    Node.Nodes.Clear();
                    
                    // ���� ��� �� ������������ ����, �� ���� �����������
                    if (!IsTerminalNode)
                    {

                        bChildAdded = DoAddChildNodes();
                        treeView.OnChildsAddedEvent();
                    }                    
                }
                finally
                {
                    treeView.EndUpdate();
                }
            }
        }

        /// <summary>
        /// ��������� ������������� ����
        /// </summary>
        public void Refresh()
        {
            // ��������� ���� �� ����������            
            bool IsNodeExpanded = Node.IsExpanded;

            // �������� ���������� �������� �����
            bChildAdded = false;
            AddChildNodes();

            // ��������� �������������� �������� ����
            FormatNode();

            // ���� ���� ��� ������� �� ����������, �� �������� ��� ����� �������� ����������
            if (IsNodeExpanded)
            Node.Expand();
            treeView.SelectedNode = Node;
        }

        /// <summary>
        /// �������������� � ����������� ������ ��� ��������� ������� ������ ����
        /// </summary>
        /// <returns></returns>
        protected virtual DBTreeNodeAction GetActions()
        {
            return null;
        }

        DBTreeNodeAction actions;

        /// <summary>
        /// ������ "�������", �������� � ������ �����
        /// </summary>
        public DBTreeNodeAction Actions
        {
            get
            {
                if (actions == null)
                    actions =  GetActions();
                return actions;
            }
        }

        /// <summary>
        ///  ���� ������, � ������� ������ ���� ������
        /// </summary>
        public TreeNode Node
        {
            get
            {
                return treeNode;
            }
        }

        /// <summary>
        /// ������, � ������� ������ ���� ������
        /// </summary>
        public DBTreeView treeView
        {
            get
            {
                DBTreeView tv = null;
                if (Node != null)
                    tv = Node.TreeView as DBTreeView;
                return tv;
            }
        }
        
        

        /// <summary>
        /// ������������ ������
        /// </summary>
        public DBTreeNodeObject Parent
        {
            get
            {
                return GetParentObject();
            }
        }
        /// <summary>
        /// �������� ��� ������������� ��� ������������� (�����) ��� ������� ����
        /// </summary>
        public System.Type ObjectViewType
        {
            get
            {
                return objectViewType;
            }
            set
            {
                objectViewType = value;

            }
        }

        /// <summary>
        /// �������� ��� ������������� ������, �������� � �����
        /// </summary>
        public object ObjectTag
        {
            get
            {
                return objectTag;
            }
            set
            {
                objectTag = value;
                FormatNode();
            }
        }

        /// <summary>
        /// ��������� �������� ���� � ����, ��������� � ���� ��������
        /// </summary>
        /// <param name="Caption">���������</param>
        /// <param name="nodeType">��� ����</param>
        /// <returns>����� ����</returns>
        public TreeNode CreateTreeNode(string Caption, System.Type nodeType)
        {
            return treeView.CreateTreeNode(treeNode, Caption, nodeType);
        }

        /// <summary>
        /// ������ ����� ���� � ������
        /// </summary>
        /// <typeparam name="T">��� ������� ����</typeparam>
        /// <param name="Caption">����� ����</param>
        /// <param name="outNodeObject">��������� ������ ����</param>
        /// <returns>���� ������</returns>
        public TreeNode CreateTreeNode<T>(string Caption, out T outNodeObject) where T : DBTreeNodeObject
        {
            return treeView.CreateTreeNode<T>(treeNode, Caption, string.Empty, out outNodeObject);
        }

        public TreeNode CreateTreeNode<T>(string Caption, string Key, out T outNodeObject) where T : DBTreeNodeObject
        {
            return treeView.CreateTreeNode<T>(treeNode, Caption, Key, out outNodeObject);
        }

        /// <summary>
        /// �������� ����������� ����, ��������� � ���� ��������
        /// </summary>
        public ContextMenuStrip NodeContextMenuStrip
        {
            get
            {
                if (treeNode.ContextMenuStrip == null)
                    treeNode.ContextMenuStrip = CreateContextMenuStrip();

                return treeNode.ContextMenuStrip;
            }
        }

        /// <summary>
        /// ���������� ������ ��������� ����, ���������� � �����
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="node"></param>
        /// <returns></returns>
        public static T GetNodeObjectOfNode<T>(TreeNode node) where T : DBTreeNodeObject
        {
            if (node == null) return default(T);
            return (node.Tag as T);
        }

        private ContextMenuStrip CreateContextMenuStrip()
        {
            if (Actions == null) return null;
                

            ContextMenuStrip menuStrip = new ContextMenuStrip(treeView.Container);
            
            menuStrip.Opening += new System.ComponentModel.CancelEventHandler(menuStrip_Opening);
            menuStrip.Tag = this;
            
            ToolStripItem tsi;
            for (int i = 0; i < APG.CodeHelper.Actions.UIAction.Count; i++)
            {
                tsi = menuStrip.Items.Add(Actions[(APG.CodeHelper.Actions.UIObjectAction)i]);
                tsi.Click += new EventHandler(tsi_Click);
                tsi.Tag = (APG.CodeHelper.Actions.UIObjectAction)i;
            }
         
            return menuStrip;
        }

        void menuStrip_Opening(object sender, System.ComponentModel.CancelEventArgs e)
        {
            foreach (ToolStripItem item in (sender as ContextMenuStrip).Items)
            {
                if (item.Tag != null)
                {
                    item.Visible = Actions.CanDoThis(this, (APG.CodeHelper.Actions.UIObjectAction)item.Tag);
                }
            }

        }

        void tsi_Click(object sender, EventArgs e)
        {
            Actions.Execute(this, (APG.CodeHelper.Actions.UIObjectAction)((sender as ToolStripItem).Tag));
        }


        protected void HandleBDException(System.Exception e)
        {
        
        }

        #region IEnumerable<DBTreeNodeObject> Members

        IEnumerator<DBTreeNodeObject> IEnumerable<DBTreeNodeObject>.GetEnumerator()
        {
            for (int i = 0; i < Node.Nodes.Count; i++ )
            {
                yield return Node.Nodes[i].Tag as DBTreeNodeObject;
            }
        }

        #endregion

        #region IEnumerable Members

        System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator()
        {
            for (int i = 0; i < Node.Nodes.Count; i++)
            {
                yield return Node.Nodes[i].Tag as DBTreeNodeObject;
            }
        }

        #endregion

        /// <summary>
        /// ���������� �� ���������� � ������
        /// </summary>
        /// <param name="sender">������-��������� ���������</param>
        public virtual void Notify(object sender)
        {
            //throw new Exception("The method or operation is not implemented.");
        }

        /// <summary>
        /// �������������� � ����������� ������� ��� ��������� ������� ������������� ����
        /// </summary>
        protected virtual void FormatNode()
        {

        }
    }

    
}
