﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing.Design;
using System.ComponentModel;


namespace Kadr.UI.Editors
{
    [System.Security.Permissions.PermissionSet(System.Security.Permissions.SecurityAction.Demand, Name = "FullTrust")]
    public class PostEditor : System.Drawing.Design.UITypeEditor
    {
        public override object EditValue(ITypeDescriptorContext context, IServiceProvider provider, object value)
        {
            using (Common.ListSelectDialog<Kadr.Data.Post> dlg = new Kadr.UI.Common.ListSelectDialog<Kadr.Data.Post>())
            {
                
                dlg.Text = "Должность";
                dlg.QueryText = "Выберите должность";
                dlg.DataSource = Kadr.Controllers.KadrController.Instance.Model.Posts.OrderBy(p => p.PostName);
                dlg.SelectedValue = (Kadr.Data.Post)value;

                if (dlg.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                    if (dlg.SelectedValue == null)
                        return Kadr.Data.NullPost.Instance;
                    else
                        return dlg.SelectedValue;
                else
                    return value;
            }
            
        }

        public override UITypeEditorEditStyle GetEditStyle(ITypeDescriptorContext context)
        {
            return UITypeEditorEditStyle.Modal;
        }
    }

}


