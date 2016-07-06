using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Data.Common;
using Kadr.Controllers;
using System.Data.Linq;

namespace Kadr.Data
{
    public partial class ScienceType : INullable
    {
        public override string ToString()
        {

            return ScienceTypeName;
        }


        
    }



    public class NullScienceType : ScienceType, INull
    {

        private NullScienceType()
        {
            this.id = 0;
        }

        public static readonly NullScienceType Instance = new NullScienceType();

        #region INull Members

        bool  IsNull()
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
