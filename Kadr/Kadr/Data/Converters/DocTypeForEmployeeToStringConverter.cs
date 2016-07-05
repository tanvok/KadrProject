using Kadr.Data.Converters;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace Kadr.Data
{
    //Конвертер выводит только типы документов с назначением Идентификационный документ, Разрешение на работу и Регистрация
    class DocTypeForEmployeeToStringConverter : SimpleToStringConvertor<EducDocumentType>
    {
        protected override ICollection GetCollection(ITypeDescriptorContext context)
        {
            var a = base.GetCollection(context).Cast<EducDocumentType>();

            IList res = a.Where((x => x != null && !x.isOld)).Where(x => x.DocPurposeForTypes.FirstOrDefault(z => z.idPurpose == 1) != null
                                                                                                           || x.DocPurposeForTypes.FirstOrDefault(z => z.idPurpose == 4) != null
                                                                                                           || x.DocPurposeForTypes.FirstOrDefault(z => z.idPurpose == 5) != null).ToList();
           // IList res = base.GetCollection(context).Cast<DocPurposeForTypes>().Where(x => x != null).Where(p => !p.isOld).ToList().Where(x => x.);
            res.Add(NullEducDocumentType.Instance);
            return res;
        }
    }
}
