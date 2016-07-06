﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Data.Common;
using Kadr.Controllers;
using System.Data.Linq;
using System.Data.Linq.Mapping;

namespace Kadr.Data
{
    public partial class  PKGroup: INullable
    {
        public override string ToString()
        {
            return this.GroupNumber + " (" + this.GroupName + ")";
        }

        public string GroupFullName
        {
            get
            {
                return GroupNumber + " (" + this.GroupName + ")";
            }
        }


        
    }

    public class NullPKGroup: PKGroup, INull
    {
        private NullPKGroup()
        {
            this.id = 0;
        }

        public static NullPKGroup Instance = new NullPKGroup();

        public override string ToString()
        {
            return "Не указана";
        }


        #region Члены INull

        bool IsNull()
        {
            return true;
        }

        #endregion
    }
}
