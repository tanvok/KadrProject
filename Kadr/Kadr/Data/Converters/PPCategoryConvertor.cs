using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;

namespace Kadr.Data.Converters
{
    class PPCategoryConvertor : SimpleToStringConvertor<SalaryKoeff>
    {
        protected override ICollection GetCollection(ITypeDescriptorContext context)
        {
                var res = Controllers.KadrController.Instance.Model.SalaryKoeffs;
                if (res == null)
                    return null;
                List<SalaryKoeff> resList = res.ToList();
                resList.Add(NullSalaryKoeff.Instance);
                return resList.OrderBy(x => x.PKSubSubCategoryNumber).ToList();
        }

        public override TypeConverter.StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
        {
            return new StandardValuesCollection(GetCollection(context));
        }

        public override object ConvertFrom(ITypeDescriptorContext context,
        System.Globalization.CultureInfo culture, object value)
        {
            if (value == null)
                return NullSalaryKoeff.Instance;
            var s = value as string;
            if (s != null)
            {

                SalaryKoeff itemSelected = null;
                var c = GetCollection(context);
                foreach (SalaryKoeff item in c)
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




