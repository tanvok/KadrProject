using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Kadr.UI.Editors
{
    [System.Security.Permissions.PermissionSet(System.Security.Permissions.SecurityAction.Demand, Name = "FullTrust")]
    public class CustomCollectionEditor : CollectionEditor
    {
        private string collectionName = "Редактор списка";
        private string elementName = "Элемент списка";
        private Type type;

        public CustomCollectionEditor(Type t) : base(t)
        {
            
        }
        /// <summary>
        /// Конструктор с заданными названиями редактора коллекции и элемента
        /// </summary>
        /// <param name="colname">Имя коллекции</param>
        /// <param name="elementname">Имя элемента</param>
        public CustomCollectionEditor(string colname, string elementname, Type t) : base(t)
        {
            collectionName = colname;
            elementName = elementname;

            type = t;
        }

        protected override CollectionForm CreateCollectionForm()
        {
            CollectionForm collform = base.CreateCollectionForm();
            collform.Text = collectionName;

            // подключаем свой обработчик открытия и в нем 
            // восстанавливаем положение и размер окна
            collform.Load += delegate (object sender, EventArgs e)
            {
                //System.Diagnostics.Trace.WriteLine("collform.Load()");
                collform.HelpButton = false;

                Label RegionProperties = new Label();
                string MembersText = elementName;
                string PropertiesText = collectionName;

                // перебираем все control-ы на форме и заменяем
                // неправильные надписи
                foreach (Control ctrl in collform.Controls)
                {
                    foreach (Control ctrl1 in ctrl.Controls)
                    {
                        if (ctrl1.GetType().ToString() == "System.Windows.Forms.Label"
                          && (ctrl1.Text == "&Members:" || ctrl1.Text == "&Члены:"))
                        {
                            ctrl1.Text = MembersText;
                        }

                        if (ctrl1.GetType().ToString() == "System.Windows.Forms.Label"
                          && (ctrl1.Text.Contains("&properties")
                          || ctrl1.Text.Contains("&Cвойства")))
                        {
                            //RegionProperties = (Label)ctrl1;
                            RegionProperties.Text = PropertiesText;
                        }

                        if (ctrl1.GetType().ToString()
                          == "System.ComponentModel.Design.CollectionEditor+FilterListBox")
                        {
                            ((ListBox)ctrl1).SelectedIndexChanged +=
                              delegate (object sndr, EventArgs ea)
                              {
                                  RegionProperties.Text = PropertiesText;
                              };
                        }

                        if (ctrl1.GetType().ToString()
                          == "System.Windows.Forms.Design.VsPropertyGrid")
                        {
                            // и на редактирование в PropertyGrid
                            ((PropertyGrid)ctrl1).SelectedGridItemChanged +=
                              delegate (Object sndr, SelectedGridItemChangedEventArgs segichd)
                              {
                                  RegionProperties.Text = PropertiesText;
                              };

                            // также сделать доступным окно с подсказками по параметрам 
                            // в нижней части
                            ((PropertyGrid)ctrl1).HelpVisible = true;
                            ((PropertyGrid)ctrl1).HelpBackColor =
                              System.Drawing.SystemColors.Info;
                        }
                    }
                }
            };
            return collform;
        }
    }
}
