using System;
using System.Collections.Generic;
using System.Linq;
using Kadr.Data;
using System.Windows.Forms;

namespace Kadr.Controllers
{
    class BonusController
    {
        /// <summary>
        /// Добавление надбавки
        /// </summary>
        /// <param name="bonusObject">объект, которому добавляем</param>
        /// <param name="bonusBindingSource">BindingSource</param>
        public void AddBonus(object bonusObject, BindingSource bonusBindingSource)
        {
            if (bonusObject is PlanStaff)
            {
                using (Kadr.UI.Common.PropertyGridDialogAdding<BonusPlanStaff> dlg =
                   new Kadr.UI.Common.PropertyGridDialogAdding<BonusPlanStaff>())
                {
                    dlg.ObjectList = KadrController.Instance.Model.BonusPlanStaffs;
                    //dlg.BindingSource = bonusBindingSource;
                    dlg.UseInternalCommandManager = true;
                    dlg.PrikazButtonVisible = true;
                    dlg.InitializeNewObject = (x) =>
                    {
                        Bonus bonus = new Bonus();
                        dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<BonusPlanStaff, Bonus>(x, "Bonus", bonus, null), this);
                        dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<BonusPlanStaff, PlanStaff>(x, "PlanStaff", bonusObject as PlanStaff, null), this);
                        dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<BonusPlanStaff, bool>(x, "ForVacancy", true, null), this);
                        dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<BonusPlanStaff, bool>(x, "ForEmployee", false, null), this);

                        Bonus prev = null;
                        if ((dlg.SelectedObjects != null) && (dlg.SelectedObjects.Length == 1))
                        {
                            prev = (dlg.SelectedObjects[0] as BonusPlanStaff).Bonus;
                        }
                        //создаем историю надбавки
                        BonusHistory bonusHistory = new BonusHistory(dlg.CommandManager, bonusObject, x.Bonus, prev);
                    };


                    dlg.UpdateObjectList = () =>
                    {
                        dlg.ObjectList = KadrController.Instance.Model.BonusPlanStaffs;
                    };

