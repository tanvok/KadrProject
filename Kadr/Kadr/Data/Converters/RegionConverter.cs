using System.Collections;
using System.ComponentModel;
using System.Linq;

namespace Kadr.Data.Converters
{
    class RegionConverter : SimpleToStringConvertor<RegionType>
    {
        protected override ICollection GetCollection(ITypeDescriptorContext context)
        {
                var res = Controllers.KadrController.Instance.Model.RegionTypes.ToList();
            var resList = res.ToList();
                resList.Add(NullRegionType.Instance);
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
                return NullRegionType.Instance;
            var s = value as string;
            if (s != null)
            {

                RegionType itemSelected = null;
                var c = GetCollection(context);
                foreach (RegionType item in c)
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
