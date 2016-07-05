using System.Collections;
using System.ComponentModel;
using System.Linq;

namespace Kadr.Data.Converters
{
    class OKVEDConvertor : SimpleToStringConvertor<OKVED>
    {
        protected override ICollection GetCollection(ITypeDescriptorContext context)
        {
                var res = Kadr.Controllers.KadrController.Instance.Model.OKVEDs;
                if (res == null)
                    return null;
                var resList = res.ToList();
                resList.Add(Kadr.Data.NullOKVED.Instance);
                return resList;
        }

        public override StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
        {
            return new StandardValuesCollection(GetCollection(context));
        }

        public override object ConvertFrom(ITypeDescriptorContext context,
        System.Globalization.CultureInfo culture, object value)
        {
            if (value == null)
                return NullOKVED.Instance;
            var s = value as string;
            if (s != null)
            {

                OKVED itemSelected = null;
                var c = GetCollection(context);
                foreach (OKVED item in c)
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




