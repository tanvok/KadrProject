using Kadr.Data;
using Kadr.UI.Common;
using Kadr.UI.Dialogs;
using System;
using System.Linq;
using System.Windows.Forms;
using UIX.Commands;

namespace Kadr.Controllers
{
    public static class CRUDBusinessTrip
    {

        public static void Create(FactStaff fs, BindingSource BusinessTripsBindingSource, object sender)
        {
            
            if (fs?.CurrentChange == null)
            {
                MessageBox.Show("Невозможно добавить командировку этому сотруднику!");
                return;
            }

            using (PropertyGridDialogAdding<BusinessTrip> dlg =
               SimpleActionsProvider.NewSimpleObjectAddingDialog<BusinessTrip>())
            {

                    dlg.InitializeNewObject = (x) =>
                    {
                        
                        new BusinessTripRegionType(dlg.CommandManager, x, DateTime.Today, DateTime.Today, KadrController.Instance.Model.RegionTypes.First());
                        new Event_BusinessTrip(dlg.CommandManager, fs.CurrentChange, MagicNumberController.BeginEventType, x, null, DateTime.Today);
                        dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<BusinessTrip, string>(x, "TripTargetPlace", "", null), sender);
                        dlg.CommandManager.Execute(new UIX.Commands.GenericPropertyCommand<BusinessTrip, FinancingSource>(x, "FinancingSource", 
                            KadrController.Instance.Model.FinancingSources.FirstOrDefault(), null), sender);
                    };

                dlg.BeforeApplyAction = (x) =>
                {
                    
                    BusinessTripDecorator btd =x.GetDecorator() as BusinessTripDecorator;
                    Event_BusinessTrip ebt=null;

                    foreach (FactStaffHistory fsh in btd.SelectedFSHs)

                        if (fsh != (x as BusinessTrip).Event.FactStaffHistory) 
                        {
                            ebt = new Event_BusinessTrip(dlg.CommandManager, fsh, MagicNumberController.BeginEventType, x, null, DateTime.Today);

                            ebt.Event.DateBegin = (x as BusinessTrip).Event.DateBegin;
                            ebt.Event.DateEnd = (x as BusinessTrip).Event.DateEnd;
                            ebt.Event.Prikaz = (x as BusinessTrip).Event.Prikaz;
                        }
                    try
                    {
                        x.CheckCorrectness();
                    }
                    catch (ArgumentOutOfRangeException e)
                    {
                        MessageBox.Show(string.Format("Внимание! Добавляемая командировка содержит противоречивые данные. \r\r{0}", e.Message));
                    }

                };

                    dlg.UpdateObjectList = () =>
                    {
                        dlg.ObjectList = KadrController.Instance.Model.BusinessTrips;
                    };

                dlg.ApplyButtonVisible = false;
                dlg.ShowDialog();
                }

            Read(fs, BusinessTripsBindingSource);
        }

        public static void Read(FactStaff fs, BindingSource BusinessTripsBindingSource)
        {
            BusinessTripsBindingSource.DataSource = KadrController.Instance.Model.FactStaffHistories.Where(t => t.FactStaff == fs).SelectMany(x => x.Events).Where(x=>(x.EventType == MagicNumberController.BeginEventType)).Select(x => x.Event_BusinessTrip).Where(t=>t!=null).Select(t=>t.BusinessTrip).Select(x => x.GetDecorator()).ToList();
        }

        public static void Update(FactStaff fs, BindingSource BusinessTripsBindingSource)
        {

            if (BusinessTripsBindingSource.Current != null)
                using (var dlg = new Kadr.UI.Common.LinqPropertyGridDialogEditing<BusinessTrip>())
            {
                    dlg.ApplyButtonVisible = false;
                    dlg.UseInternalCommandManager = true;

                dlg.SelectedObjects = new object[] { (BusinessTripsBindingSource.Current as BusinessTripDecorator).GetTrip() };

                dlg.BeforeApplyAction = (trip) =>
                {
                    BusinessTripDecorator btd = trip.GetDecorator() as BusinessTripDecorator;

                    //добавляем новые цели поездки
                    //btd.TripTargets.Where(p => p.IsNew).Select(p => p.Target.BusinessTrip = trip);
                    //trip.BusinessTripTargets.AddRange(btd.TripTargets.Where(p => p.IsNew).Select(p => p.Target));
                    
                    //обрабатываем удаленные цели поездки
                    //foreach (BusinessTripTarget btt in trip.BusinessTripTargets)
                    //    if (!btd.TripTargets.Select(p => p.Target).Contains(btt)) KadrController.Instance.Model.BusinessTripTargets.DeleteOnSubmit(btt);

                    /*
                    //обрабатываем удаленные регионы
                    foreach (BusinessTripRegionType btr in trip.BusinessTripRegionTypes)
                        if (!btd.TripRegions.Select(p => p.Type).Contains(btr)) KadrController.Instance.Model.BusinessTripRegionTypes.DeleteOnSubmit(btr);

                    //добавляем новые регионы
                    btd.TripRegions.Where(p => p.IsNew).Select(p => p.Type.BusinessTrip = trip);
                    trip.BusinessTripRegionTypes.AddRange(btd.TripRegions.Where(p => p.IsNew).Select(p => p.Type));
                    */

                    //добавляем события по новым должностям
                    var duties = trip.Event_BusinessTrips.Select(b => b.Event.FactStaffHistory);

                    foreach (FactStaffHistory fsh in btd.SelectedFSHs)
                        if (!duties.Contains(fsh))
                            trip.Event_BusinessTrips.Add(new Event_BusinessTrip(dlg.CommandManager, fsh, MagicNumberController.BeginEventType, trip, null, DateTime.Today));

                    foreach (Event_BusinessTrip e in trip.Event_BusinessTrips)
                    {
                        //удаляем события по исключенным должностям
                        if (!btd.SelectedFSHs.Contains(e.Event.FactStaffHistory))
                        {
                            KadrController.Instance.Model.Events.DeleteOnSubmit(e.Event);
                            KadrController.Instance.Model.Event_BusinessTrips.DeleteOnSubmit(e);
                            continue;
                        }
                        //изменяем сроки командировки и приказ для события по каждой должности

                            e.Event.DateBegin = trip.Event.DateBegin;
                            e.Event.DateEnd = trip.Event.DateEnd;
                            e.Event.Prikaz = trip.Event.Prikaz;
                    }

                    try
                    {
                        trip.CheckCorrectness();
                    }
                    catch (ArgumentOutOfRangeException e)
                    {
                        MessageBox.Show(string.Format("Внимание! Редактируемая командировка содержит противоречивые данные. \r\r{0}",e.Message));
                    }

                };

                    dlg.UpdateObjectList = () =>
                    {
                        dlg.ObjectList = KadrController.Instance.Model.BusinessTrips;
                    };

                    dlg.ShowDialog();
            }

            Read(fs, BusinessTripsBindingSource);
        }

