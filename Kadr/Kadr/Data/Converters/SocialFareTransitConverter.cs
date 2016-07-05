using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;

namespace Kadr.Data.Converters
{
    class SocialFareTransitConverter : SimpleToStringConvertor<SocialFareTransit>
    {
        protected override ICollection GetCollection(ITypeDescriptorContext context)
        {
            if (context.Instance is OK_OtpuskDecorator)
            {
                var res = Kadr.Controllers.KadrController.Instance.Model.SocialFareTransits.Where(x => x.Employee == (context.Instance as OK_OtpuskDecorator).Employee);
                List<SocialFareTransit> resList = res.ToList().Where(x => !x.IsUsed).ToList();
                resList.Add(NullSocialFareTransit.Instance);
                return resList;
            }
            else
            {
                return Controllers.KadrController.Instance.Model.SocialFareTransits.ToArray();
            }
        }

        public override TypeConverter.StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
        {
            return new StandardValuesCollection(GetCollection(context));
        }

        public override object ConvertFrom(ITypeDescriptorContext context,
        System.Globalization.CultureInfo culture, object value)
        {
            if (value == null)
                return NullSocialFareTransit.Instance;
            var s = value as string;
            if (s != null)
            {

                SocialFareTransit itemSelected = null;
                var c = GetCollection(context);
                foreach (SocialFareTransit item in c)
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


