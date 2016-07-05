using Kadr.Controllers;
using Kadr.Data.Common;
using System;
using System.Data.Linq;
using System.Linq;
using System.Text;

namespace Kadr.Data
{
    public partial class BusinessTrip : UIX.Views.IDecorable, UIX.Views.IValidatable, INullable, IObjectState, IComparable
    {
        #region Properties
        private BusinessTripDecorator decorator;

        #endregion

        public Event Event
        {
            get
            {
                return Event_BusinessTrips.Select(x => x.Event).FirstOrDefault(x => x.EventType == MagicNumberController.BeginEventType);
            }
        }

        public Event ChangeTermsEvent
        {
            get
            {
                return Event_BusinessTrips.Select(x => x.Event).FirstOrDefault(x => x.EventType == MagicNumberController.ChangeTermsEventType);
            }
        }


        public string TripTarget
        {
            get
            {
                if (BusinessTripRegionTypes.Count > 0) return BusinessTripRegionTypes[0].Reason;
                else return null;
            }
        }

        public bool IsCorrect
        {
            get
            {
                try
                {
                    CheckCorrectness();
                    return true;
                }
                catch
                {
                    return false;
                }

            }
        }

        public bool IsMoved
        {
            get { return ChangeTermsEvent != null; }
        }

        public bool IsCanceled
        {
            get { return Event.PrikazEnd != null; }
        }

        public override string ToString()
        {
            StringBuilder sb = new StringBuilder("Командировка. ");
            if (Event.FactStaff != null)
                if (Event.FactStaff.Employee != null)
                    sb.Append($"Сотрудник: {Event.FactStaff.Employee.ToString()}.");

            if (!string.IsNullOrEmpty(TripTarget) && (id != 0)) sb.Append($" Место:{TripTargetPlace}");
            if ((Event.DateBegin != null) && (id != 0)) sb.Append($"Выезд: {Event.DateBegin.ToString()}");
            return sb.ToString();

        }

        #region partial Methods


        public void CheckCorrectness()
        { 
                if (Event.DateEnd<Event.DateBegin)
                        throw new ArgumentOutOfRangeException("Дата окончания командировки. Дата окончания командировки должна быть не раньше даты начала командировки");

                if (DaysInRoad!= null)
                if ((DaysInRoad > ((Event.DateEnd - Event.DateBegin).Value.Days+1)) || (DaysInRoad <= 0))
                    throw new ArgumentOutOfRangeException("Количество дней в дороге. Обратите внимание, что дни в дороге включают только дни, проведенные в пути, но не в месте назначения");

                foreach (BusinessTripRegionType btr in BusinessTripRegionTypes)
                {
                   

                    if (btr.DateBegin > btr.DateEnd)
                        throw new ArgumentOutOfRangeException(string.Format("Даты пребывания в месте назначения. Дата начала пребывания в  {0} не может быть больше даты окончания пребывания в регионе", btr.Place));

                    if (btr.DateBegin<Event.DateBegin)
                        throw new ArgumentOutOfRangeException(string.Format("Дата начала пребывания в месте назначения. Дата начала пребывания в {0} не может быть раньше даты начала командировки", btr.Place));

                    if (btr.DateEnd > Event.DateEnd)
                        throw new ArgumentOutOfRangeException(string.Format("Дата окончания пребывания в месте назначения. Дата окончания пребывания в {0} не может быть позже даты окончания командировки", btr.Place));

                    foreach (BusinessTripRegionType btr2 in BusinessTripRegionTypes)
                        if (btr!= btr2)
                            if ((btr2.DateBegin<btr.DateEnd) && (btr2.DateEnd > btr.DateBegin)) throw new ArgumentOutOfRangeException(string.Format("Сроки пребывания в местах назначения. Проверьте сроки пребывания в местах назначения {0} и {1}, они пересекаются", btr.ToString(), btr2.ToString()));
                    
                }
    }

    /// <summary>
    /// Проверка всех параметров перед сохранением
    /// </summary>
    /// <param name="action"></param>
    partial void OnValidate(System.Data.Linq.ChangeAction action)
        {
            if ((action == ChangeAction.Insert) || (action == ChangeAction.Update))
            {
                if (Event == null) throw new ArgumentNullException("Приказ");

                if (Event.Prikaz == null) throw new ArgumentNullException("Приказ");

                if (Event.Prikaz.IsNull()) throw new ArgumentNullException("Приказ");

                if (BusinessTripRegionTypes.Count()==0) throw new ArgumentNullException("Регион пребывания");

                //if (FinancingSource==null) throw new ArgumentNullException("Источник финансирования");
                //if (TripTargetPlace == null) throw new ArgumentNullException("Место назначения");
                //if (TripTargetPlace == "") throw new ArgumentNullException("Место назначения");

                if (Event.DateBegin == null) throw new ArgumentNullException("Срок начала командировки");
                if (Event.DateEnd == null) throw new ArgumentNullException("Срок окончания командировки");


                }
        }

        #endregion

        #region IValidatable Members

        void UIX.Views.IValidatable.Validate()
        {
            OnValidate(ChangeAction.Insert);
        }

        #endregion

        #region IDecorable Members

        public object GetDecorator()
        {
            if (decorator == null)  decorator = new BusinessTripDecorator(this);
            return decorator;
        }

        #endregion

        #region IObjectState Members

        ObjectState IObjectState.State()
        {
            //TODO: статус приказа по персоналу должен определяться тем, есть ли отменяющий его приказ
            return ObjectState.Current;

        }

        #endregion

        public int CompareTo(object obj)
        {
            return this.ToString().CompareTo(obj.ToString());
        }



    }
}
