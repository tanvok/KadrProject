using System.Collections;
using System.ComponentModel;
using System.Linq;

namespace Kadr.Data.Converters
{
    class FinancingSourceConvertor : SimpleToStringConvertor<FinancingSource>// TypeConverter
    {
        public override bool GetStandardValuesSupported(ITypeDescriptorContext context)
        {
            return true;
        }

        protected override ICollection GetCollection(ITypeDescriptorContext context)
        {
            IList res = Kadr.Controllers.KadrController.Instance.Model.FinancingSources.Where(fs => fs.id < 3).OrderBy(finSource => finSource.FinancingSourceName).ToList();
            res.Add(NullFinancingSource.Instance);
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

                FinancingSource itemSelected = null;
                var c = GetCollection(context);
                foreach (FinancingSource item in c)
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


