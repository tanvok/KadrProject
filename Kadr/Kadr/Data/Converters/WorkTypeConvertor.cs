using System.Collections;
using System.ComponentModel;
using System.Linq;

namespace Kadr.Data.Converters
{
    class WorkTypeConvertor : SimpleToStringConvertor<WorkType>
    {
        protected override ICollection GetCollection(ITypeDescriptorContext context)
        {
            /*Employee currentEmployee = null;
            if (context.Instance is FactStaffMainBaseDecorator)
            {
                currentEmployee = (context.Instance as FactStaffMainBaseDecorator).Employee;
            }

            if (context.Instance is FactStaffHistoryMainBaseDecorator)
            {
                currentEmployee = (context.Instance as FactStaffHistoryMainBaseDecorator).FactStaff.Employee;
            }

            if (currentEmployee != null)
            {
                //выбираем только договоры (без доп соглашений)
                var res = currentEmployee.FactStaffs.SelectMany(x => x.FactStaffHistories).SelectMany(y => y.Events).Where(x
                        => x.EventKind.ForFactStaff).Where(x => x.Contract != null).Select(z => z.Contract).Where(m => m.idMainContract == null).Where(x => x != currentContract);

                if (res == null)
                    return null;
                List<Contract> resList = res.ToList();
                return resList;
            }
            else*/
            {
                return Controllers.KadrController.Instance.Model.WorkTypes.ToArray();
            }
        }

        public override TypeConverter.StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
        {
            return new StandardValuesCollection(GetCollection(context));
        }

        public override object ConvertFrom(ITypeDescriptorContext context,
        System.Globalization.CultureInfo culture, object value)
        {
            /*if (value == null)
                return NullSocialFareTransit.Instance;*/
            if (value != null && value is string)
            {

                Contract itemSelected = null;
                var c = GetCollection(context);
                foreach (Contract item in c)
                {
                    string itemName = item.ToString();

                    if (itemName.Equals((string)value))
                    {
                        itemSelected = item;
                    }
                }
                return itemSelected;
            }
            else
                return base.ConvertFrom(context, culture, value);
        }

 
    }
}



