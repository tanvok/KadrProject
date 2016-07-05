using System.Collections.Generic;
using System.Linq;
using Kadr.Data;

namespace Kadr.Controllers
{
    class MagicNumberController
    {
        #region WorkType
        /// <summary>
        /// возвращает вид работы "почасовики"
        /// </summary>
        public static WorkType hourWorkType
        {
            get
            {
                return KadrController.Instance.Model.WorkTypes.Where(wt => wt.id == 19).FirstOrDefault();
            }
        }

        /// <summary>
        /// возвращает основной вид работы
        /// </summary>
        public static WorkType MainWorkType
        {
            get
            {
                return Kadr.Controllers.KadrController.Instance.Model.WorkTypes.Where(wt => wt.id == 1).First();
            }
        }

        public static WorkType AlienType
        {
            get
            {
                return KadrController.Instance.Model.WorkTypes.First(wt => wt.id == 6);
            }
        }

        /// <summary>
        /// возвращает вид работы временная вакансия
        /// </summary>
        static public WorkType TemporaryVacancyWorkType
        {
            get
            {
                return Kadr.Controllers.KadrController.Instance.Model.WorkTypes.Where(wt => wt.id == 15).First();
            }
        }

        /// <summary>
        /// возвращает вид работы для замещения
        /// </summary>
        static public WorkType ReplacementWorkType
        {
            get
            {
                return Kadr.Controllers.KadrController.Instance.Model.WorkTypes.Where(wtp => wtp.IsReplacement).FirstOrDefault();
            }
        }

        #endregion

        public static Dep UGTUDep
        {
            get
            {
                return KadrController.Instance.Model.Deps.SingleOrDefault(dep => dep.id == 1);
            }
        }

