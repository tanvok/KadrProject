using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;
using Kadr.KadrTreeView;
using Kadr.Controllers;
using Kadr.Data;
using Kadr.Data.Common;
using Reports.Frames;
using Kadr.Controllers;

namespace Kadr.UI.Frames
{
    public partial class KadrEmployeeFrame : KadrBaseFrame
    {

        /// <summary>
        /// Текущая должность (фактическое штатное) сотрудника
        /// </summary>
        /*public FactStaff FactStaff
        {
            get
            {
                if (this.FrameNodeObject != null)
                    return (this.FrameNodeObject as KadrEmployeeObject).FactStaff;
                else
                    return null;
            }
        }*/


        /// <summary>
        /// Отображаемый сотрудник
        /// </summary>
        public Kadr.Data.Employee Employee
        {
            get
            {
                if (this.FrameNodeObject != null)
                    if ((this.FrameNodeObject as KadrEmployeeObject).Employee != null)
                        return (this.FrameNodeObject as KadrEmployeeObject).Employee;
                return NullEmployee.Instance;
            }
        }


        /// <summary>
        /// Отображаемый сотрудник отдела - FactStaff
        /// </summary>
        public Kadr.Data.FactStaff FactStaff
        {
            get
            {
                if (this.FrameNodeObject != null)
                    if ((this.FrameNodeObject as KadrEmployeeObject).Employee != null)
                        return (this.FrameNodeObject as KadrEmployeeObject).FactStaff;
                return NullFactStaff.Instance;
            }
        }

        private UIX.Commands.ICommandManager commandManager;




        #region LoadData

        private void LoadPostList()
        {
 
            factStaffBindingSource.DataSource = KadrController.Instance.Model.FactStaffs.Where(factSt => factSt.Employee == Employee).OrderBy(factSt => factSt.Prikaz.DatePrikaz);//.OfType<UIX.Views.IDecorable>().ToArray();
        }

        private void LoadBonus()
        {
            tsbBonusFilter_DropDownItemClicked(null, null);
        }

        private void LoadBonus(ArrayList BonusFilters)
        {
            //фильтруем элементы
            ArrayList bon = new ArrayList();
            IEnumerable<Bonus> bonus = BonusController.Instance.GetAllEmployeeBonus((this.FrameNodeObject as KadrEmployeeObject).Employee);
            foreach (Bonus bn in bonus)
            {
                if (BonusFilters.Contains((bn as IObjectState).State()))
                {
                    if (bn.BonusPlanStaff != null)
                    {

                        foreach (FactStaff fcSt in (bn.BonusPlanStaff.PlanStaff.FactStaffs.Where(fcSt
                                => fcSt.Employee == (this.FrameNodeObject as KadrEmployeeObject).Employee)))
                            if (BonusFilters.Contains((fcSt as IObjectState).State()))
                            {
                                bon.Add(bn);
                                break;
                            }
                    }
                    else
                    {
                        if (bn.BonusPost != null)
                        {
                            foreach (FactStaff fcSt in bn.BonusPost.Post.PlanStaffs.SelectMany(plSt =>
                                plSt.FactStaffs).Where(fcSt => fcSt.Employee == (this.FrameNodeObject as KadrEmployeeObject).Employee))
                                if (BonusFilters.Contains((fcSt as IObjectState).State()))
                                {
                                    bon.Add(bn);
                                    break;
                                }
                        }
                        else
                            bon.Add(bn);
                    }
                }
 
            }

            AllbonusBindingSource.DataSource = bon;
           
            
            //bonusBindingSource.DataSource = BonusController.Instance.GetBonus((this.FrameNodeObject as KadrEmployeeObject).Employee);
            //AllbonusBindingSource.DataSource = BonusController.Instance.GetAllEmployeeBonus((this.FrameNodeObject as KadrEmployeeObject).Employee);
                //KadrController.Instance.Model.Bonus.Where(bonus => bonus.FactStaff.Employee == Employee);
        }

        private void LoadEmployee()
        {
            cpgEmployee.SelectedObjects = new object[] { Employee.GetDecorator() };
            commandManager = new UIX.Commands.CommandManager();
            cpgEmployee.CommandRegister = commandManager.GetCommandRegister();
            commandManager.BeginBatchCommand();
        }

        private void LoadEducation()
        {
            employeeDegreeBindingSource.DataSource = KadrController.Instance.Model.EmployeeDegrees.Where(empDegr => empDegr.Employee == Employee);
            employeeRankBindingSource.DataSource = KadrController.Instance.Model.EmployeeRanks.Where(empRank => empRank.Employee == Employee);
        }

        private void LoadOtpusk()
        {
            FactStaff currentFactStaff = factStaffBindingSource.Current as FactStaff;
            if (currentFactStaff != null)
                oKOtpuskBindingSource.DataSource =
                    KadrController.Instance.Model.OK_Otpusks.Where(otp => otp.FactStaff == currentFactStaff).Where(
                         otp => otp.DateBegin >= DateTime.Today.AddYears(-2)).OrderByDescending(otp => otp.DateBegin);

        }

