﻿using Kadr.UI.Editors;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Kadr.Data
{
    class FactStaffHourDecorator
    {
        private FactStaff factStaff;
        public FactStaffHourDecorator(FactStaff factStaff)
        {
            this.factStaff = factStaff;
        }


        public override string ToString()
        {
            return "Почасовики (бюджет) отдела " + factStaff.Department.ToString().ToLower();
        }

        [System.ComponentModel.DisplayName("ID")]
        [System.ComponentModel.Category("Атрибуты")]
        [System.ComponentModel.Description("Уникальный код сотрудника в штатном расписании")]
        [System.ComponentModel.ReadOnly(true)]
        public int ID
        {
            get
            {
                return factStaff.id;
            }
            set
            {
                factStaff.id = value;
            }
        }

        [System.ComponentModel.DisplayName("ФИО сотрудника")]
        [System.ComponentModel.Category("Основные параметры")]
        [System.ComponentModel.Description("ФИО сотрудника, назначенного на должность")]
        [System.ComponentModel.Editor(typeof(Kadr.UI.Editors.EmployeeEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public Kadr.Data.Employee Employee
        {
            get
            {
                return factStaff.Employee;
            }
            set
            {
                factStaff.Employee = value;
            }
        }

        [System.ComponentModel.DisplayName("Количество ставок")]
        [System.ComponentModel.Category("Основные параметры")]
        [System.ComponentModel.Description("Занимаемое сотрудником по факту количество ставок")]
        public decimal StaffCount
        {
            get
            {
                return factStaff.StaffCount;
            }
            set
            {
                factStaff.StaffCount = value;
            }
        }

        [System.ComponentModel.DisplayName("Количество ставок по нагрузке")]
        [System.ComponentModel.Category("Почасовики")]
        [System.ComponentModel.Description("Занимаемое сотрудником количество ставок по нагрузке")]
        [System.ComponentModel.ReadOnly(true)]
        public decimal? HourStaffCount
        {
            get
            {
                return factStaff.HourStaffCount;
            }
        }

        [System.ComponentModel.DisplayName("Количество часов")]
        [System.ComponentModel.Category("Почасовики")]
        [System.ComponentModel.Description("Количество часов для почасовиков")]
        public decimal? HourCount
        {
            get
            {
                return factStaff.HourCount;
            }
            set
            {
                factStaff.HourCount = value;
            }
        }

        [System.ComponentModel.DisplayName("Оплата за час")]
        [System.ComponentModel.Category("Почасовики")]
        [System.ComponentModel.Description("Оплата за час для почасовиков")]
        public decimal? HourSalary
        {
            get
            {
                return factStaff.HourSalary;
            }
            set
            {
                factStaff.HourSalary = value;
            }
        }

        [System.ComponentModel.DisplayName("Отдел")]
        [System.ComponentModel.Category("Общие")]
        [System.ComponentModel.Description("Название отдела")]
        [System.ComponentModel.ReadOnly(true)]
        // [System.ComponentModel.Editor(typeof(Kadr.UI.Editors.PostEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public Kadr.Data.Dep Department
        {
            get
            {
                return factStaff.Department;
            }
        }

        [System.ComponentModel.DisplayName("Название вида работы")]
        [System.ComponentModel.Category("Основные параметры")]
        [System.ComponentModel.Description("Название вида работы")]
        //[System.ComponentModel.Editor(typeof(Kadr.UI.Editors.WorkTypeEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public Kadr.Data.WorkType WorkType
        {
            get
            {
                return factStaff.WorkType;
            }
            set
            {
                factStaff.WorkType = value;
            }
        }

        [System.ComponentModel.DisplayName("Источник финансирования")]
        [System.ComponentModel.Category("Почасовики")]
        [System.ComponentModel.Description("Источник финансирования (редактировать для почасовиков)")]
        [System.ComponentModel.TypeConverter(typeof(Kadr.Data.Converters.FinancingSourceConvertor))]
        //[System.ComponentModel.Editor(typeof(Kadr.UI.Editors.FinancingSourceEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public Kadr.Data.FinancingSource FinancingSource
        {
            get
            {
                return factStaff.FinancingSource;
            }
            set
            {
                factStaff.FinancingSource = value;
            }
        }

        [System.ComponentModel.DisplayName("Приказ утверждения")]
        [System.ComponentModel.Category("Основные параметры")]
        [System.ComponentModel.Description("Приказ назначения сотрудника")]
        [System.ComponentModel.Editor(typeof(Kadr.UI.Editors.PrikazEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public Kadr.Data.Prikaz PrikazBegin
        {
            get
            {
                return factStaff.PrikazBegin;
            }
            set
            {
                factStaff.PrikazBegin = value;
            }
        }

        [System.ComponentModel.DisplayName("Приказ увольнения")]
        [System.ComponentModel.Category("Параметры увольнения")]
        [System.ComponentModel.Description("Приказ увольнения сотрудника")]
        [System.ComponentModel.Editor(typeof(Kadr.UI.Editors.PrikazEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public Kadr.Data.Prikaz PrikazEnd
        {
            get
            {
                return factStaff.Prikaz;
            }
            set
            {
                factStaff.Prikaz = value;
            }
        }

        [System.ComponentModel.DisplayName("Дата назначения")]
        [System.ComponentModel.Category("Основные параметры")]
        [System.ComponentModel.Description("Дата назначения на должность")]
        // [System.ComponentModel.Editor(typeof(Kadr.UI.Editors.PostEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public DateTime DataBegin
        {
            get
            {
                return Convert.ToDateTime(factStaff.DateBegin);
            }
            set
            {
                factStaff.DateBegin = value;
            }
        }

        [System.ComponentModel.DisplayName("Дата увольнения")]
        [System.ComponentModel.Category("Параметры увольнения")]
        [System.ComponentModel.Description("Дата снятия с должности")]
        // [System.ComponentModel.Editor(typeof(Kadr.UI.Editors.PostEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public DateTime DataEnd
        {
            get
            {
                return Convert.ToDateTime(factStaff.DateEnd);
            }
            set
            {
                factStaff.DateEnd = value;
            }
        }

        [System.ComponentModel.DisplayName("Комментарий")]
        [System.ComponentModel.Category("Почасовики")]
        [System.ComponentModel.Description("Комментарий")]
        // [System.ComponentModel.Editor(typeof(Kadr.UI.Editors.PostEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public string Comment
        {
            get
            {
                return factStaff.Comment;
            }
            set
            {
                factStaff.Comment = value;
            }
        }

        [System.ComponentModel.DisplayName("Центр затрат")]
        [System.ComponentModel.Category("Основные параметры")]
        [System.ComponentModel.Description("Центр затрат")]
        [System.ComponentModel.Editor(typeof(FundingCenterEditor), typeof(System.Drawing.Design.UITypeEditor))]
        public FundingCenter FundingCenter
        {
            get
            {
                return factStaff.FundingCenter;
            }
            set
            {
                factStaff.FundingCenter = value;
            }
        }

    }

}
