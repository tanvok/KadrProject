﻿using Kadr.UI.Editors;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Data.Converters;

namespace Kadr.Data
{
    class EmployeeDecorator
    {
        private Employee employee;
        public EmployeeDecorator(Employee employee)
        {
            this.employee = employee;
        }

        override public string ToString()
        {

            return "Сотрудник " + employee.EmployeeSmallName;
        }

        [System.ComponentModel.DisplayName("ID")]
        [System.ComponentModel.Category("Атрибуты")]
        [System.ComponentModel.Description("Уникальный код сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
       // [System.ComponentModel.Browsable(false)]
        public int ID
        {
            get
            {
                return employee.id;
            }
            set
            {
                employee.id = value;
            }
        }

        [System.ComponentModel.DisplayName("Табельный номер")]
        [System.ComponentModel.Category("Атрибуты")]
        [System.ComponentModel.Description("Табельный номер сотрудника в системе отдела кадров")]
        [System.ComponentModel.ReadOnly(true)]
        public string itab_n
        {
            get
            {

                return (employee.itab_n);
            }
            set
            {
                employee.itab_n = value;
            }
        }

        [System.ComponentModel.DisplayName("\t\tФамилия")]
        [System.ComponentModel.Category("\tФамилия, имя, отчество")]
        [System.ComponentModel.Description("Фамилия сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public string LastName
        {
            get
            {
                return employee.LastName;
            }
            set
            {
                employee.LastName = value;
            }
        }

        [System.ComponentModel.DisplayName("Пол")]
        [System.ComponentModel.Category("Личные данные")]
        [System.ComponentModel.Description("Пол сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        [System.ComponentModel.TypeConverter(typeof(Kadr.UI.Common.GenderBooleanConverter))]//Kadr.UI.Common.CustomBooleanConverter
        public bool SexBit
        {
            get
            {
                return employee.SexBit;
            }
            set
            {
                employee.SexBit = value;
            }
        }

        [System.ComponentModel.DisplayName("\tИмя")]
        [System.ComponentModel.Category("\tФамилия, имя, отчество")]
        [System.ComponentModel.Description("Имя сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public string FirstName
        {
            get
            {
                return employee.FirstName;
            }
            set
            {
                employee.FirstName = value;
            }
        }

        [System.ComponentModel.DisplayName("Отчество")]
        [System.ComponentModel.Category("\tФамилия, имя, отчество")]
        [System.ComponentModel.Description("Отчество сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public string Otch
        {
            get
            {
                return employee.Otch;
            }
            set
            {
                employee.Otch = value;
            }
        }

        [System.ComponentModel.DisplayName("Серия")]
        [System.ComponentModel.Category("Паспорт")]
        [System.ComponentModel.Description("Серия паспорта сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public string Paspser
        {
            get
            {
                return employee.paspser;
            }
            set
            {
                employee.paspser = value;
            }
        }

        [System.ComponentModel.DisplayName("Номер")]
        [System.ComponentModel.Category("Паспорт")]
        [System.ComponentModel.Description("Номер паспорта сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public string Paspnomer
        {
            get
            {
                return employee.paspnomer;
            }
            set
            {
                employee.paspnomer = value;
            }
        }

        [System.ComponentModel.DisplayName("Кем выдан")]
        [System.ComponentModel.Category("Паспорт")]
        [System.ComponentModel.Description("Кем выдан паспорт сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public string Paspkem
        {
            get
            {
                return employee.paspkem;
            }
            set
            {
                employee.paspkem = value;
            }
        }

        [System.ComponentModel.DisplayName("Дата выдачи")]
        [System.ComponentModel.Category("Паспорт")]
        [System.ComponentModel.Description("Дата выдачи паспорта сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public DateTime Paspdate
        {
            get
            {
                return Convert.ToDateTime(employee.paspdate);
            }
            set
            {
                employee.paspdate = value;
            }
        }

        [System.ComponentModel.DisplayName("Серия ТК")]
        [System.ComponentModel.Category("Трудовая книжка")]
        [System.ComponentModel.Description("Серия трудовой книжки сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public string EmplHistSer
        {
            get
            {
                return employee.EmplHistSer;
            }
            set
            {
                employee.EmplHistSer = value;
            }
        }

        [System.ComponentModel.DisplayName("Номер ТК")]
        [System.ComponentModel.Category("Трудовая книжка")]
        [System.ComponentModel.Description("Номер трудовой книжки сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public string EmplHistNumber
        {
            get
            {
                return employee.EmplHistNumber;
            }
            set
            {
                employee.EmplHistNumber = value;
            }
        }

        [System.ComponentModel.DisplayName("Дата выдачи ТК")]
        [System.ComponentModel.Category("Трудовая книжка")]
        [System.ComponentModel.Description("Дата выдачи трудовой книжки сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public DateTime EmplHistDate
        {
            get
            {
                return Convert.ToDateTime(employee.EmplHistDate);
            }
            set
            {
                employee.EmplHistDate = value;
            }
        }
        [System.ComponentModel.DisplayName("ИНН")]
        [System.ComponentModel.Category("Документы")]
        [System.ComponentModel.Description("ИНН сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public string INN
        {
            get
            {
                return employee.inn;
            }
            set
            {
                employee.inn = value;
            }
        }

        [System.ComponentModel.DisplayName("Номер мед полиса")]
        [System.ComponentModel.Category("Документы")]
        [System.ComponentModel.Description("Номер медицинского полиса сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public string Medpolis
        {
            get
            {
                return employee.medpolis;
            }
            set
            {
                employee.medpolis = value;
            }
        }

        [System.ComponentModel.DisplayName("СНИЛС")]
        [System.ComponentModel.Category("Документы")]
        [System.ComponentModel.Description("СНИЛС сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public string Ssgps
        {
            get
            {
                return employee.ssgps;
            }
            set
            {
                employee.ssgps = value;
            }
        }

        /*[System.ComponentModel.DisplayName("ИНН")]
        [System.ComponentModel.Category("Документы")]
        [System.ComponentModel.Description("ИНН сотрудника")]
        public string
        {
            get
            {
                return employee;
            }
            set
            {
                employee = value;
            }
        }*/
        [System.ComponentModel.DisplayName("Дата рождения")]
        [System.ComponentModel.Category("Личные данные")]
        [System.ComponentModel.Description("Дата рождения сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public DateTime BirthDate
        {
            get
            {
                return Convert.ToDateTime(employee.BirthDate);
            }
            set
            {
                employee.BirthDate = value;
            }
        }

        [System.ComponentModel.DisplayName("Место рождения")]
        [System.ComponentModel.Category("Личные данные")]
        [System.ComponentModel.Description("Место рождения сотрудника")]
        [System.ComponentModel.ReadOnly(true)]
        public string BirthPlace
        {
            get
            {
                return employee.BirthPlace;
            }
            set
            {
                employee.BirthPlace = value;
            }
        }

        [System.ComponentModel.DisplayName("Районный коэффициент")]
        [System.ComponentModel.Category("Коэффициенты")]
        [System.ComponentModel.Description("Районный коэффициент сотрудника")]

        public int RayonKoeff
        {
            get
            {
                return employee.RayonKoeff;
            }
            set
            {
                employee.RayonKoeff = value;
            }
        }

        [System.ComponentModel.DisplayName("Северный коэффициент")]
        [System.ComponentModel.Category("Коэффициенты")]
        [System.ComponentModel.Description("Северный коэффициент сотрудника")]
        public int SeverKoeff
        {
            get
            {
                return employee.SeverKoeff;
            }
            set
            {
                employee.SeverKoeff = value;
            }
        }

        [System.ComponentModel.DisplayName("Гражданство")]
        [System.ComponentModel.Category("Личные данные")]
        [System.ComponentModel.Description("Гражданство сотрудника")]
        [System.ComponentModel.TypeConverter(typeof(SimpleToStringConvertor<Grazd>))]
        [System.ComponentModel.ReadOnly(true)]
        public Grazd Grazd
        {
            get
            {
                return employee.Grazd;
            }
            set
            {
                employee.Grazd = value;
            }
        }

        [System.ComponentModel.DisplayName("Семейное положение")]
        [System.ComponentModel.Category("Личные данные")]
        [System.ComponentModel.Description("Семейное положение сотрудника")]
        [System.ComponentModel.TypeConverter(typeof(SimpleToStringConvertor<SemPol>))]
        [System.ComponentModel.ReadOnly(true)]
        public SemPol SemPol
        {
            get
            {
                return employee.SemPol;
            }
            set
            {
                employee.SemPol = value;
            }
        }

    }
}
