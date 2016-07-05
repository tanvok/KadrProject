using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing.Design;
using System.ComponentModel;
using Kadr.UI.Dialogs;
using Kadr.Data;
using Kadr.Controllers;


namespace Kadr.UI.Editors
{
    [System.Security.Permissions.PermissionSet(System.Security.Permissions.SecurityAction.Demand, Name = "FullTrust")]
    public class EmployeePassportEditor : System.Drawing.Design.UITypeEditor
    {
        public override object EditValue(ITypeDescriptorContext context, IServiceProvider provider, object value)
        {
            Employee currentEmployee = null;

            if (context.Instance is EmployeeDecorator)
            {
                currentEmployee = (context.Instance as EmployeeBaseDecorator).Employee;
            }

            CRUDEmployeeHistory.Read(currentEmployee, this);
            return null;
        }

        public override UITypeEditorEditStyle GetEditStyle(ITypeDescriptorContext context)
        {
            return UITypeEditorEditStyle.Modal;
        }
    }

}



