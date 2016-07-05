using System.Collections;
using System.ComponentModel;
using System.Linq;

namespace Kadr.Data.Converters
{
    class OK_ReasonConvertor : SimpleToStringConvertor<OK_Reason>
    {
        protected override ICollection GetCollection(ITypeDescriptorContext context)
        {
            var res = Controllers.KadrController.Instance.Model.OK_Reasons.Where(x => !x.is_old.Value).OrderBy(y=>y.reasonname);
            var resList = res.ToList();
            resList.Add(NullOK_Reason.Instance);
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
                return NullOK_Reason.Instance;

            var s = value as string;
            if (s != null)
            {

                OK_Reason itemSelected = null;
                var c = GetCollection(context);
                foreach (OK_Reason item in c)
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