                    dlg.ShowDialog();
                }
            }
            else
            {
                using (Kadr.UI.Common.PropertyGridDialogAdding<Bonus> dlg =
                   new Kadr.UI.Common.PropertyGridDialogAdding<Bonus>())
                {
                    dlg.ObjectList = KadrController.Instance.Model.Bonus;
                    dlg.BindingSource = bonusBindingSource;
                    dlg.UseInternalCommandManager = true;
                    dlg.PrikazButtonVisible = true;
                    dlg.InitializeNewObject = (x) =>
                    {
                        Bonus prev = null;
                        if ((dlg.SelectedObjects != null) && (dlg.SelectedObjects.Length == 1))
                        {
                            prev = dlg.SelectedObjects[0] as Bonus;
                        }
                        //создаем историю надбавки
                        BonusHistory bonusHistory = new BonusHistory(dlg.CommandManager, bonusObject, x, prev);
                    };


                    dlg.UpdateObjectList = () =>
                    {
                        dlg.ObjectList = KadrController.Instance.Model.Bonus;
                    };

                    dlg.ShowDialog();
                }
            }
           
        }

        /// <summary>
        /// Создает новое изменение для надбавки
        /// </summary>
        /// <param name="currentBonus">Надбавка</param>
        public void CreateBonusChange(Bonus currentBonus)
        {
            if (currentBonus == null)
            {
                MessageBox.Show("Не выбран редактируемый объект.", "АИС \"Штатное расписание\"");
                return;
            }

            using (Kadr.UI.Common.PropertyGridDialogAdding<BonusHistory> dlg =
                 new Kadr.UI.Common.PropertyGridDialogAdding<BonusHistory>())
            {
                dlg.UseInternalCommandManager = true;
                dlg.ObjectList = KadrController.Instance.Model.BonusHistories;
                //dlg.BindingSource = planStaffBindingSource;
                dlg.PrikazButtonVisible = true;
                dlg.oneObjectCreated = true;
                dlg.InitializeNewObject = (x) =>
                {                    
                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<BonusHistory, decimal>(x, "BonusCount", currentBonus.LastBonusCount, null), this);
                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<BonusHistory, Prikaz>(x, "Prikaz", NullPrikaz.Instance, null), this);
                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<BonusHistory, FinancingSource>(x, "FinancingSource", currentBonus.LastFinancingSource, null), this);
                    dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<BonusHistory, Bonus>(x, "Bonus", currentBonus, null), this);
                };

                dlg.UpdateObjectList = () =>
                {
                    dlg.ObjectList = KadrController.Instance.Model.BonusHistories;
                };

                dlg.ShowDialog();
            }
        }

        /// <summary>
        /// Возвращает список надбавок для объекта
        /// </summary>
        /// <param name="bonusObject">объект</param>
        /// <returns></returns>
        public IEnumerable<Bonus> GetBonus(object bonusObject)
        {
            IEnumerable<Bonus> bonus = null;
            if (bonusObject is FactStaff)
            {
                bonus = KadrController.Instance.Model.Bonus.Where(bon =>
                    bon.BonusFactStaff != null).Where(bon => bon.BonusFactStaff.FactStaff == (bonusObject as FactStaff));
            }

            if (bonusObject is PlanStaff)
            {
                bonus = KadrController.Instance.Model.Bonus.Where(bon =>
                    bon.BonusPlanStaff != null).Where(bon => bon.BonusPlanStaff.PlanStaff == (bonusObject as PlanStaff));
            }

            if (bonusObject is Post)
            {
                bonus = KadrController.Instance.Model.Bonus.Where(bon =>
                    bon.BonusPost != null).Where(bon => bon.BonusPost.Post == (bonusObject as Post));
            }
            if (bonus != null)
                return bonus.OrderBy(bon => bon.BonusType.BonusTypeName).ThenBy(bon => bon.DateEnd).ThenBy(bon => bon.LastDateBegin);
            return null;
        }

        public IEnumerable<Bonus> GetAllEmployeeBonus(Employee employee)
        {
            IEnumerable<Bonus> bonus = null;

            bonus = (KadrController.Instance.Model.Bonus.Where(bon => bon.BonusFactStaff != null).Where(bon
                => ((bon.BonusFactStaff.FactStaff.Employee == employee))) as IEnumerable<Bonus>).Concat(KadrController.Instance.Model.FactStaffs.Where(factStf
                    => (factStf.Employee == employee) ).SelectMany(factStf
                        => factStf.PlanStaff.BonusPlanStaffs).Where(bonPlSt => bonPlSt.ForEmployee).Select(bonPlSt => bonPlSt.Bonus) as IEnumerable<Bonus>).Concat(KadrController.Instance.Model.FactStaffs.Where(factStf
                    => (factStf.Employee == employee) ).SelectMany(factStf
                        => factStf.PlanStaff.Post.BonusPosts).Select(bonPost => bonPost.Bonus) as IEnumerable<Bonus>).Distinct();

            return bonus.OrderBy(bon => bon.BonusType.BonusTypeName).ThenBy(bon => bon.DateEnd).ThenBy(bon => bon.DateBegin);
        }


        public void EditBonus(Bonus bonus)
        {
            if (bonus.BonusPlanStaff != null)
                LinqActionsController<BonusPlanStaff>.Instance.EditObject(bonus.BonusPlanStaff, true);
            else
                LinqActionsController<Bonus>.Instance.EditObject(bonus, true);
        }


        public void DeleteBonus(BindingSource bonusBindingSource, Bonus CurrentBonus = null)
        {
            if (CurrentBonus == null)
                CurrentBonus = bonusBindingSource.Current as Bonus;

            if (CurrentBonus == null)
            {
                MessageBox.Show("Не выбрана удаляемая надбавка.", "АИС \"Штатное расписание\"");
                return;
            }

            //если уже задана история (более одной записи), то нельзя удалить надбавку
            if (CurrentBonus.BonusHistories.Count > 1)
            {
                MessageBox.Show("У заданной надбавки есть история изменений. Сначала необходимо удалить историю.", "АИС \"Штатное расписание\"");
                return;
            }

            if (MessageBox.Show("Удалить надбавку?", "АИС Штатное расписание", MessageBoxButtons.OKCancel)
                != DialogResult.OK)
            {
                return;
            }

            KadrController.Instance.Model.BonusHistories.DeleteAllOnSubmit(KadrController.Instance.Model.BonusHistories.Where(bonHist => bonHist.Bonus == CurrentBonus));

            if (CurrentBonus.BonusFactStaff != null)
                KadrController.Instance.Model.BonusFactStaffs.DeleteOnSubmit(CurrentBonus.BonusFactStaff);

            if (CurrentBonus.BonusPlanStaff != null)
                KadrController.Instance.Model.BonusPlanStaffs.DeleteOnSubmit(CurrentBonus.BonusPlanStaff);

            if (CurrentBonus.BonusPost != null)
                KadrController.Instance.Model.BonusPosts.DeleteOnSubmit(CurrentBonus.BonusPost);

            LinqActionsController<Bonus>.Instance.DeleteObject(CurrentBonus, KadrController.Instance.Model.Bonus, bonusBindingSource);

        }
 

        private static BonusController instance;


        private BonusController() 
        {
        }


        /// <summary>
        /// Получает единственный экземпляр контроллера
        /// </summary>
        public static BonusController Instance
        {
            get
            {
                if (instance == null)
                    instance = new BonusController();
                return instance;
            }
        }

        

    }
}