        #region EventKinds
        /// <summary>
        /// Материальная ответственность
        /// </summary>
        public static EventKind MatResponsibilityKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Single(x => x.id == 16);
            }
        }

        /// <summary>
        /// Прием почасовика по договору
        /// </summary>
        public static EventKind FactStaffHourContractCreateEventKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Single(x => x.id == 14);
            }
        }
        /// <summary>
        /// Повышение квалификации
        /// </summary>
        public static EventKind DopEducKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Single(x => x.id == 19);
            }
        }

        /// <summary>
        /// Прием сотрудника
        /// </summary>
        public static EventKind FactStaffCreateEventKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Single(x => x.id == 1);
            }
        }

        /// <summary>
        /// Перевод на новую должность
        /// </summary>
        public static EventKind FactStaffTransferSimpleEventKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Single(x => x.id == 20);
            }
        }

        /// <summary>
        /// Перевод сотрудника
        /// </summary>
        public static EventKind FactStaffTransferMainEventKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Single(x => x.id == 3);
            }
        }

        /// <summary>
        /// перевод с сохранением временной вакансии
        /// </summary>
        public static EventKind FactStaffTemporaryTransferEventKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Single(x => x.id == 22);
            }
        }

        /// <summary>
        /// Прием почасовика
        /// </summary>
        public static EventKind FactStaffHourCreateEventKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Single(x => x.id == 11);
            }
        }

        /// <summary>
        /// Назначение замещения
        /// </summary>
        public static EventKind ReplacementBeginEventKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Single(x => x.id == 10);
            }
        }

        /// <summary>
        /// Изменение условий трудового договора
        /// </summary>
        public static EventKind FactStaffChangeMainEventKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Single(x => x.id == 2);
            }
        }

        /// <summary>
        /// Смена источника финансирования
        /// </summary>
        public static EventKind FactStaffFinSourceChangeEventKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Single(x => x.id == 4);
            }
        }

        public static IEnumerable<EventKind> FactStaffChangeEventKinds
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Where(x => x.EventKind1 == MagicNumberController.FactStaffChangeMainEventKind).ToArray();
            }
        }

        public static IEnumerable<EventKind> FactStaffTransferSubEventKinds
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Where(x => x.EventKind1 == MagicNumberController.FactStaffTransferMainEventKind).ToArray();
            }
        }

        /// <summary>
        /// Отпуск
        /// </summary>
        public static EventKind VacationEventKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.Single(x => x.id == 15);
            }
        }

        static public EventKind BusinessTripKind
        {
            get
            {
                return Kadr.Controllers.KadrController.Instance.Model.EventKinds.SingleOrDefault(x => x.id == 17);
            }
        }

        public static EventKind ValidationKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.SingleOrDefault(x => x.id == 18);
            }
        }
        public static EventKind VacationKind
        {
            get
            {
                return KadrController.Instance.Model.EventKinds.SingleOrDefault(x => x.id == 15);
            }
        }

        #endregion

        #region EventTypes

        public static EventType BeginEventType
        {
            get
            {
                return KadrController.Instance.Model.EventTypes.Single(x => x.id == 1);
            }
        }

        public static int BeginEventTypeId
        {
            get
            {
                return 1;
            }
        }

        public static EventType EndEventType
        {
            get
            {
                return KadrController.Instance.Model.EventTypes.Single(x => x.id == 2);
            }
        }

        public static EventType ChangeTermsEventType
        {
            get
            {
                return KadrController.Instance.Model.EventTypes.Single(x => x.id == 3);
            }
        }

        #endregion

        #region PrikazType

        //Прием сотрудника
        public static PrikazType HiredPrikazType
        {
            get
            {
                return KadrController.Instance.Model.PrikazTypes.SingleOrDefault(x => x.id == 10);
            }
        }

        //Перевод сотрудника
        public static PrikazType TransferPrikazType
        {
            get
            {
                return KadrController.Instance.Model.PrikazTypes.SingleOrDefault(x => x.id == 6);
            }
        }



        //Увольнение сотрудника
        public static PrikazType FiredPrikazType
        {
            get
            {
                return KadrController.Instance.Model.PrikazTypes.SingleOrDefault(x => x.id == 5);
            }
        }

        //Командировка
        public static PrikazType BusinessTripPrikazType
        {
            get
            {
                return KadrController.Instance.Model.PrikazTypes.SingleOrDefault(x => x.id == 42);
            }
        }

        //Материальная ответственность
        public static PrikazType MaterialPrikazType
        {
            get
            {
                return KadrController.Instance.Model.PrikazTypes.SingleOrDefault(x => x.id == 18);
            }
        }

        //Дополнительное образование
        public static PrikazType DopEducPrikazType
        {
            get
            {
                return KadrController.Instance.Model.PrikazTypes.SingleOrDefault(x => x.id == 44);
            }
        }

        //Отпуск
        public static PrikazType OtpuskPrikazType
        {
            get
            {
                return KadrController.Instance.Model.PrikazTypes.SingleOrDefault(x => x.id == 21);
            }
        }

        //Льготный проезд
        public static PrikazType SocialFareTransitPrikazType
        {
            get
            {
                return KadrController.Instance.Model.PrikazTypes.SingleOrDefault(x => x.id == 43);
            }
        }

        //Аттестации
        public static PrikazType ValidationPrikazType
        {
            get
            {
                return KadrController.Instance.Model.PrikazTypes.SingleOrDefault(x => x.id == 45);
            }
        }

        //Смена ФИО
        public static PrikazType FIOChangePrikazType
        {
            get
            {
                return KadrController.Instance.Model.PrikazTypes.SingleOrDefault(x => x.id == 23);
            }
        }

        /// <summary>
        /// Договор
        /// </summary>
        public static PrikazType ContractPrikazType
        {
            get
            {
                return KadrController.Instance.Model.PrikazTypes.SingleOrDefault(x => x.id == 27);
            }
        }

        /// <summary>
        /// Доп соглашение (изменение договора)
        /// </summary>
        public static PrikazType SubContractPrikazType
        {
            get
            {
                return KadrController.Instance.Model.PrikazTypes.SingleOrDefault(x => x.id == 14);
            }
        }

        #endregion



        static public RegionType DefaultRegionType
        {
            get
            {
                return KadrController.Instance.Model.RegionTypes.Single(x => x.id == 1);
            }
        }
        static public Category DefaultStandingType
        {
            get
            {
                return null; //KadrController.Instance.Model.Categories.Single(x => x.id == 1);
            }
        }

        #region FinSource
        static public FinancingSource budgetFinancingSource
        {
            get
            {
                return Kadr.Controllers.KadrController.Instance.Model.FinancingSources.Where(finS => finS.id == 1).First();
            }
        }

        static public FinancingSource extrabudgetFinancingSource
        {
            get
            {
                return Kadr.Controllers.KadrController.Instance.Model.FinancingSources.Where(finS => finS.id == 2).First();
            }
        }

        static public FinancingSource DefaultFinancingSource
        {
            get
            {
                return Kadr.Controllers.KadrController.Instance.Model.FinancingSources.Where(finS => finS.id == 0).First();
            }
        }

        #endregion

        public static OK_Reason TransferReason
        {
            get
            {
                return KadrController.Instance.Model.OK_Reasons.First(x => x.idreason == 218);
            }
        }

        #region ReportSettings
        public static int BeginRow => 2;


        #endregion
    }
}
