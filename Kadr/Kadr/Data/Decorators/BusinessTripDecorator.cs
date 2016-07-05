using Kadr.Controllers;
using Kadr.Data.Converters;
using Kadr.Interfaces;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.Design;
using System.Data.Linq;
using System.Drawing.Design;
using System.Linq;
using System.Text;

namespace Kadr.Data
{
    [TypeConverter(typeof(PropertySorter))]
    class BusinessTripDecorator: IPrikazTypeProvider
    {

        private BusinessTrip trip;
        //private List<BusinessTripTargetDecorator> tripTargets = new List<BusinessTripTargetDecorator>();
        private List<BusinessTripRegionTypeDecorator> tripRegions = new List<BusinessTripRegionTypeDecorator>();
        private List<FactStaffHistory> selectedFSHs = new List<FactStaffHistory>();
        public BusinessTripDecorator(BusinessTrip Trip)
        {
            this.trip = Trip;

            //tripTargets.AddRange(Trip.BusinessTripTargets.Select(x=>new BusinessTripTargetDecorator(x)));

            tripRegions.AddRange(Trip.BusinessTripRegionTypes.Select(x => x.GetDecorator() as BusinessTripRegionTypeDecorator));

            foreach (Event_BusinessTrip ebt in Trip.Event_BusinessTrips)
                selectedFSHs.Add(ebt.Event.FactStaffHistory);

            /*if (Trip.Event.Prikaz != null)
                if (Trip.Event.Prikaz.DatePrikaz != null)
                    PDate = (DateTime)Trip.Event.Prikaz.DatePrikaz;*/
        }

        public override string ToString()
        {
            return trip.ToString();
        }

        [DisplayName("ID")]
        [Category("Атрибуты")] 
        [Description("Уникальный код командировки")]
        [ReadOnly(true)]
        [Browsable(false)]
        public int ID
        {
            get
            {
                return trip.id;
            }
            
        }

