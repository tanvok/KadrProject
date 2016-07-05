using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Data.Common;

namespace Kadr.Data
{
    public partial class FundingCenter: INullable
    {
        public override string ToString()
        {
            return FundingCenterName;
        }

       
    }


    public class NullFundingCenter : FundingCenter, INull
    {

        private NullFundingCenter()
        {
            this.id = 0;
        }

        public static readonly NullFundingCenter Instance = new NullFundingCenter();

        #region INull Members

        bool IsNull()
        {
            return true;
        }

        public override string ToString()
        {
            return "(По умолчанию)";
        }

        #endregion
    }
}
