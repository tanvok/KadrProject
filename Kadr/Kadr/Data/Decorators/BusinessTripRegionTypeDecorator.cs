using Kadr.Data.Converters;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace Kadr.Data
{
    [DisplayName("Место пребывания")]
    [TypeConverter(typeof(PropertySorter))]
    class BusinessTripRegionTypeDecorator
    {
        private BusinessTripRegionType type = null;
        private bool isNew = true;

        public BusinessTripRegionTypeDecorator(BusinessTripRegionType Type)
        {
            this.type = Type;
            isNew = false;
        }

        public BusinessTripRegionTypeDecorator()
        {
            this.type = new BusinessTripRegionType();
        }

        public override string ToString()
        {
            return type.ToString();
        }

        [Browsable(false)]
        public BusinessTripRegionType Type
        {
            get { return type; }
        }

        [Category("1. Место")]
        [PropertyOrder(2)]
        [DisplayName("Территориальные условия")]
        [Description("В какой регион командируется сотрудник")]
        [ReadOnly(false)]
        [TypeConverter(typeof(Kadr.Data.Converters.SimpleToStringConvertor<RegionType>))]

        public RegionType TripMainRegion
        {
            get
            {
                return type.RegionType;
            }

            set
            {
                type.RegionType = value;
            }

        }


        [DisplayName("Дата начала")]
        [Category("2. Сроки")]
        [Description("Дата начала пребывания в регионе")]
        [ReadOnly(false)]
        public DateTime? DateBegin
        {
            get
            {
                return type.DateBegin;
            }
            set
            {
                if (value != null)
                {
                    type.DateBegin = value.Value.Date;
                }
                else
                    type.DateBegin = value;

            }
        }

        [System.ComponentModel.DisplayName("Дата окончания")]
        [System.ComponentModel.Category("2. Сроки")]
        [System.ComponentModel.Description("Дата окончания пребывания в регионе")]
        [System.ComponentModel.ReadOnly(false)]
        public DateTime? DateEnd
        {
            get
            {
                return type.DateEnd;
            }
            set
            {

                if (value != null)
                {
                    type.DateEnd = value.Value.Date;
                }
                else
                    type.DateEnd = value;

            }
        }

        [Category("1. Место")]
        [PropertyOrder(1)]
        [DisplayName("Место назначения")]
        [Description("В какой город/организацию/объект командируется сотрудник")]
        [ReadOnly(false)]
        //[System.ComponentModel.TypeConverter(typeof(Kadr.Data.Converters.SimpleToStringConvertor<RegionType>))]

        public string Place
        {
            get
            {
                return type.Place;
            }

            set
            {
                type.Place = value;
            }

        }

        [Category("2. Цели")]
        [DisplayName("Цели пребывания")]
        [Description("С какими целями (через запятую) сотрудник направляется в данное место")]
        [ReadOnly(false)]
        //[System.ComponentModel.TypeConverter(typeof(Kadr.Data.Converters.SimpleToStringConvertor<RegionType>))]

        public string Reason
        {
            get
            {
                return type.Reason;
            }

            set
            {
                type.Reason = value;
            }

        }

        [Category("2. Сроки")]
        [DisplayName("Дней")]
        [Description("Сколько дней сотрудник пребывает в данном месте")]
        [ReadOnly(false)]
        //[System.ComponentModel.TypeConverter(typeof(Kadr.Data.Converters.SimpleToStringConvertor<RegionType>))]
        public int? Days
        {
            get
            {
                if ((DateBegin != null) && (DateEnd != null))
                    return (int)Math.Round((DateEnd.Value - DateBegin.Value).TotalDays + 1);

                return null;
            }
        }

        [Browsable(false)]
        public bool IsNew
        {
            get
            {
                return isNew;
            }
            set
            {
                isNew = value;
            }
        }

    }
}
