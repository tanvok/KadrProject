using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Kadr.UI.Dialogs;
using Kadr.UI.Frames;
using Kadr.KadrTreeView;
using Kadr.Data.Common;
using Kadr.Controllers;
using Reports.Forms;
using System.Linq;
using Kadr.Data;
 

namespace Kadr.UI.Forms
{
    public partial class KadrBaseForm : Form
    {


        #region Private fields
        private APG.CodeHelper.Actions.ActionManager actionManager = new APG.CodeHelper.Actions.ActionManager();
        private Kadr.UI.Frames.KadrBaseFrame activeFrame;
        private ToolStripItem actionMenuStripItem;
        private APG.CodeHelper.ContextMenuHelper.ContextMenuBuilder contextMenuBuilder;
        private APG.CodeHelper.ContextMenuHelper.ContextMenuBuilder actionButtonDropDownMenuBuilder;

        internal APG.CodeHelper.ContextMenuHelper.ContextMenuBuilder ActionButtonDropDownMenuBuilder
        {
            get { return actionButtonDropDownMenuBuilder; }
            
        }

        internal APG.CodeHelper.ContextMenuHelper.ContextMenuBuilder ContextMenuBuilder
        {
            get { return contextMenuBuilder; }
        }

        /// <summary>
        /// �������� ������ ����, ���� ����������� �������������� ��������
        /// </summary>
        public ToolStripItem ActionMenuStripItem
        {
            get { return actionMenuStripItem; }
        }

        //
        private ToolStripItem[] nodeContextItems = new ToolStripItem[9]; 

        #endregion

        #region Private Methods

        private void CreateNodeContextItems()
        {
            nodeContextItems[0] = new ToolStripMenuItem();
            nodeContextItems[0].Text = "����������";
            nodeContextItems[0].Click += new EventHandler(����������ToolStripMenuItem_Click);
           
            nodeContextItems[1] = new ToolStripMenuItem();
            nodeContextItems[1].Text = "��������";
            nodeContextItems[1].Click += new EventHandler(��������ToolStripMenuItem_Click);

            nodeContextItems[2] = new ToolStripSeparator();

            nodeContextItems[3] = new ToolStripMenuItem();
            nodeContextItems[3].Text = "�������� ���";
            nodeContextItems[3].Click += new EventHandler(�����������ToolStripMenuItem_Click);

            nodeContextItems[4] = new ToolStripMenuItem();
            nodeContextItems[4].Text = "�������� ���";
            nodeContextItems[4].Click += new EventHandler(�����������ToolStripMenuItem_Click);
            
            nodeContextItems[5] = new ToolStripSeparator();

            nodeContextItems[6] = new ToolStripMenuItem();
            nodeContextItems[6].Text = "��������";
            nodeContextItems[6].Click += new EventHandler(��������ToolStripMenuItem_Click);

            nodeContextItems[7] = new ToolStripSeparator();

            nodeContextItems[8] = new ToolStripMenuItem();
            nodeContextItems[8].Text = "��������";
            nodeContextItems[8].Image = treeViewImageList.Images[4];
            actionMenuStripItem = nodeContextItems[8];

            //ContextMenuBuilder
            contextMenuBuilder = new APG.CodeHelper.ContextMenuHelper.ContextMenuBuilder(treeNodeContextMenu, null, ActionMenuStripItem);
            actionButtonDropDownMenuBuilder = new APG.CodeHelper.ContextMenuHelper.ContextMenuBuilder(tsbNew.DropDownItems, null);
 
        }

        private void OnCommandExecute(object sender, EventArgs e)
        {
            RollbackMenuItem.Enabled = (sender as APG.CodeHelper.Actions.ActionManager).Executed.Count > 0;
        }

        private void OnCommandRollback(object sender, EventArgs e)
        {
            RedoMenuItem.Enabled = (sender as APG.CodeHelper.Actions.ActionManager).Rollbacked.Count > 0;
        }

        private void ExitApplication()
        {
            if (DisposeActiveFrame())
                Application.Exit();
        }

        private void ShowApplicationAbout()
        {
            //using (System.Windows.Forms.Form dlg = new ISGBAbout())
            //{
            //    dlg.ShowDialog();
            //}
        }

