using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Kadr.Data;
using Kadr.UI.Common;
using UIX.Commands;

namespace Kadr.Controllers
{
    public static class CRUDDopEducation
    {
        public static void Create(Employee e, FactStaff fs, BindingSource DopEducationBindingSource, object sender)
        {
            

            Read(e, DopEducationBindingSource);
        }

        private static Action<OK_DopEducation> BeforeApplyAction()
        {
            return (x) =>
            {
                if (x.TempPrikaz != null)
                    x.Event = new Event()
                    {
                        FactStaff = x.FactStaff,
                        Prikaz = x.TempPrikaz
                    };
                if ((x.Event == null) || (x.Event.Prikaz != null)) return;
                KadrController.Instance.Model.Events.DeleteOnSubmit(x.Event);
                x.Event = null;
            };
        }

        public static void Read(Employee e, BindingSource DopEducationBindingSource)
        {
            DopEducationBindingSource.DataSource = KadrController.Instance.Model.OK_DopEducations.Where(educ => educ.Employee == e).Select(x => x.GetDecorator()).ToList();
        }

        public static void Update(Employee e,FactStaff fs, BindingSource DopEducationBindingSource)
        {
            

            Read(e, DopEducationBindingSource);
        }

        public static void Delete(Employee e, BindingSource DopEducationBindingSource)
        {
            
            Read(e, DopEducationBindingSource);
        }
    }
}
