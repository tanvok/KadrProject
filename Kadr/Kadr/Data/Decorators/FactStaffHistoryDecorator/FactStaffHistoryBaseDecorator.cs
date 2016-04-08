﻿using Kadr.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Kadr.Interfaces;

namespace Kadr.Data
{
    class FactStaffHistoryBaseDecorator : IPrikazTypeProvider
    {
        protected FactStaffHistory factStaffHistory;
        public FactStaffHistoryBaseDecorator(FactStaffHistory factStaffHistory)
        {
            this.factStaffHistory = factStaffHistory;
        }

        override public string ToString()
        {
            if (factStaffHistory.EventKind != null)
                return factStaffHistory.EventKind.ToString();
            return factStaffHistory.ToString();
        }

        [System.ComponentModel.DisplayName("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tФИО сотрудника")]
        [System.ComponentModel.Category("\t\t\t\t\t\t\t\t\t\t\tОбщие")]
        [System.ComponentModel.Description("ФИО сотрудника, назначенного на должность")]
        [System.ComponentModel.ReadOnly(true)]
        public Kadr.Data.Employee Employee
        {
            get
            {
                return factStaffHistory.FactStaff.Employee;
            }
        }

        [System.ComponentModel.DisplayName("\t\t\t\t\t\t\t\t\t\tДата назначения")]
        [System.ComponentModel.Category("\t\t\t\t\t\tОсновные параметры")]
        [System.ComponentModel.Description("Дата назначения на должность")]
        [System.ComponentModel.ReadOnly(false)]
        public DateTime DateBegin
        {
            get
            {
                return factStaffHistory.DateBegin;
            }
            set
            {
                factStaffHistory.DateBegin = value;
                factStaffHistory.SetContractDates(value);
               
            }
        }

        [System.ComponentModel.DisplayName("\t\t\t\t\t\t\t\t\tПриказ назначения")]
        [System.ComponentModel.Category("\t\t\t\t\t\tОсновные параметры")]
        [System.ComponentModel.Description("Приказ назначения на должность")]
        [System.ComponentModel.ReadOnly(false)]
        [System.ComponentModel.Editor(typeof(Kadr.UI.Editors.PrikazEditor), typeof(System.Drawing.Design.UITypeEditor))]
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

        [System.ComponentModel.Browsable(false)]
        [System.ComponentModel.ReadOnly(true)]
        public PrikazType PrikazType
        {
            get { return MagicNumberController.HiredPrikazType; }
        }
    }
}

