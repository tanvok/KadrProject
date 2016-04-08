﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace Kadr.Data.Converters
{
class SocialStatusToStringConverter : SimpleToStringConvertor<OK_SocialStatus>
    {
        protected override ICollection GetCollection(ITypeDescriptorContext context)
        {
             ICollection res = base.GetCollection(context).Cast<OK_SocialStatus>().Where(x=>x!=null).Where(x => (bool)!x.is_old).OrderBy(y=>y.SocialStatusName).ToList();

            (res as IList).Add(null);

            return res;
        }
    }
}
