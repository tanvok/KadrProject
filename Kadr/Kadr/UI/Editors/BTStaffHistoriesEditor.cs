using Kadr.Controllers;
using Kadr.Data;
using Kadr.UI.Dialogs;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing.Design;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Kadr.UI.Editors
{

    [System.Security.Permissions.PermissionSet(System.Security.Permissions.SecurityAction.Demand, Name = "FullTrust")]
    public class BTStaffHistoriesEditor : System.Drawing.Design.UITypeEditor
    {
        public override object EditValue(ITypeDescriptorContext context, IServiceProvider provider, object value)
        {
            if (context.Instance is BusinessTripDecorator)
                {
                FactStaff fs = (context.Instance as BusinessTripDecorator).GetTrip().Event.FactStaff;

                List<FactStaffHistory> fshs = KadrController.Instance.Model.FactStaffs.Where(f => (f.Employee == fs.Employee) && ((f.DateEnd == null)||(f.DateEnd >DateTime.Today))).Select(f => f.CurrentChange).ToList();

                fshs = fshs.Where(f => f.WorkType != MagicNumberController.hourWorkType).ToList();
                var sel = (context.Instance as BusinessTripDecorator).SelectedFSHs;

                using (FSHSelectionDialog dlg = new FSHSelectionDialog(fshs, sel, (context.Instance as BusinessTripDecorator).GetTrip().Event.FactStaffHistory))
                {

                    dlg.Text = "Выберите должности, по которым осуществляется командировка";

                    if (dlg.ShowDialog() == DialogResult.OK)
                        return dlg.SelectedHistories;
                }
                return (context.Instance as BusinessTripDecorator).SelectedFSHs;
                }
            return null;
        }

        public override UITypeEditorEditStyle GetEditStyle(ITypeDescriptorContext context)
        {
            return UITypeEditorEditStyle.Modal;
        }
    }
}
