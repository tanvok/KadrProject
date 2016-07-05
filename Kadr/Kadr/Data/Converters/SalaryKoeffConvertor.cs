using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;

namespace Kadr.Data.Converters
{
    class SalaryKoeffConvertor : SimpleToStringConvertor<SalaryKoeff>
    {
        protected override ICollection GetCollection(System.ComponentModel.ITypeDescriptorContext context)
        {
            var res = Kadr.Controllers.KadrController.Instance.Model.SalaryKoeffs.OrderBy(x => x.PKSubSubCategoryNumber);
            List<SalaryKoeff> resList = res.ToList();
            resList.Add(NullSalaryKoeff.Instance);
            return resList;
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

