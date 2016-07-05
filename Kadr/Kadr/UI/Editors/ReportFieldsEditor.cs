using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing.Design;
using System.ComponentModel;
using ClosedXML.Excel;
using Kadr.Reporting;
using Kadr.UI.Dialogs;

namespace Kadr.UI.Editors
{
    [System.Security.Permissions.PermissionSet(System.Security.Permissions.SecurityAction.Demand, Name = "FullTrust")]

    public class ReportFieldsEditor : System.Drawing.Design.UITypeEditor
    {
        public override object EditValue(ITypeDescriptorContext context, IServiceProvider provider, object value)
        {
            using (UI.Dialogs.ReportFieldsDialog dlg = new Dialogs.ReportFieldsDialog())
            {
                dlg.Width += 100;
                dlg.Text = "Выбор полей отчета";
                dlg.CheckObjects = value as CheckableCollection;
               return dlg.ShowDialog() == System.Windows.Forms.DialogResult.OK ? value : value;
            }

        }

        public override UITypeEditorEditStyle GetEditStyle(ITypeDescriptorContext context)
        {
            return UITypeEditorEditStyle.Modal;
        }
    }
}
