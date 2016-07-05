using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;

namespace Kadr.Data.Converters
{
    class ContractConvertor : SimpleToStringConvertor<Contract>
    {
        protected override ICollection GetCollection(ITypeDescriptorContext context)
        {
            Employee currentEmployee = null;
            Contract currentContract = null;
            var instance = context.Instance as FactStaffMainBaseDecorator;
            if (instance != null)
            {
                currentEmployee = instance.Employee;
                currentContract = instance.CurrentContract;
            }

            var decorator = context.Instance as FactStaffHistoryMinDecorator;
            if (decorator != null)
            {
                currentEmployee = decorator.FactStaff.Employee;
                currentContract = decorator.CurrentContract;
            }

            if (currentEmployee != null)
            {
                //выбираем только договоры (без доп соглашений)
                var res = currentEmployee.FactStaffs.SelectMany(x => x.FactStaffHistories).SelectMany(y => y.Events).Where(x
                        => x.EventKind.ForFactStaff).Where(x => x.Contract != null).Select(z => z.Contract).Where(m => m.idMainContract == null).Where(x => x != currentContract);

                List<Contract> resList = res?.ToList();
                return resList;
            }
            else
            {
                return Controllers.KadrController.Instance.Model.Contracts.Where(x => x.MainContract == null).ToArray();
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
            var s = value as string;
            if (s != null)
            {

                Contract itemSelected = null;
                var c = GetCollection(context);
                foreach (Contract item in c)
                {
                    var itemName = item.ToString();

                    if (itemName.Equals(s))
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


