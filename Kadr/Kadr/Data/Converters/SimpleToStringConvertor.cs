using Kadr.Interfaces;
using Kadr.Controllers;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using Kadr.Data.Common;
using Kadr.Properties;

namespace Kadr.Data.Converters
{
    class SimpleToStringConvertor<T> : SimpleToStringWithoutNullConvertor<T>
        where T:class
    {
        protected override ICollection GetCollection(System.ComponentModel.ITypeDescriptorContext context)
        {
            if (col != null) return col;

            col = base.GetCollection(context);

            //Для пункта "(Не задано)"

            if (col.Count > 0)
                if (typeof(INullable).IsAssignableFrom(typeof(T)))
                    (col as System.Collections.Generic.List<T>).Add((T)((col as List<T>)[0] as INullable).GetNullInstance());

            return col;


        }
    }


}