        [DisplayName("Приказ")]
        [Category("1. Основные")]
        [Description("Приказ, назначающий командировку")]
        [ReadOnly(false)]
        [PropertyOrder(1)]
        [Editor(typeof(Kadr.UI.Editors.PrikazEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public Kadr.Data.Prikaz Prikaz
        {
            get
            {
                return trip.Event.Prikaz;
            }
            set
            {
                trip.Event.Prikaz = value;
                if (value != null)
                {
                    if (value.DateBegin != null) DateBegin = (DateTime)value.DateBegin;
                    if (value.DateEnd != null) DateEnd = (DateTime)value.DateBegin;
                }
            }
        }



        [DisplayName("Дата начала")]
        [PropertyOrder(2)]
        [Category("1. Основные")]
        [Description("Дата начала командировки, значащаяся в приказе")]
        [ReadOnly(false)]
        public DateTime DateBegin
        {
            get
            {
                return (DateTime)trip.Event.DateBegin;
            }
            set
            {
                if (value != null)
                {
                    if ((trip.BusinessTripRegionTypes.First().DateBegin == DateBegin)|| 
                        (trip.BusinessTripRegionTypes.First().DateBegin < value))
                        trip.BusinessTripRegionTypes.First().DateBegin = value;

                    trip.Event.DateBegin = value.Date;

                    if (trip.Event.DateBegin > DateEnd)
                        DateEnd = DateBegin;
                }
            }
        }


        [DisplayName("Дата окончания")]
        [PropertyOrder(3)]
        [Category("1. Основные")]
        [Description("Дата окончания командировки, значащаяся в приказе")]
        [ReadOnly(false)]
        public DateTime DateEnd
        {
            get
            {

                return (DateTime)trip.Event.DateEnd;
            }
            set
            {

                if (value != null)
                {
                    if ((trip.BusinessTripRegionTypes.First().DateEnd == DateEnd)||(trip.BusinessTripRegionTypes.First().DateEnd > value.Date)) trip.BusinessTripRegionTypes.First().DateEnd = value.Date;
                    trip.Event.DateEnd = value.Date;

                    if (trip.Event.DateBegin > DateEnd)
                        DateBegin = value.Date;
                }

            }
        }


        [DisplayName("Места пребывания и цели поездки")]
        [Category("1. Основные")]
        [PropertyOrder(4)]
        [Description("Уточните регионы, места и цели пребывания сотрудника во время командировки, если это необходимо")]
        [TypeConverter(typeof(CollectionTypeConverter))]
        //[Editor(typeof(Kadr.UI.Editors.BTRegionEditor), typeof(UITypeEditor))]
        public List<BusinessTripRegionTypeDecorator> TripRegions
        {
            get
            {
                //актуализация коллекции 
                tripRegions.Where(p => p.IsNew).Select(p => p.Type.BusinessTrip = trip);
                trip.BusinessTripRegionTypes.AddRange(tripRegions.Where(p => p.IsNew).Select(p => p.Type));
                tripRegions.Where(p => p.IsNew).Select(p=>p.IsNew = false);

                //удаление регионов, которые были убраны во время редактирования
                var tmp = new List<BusinessTripRegionType>();

                foreach (BusinessTripRegionType btr in trip.BusinessTripRegionTypes)
                    if (!tripRegions.Select(t => t.Type).Contains(btr)) tmp.Add(btr);

                foreach (BusinessTripRegionType btr in tmp)
                {
                    trip.BusinessTripRegionTypes.Remove(btr);
                    //KadrController.Instance.Model.BusinessTripRegionTypes.DeleteOnSubmit(btr);
                }

                return tripRegions;
            }
            set
            {
                tripRegions = value;               
            }

        }


        [DisplayName("Должности командировки")]
        [Category("1. Основные")]
        [PropertyOrder(5)]
        [Description("Укажите, по каким должностям сотрудник отправляется в командировку")]
        [TypeConverter(typeof(CollectionTypeConverter))]
        //[Editor(typeof(UI.Editors.BTStaffHistoriesEditor), typeof(UITypeEditor))]
        public List<FactStaffHistory> SelectedFSHs
        {
            get
            {
                return selectedFSHs;
            }
            set
            {
                selectedFSHs = value;
            }

        }
        


        [DisplayName("Сроки пребывания в регионах уточнены")]
        [Category("4. Информация")]
        [Description("Изменены даты пребывания в регионах командировки")]
        [ReadOnly(true)]
        [Browsable(false)]
        public bool IsRegionDatesChanged
        {
            get
            {
                var list = trip.BusinessTripRegionTypes;
                return ((list.Count > 1) || (list[0].DateBegin != DateBegin) || (list[0].DateEnd != DateEnd));
            }
        }

        [DisplayName("Сроки изменены приказом")]
        [Category("4. Информация")]
        [Description("Изменены даты пребывания в регионах командировки")]
        [ReadOnly(true)]
        [Browsable(false)]
        public bool IsMoved
        {
            get { return trip.IsMoved; }
        }

        [DisplayName("Отменена приказом")]
        [Category("3. Информация")]
        [Description("Приказ отмены командировки")]
        [ReadOnly(false)]
        [Browsable(false)]
        public Prikaz PrikazEnd
        {
            get
            {
                return trip.Event.PrikazEnd;
            }
            set
            {
                trip.Event.PrikazEnd = value;
            }
        }



        [DisplayName("Дней в дороге")]
        [Category("3. Сроки")]
        [PropertyOrder(1)]
        [Description("Сколько дней сотрудник проводит в дороге до места пребывания и обратно. Обратите внимание: число дней в дороге не включает дни пребывания в месте (местах) назначения.")]
        [ReadOnly(false)]
        public int? DaysInRoad
        {
            get
            {
                return trip.DaysInRoad;
            }
            set
            {
                trip.DaysInRoad = value;
            }

        }


        [DisplayName("Всего")]
        [Category("3. Сроки")]
        [PropertyOrder(10)]
        [Description("Сколько дней сотрудник проводит в командировке в сумме")]
        [ReadOnly(false)]
        public int? DaysTotal
        {
            get
            {
                if ((DateBegin!=null)&& (DateEnd != null))
                return (int)Math.Round((DateEnd-DateBegin).TotalDays + 1);

                return null;
            }


        }

        [DisplayName("Не считая времени нахождения в пути")]
        [Category("3. Сроки")]
        [PropertyOrder(11)]
        [Description("Сколько дней сотрудник проводит в командировке без дороги")]
        [ReadOnly(false)]
        public int? DaysNoRoad
        {
            get
            {
                if ((DaysTotal!=null)&&(DaysInRoad != null))
                return DaysTotal-DaysInRoad;

                return null;
            }

        }

        [DisplayName("Финансирование")]
        [Category("2. Дополнительно")]
        [PropertyOrder(2)]
        [Description("За счет каких средств осуществляется командировка")]
        [ReadOnly(false)]
        [TypeConverter(typeof(SimpleToStringConvertor<FinancingSource>))]
        //[Editor(typeof(Kadr.UI.Editors.FinancingSourceEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public FinancingSource FinSource
        {
            get
            {
                return trip.FinancingSource;
            }
            set
            {
                trip.FinancingSource = value;
            }
        }

        [Browsable(false)]
        [ReadOnly(true)]
        public PrikazType PrikazType
        {
            get
            {
                return MagicNumberController.BusinessTripPrikazType;
            }
        }

       
        internal BusinessTrip GetTrip()
        {
            return trip;
        }

        internal BusinessTripRegionType GetRegionType()
        {
            return trip.BusinessTripRegionTypes.FirstOrDefault();
        }

        internal void CancelTrip(Prikaz p)
        {
            foreach (Event_BusinessTrip e in trip.Event_BusinessTrips)
                e.Event.PrikazEnd = p;
        }

        internal void ChangeDates(DateTime beg, DateTime end)
        {
            DateBegin = beg;
            DateEnd = end;

            foreach (Event_BusinessTrip e in trip.Event_BusinessTrips)
            {
                e.Event.DateBegin = beg;
                e.Event.DateEnd = end;
            }
        }
    }

}