        #endregion

        public KadrEmployeeFrame()
        {
            InitializeComponent();
        }

        public KadrEmployeeFrame(object AObject)
        {
            InitializeComponent();
            FrameObject = AObject;
        }

        protected override void DoRefreshFrame()
        {
            tcEmployee_SelectedIndexChanged(null,null);
        }

        private void btnOk_Click(object sender, EventArgs e)
        {
            if (commandManager.IsInBatchMode)
            {
                commandManager.EndBatchCommand();
            }
            KadrController.Instance.SubmitChanges();
            commandManager.BeginBatchCommand();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            if (commandManager != null)
            {
                if (commandManager.IsInBatchMode)
                {
                    commandManager.TerminateBatchCommand();
                }
            }
            commandManager.BeginBatchCommand();
            cpgEmployee.SelectedObjects = new object[] { Employee.GetDecorator() };
        }


        private void EditDegreeBtn_Click(object sender, EventArgs e)
        {
            if (employeeDegreeBindingSource.Current != null)
                LinqActionsController<EmployeeDegree>.Instance.EditObject(
                        employeeDegreeBindingSource.Current as EmployeeDegree, false);

        }

        private void AddDegreeBtn_Click(object sender, EventArgs e)
        {
            using (Kadr.UI.Common.PropertyGridDialogAdding<EmployeeDegree> dlg =
               new Kadr.UI.Common.PropertyGridDialogAdding<EmployeeDegree>())
            {
                dlg.ObjectList = KadrController.Instance.Model.EmployeeDegrees;
                dlg.BindingSource = employeeDegreeBindingSource;
                dlg.UseInternalCommandManager = true;
                dlg.InitializeNewObject = (x) =>
                {
                    EducDocument educDocument = new EducDocument();
                    EducDocumentType docType = Kadr.Controllers.KadrController.Instance.Model.EducDocumentTypes.Where(educDocType
                        => educDocType.id == 1).First();
                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<EducDocument, EducDocumentType>(educDocument, "EducDocumentType", docType, null), this);

                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<EmployeeDegree, ScienceType>(x, "ScienceType", NullScienceType.Instance, null), this);
                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<EmployeeDegree, Degree>(x, "Degree", NullDegree.Instance, null), this);
                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<EmployeeDegree, Employee>(x, "Employee", Employee, null), this);
                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<EmployeeDegree, EducDocument>(x, "EducDocument", educDocument, null), this);
                };



                dlg.UpdateObjectList = () =>
                {
                    dlg.ObjectList = KadrController.Instance.Model.EmployeeDegrees;
                };

                dlg.ShowDialog();
            }

        }

        private void DelDegreeBtn_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Удалить научную степень сотрудника?", "АИС Штатное расписание", MessageBoxButtons.OKCancel)
                == DialogResult.OK)
            {
                LinqActionsController<EducDocument>.Instance.DeleteObject((employeeDegreeBindingSource.Current as EmployeeDegree).EducDocument,
                     KadrController.Instance.Model.EducDocuments, null);

                LinqActionsController<EmployeeDegree>.Instance.DeleteObject(employeeDegreeBindingSource.Current as EmployeeDegree,
                     KadrController.Instance.Model.EmployeeDegrees, employeeDegreeBindingSource);
            }
        }

        private void AddRankBtn_Click(object sender, EventArgs e)
        {
            using (Kadr.UI.Common.PropertyGridDialogAdding<EmployeeRank> dlg =
               new Kadr.UI.Common.PropertyGridDialogAdding<EmployeeRank>())
            {
                dlg.ObjectList = KadrController.Instance.Model.EmployeeRanks;
                dlg.BindingSource = employeeRankBindingSource;
                dlg.UseInternalCommandManager = true;
                dlg.InitializeNewObject = (x) =>
                {
                    EducDocument educDocument = new EducDocument();
                    EducDocumentType docType = Kadr.Controllers.KadrController.Instance.Model.EducDocumentTypes.Where(educDocType
                        => educDocType.id == 2).First();
                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<EducDocument, EducDocumentType>(educDocument, "EducDocumentType", docType, null), this);

                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<EmployeeRank, Rank>(x, "Rank", NullRank.Instance, null), this);
                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<EmployeeRank, Employee>(x, "Employee", Employee, null), this);
                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<EmployeeRank, EducDocument>(x, "EducDocument", educDocument, null), this);

                };

                dlg.UpdateObjectList = () =>
                {
                    dlg.ObjectList = KadrController.Instance.Model.EmployeeRanks;
                };

                dlg.ShowDialog();
            }
        }

        private void EditRankBtn_Click(object sender, EventArgs e)
        {
            if (employeeRankBindingSource.Current != null)
                LinqActionsController<EmployeeRank>.Instance.EditObject(
                        employeeRankBindingSource.Current as EmployeeRank, false);
        }

        private void DelRankBtn_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Удалить ученое звание сотрудника?", "АИС Штатное расписание", MessageBoxButtons.OKCancel)
                 == DialogResult.OK)
            {
                LinqActionsController<EducDocument>.Instance.DeleteObject((employeeRankBindingSource.Current as EmployeeRank).EducDocument,
                     KadrController.Instance.Model.EducDocuments, null);

                LinqActionsController<EmployeeRank>.Instance.DeleteObject(employeeRankBindingSource.Current as EmployeeRank,
                     KadrController.Instance.Model.EmployeeRanks, employeeRankBindingSource);
            }
        }

        

        public void RefreshBonusFilter()
        {
            tsbBonusFilter_DropDownItemClicked(this, null);
        }

        private void tsbBonusFilter_DropDownItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            LoadBonus(ObjectStateController.Instance.GetObjectStatesForFilter(tsbBonusFilter, e));
        }

        

        private void KadrEmployeeFrame_Load(object sender, EventArgs e)
        {
            tcEmployee.TabPages.Remove(tpEmplBonus);
            
            dtpBonRepPeriodBegin.Value = DateTime.Today.AddDays(-DateTime.Today.Day + 1);
            dtpBonRepPeriodEnd.Value = DateTime.Today;

            
        }

        private void btnBonusRepLoad_Click(object sender, EventArgs e)
        {
            employeeBonusReportFrame1.UpdateReportParams(dtpBonRepPeriodBegin.Value, dtpBonRepPeriodEnd.Value, Employee.id, false);
        }

 

        private void dgvAllBonus_RowPrePaint(object sender, DataGridViewRowPrePaintEventArgs e)
        {
            if ((dgvAllBonus.Rows[e.RowIndex].DataBoundItem as Bonus).HasHistoryChanges)
            {
                dgvAllBonus.Rows[e.RowIndex].DefaultCellStyle.BackColor = Color.Bisque;
            }
            else
            {
                dgvAllBonus.Rows[e.RowIndex].DefaultCellStyle.BackColor = Color.White;
            }
        }

        private void tcEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (tcEmployee.SelectedTab == tpBonus)
                LoadBonus();

            if (tcEmployee.SelectedTab == tpEducation)
                LoadEducation();

            if (tcEmployee.SelectedTab == tpEmpPost)
                LoadPostList();

            if (tcEmployee.SelectedTab == tpEmployee)
                LoadEmployee();

            if (tcEmployee.SelectedTab == tpEmplBonus)
            {
                bonusFrame1.BonusObject = Employee;
                bonusFrame1.LoadBonus();
            }
        }

        private void tsbBonusHistory_Click(object sender, EventArgs e)
        {
            var currentBonus = AllbonusBindingSource.Current as Bonus;
            if (currentBonus == null)
            {
                MessageBox.Show("Не выбрана надбавка для просмотра истории.", "АИС \"Штатное расписание\"");
                return;
            }

            using (Kadr.UI.Forms.BonusHistoryForm histForm =
                           new Kadr.UI.Forms.BonusHistoryForm())
            {
                histForm.Bonus = currentBonus;
                histForm.ShowDialog();
            }
        }

        private void dgvAllBonus_DoubleClick(object sender, EventArgs e)
        {
            tsbBonusHistory_Click(null, null);
        }

        private void factStaffBindingSource_PositionChanged(object sender, EventArgs e)
        {
            LoadOtpusk();
        }

        private void employeeBonusReportFrame1_Load(object sender, EventArgs e)
        {
            employeeBonusReportFrame1.InitializeReport(typeof(Reports.GetEmployeesSumResult), 0);
        }

        private void LoadContactData()
        {
            CRUDPhone.Read(Employee, oKphoneBindingSource);
            CRUDAddress.Read(Employee, oKAdressBindingSource);
        }

        private void tcEmplData_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (tcEmplData.SelectedTab == tpContData)
                LoadContactData();
        }

        private void tcPostData_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (tcPostData.SelectedTab == tpBusTrip)
                BusinessTripsBindingSource.DataSource =
                    KadrController.Instance.Model.FactStaffHistories.Where(t => t.FactStaff == (FactStaff)factStaffBindingSource.Current).SelectMany(x => x.Events).Where(x => (x.EventType == MagicNumberController.BeginEventType)).Select(x => x.Event_BusinessTrip).Where(t => t != null).Select(t => t.BusinessTrip).Select(x => x.GetDecorator()).ToList();
            if (tcPostData.SelectedTab == tpIncapacity)
                oKInkapacityBindingSource.DataSource = KadrController.Instance.Model.OK_Inkapacities.Where(x => x.Employee == Employee)
                    .OrderByDescending(x => x.DateBegin);
        }
    }

}