        public static void Delete(FactStaff fs, BindingSource BusinessTripsBindingSource)
        {
            if (BusinessTripsBindingSource.Current == null)
                MessageBox.Show("Не выбрана командировка!");
            else
            if (MessageBox.Show(string.Format("Вы уверены, что хотите удалить '{0}'?", (BusinessTripsBindingSource.Current as BusinessTripDecorator).ToString()), "Подтверждение", MessageBoxButtons.OKCancel) == DialogResult.OK)
            {
                

                BusinessTrip bt = (BusinessTripsBindingSource.Current as BusinessTripDecorator).GetTrip();

                if (fs != bt.Event.FactStaff)
                {
                    Event e = bt.Event_BusinessTrips.FirstOrDefault(x => (x.Event.FactStaff == fs) && (x.Event.EventType == MagicNumberController.BeginEventType)).Event;
                    KadrController.Instance.Model.Event_BusinessTrips.DeleteOnSubmit(bt.Event_BusinessTrips.FirstOrDefault(x=>x.Event==e));
                    KadrController.Instance.Model.Events.DeleteOnSubmit(e);
                }

                else
                {
                    foreach (BusinessTripRegionType rt in bt.BusinessTripRegionTypes)
                        KadrController.Instance.Model.BusinessTripRegionTypes.DeleteOnSubmit(rt);

                    foreach (Event_BusinessTrip e in bt.Event_BusinessTrips)
                    {
                        KadrController.Instance.Model.Events.DeleteOnSubmit(e.Event);
                        KadrController.Instance.Model.Event_BusinessTrips.DeleteOnSubmit(e);
                    }

                    //foreach (BusinessTripTarget t in bt.BusinessTripTargets)
                    //    KadrController.Instance.Model.BusinessTripTargets.DeleteOnSubmit(t);

                    KadrController.Instance.Model.BusinessTrips.DeleteOnSubmit(bt);

                    KadrController.Instance.Model.Events.DeleteOnSubmit(bt.Event);
                }
                KadrController.Instance.Model.SubmitChanges();
                
            }
            Read(fs, BusinessTripsBindingSource);
        }

        public static void CancelTrip(FactStaff fs, BindingSource BusinessTripsBindingSource)
        {
            PrikazSelectionDialog dlg;

                dlg = new PrikazSelectionDialog((BusinessTripsBindingSource.Current as BusinessTripDecorator).PrikazEnd, MagicNumberController.BusinessTripPrikazType);

                dlg.Text = "Приказ отмены командировки";

                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    (BusinessTripsBindingSource.Current as BusinessTripDecorator).CancelTrip((Prikaz)dlg.DialogObject);
                    KadrController.Instance.Model.SubmitChanges();
                }

            
            Read(fs, BusinessTripsBindingSource);
        }

        public static void TripChangeDates(FactStaff fs, BindingSource BusinessTripsBindingSource)
        {
            using (PrikazSelectionDialog dlg = new PrikazSelectionDialog(null,MagicNumberController.BusinessTripPrikazType))
            {
                dlg.Text = "Приказ изменения сроков командировки";

                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    BusinessTripDecorator dec = (BusinessTripDecorator)BusinessTripsBindingSource.Current;
                    
                    using (DatesRangeDialog dlgdates = new DatesRangeDialog(dec.DateBegin, dec.DateEnd))
                    {
                        dlgdates.Text = "Новые сроки командировки";
                        if (dlgdates.ShowDialog() == DialogResult.OK)
                        {
                            ICommandManager CM = new UIX.Commands.CommandManager();

                            CM.BeginBatchCommand();

                            Event_BusinessTrip ebt = new Event_BusinessTrip(CM, fs.CurrentChange, MagicNumberController.ChangeTermsEventType, dec.GetTrip(), null, null);
                            CM.Execute(new UIX.Commands.GenericPropertyCommand<Event, Prikaz>(ebt.Event, "Prikaz", (Prikaz)dlg.DialogObject, null), null);
                            CM.Execute(new UIX.Commands.GenericPropertyCommand<Event, Event>(ebt.Event, "Event1", dec.GetTrip().Event, null), null);
                            (BusinessTripsBindingSource.Current as BusinessTripDecorator).ChangeDates(dlgdates.dBegin.Value.Date, dlgdates.dEnd.Value.Date);

                            CM.EndBatchCommand();
                            KadrController.Instance.Model.SubmitChanges();
                        }
                    }
                }
                Read(fs, BusinessTripsBindingSource);
            }
        }
    }
}
