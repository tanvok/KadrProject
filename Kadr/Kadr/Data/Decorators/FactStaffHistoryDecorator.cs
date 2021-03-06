﻿using Kadr.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Kadr.Data
{
    class FactStaffHistoryDecorator
    {
        private FactStaffHistory factStaffHistory;
        public FactStaffHistoryDecorator(FactStaffHistory factStaffHistory)
        {
            this.factStaffHistory = factStaffHistory;
        }

        override public string ToString()
        {
            return factStaffHistory.ToString();
        }


        [System.ComponentModel.DisplayName("Дата изменения")]
        [System.ComponentModel.Category("Основные атрибуты изменения")]
        [System.ComponentModel.Description("Дата изменения")]
        [System.ComponentModel.ReadOnly(true)]
        public DateTime DateBegin
        {
            get
            {
                return factStaffHistory.DateBegin;
            }
            set
            {
                factStaffHistory.DateBegin = value;

            }
        }

        [System.ComponentModel.DisplayName("Приказ изменения")]
        [System.ComponentModel.Category("Основные атрибуты изменения")]
        [System.ComponentModel.Description("Приказ изменения записи в штатном расписании")]
        //[System.ComponentModel.Editor(typeof(Kadr.UI.Editors.PrikazEditor), typeof(System.Drawing.Design.UITypeEditor))]
        [System.ComponentModel.ReadOnly(true)]
        public Prikaz PrikazBegin
        {
            get
            {
                return factStaffHistory.Prikaz;
            }
            set
            {
                factStaffHistory.Prikaz = value;
            }
        }


        [System.ComponentModel.DisplayName("Новый вид работы")]
        [System.ComponentModel.Category("Новые значения атрибутов")]
        [System.ComponentModel.Description("Новый вид работы сотрудника")]
        //[System.ComponentModel.TypeConverter(typeof(Kadr.Data.Converters.SimpleToStringConvertor<WorkType>))]
        [System.ComponentModel.ReadOnly(true)]
        public WorkType WorkType
        {
            get
            {
                return factStaffHistory.WorkType;
            }
            set
            {
                factStaffHistory.WorkType = value;
            }
        }


        [System.ComponentModel.DisplayName("Количество ставок")]
        [System.ComponentModel.Category("Новые значения атрибутов")]
        [System.ComponentModel.Description("Новое количество ставок сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public decimal StaffCount
        {
            get
            {
                return factStaffHistory.StaffCount;
            }
            set
            {
                if (value >= 0.1M)
                {
                    factStaffHistory.StaffCount = value;
                }
                else
                    throw new ApplicationException("Количество ставок не может быть меньше 0,1.");
            }
        }



        [System.ComponentModel.DisplayName("Подподкатегория")]
        [System.ComponentModel.Category("Новые значения атрибутов")]
        [System.ComponentModel.Description("Подподкатегория (определяет коэффициент к окладу сотрудника)")]
        [System.ComponentModel.ReadOnly(true)]
        public int? SalaryKoeff
        {
            get
            {
                if (factStaffHistory.SalaryKoeff != null)
                    return factStaffHistory.SalaryKoeff.PKSubSubCategoryNumber;
                return null;
            }
            set
            {
                factStaffHistory.SalaryKoeff = KadrController.Instance.Model.SalaryKoeffs.Where(koef => koef.PKSubSubCategoryNumber == value).FirstOrDefault();
            }
        }



        [System.ComponentModel.DisplayName("Отдел")]
        [System.ComponentModel.Category("Общие")]
        [System.ComponentModel.Description("Название отдела")]
        [System.ComponentModel.ReadOnly(true)]
        public Kadr.Data.Dep Department
        {
            get
            {
                return factStaffHistory.FactStaff.Department;
            }
        }

    }
}
