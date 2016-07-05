using Kadr.Data;
using Kadr.UI.Editors;
using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Kadr.UI.Editors
{
    [System.Security.Permissions.PermissionSet(System.Security.Permissions.SecurityAction.Demand, Name = "FullTrust")]
    class BTRegionEditor : CustomCollectionEditor
    {
        public BTRegionEditor(Type t) : base("Места пребывания и цели поездки", "Место пребывания", t)
        {

        }

        /*protected override CollectionForm CreateCollectionForm()
        {
            var res = base.CreateCollectionForm();

            res.Width = 800;

            return res;
        }*/
    }
}
