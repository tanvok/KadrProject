using System;
using System.Collections;
using System.ComponentModel;
using System.Linq;
using Kadr.Data.Common;

namespace Kadr.Data.Converters
{
    class FactStaffConverter : SimpleToStringConvertor<FactStaff>// TypeConverter
    {
        public override bool GetStandardValuesSupported(ITypeDescriptorContext context)
        {
            return true;
        }

        protected override ICollection GetCollection(ITypeDescriptorContext context)
        {
            IList res = null;
            PlanStaff currentPlanStaff = null;
            Employee currentEmployee = null;
            var instance = context.Instance as FactStaffReplacementTransferDecorator;
            if (instance != null)
            {
                currentPlanStaff = instance.PlanStaff;
                currentEmployee = instance.Employee;
            }

            if ((currentPlanStaff == null) || (currentPlanStaff.IsNull()))
                res = Kadr.Controllers.KadrController.Instance.Model.FactStaffs.Where(fs => (fs.DateEnd == null) || (fs.DateEnd >= DateTime.Today)).Where(fs => fs.Employee != currentEmployee).ToArray().OrderBy(fs => fs.ToString()).ToList();
            else
                res = currentPlanStaff.FactStaffs.Where(fs => fs.id > 0).Where(fs => (fs.DateEnd == null) || (fs.DateEnd >= DateTime.Today)).ToArray().OrderBy(fs => fs.ToString()).ToList();
            return res;
        }

        public override TypeConverter.StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
        {
            return new StandardValuesCollection(GetCollection(context));
        }

        public override object ConvertFrom(ITypeDescriptorContext context,
        System.Globalization.CultureInfo culture, object value)
        {
            var s = value as string;
            if (s != null)
            {

                FactStaff itemSelected = null;
                var c = GetCollection(context);
                foreach (FactStaff item in c)
                {
                    string itemName = item.ToString();

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


