using Kadr.Data.Converters;
using System;
using System.ComponentModel;
using System.ComponentModel.Design;
using System.Drawing.Design;

namespace Kadr.Data
{
    [DisplayName("Место назначения")]
    [TypeConverter(typeof(PropertySorter))]
    internal class BusinessTripTargetDecorator
    {
        //
        private BusinessTripTarget target = null;
        private bool isNew = true;

        public BusinessTripTargetDecorator(BusinessTripTarget target)
        {
            this.target = target;
            isNew = false;
        }

        public BusinessTripTargetDecorator()
        {
            target = new BusinessTripTarget();
        }

        [DisplayName("Место")]
        [Description("Место назначения командировки")]
        [ReadOnly(false)]
        [PropertyOrder(1)]
        public string Place
        {
            get { return target.Place; }
            set { target.Place = value; }
        }

        [DisplayName("Цель")]
        [Description("Цель пребывания")]
        [ReadOnly(false)]
        [PropertyOrder(2)]
        public string Reason
        {
            get { return target.Reason; }
            set { target.Reason = value; }
        }

        [DisplayName("Дата прибытия")]
        [Description("День, в который сотрудник прибудет (или уже прибыл) в данное место")]
        [ReadOnly(false)]
        [PropertyOrder(3)]
        [EditorAttribute(typeof(DateTimeEditor), typeof(UITypeEditor))]
        public DateTime? DateArrival
        {
            get { return target.DateArrival; }
            set { target.DateArrival = value; }
        }

        [DisplayName("Дата отъезда")]
        [Description("День, в который сотрудник покинет (или уже покинул) данное место")]
        [ReadOnly(false)]
        [EditorAttribute(typeof(DateTimeEditor), typeof(UITypeEditor))]
        [PropertyOrder(4)]
        public DateTime? DateDeparture
        {
            get { return target.DateDeparture; }
            set { target.DateDeparture = value; }
        }

        [Browsable(false)]
        public BusinessTripTarget Target
        {
            get { return target; }
        }

        [Browsable(false)]
        public bool IsNew
        {
            get
            {
                return isNew;
            }
        }

        [Browsable(false)]
        public override string ToString()
        {
            return target.ToString();
        }

    }
}