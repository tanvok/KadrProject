using Kadr.Data;
using Kadr.UI.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Kadr.Controllers
{
    

    public static class CRUDBusinessTrips
    {

        public static void Read(FactStaff fs, BindingSource BusinessTripsBindingSource)
        {
            BusinessTripsBindingSource.DataSource = KadrController.Instance.Model.BusinessTrips.Where(t => t.Event.FactStaff == fs).ToList();
        }

    }
}
