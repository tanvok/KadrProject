using System;
using System.ComponentModel;
using System.Drawing.Design;
using System.Windows.Forms;

namespace Kadr.UI.Editors
{
    [System.Security.Permissions.PermissionSet(System.Security.Permissions.SecurityAction.Demand, Name = "FullTrust")]
    internal class SaveFileDialogEditor : UITypeEditor
    {

        public override object EditValue(ITypeDescriptorContext context, IServiceProvider provider, object value)
        {
            using (var fbdlg = new SaveFileDialog())
            {
                if (fbdlg.ShowDialog() == DialogResult.OK) return fbdlg.FileName;
            }
            return value;
        }


        public override UITypeEditorEditStyle GetEditStyle(ITypeDescriptorContext context)
        {
            return UITypeEditorEditStyle.Modal;
        }

    }
}