using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;

namespace APG.CodeHelper.UI
{
    public partial class CrystalReportVeiwerRus : CrystalDecisions.Windows.Forms.CrystalReportViewer
    {
        private CrystalDecisions.CrystalReports.Engine.ReportClass report;
        public CrystalReportVeiwerRus()
        {
            InitializeComponent();
            if (!DesignMode)
            {
                ToolStripItem expButton = (Controls[3] as ToolStrip).Items[0];
                expButton.ToolTipText = "�������";
                //expButton.MouseDown += new MouseEventHandler(expButton_MouseDown);

                (Controls[3] as ToolStrip).Items[1].ToolTipText = "������";
                (Controls[3] as ToolStrip).Items[2].ToolTipText = "��������";
                (Controls[3] as ToolStrip).Items[3].ToolTipText = "������ ��������";
                (Controls[3] as ToolStrip).Items[4].ToolTipText = "������ ��������";
                (Controls[3] as ToolStrip).Items[5].ToolTipText = "���������� ��������";
                (Controls[3] as ToolStrip).Items[6].ToolTipText = "��������� ��������";
                (Controls[3] as ToolStrip).Items[7].ToolTipText = "��������� ��������";


                ToolStripItem goToPageButton = (Controls[3] as ToolStrip).Items[8];
                goToPageButton.ToolTipText = "������� � ��������";
                goToPageButton.MouseDown += new MouseEventHandler(goToPageButton_MouseDown);

                (Controls[3] as ToolStrip).Items[9].ToolTipText = "������� ������� ���";

                ToolStripItem searchButton = (Controls[3] as ToolStrip).Items[10];
                searchButton.ToolTipText = "�����...";
                searchButton.MouseDown += new MouseEventHandler(searchButton_MouseDown);

                ToolStripDropDownButton zoomButton = ((Controls[3] as ToolStrip).Items[11] as ToolStripDropDownButton);
                zoomButton.ToolTipText = "�������";
                zoomButton.DropDown.Items[0].Text = "�� ������ ��������";
                zoomButton.DropDown.Items[1].Text = "�������� �������";
                zoomButton.DropDown.Items[10].Text = "������...";
                zoomButton.DropDown.Items[10].MouseDown += SetZoom;

                Controls[4].Visible = false;
                DisplayStatusBar = false;
            }
        }

        void expButton_MouseDown(object sender, MouseEventArgs e)
        {       
            report = (ReportSource as CrystalDecisions.CrystalReports.Engine.ReportClass);
            SaveFileDialog saveDialog = new SaveFileDialog();
            saveDialog.Filter = "Crystal Report (*.rpt)|*.rpt|Adobe Acrobat (*.pdf)|*.pdf|Microsoft Excel (*.xls)|*.xls|Microsoft Word (*.doc)|*.doc|Rich Text Format (*.rtf)|*.rtf";
            saveDialog.Title = "������� �������";

            saveDialog.ShowDialog();

            if (saveDialog.FileName != "")
            {
                switch (saveDialog.FilterIndex)
                {
                    case 1:
                        report.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.CrystalReport, @saveDialog.FileName);
                        break;
                    case 2:
                        report.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, @saveDialog.FileName);
                        break;
                    case 3:
                        report.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.Excel, @saveDialog.FileName);
                        break;
                    case 4:
                        report.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.WordForWindows, @saveDialog.FileName);
                        break;
                    case 5:
                        report.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.RichText, @saveDialog.FileName);
                        break;
                    default:
                        break;
                }
            }

        }

        void goToPageButton_MouseDown(object sender, MouseEventArgs e)
        {
            report = (ReportSource as CrystalDecisions.CrystalReports.Engine.ReportClass);
            CodeHelper.UI.MessageDialog<NumericUpDown> mesDialog = new MessageDialog<NumericUpDown>("������� �� ��������", "������� �� ������� �:", "");
            mesDialog[0].Minimum = 1;
            switch (mesDialog.ShowDialog())
            {
                case DialogResult.OK:
                    ShowNthPage((int)mesDialog[0].Value);
                    break;
                default: break;
            }

        }

        void searchButton_MouseDown(object sender, MouseEventArgs e)
        {
            report = (ReportSource as CrystalDecisions.CrystalReports.Engine.ReportClass);
            CodeHelper.UI.MessageDialog<TextBox> mesDialog = new MessageDialog<TextBox>("�����", "����� ��� ����� � ���������:", "");
            switch (mesDialog.ShowDialog())
            {
                case DialogResult.OK:
                    while (SearchForText(mesDialog[0].Text))
                        mesDialog.ShowDialog();
                    MessageBox.Show("����� � ��������� �������", "���������� ������");
                    break;
                default: break;
            }
        }

        void SetZoom(object sender, EventArgs e)
        {
            report = (ReportSource as CrystalDecisions.CrystalReports.Engine.ReportClass);
            CodeHelper.UI.MessageDialog<NumericUpDown> mesDialog = new MessageDialog<NumericUpDown>("�������", "������� (25-400%):", "");
            mesDialog[0].Minimum = 25;
            mesDialog[0].Maximum = 400;
            switch (mesDialog.ShowDialog())
            {
                case DialogResult.OK:
                    Zoom((int)mesDialog[0].Value);
                    break;
                default: break;
            }
        }

    }
}
