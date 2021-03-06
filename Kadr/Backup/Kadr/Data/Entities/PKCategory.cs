﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Data.Common;
using Kadr.Controllers;
using System.Data.Linq;

namespace Kadr.Data
{
    public partial class PKCategory : UIX.Views.IDecorable, UIX.Views.IValidatable, INull,IComparable
    {
        public override string ToString()
        {
            return Convert.ToString(this.PKGroup.GroupNumber)+" - "+
                Convert.ToString(this.PKCategoryNumber);
        }

        public bool HaveSalary
        {
            get
            {
                return (PKCategorySalary != null);
            }
        }

        public PKCategorySalary PKCategorySalary
        {
            get
            {
                if (PKCategorySalaries.Where(catSal => (catSal.DateEnd == null) && (catSal.SalarySize > 0)).Count() > 0)
                    return PKCategorySalaries.Where(catSal => (catSal.DateEnd == null) && (catSal.SalarySize > 0)).Last() as PKCategorySalary;
                else
                    return null;
            }
        }

        #region IDecorable Members

        public object GetDecorator()
        {
            return new PKCategoryDecorator(this);
        }


        #endregion


        #region partial Methods

        partial void OnCreated()
        {
            //DateBegin = DateTime.Today;
            //this.
        }

        /// <summary>
        /// Проверка всех параметров перед сохранением
        /// </summary>
        /// <param name="action"></param>
        partial void OnValidate(System.Data.Linq.ChangeAction action)
        {
            if ((action == ChangeAction.Insert) || (action == ChangeAction.Update))
            {
                if (this.PKGroup.IsNull()) throw new ArgumentNullException("Профессиональная группа.");
                if (this.PKCategoryNumber < 0) throw new ArgumentOutOfRangeException("Номер профессиональной категории.");
            }
        }
        #endregion


        #region IValidatable Members

        void UIX.Views.IValidatable.Validate()
        {
            OnValidate(ChangeAction.Insert);
        }

        #endregion



        #region Члены INull

        bool INull.IsNull()
        {
            return false;
        }

        #endregion

        #region Члены IComparable

        public int CompareTo(object obj)
        {
            return ToString().CompareTo(obj.ToString());
        }

        #endregion
    }

    public class NullPKCategory : PKCategory, INull
    {

        private NullPKCategory()
        {
            this.id = 0;
        }

        public static readonly NullPKCategory Instance = new NullPKCategory();

        #region INull Members

        bool INull.IsNull()
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




