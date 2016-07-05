﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Data.Common;
using Kadr.Controllers;
using System.Data.Linq;
using Kadr.Data;


namespace Kadr.Data
{
    public partial class CategoryZP : INullable

    {
        public override string ToString()
        {
            return CategoryZPName;
        }

       
    }

    public class NullCategoryZP : CategoryZP, INull
    {

        private NullCategoryZP()
        {
            this.id = 0;
        }

        public static readonly NullCategoryZP Instance = new NullCategoryZP();

        #region INull Members

        bool IsNull()
        {
            return true;
        }
        public override string ToString()
        {
            return "(Не задана)";
        }

        #endregion
    }
}