        private void ApplicationAboutStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowApplicationAbout();
        }

        private void ExitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ExitApplication();
        }

        private void RollbackMenuItem_DropDownItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            throw new NotImplementedException();
        }

        private void CreateUndoRedoDropDownMenu(ToolStripSplitButton toolStripSplitButton, Stack<APG.CodeHelper.Actions.IAction> sourceItems)
        {
            ToolStripItem tsi;
            toolStripSplitButton.DropDownItems.Clear();

            foreach (APG.CodeHelper.Actions.IAction command in sourceItems)
            {
                tsi = new ToolStripMenuItem();
                tsi.Text = command.ToString();
                toolStripSplitButton.DropDownItems.Add(tsi);
            }

        }

        private void RollbackMenuItem_DropDownOpening(object sender, EventArgs e)
        {
            CreateUndoRedoDropDownMenu(sender as ToolStripSplitButton, Commands.Executed);
        }

        private void RedoMenuItem_DropDownOpening(object sender, EventArgs e)
        {
            CreateUndoRedoDropDownMenu(sender as ToolStripSplitButton, Commands.Rollbacked);
        }

        private void tscbTextSearch_Enter(object sender, EventArgs e)
        {
            //EnterSearchComboBox(sender);
        }

        private static void EnterSearchComboBox(object sender)
        {
            // ������� ������ "������� �����" � ���� ������ ��� ��������� ������
            (sender as ToolStripComboBox).ForeColor = SystemColors.WindowText;
            (sender as ToolStripComboBox).Text = "";
        }

        private void tscbTextSearch_Leave(object sender, EventArgs e)
        {
           // LeaveSearchComboBox(sender);

        }

        private static void LeaveSearchComboBox(object sender)
        {
            // ��� ������ ������ ����� ����� ������� ��������������� ����� "������� �����"
            (sender as ToolStripComboBox).Text = "������� �����";
            (sender as ToolStripComboBox).ForeColor = Color.Gray;
        }




        // ����� ������������ ���� ��� ���� ������ 
        private void kadrTreeView1_MouseClick(object sender, MouseEventArgs e)
        {
            if ((SelectedObject == null) || (SelectedObject.NodeContextMenuStrip == null))
                return;

            if (e.Button == MouseButtons.Right)
            {
                SelectedObject.NodeContextMenuStrip.Items.AddRange(nodeContextItems);
                //SelectedObject.NodeContextMenuStrip.Show(e.Location);
                ContextMenuBuilder.ContextMenuStrip = SelectedObject.NodeContextMenuStrip;
                ContextMenuBuilder.Receiver = SelectedObject.Actions;
                ContextMenuBuilder.PopupMenu(this, e.X, e.Y);
            }
        }

        private void kadrTreeView1_AfterSelect(object sender, TreeViewEventArgs e)
        {
            // ������� �� ����� ���� ������ �������� ����������� �����, ����������  � 
            // �������� �������� ����
            ShowSelectedNodeFrame(e);

            // ��������� ��������� ��������� ������ ������������ (toolStrip1) 
            // �� ��������� ����������� ���������� �������� ��������� �����
            // (����� UIAction.CanDoThis(UIObjectAction action))
            AssignToolStripItemState(sender);          

        }

        private void AssignToolStripItemState(object sender)
        {
            if (SelectedActions != null)
            {
                tsbNew.Text = SelectedActions[APG.CodeHelper.Actions.UIObjectAction.taAdd];
                tsbDelete.Text = SelectedActions[APG.CodeHelper.Actions.UIObjectAction.taDelete];
                tsbEdit.Text = SelectedActions[APG.CodeHelper.Actions.UIObjectAction.taUpdate];

                tsbNew.Enabled = SelectedActions.CanDoThis(sender, APG.CodeHelper.Actions.UIObjectAction.taAdd);
                tsbDelete.Enabled = SelectedActions.CanDoThis(sender, APG.CodeHelper.Actions.UIObjectAction.taDelete);
                tsbEdit.Enabled = SelectedActions.CanDoThis(sender, APG.CodeHelper.Actions.UIObjectAction.taUpdate);
                tsbCopy.Enabled = SelectedActions.CanDoThis(sender, APG.CodeHelper.Actions.UIObjectAction.taCopy);
                tsbPaste.Enabled = SelectedActions.CanDoThis(sender, APG.CodeHelper.Actions.UIObjectAction.taPaste);
                tsbCut.Enabled = SelectedActions.CanDoThis(sender, APG.CodeHelper.Actions.UIObjectAction.taCut);
            }
        }

        // ����� ����������� ����� ��� �������� ���� ������
        private void ShowSelectedNodeFrame(TreeViewEventArgs e)
        {
            System.Type frame = null;

            // �������� ��� �����������, ��������� � �����
            Kadr.KadrTreeView.KadrNodeObject obj = (e.Node.Tag as Kadr.KadrTreeView.KadrNodeObject);

            // ������ �� � ����� ������ � �������� �� ������ ����� DBTreeNodeObject
            if (obj != null)
            {
                frame = obj.ObjectViewType;



                //���������� ����
                Frame = frame;

                CurrentObjectLabel.Text = obj.ToString();

                
                CurrentObjectInfoLabel.Text = obj.GetObjectInfo();
                if (CurrentObjectInfoLabel.Text == "")
                    CurrentObjectInfoLabel.Visible = false;
                else
                    CurrentObjectInfoLabel.Visible = true;

               // (obj as Kadr.KadrTreeView.KadrNodeObject).GetObjectStatus();

                //���� ������ - �����, ���������� ������ �� ����������� 
                if (obj is Kadr.KadrTreeView.RootNodeObject)
                {
                    tsbEmployeeFilter.Visible = true;
                    tsbDepartmentFilter.Visible = true;

                     //������������� ������ 
                    ArrayList EmployeeFilters = (activeFrame.FrameNodeObject as RootNodeObject).ObjectFilters;
                    for (ObjectState objectState = ObjectState.Current; objectState <= ObjectState.Canceled; objectState++)
                    {
                        (tsbEmployeeFilter.DropDownItems[(int)objectState] as ToolStripMenuItem).Checked =
                            EmployeeFilters.Contains(objectState);
                    }

                    //������������� ������ 
                    ArrayList DepartmentFilters = (activeFrame.FrameNodeObject as RootNodeObject).DepartmentFilters;
                    for (ObjectState objectState = ObjectState.Current; objectState <= ObjectState.Canceled; objectState++)
                    {
                        (tsbDepartmentFilter.DropDownItems[(int)objectState] as ToolStripMenuItem).Checked =
                            DepartmentFilters.Contains(objectState);
                    }

                }
                else
                {
                    tsbEmployeeFilter.Visible = false;
                    tsbDepartmentFilter.Visible = false;

                }
            }


        }

        // ���������� ����c�������� ����
        private void tsbUpdate_Click(object sender, EventArgs e)
        {
            if (SelectedObject != null)
            {
               // if (!(SelectedObject.Node.IsExpanded()))
                    SelectedObject.Refresh();
            }
            
            if (ActiveFrame != null)
                ActiveFrame.RefreshFrame();

        }

        // ��������� ��������� ������ ����������  �������
        private void tsbNew_MouseEnter(object sender, EventArgs e)
        {
            //(sender as ToolStripItem).Text = SelectedActions[APG.CodeHelper.Actions.UIObjectAction.taAdd];
        }

        // ����� �������� �������� �������
        private void tsbDelete_Click(object sender, EventArgs e)
        {
            if (SelectedActions != null)
            {
                SelectedActions.Execute(this, APG.CodeHelper.Actions.UIObjectAction.taDelete);
            }
        }

        // ����� �������� �������������� �������
        private void tsbEdit_Click(object sender, EventArgs e)
        {
            if (SelectedActions != null)
            {
                SelectedActions.Execute(this, APG.CodeHelper.Actions.UIObjectAction.taUpdate);
            }
        }

        // ����� �������� ������� �������
        private void tsbCut_Click(object sender, EventArgs e)
        {
            (sender as ToolStripItem).Text = SelectedActions[APG.CodeHelper.Actions.UIObjectAction.taCut];
        }

        // ����� �������� ����������� �������
        private void tsbCopy_Click(object sender, EventArgs e)
        {
            (sender as ToolStripItem).Text = SelectedActions[APG.CodeHelper.Actions.UIObjectAction.taCopy];
        }

        // ����� �������� ������� �������
        private void tsbPaste_Click(object sender, EventArgs e)
        {
            (sender as ToolStripItem).Text = SelectedActions[APG.CodeHelper.Actions.UIObjectAction.taPaste];
        }

        // ��������� ��������� ������ ��������  �������
        private void tsbDelete_MouseEnter(object sender, EventArgs e)
        {
           // (sender as ToolStripItem).Text = SelectedActions[APG.CodeHelper.Actions.UIObjectAction.taDelete];
        }

        // ��������� ��������� ������ ��������������  �������
        private void tsbEdit_MouseEnter(object sender, EventArgs e)
        {
            (sender as ToolStripItem).Text = SelectedActions[APG.CodeHelper.Actions.UIObjectAction.taUpdate];
        }

        // ��������� ��������� ������ �������  �������
        private void tsbCut_MouseEnter(object sender, EventArgs e)
        {
            (sender as ToolStripItem).Text = SelectedActions[APG.CodeHelper.Actions.UIObjectAction.taCut];
        }

        // ��������� ��������� ������ �����������  �������
        private void tsbCopy_MouseEnter(object sender, EventArgs e)
        {
            (sender as ToolStripItem).Text = SelectedActions[APG.CodeHelper.Actions.UIObjectAction.taCopy];
        }
        // ��������� ��������� ������ �������  �������
        private void tsbPaste_MouseEnter(object sender, EventArgs e)
        {
            (sender as ToolStripItem).Text = SelectedActions[APG.CodeHelper.Actions.UIObjectAction.taPaste];
        }

        private void ����������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            SelectedObject.Node.Expand();
        }

        private void ��������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            SelectedObject.Node.Collapse(true);
        }

        private void �����������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            SelectedObject.Node.ExpandAll();
        }

        private void �����������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            SelectedObject.Node.Collapse(false);
        }

        private void ��������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            SelectedObject.Refresh();
        }

        private void ����������ToolStripMenuItem_DropDownOpening(object sender, EventArgs e)
        {
            (sender as ToolStripMenuItem).Enabled = !(SelectedObject.Node.IsExpanded);
        }

        private void ��������ToolStripMenuItem_DropDownOpening(object sender, EventArgs e)
        {
            (sender as ToolStripMenuItem).Enabled = SelectedObject.Node.IsExpanded;
        }



        private void KadrBaseForm_Load(object sender, EventArgs e)
        {

            //ImportDailyReportFiles();
            CreateNodeContextItems();
           
        }

        // ����������� �����, ���������� ����� ��������� �����
        //private void ImportDailyReportFiles()
        //{            
        //    if (Environment.GetCommandLineArgs().Length > 1)
        //    {
        //        string[] args = new string[Environment.GetCommandLineArgs().Length - 1];
        //        for (int i = 1; i < Environment.GetCommandLineArgs().Length; i++)
        //        {
        //            args[i-1] = Environment.GetCommandLineArgs()[i];
        //        }
        //        ISGB.Controllers.ISGBDailyReportImportExportController.Instance.ImportDocuments(args);
        //    }
                          
        //}

        void frame_FrameDataChangedEvent(object sender, Kadr.UI.Frames.FrameDataChangedArgs e)
        {
            if ((SelectedObject != null))
            {
                SelectedObject.Notify(sender);
            }
        }


        #endregion
              
        #region Protected Methods

        protected Kadr.UI.Frames.KadrBaseFrame CreateFrame(System.Type frameType, System.Windows.Forms.Control parent)
        {
            return CreateFrame(frameType, parent, null);   
        }
        
        /// <summary>
        /// ��� ������� ��������� ����� ��� ���������� �������������
        /// </summary>
        //private IDictionary<string, ISGBBaseFrame> framePool = 
        //    new Dictionary<string, ISGBBaseFrame>(10);

        /// <summary>
        ///  ������ ����� ������ ������ �� ��� ����, ��������� ��� �� ������ ��������� � ��������� ��� ���������� �����
        ///  ������� �������� FrameObject � ����� RefreshFrame().
        ///  ���� ������ ��������� ���� ��� ����������, �� ����� ������ �� ��������, � ����������� �� ����.
        /// </summary>
        /// <param name="frameType">��� ������ ��� ��������</param>
        /// <param name="parent">������ System.Windows.Forms.Control ��� ����� ������������� �����</param>
        /// <param name="AObject">���������������� ������ ������</param>
        /// <returns>������ ���� ISGB.Frames.ISGBBaseFrame</returns>
        protected Kadr.UI.Frames.KadrBaseFrame CreateFrame(System.Type frameType, System.Windows.Forms.Control parent, object AObject)
        {

            Kadr.UI.Frames.KadrBaseFrame frame = null;

            try
            {
                //if (framePool.ContainsKey(frameType.FullName))
                //{
                //    frame = framePool[frameType.FullName];           
                //}
                //else
                //{
                // ���� ����� ��� ������, �� �������� ��� �� ����
                    // ������ ������ ���� ������ ��� �� ����������

                    frame = Activator.CreateInstance(frameType, AObject) as Kadr.UI.Frames.KadrBaseFrame;
                    frame.FrameDataChangedEvent += new Kadr.UI.Frames.FrameDataChangedDelegate(frame_FrameDataChangedEvent);
                //    framePool.Add(frameType.FullName, frame);
               // }
                frame.FrameObject = AObject;                                     
                frame.FrameGuiObject = kadrTreeView1.SelectedNode;
                frame.FrameNodeObject = kadrTreeView1.SelectedObject;
                frame.Parent = parent;
                frame.Dock = DockStyle.Fill;

                // ������� ����� � ������� �����
                BindCurrentFrameWithNodeObject(frame);

                //���������������� ����� � �������� ������������ 
                KadrController.Instance.AddView(frame);

                
                frame.RefreshFrame();
                frame.Show();
            }
            catch(Exception)
            {
                if (frame != null)
                {
                    frame.Dispose();
                    frame = null;
                }
                throw;
            }
                  
            return frame;
        }

        // ��������� ��������� ����� � ����� ������� ������
        private void BindCurrentFrameWithNodeObject(Kadr.UI.Frames.KadrBaseFrame frame)
        {
            BindCurrentFrameWithNodeObject(frame, SelectedObject);
        }

        // ��������� ����� � �������� ����� ������
        private void BindCurrentFrameWithNodeObject(Kadr.UI.Frames.KadrBaseFrame kadrBaseFrame, APG.CodeHelper.DBTreeView.DBTreeNodeObject SelectedObject)
        {
            if ((SelectedObject != null) && (kadrBaseFrame != null))
            {
                SelectedObject.ObjectView = kadrBaseFrame;
                //kadrBaseFrame.RestoreFrameState(SelectedObject.Store);
            }
        }
        
        #endregion

        #region Public properties
        public APG.CodeHelper.Actions.ActionManager Commands
        {
            get
            {
                return actionManager;
            }
        }

        public Kadr.UI.Frames.KadrBaseFrame ActiveFrame
        {
            get
            {
                return activeFrame;
            }
        }

        public System.Type Frame
        {
            set
            {
                if (DisposeActiveFrame())
                   if (value != null)
                   {
                       activeFrame = CreateFrame(value, splitContainer1.Panel2, kadrTreeView1.SelectedObject.ObjectTag);

                       activeFrame.Caption = kadrTreeView1.SelectedNode.FullPath; 
  
                   }
              }
         }
    
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        private bool DisposeActiveFrame()
        {
            bool result = true;

            if (activeFrame != null)
            {
                if (activeFrame.IsModified)
                {
                    switch (
                        MessageBox.Show(string.Format("������ ����� \"{0}\" ���� ��������.\n������� ��������� ��������� � ���� ������?", activeFrame.FrameName),
                        "���������� ������",
                        MessageBoxButtons.YesNoCancel, MessageBoxIcon.Question))
                    {
                        case DialogResult.Yes:
                            activeFrame.Apply();
                            DisposeActiveFrameInternal(); break;
                        case DialogResult.No:
                            activeFrame.Cancel();
                            DisposeActiveFrameInternal();
                            break;
                        default:
                            result = false;
                            break;
                    }

                }
                else
                    DisposeActiveFrameInternal();
           }
           return result;
        }

        private void DisposeActiveFrameInternal()
        {
            if (activeFrame != null)
            {
                //activeFrame.Dispose();
                activeFrame.IsModified = false;
                activeFrame.Hide();
                activeFrame = null;
            }
        }

        public APG.CodeHelper.DBTreeView.DBTreeNodeObject SelectedObject
        {
            get
            {
                return kadrTreeView1.SelectedObject;
            }
        }

        public APG.CodeHelper.DBTreeView.DBTreeNodeAction SelectedActions
        {
            get 
            {
                return kadrTreeView1.SelectedActions;
            }
        }

        #endregion
        
        #region Public Methods
        
        public KadrBaseForm() 
        {

            InitializeComponent();

            LeaveSearchComboBox(this.tscbTextSearch);

            Commands.OnExecute += new EventHandler(OnCommandExecute);
            Commands.OnRollback += new EventHandler(OnCommandRollback);

            //KadrController.Instance.AddView(kadrTreeView1);
        }


        #endregion

        private void KadrBaseForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            e.Cancel = (!DisposeActiveFrame());
        }

        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            //using (System.Windows.Forms.Form dlg = new ISGB.Dialogs.ISGBSteelDialog())
            //{
            //    dlg.ShowDialog();
            //}
        }

        private void tsbNew_ButtonClick(object sender, EventArgs e)
        {
            if (SelectedActions != null)
            {
                SelectedActions.Execute(this, APG.CodeHelper.Actions.UIObjectAction.taAdd);
            }
        }

        private void tsbUpdate_MouseEnter(object sender, EventArgs e)
        {
            if (SelectedObject != null)
            {
                (sender as ToolStripItem).Text = string.Format("��������: {0}", SelectedObject.Node.Text);
            }
                
        }        

        private void KadrBaseForm_FormClosed(object sender, FormClosedEventArgs e)
        {
            //if (e.CloseReason == CloseReason.ApplicationExitCall)
            //{
            //    ISGB.Properties.Settings.Default.Save();
            //}
        }

        private void kadrTreeView1_NodeChildsAddedEvent(object sender, EventArgs e)
        {
            if (ActiveFrame != null)
                ActiveFrame.RefreshFrame();
        }

        private void ����������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Help.ShowHelp(this, helpProvider1.HelpNamespace);
        }

        private void toolStripTextBox1_DropDownOpening(object sender, EventArgs e)
        {
            //if (SelectedObject is ReportNodeObject)
            //{
            //    miExportReport.Text = string.Format("�������������� {0}...", SelectedObject.Node.Text);
            //    miExportReport.Enabled = true;
            //}
            //else
            //    miExportReport.Enabled = false;
        }

        private void miExportReport_Click(object sender, EventArgs e)
        {
            //ExportDayliReport();
        }


        private void ���������������������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //ImportDayliReport();
        }


        private void toolStripSplitButton1_ButtonClick(object sender, EventArgs e)
        {
            
        }


        private void miImport_Click(object sender, EventArgs e)
        {
            //ImportDictionaries();
        }



        private void tsbNew_DropDownOpening(object sender, EventArgs e)
        {
            BuildActionDropDownMenu();
        }

        private void BuildActionDropDownMenu()
        {
            ActionButtonDropDownMenuBuilder.Receiver = SelectedActions;
            ActionButtonDropDownMenuBuilder.BuildToolStripItemCollection();
        }


        private void tsmiActions_DropDownOpening(object sender, EventArgs e)
        {
            BuildActionDropDownMenu();
            tsmiActions.DropDown.Items.Clear();
            ToolStripItem[] items = new ToolStripItem[ActionButtonDropDownMenuBuilder.ToolStripItemCollection.Count];
            ActionButtonDropDownMenuBuilder.ToolStripItemCollection.CopyTo(items, 0);
            tsmiActions.DropDown.Items.AddRange(items);
            
        }

        private void KadrBaseForm_DragEnter(object sender, DragEventArgs e)
        {
            if (e.Data.GetDataPresent("FileDrop"))
            {
                e.Effect = DragDropEffects.Link;
            }
            else
                e.Effect = DragDropEffects.None;

            //foreach (string f in e.Data.GetFormats())
            //{
            //    System.Diagnostics.Debug.WriteLine(f);
            //}
        }
        private delegate void ImportDocsDelegate();

        private void KadrBaseForm_DragDrop(object sender, DragEventArgs e)
        {
            
            //string[] files = (string[])e.Data.GetData("FileDrop");
            //if (files != null)
            //{
            //    ImportDocsDelegate importDocsDelegate = delegate()
            //    {
            //        Controllers.ISGBDailyReportImportExportController.Instance.ImportDocuments(files);
            //    };

            //    this.BeginInvoke(importDocsDelegate);
            //    //Controllers.ISGBDailyReportImportExportController.Instance.ImportDocuments(files);
            //}
        }

 
        private void �����������ToolStripMenuItem_DropDownOpened(object sender, EventArgs e)
        {
        }

        private void kadrTreeView1_BeforeSelect(object sender, TreeViewCancelEventArgs e)
        {
            
            //SelectedObject.Node
            //if ((ActiveFrame != null) && (SelectedObject != null))
            //    ActiveFrame.SaveFrameState(SelectedObject.Store);
        }

        
        private void toolStripMenuItem12_Click(object sender, EventArgs e)
        {
            //ExportDictionaries(true);
        }


        /// <summary>
        /// ���������� ����� ��������
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void �����������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (BonusSuperTypeDialog dlg = new BonusSuperTypeDialog())
            {
                //dlg.UseInternalCommandManager = true;
                //dlg.Text = "�������������� �������� ���������� ������ " + Department.DepartmentName;

                dlg.ShowDialog();
            }

        }

        /// <summary>
        /// ���������� ����� ��������
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ���ToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            using (BonusTypeDialog dlg = new BonusTypeDialog())
            {
                dlg.ShowDialog();
            }

        }


        /// <summary>
        /// ���������� ���������������-���������������� �����
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ���ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (PKGroupDialog dlg = new PKGroupDialog())
            {
                dlg.ShowDialog();
            }

        }

        /// <summary>
        /// ���������� ����� �����
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ���������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (WorkTypeDialog dlg = new WorkTypeDialog())
            {
                dlg.ShowDialog();
            }

        }

        /// <summary>
        /// ���������� �����������
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void �����������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (GrazdDialog dlg = new GrazdDialog())
            {
                dlg.ShowDialog();
            }

        }

        private void �����������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (SemPolDialog dlg = new SemPolDialog())
            {
                dlg.ShowDialog();
            }

        }

        /// <summary>
        /// ���������������-���������������� ���������
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ���������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (PKCategoryDialog dlg = new PKCategoryDialog())
            {
                dlg.ShowDialog();
            }

        }

        private void ���������ToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void ������������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (CategoryDialog dlg = new CategoryDialog())
            {
                dlg.ShowDialog();
            }

        }

        private void tsbEmployeeFilter_DropDownItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            if (activeFrame is KadrRootFrame)
            {
                ArrayList EmployeeFilters = new ArrayList();
                for (ObjectState objectState = ObjectState.Current; objectState <= ObjectState.Canceled; objectState++)
                {
                    if (tsbEmployeeFilter.DropDownItems[(int)objectState] == e.ClickedItem)
                    {
                        if (!(tsbEmployeeFilter.DropDownItems[(int)objectState] as ToolStripMenuItem).Checked)
                            EmployeeFilters.Add(objectState);
                    }
                    else
                    {
                        if ((tsbEmployeeFilter.DropDownItems[(int)objectState] as ToolStripMenuItem).Checked)
                            EmployeeFilters.Add(objectState);
                    }
                }

                (activeFrame.FrameNodeObject as RootNodeObject).ObjectFilters = EmployeeFilters;
            }

        }

        private void tsbDepartmentFilter_DropDownItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            if (activeFrame is KadrRootFrame)
            {
                ArrayList DepartmentFilters = new ArrayList();
                for (ObjectState objectState = ObjectState.Current; objectState <= ObjectState.Canceled; objectState++)
                {

                    if (tsbDepartmentFilter.DropDownItems[(int)objectState] == e.ClickedItem)
                    {
                        if (!(tsbDepartmentFilter.DropDownItems[(int)objectState] as ToolStripMenuItem).Checked)
                            DepartmentFilters.Add(objectState);
                    }
                    else
                    {
                        if ((tsbDepartmentFilter.DropDownItems[(int)objectState] as ToolStripMenuItem).Checked)
                            DepartmentFilters.Add(objectState);
                    }
                }

                (activeFrame.FrameNodeObject as RootNodeObject).DepartmentFilters = DepartmentFilters;
            }

        }

        private void ������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (PrikazSuperTypeDialog dlg = new PrikazSuperTypeDialog())
            {
                dlg.ShowDialog();
            }
        }

        private void ������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (PrikazTypeDialog dlg = new PrikazTypeDialog())
            {
                dlg.ShowDialog();
            }

        }

        private void ����������������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (FinancingSourceDialog dlg = new FinancingSourceDialog())
            {
                dlg.ShowDialog();
            }

        }

        private void �������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (SalaryDialog dlg = new SalaryDialog())
            {
                dlg.ShowDialog();
            }

        }

        private void �������������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (GlobalPrikazDialog dlg = new GlobalPrikazDialog())
            {
                dlg.ShowDialog();
            }

        }

        private void ����������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (BonusMeasureDialog dlg = new BonusMeasureDialog())
            {
                dlg.ShowDialog();
            }

        }

        private void �����������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (FactStaffReplacementReasonDialog dlg = new FactStaffReplacementReasonDialog())
            {
                dlg.ShowDialog();
            }

        }

        private void �������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (BaseReportForm repForm = new BaseReportForm())
            {
                repForm.LoadData(typeof(Reports.GetBonusByBonusTypeResult));
                //repForm.Show();
                repForm.ShowDialog();
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            

        }

        private void toolStripComboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void tscbFindType_SelectedIndexChanged(object sender, EventArgs e)
        {
            tscbTextSearch.Items.Clear();
            if (tscbFindType.SelectedIndex == 1)//�� ������
            {
                foreach (Department dep in KadrController.Instance.Model.Departments.OrderBy(dep => dep.DepartmentName))
                {
                    tscbTextSearch.Items.Add(dep);
                }
            }

            if (tscbFindType.SelectedIndex == 0)//�� c���������
            {
                foreach (Employee empl in KadrController.Instance.Model.Employees.Where(empl => empl.FactStaffs.Count() > 0).OrderBy(empl => 
                    empl.LastName).ThenBy(empl => empl.FirstName).ThenBy(empl => empl.Otch))
                {
                    tscbTextSearch.Items.Add(empl);
                }
            }

        }

        private void tscbTextSearch_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (tscbFindType.SelectedIndex == 1)//�� ������
            {
                kadrTreeView1.FindAndSelectDepartment(
                    tscbTextSearch.SelectedItem as Department);
            }
            if (tscbFindType.SelectedIndex == 0)//�� �����������
            {
                kadrTreeView1.FindAndSelectEmployee(
                    tscbTextSearch.SelectedItem as Employee);
            }
           
        }

        private void kadrTreeView1_AfterExpand(object sender, TreeViewEventArgs e)
        {

        }

        private void �����������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (Reports.Forms.BaseReportForm repForm = new Reports.Forms.BaseReportForm())
            {
                repForm.LoadData(typeof(Reports.GetDepartmentBonusResult));
                //repForm.ShowDialog();

 
            }

        }

        private void ���������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (TimeSheetDayStateDialog dlg = new TimeSheetDayStateDialog())
            {
                dlg.ShowDialog();
            }

        }

        private void �������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (TimeSheetSheduleTypeDialog dlg = new TimeSheetSheduleTypeDialog())
            {
                dlg.ShowDialog();
            }
        }

        private void �����������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (BonusReportDialog dlg = new BonusReportDialog())
            {
                dlg.ShowDialog();
            }
        }

        private void ������������������������ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (BonusReportColumnsDialog dlg = new BonusReportColumnsDialog())
            {
                dlg.ShowDialog();
            }
        }

        


    }
}