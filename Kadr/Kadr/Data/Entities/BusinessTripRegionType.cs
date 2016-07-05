using Kadr.Data.Common;
using System;
using System.Data.Linq;
using UIX.Views;
using UIX.Commands;

namespace Kadr.Data
{
    public partial class BusinessTripRegionType : IComparable, IDecorable, IValidatable
    {

        #region Properties

        //public int ID { get { return idRegionType; } set { idRegionType = value; } }

        #endregion

        public BusinessTripRegionType(ICommandManager commandManager,
            BusinessTrip trip, DateTime? beg, DateTime? end, RegionType regionType) : this()
        {
            commandManager.Execute(new UIX.Commands.GenericPropertyCommand<BusinessTripRegionType, DateTime?>(this, "DateBegin", beg, null), null);
            commandManager.Execute(new UIX.Commands.GenericPropertyCommand<BusinessTripRegionType, DateTime?>(this, "DateEnd", end, null), null);
            commandManager.Execute(new UIX.Commands.GenericPropertyCommand<BusinessTripRegionType, RegionType>(this, "RegionType", regionType, null), null);
            commandManager.Execute(new UIX.Commands.GenericPropertyCommand<BusinessTripRegionType, BusinessTrip>(this, "BusinessTrip", trip, null), null);
        }

        public override string ToString()
        {
            if (Place != null) return Place;

            if ((DateBegin != null) && (DateEnd != null))
            {
                if (RegionType != null)
                    return $"{RegionType.RegionTypeName} — с {DateBegin.Value.ToShortDateString()} по {DateEnd.Value.ToShortDateString()}";
                else return $"С {DateBegin.Value.ToShortDateString()} по {DateEnd.Value.ToShortDateString()}";
            }
            if (RegionType != null) return RegionType.RegionTypeName;
            return "Не определено";
        }

        #region partial Methods


        /// <summary>
        /// Проверка всех параметров перед сохранением
        /// </summary>
        /// <param name="action"></param>
        partial void OnValidate(System.Data.Linq.ChangeAction action)
        {
            if ((action == ChangeAction.Insert) || (action == ChangeAction.Update))
            {
                if ((idBusinessTrip == 0) && (BusinessTrip == null)) throw new ArgumentNullException("Командировка");
                if ((idRegionType == 0) && (RegionType == null)) throw new ArgumentNullException("Регион пребывания");

                if (DateBegin > DateEnd) throw new ArgumentOutOfRangeException("Дата начала пребывания в регионе не может быть позже даты окончания!");
                //if ((BusinessTrip.Event.DateBegin > DateBegin) || (BusinessTrip.Event.DateEnd < DateBegin)) throw new ArgumentOutOfRangeException("Дата начала пребывания выходит за рамки командировки!");
                //if ((BusinessTrip.Event.DateBegin > DateEnd) || (BusinessTrip.Event.DateEnd < DateEnd)) throw new ArgumentOutOfRangeException("Дата окончания пребывания выходит за рамки командировки!");
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
            return new BusinessTripRegionTypeDecorator(this);
        }

        #endregion


        public int CompareTo(object obj)
        {
            return ToString().CompareTo(obj.ToString());
        }


        public DateTime StartOfWork => DateBegin.Value;

        public DateTime? EndOfWork => DateEnd.Value;

        

        

        public DateTime Start
        {
            get { return DateBegin.Value; }
            set { DateBegin = value; }
        }
        public DateTime Stop
        {
            get { return DateEnd.Value; }
            set { DateEnd = value; }
        }
        /// <summary>
        /// <remarks>Командировки всегда имеют дату завершения, 
        /// а потому считаются событиями завершёнными</remarks>
        /// </summary>
        public bool IsEnded => true;

        
    }
}
