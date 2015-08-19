using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Kadr.Data
{
    public partial class BonusPlanStaff : UIX.Views.IDecorable
    {
        public override string ToString()
        {
            return Bonus.ToString();
        }

        #region IDecorable Members

        public object GetDecorator()
        {
            return new BonusPlanStaffDecorator(this);
        }


        #endregion
    }
}
