using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Data.Common;
using Kadr.Controllers;
using System.Data.Linq;

namespace Kadr.Data
{
    public partial class BonusSuperType : INullable
    {

        public override string ToString()
        {
            return BonusSuperTypeName;
        }

        
    }

    public class NullBonusSuperType : BonusSuperType, INullable
    {

        private NullBonusSuperType()
        {
            this.id = 0;
        }

        public static readonly NullBonusSuperType Instance = new NullBonusSuperType();

        #region INull Members

        

        public override string ToString()
        {
            return "(Не задан)";
        }

        #endregion
    }
}
