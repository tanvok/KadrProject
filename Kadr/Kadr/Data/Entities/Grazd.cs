﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Data.Common;

namespace Kadr.Data
{
    public partial class Grazd : INullable, IComparable
    {
        public override string ToString()
        {
            return this.grazdName;
        }



        


        public int CompareTo(object obj)
        {
            return grazdName.CompareTo(obj.ToString());
        }
    }

    public class NullGrazd : Grazd, INull
    {

        private NullGrazd()
        {
            this.id = 0;
        }

        public static readonly NullGrazd Instance = new NullGrazd();

        #region INull Members

        bool IsNull()
        {
            return true;
        }
        public override string ToString()
        {
            return "(Не заданo)";
        }

        #endregion
    }
}
