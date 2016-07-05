using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Data.Common;
using Kadr.Controllers;
using System.Data.Linq;

namespace Kadr.Data
{
    public partial class BonusMeasure : INullable
    {
        public override string ToString()
        {
            return MeasureName +" ("+this.Sign+")";
        }

        

        
    }

     public class NullBonusMeasure : BonusMeasure, INull
    {

        private NullBonusMeasure()
        {
            this.id = 0;
        }

        public static readonly NullBonusMeasure Instance = new NullBonusMeasure();

        #region INull Members

        bool IsNull()
        {
            return true;
        }

        public override string ToString()
        {
            return "(Не заданa)";
        }

        #endregion
    }
}
