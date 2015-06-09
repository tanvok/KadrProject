using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Kadr.UI.Common;
using Kadr.Controllers;
using Kadr.Data;
using Kadr.Data.Common;
using System.Collections;

namespace Kadr.UI.Dialogs
{
    public partial class BonusProlongFullDialog : CustomBaseDialog
    {

        protected IEnumerable<GetBonusByBonusTypeForProlongResult> bonus;
        
        public BonusProlongFullDialog()
        {
            InitializeComponent();
        }

        private void BonusProlongFullDialog_Load(object sender, EventArgs e)
        {
            financingSourceBindingSource.DataSource = KadrController.Instance.Model.FinancingSources.OrderBy(fnS => fnS.FinancingSourceName).ToArray();
            IEnumerable<BonusType> bonusTypes = KadrController.Instance.Model.BonusTypes.OrderBy(bnT => bnT.BonusTypeName).ToArray();
            foreach (BonusType bonType in bonusTypes)
            {
                cbBonusType.Items.Add(bonType);
            }
            cbBonusType.SelectedItem = bonusTypes.FirstOrDefault();

            cbFinancingSource.Enabled = false;
            chbWithFinSource.Checked = false;
        }

        private void cbBonusType_SelectedIndexChanged(object sender, EventArgs e)
        {
            //загружаем список надбавок указанного типа
            /*IEnumerable<BonusFactStaff> bonusFactStaff = KadrController.Instance.Model.Bonus.Where(bon => (bon.DateEnd < DateTime.Today) || (bon.DateEnd == null)).
                Where(bon => bon.BonusType == (cbBonusType.SelectedItem as BonusType)).Where(bon => bon.BonusFactStaff != null).Select(bon => bon.BonusFactStaff);
                    //IEnumerable<FactStaff> bonusFactStaff = KadrController.Instance.Model.FactStaffs.Where(fcSt => bonus.Select(bon => bon.BonusFactStaff.idFactStaff).Contains(fcSt.id)).ToArray();
            
            var factStaffs = KadrController.Instance.Model.FactStaffs.Join(bonusFactStaff, fcSt => fcSt.id, bon => bon.idFactStaff,
                (fcSt, bon) => new
                {
                    id = fcSt.id,
                    BonusCount = bon.Bonus.BonusCount,
                    Department = fcSt.Department,
                    Post = fcSt.Post,
                    Employee = fcSt.Employee,
                    StaffCount = fcSt.StaffCount,
                    WorkType = fcSt.WorkType,
                    FinSource = fcSt.FinSource,
                    DateBegin = fcSt.DateBegin,
                    DateEnd = fcSt.DateEnd,
                    BonusDateBegin = bon.Bonus.DateBegin,
                    BonusFinancingSourceName = bon.Bonus.FinancingSourceName
                });
            factStaffBindingSource.DataSource = factStaffs;*/
            bonus = KadrController.Instance.Model.GetBonusByBonusTypeForProlong((cbBonusType.SelectedItem as BonusType).id, DateTime.Today, DateTime.Today.AddMonths(1).AddDays(1 - DateTime.Today.Day)).ToArray();
            getBonusByBonusTypeForProlongResultBindingSource.DataSource = bonus;
        }

        protected override void DoApply()
        {
            if ((dtNewDate.Value == null)
                || (cbBonusType.SelectedItem == null)
                || (cbNewPrikaz.SelectedItem == null))
            {
                MessageBox.Show("Внесите все данные!");
                return;
            }

            //var deps = KadrController.Instance.Model.GetSubDepartmentsWithPeriod(1, dtNewDate.Value, dtNewDate.Value).ToArray();

            //выбираем все надбавки указанного типа, которые еще действующие

            //для каждой подходящей по условиям надбавки создаем запись истории
            IEnumerable<GetBonusByBonusTypeForProlongResult> CheckedBonus = bonus.Where(bon => bon.Prolong.Value).ToArray();
            //IEnumerable<Bonus> targetBonus = KadrController.Instance.Model.Bonus.Where(bon => CheckedBonus.Select(prolBon => prolBon.idBonus).Contains(bon.id)).ToArray();
            foreach (GetBonusByBonusTypeForProlongResult curBonus in CheckedBonus)
            {
                Bonus bon = KadrController.Instance.Model.Bonus.Where(bn => bn.id == curBonus.idBonus).FirstOrDefault();
                if (curBonus == null)
                    continue;
                BonusHistory bonHist = new BonusHistory();
                bonHist.BonusCount = curBonus.BonusCount.Value;
                bonHist.DateBegin = dtNewDate.Value;
                bonHist.Prikaz = cbNewPrikaz.SelectedItem as Prikaz;
                if ((chbWithFinSource.Checked) && (cbFinancingSource.SelectedItem != null))
                {
                    //если источник финансирования <не указано> 
                    if ((cbFinancingSource.SelectedItem as FinancingSource).id == 0)
                    {
                        bonHist.FinancingSource = bon.ObjectFinancingSource;
                    }
                    else
                        bonHist.FinancingSource = cbFinancingSource.SelectedItem as FinancingSource;
                }
                else //если источник просто не указан, то берем источник надбавки
                {
                    bonHist.FinancingSource = bon.LastFinancingSource;
                }
                bonHist.Bonus = bon;
            }
            KadrController.Instance.SubmitChanges();
        }

        private void chbWithFinSource_CheckedChanged(object sender, EventArgs e)
        {
            cbFinancingSource.Enabled = chbWithFinSource.Checked;
        }

        private void cbBonRepWithSubDeps_CheckedChanged(object sender, EventArgs e)
        {
            foreach (GetBonusByBonusTypeForProlongResult bon in bonus)
            {
                bon.Prolong = cbBonRepWithSubDeps.Checked;
            }
            getBonusByBonusTypeForProlongResultBindingSource.DataSource = null;
            getBonusByBonusTypeForProlongResultBindingSource.DataSource = bonus;
        }

        private void dtNewDate_ValueChanged(object sender, EventArgs e)
        {

        }
    }
}
