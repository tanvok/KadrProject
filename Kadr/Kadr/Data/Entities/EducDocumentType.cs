using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Data.Common;
using Kadr.Controllers;
using System.Data.Linq;

namespace Kadr.Data
{
    public partial class EducDocumentType : INullable
    {
        public override string ToString()
        {
            return DocTypeName;
        }
        
    }


    public class NullEducDocumentType : EducDocumentType, INull
    {

        private NullEducDocumentType()
        {
            this.id = 0;
        }

        public static readonly NullEducDocumentType Instance = new NullEducDocumentType();

        #region INull Members

        bool IsNull()
        {
            return true;
        }

        public override string ToString()
        {
            return "(Не задан)";
        }

        #endregion
    }
}
