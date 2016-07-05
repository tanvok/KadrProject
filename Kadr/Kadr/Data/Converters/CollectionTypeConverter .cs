using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.Linq;
using System.Text;

namespace Kadr.Data.Converters
{
    class CollectionTypeConverter : TypeConverter
    {
        /// <summary>
        /// Только в строку
        /// </summary>
        public override bool CanConvertTo(
          ITypeDescriptorContext context, Type destType)
        {
            return destType == typeof(string);
        }

        /// <summary>
        /// И только так
        /// </summary>
        public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture,object value, Type destType)
        {
            if (value == null) return "";



            if (value is IEnumerable)
            {
                var col = (value as IEnumerable).OfType<object>();
                if (col.Count() > 0)
                    if (col.Count() > 1)
                        return col.Aggregate((x, y) => string.Format("{0}; {1}", x.ToString(), y.ToString()));
                    else return col.ToList()[0].ToString();
                else return "";
            }
            

            return "Список...";
        }
    }
}
