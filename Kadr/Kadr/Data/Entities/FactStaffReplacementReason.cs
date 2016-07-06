using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Data.Common;
using Kadr.Controllers;
using System.Data.Linq;

namespace Kadr.Data
{
    public partial class FactStaffReplacementReason : INullable
    {
        public override string ToString()
        {
            return ReplacementReasonName;
        }
        
       
    }


    public class NullFactStaffReplacementReason : FactStaffReplacementReason, INull
    {

        private NullFactStaffReplacementReason()
        {
            this.id = 0;
        }

        public static readonly NullFactStaffReplacementReason Instance = new NullFactStaffReplacementReason();

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
