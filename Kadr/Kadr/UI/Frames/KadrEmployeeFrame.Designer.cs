namespace Kadr.UI.Frames
{
    partial class KadrEmployeeFrame
    {

        /// <summary> 
        /// ��������� ���������� ������������.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// ���������� ��� ������������ �������.
        /// </summary>
        /// <param name="disposing">�������, ���� ����������� ������ ������ ���� ������; ����� �����.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.tcEmployee = new System.Windows.Forms.TabControl();
            this.tpEmployee = new System.Windows.Forms.TabPage();
            this.tableLayoutPanel5 = new System.Windows.Forms.TableLayoutPanel();
            this.cpgEmployee = new UIX.UI.CommandPropertyGrid();
            this.panel1 = new System.Windows.Forms.Panel();
            this.btnCancel = new System.Windows.Forms.Button();
            this.btnOk = new System.Windows.Forms.Button();
            this.tpEmpPost = new System.Windows.Forms.TabPage();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.dgvEmplPosts = new System.Windows.Forms.DataGridView();
            this.Department = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Post = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.WorkType = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.HourCount = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.FinancingSource = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.PKCategory = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Category = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.SalarySize = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.StaffCount = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.FStDateBegin = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.FStPrikazBegin = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dateEndDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Prikaz = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.factStaffBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.idOtpuskVidDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.idOtpuskPrikazDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.OtpDateBegin = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn8 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.oKOtpuskBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.tpBonus = new System.Windows.Forms.TabPage();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.dgvAllBonus = new System.Windows.Forms.DataGridView();
            this.BonusLevel = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.BonusPost = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.BnLastFinancingSource = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.AllBonusCount = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.AllDateBegin = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.PrikazBegin = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.IntermediateDateEnd0 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn5 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn6 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn7 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.AllbonusBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.toolStrip3 = new System.Windows.Forms.ToolStrip();
            this.tsbBonusHistory = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.tsbBonusFilter = new System.Windows.Forms.ToolStripSplitButton();
            this.�������ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.����������ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.tpEducation = new System.Windows.Forms.TabPage();
            this.splitContainer2 = new System.Windows.Forms.SplitContainer();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.tableLayoutPanel3 = new System.Windows.Forms.TableLayoutPanel();
            this.dataGridView2 = new System.Windows.Forms.DataGridView();
            this.degreeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.scienceTypeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.educDocumentDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dissertCouncilDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.degreeDateDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.diplWhereDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.employeeDegreeBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.toolStrip4 = new System.Windows.Forms.ToolStrip();
            this.AddDegreeBtn = new System.Windows.Forms.ToolStripButton();
            this.EditDegreeBtn = new System.Windows.Forms.ToolStripButton();
            this.DelDegreeBtn = new System.Windows.Forms.ToolStripButton();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.tableLayoutPanel4 = new System.Windows.Forms.TableLayoutPanel();
            this.dataGridView3 = new System.Windows.Forms.DataGridView();
            this.rankDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.educDocumentDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.rankWhereDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.employeeRankBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.AddRankBtn = new System.Windows.Forms.ToolStripButton();
            this.EditRankBtn = new System.Windows.Forms.ToolStripButton();
            this.DelRankBtn = new System.Windows.Forms.ToolStripButton();
            this.tpEmplBonusReport = new System.Windows.Forms.TabPage();
            this.btnBonusRepLoad = new System.Windows.Forms.Button();
            this.dtpBonRepPeriodEnd = new System.Windows.Forms.DateTimePicker();
            this.label1 = new System.Windows.Forms.Label();
            this.dtpBonRepPeriodBegin = new System.Windows.Forms.DateTimePicker();
            this.tableLayoutPanel6 = new System.Windows.Forms.TableLayoutPanel();
            this.toolStrip6 = new System.Windows.Forms.ToolStrip();
            this.toolStripLabel2 = new System.Windows.Forms.ToolStripLabel();
            this.employeeBonusReportFrame1 = new Reports.Frames.ReportBaseFrameForPeriod();
            this.tpEmplBonus = new System.Windows.Forms.TabPage();
            this.bonusFrame1 = new Kadr.UI.Frames.BonusFrame();
            this.groupBox1.SuspendLayout();
            this.tcEmployee.SuspendLayout();
            this.tpEmployee.SuspendLayout();
            this.tableLayoutPanel5.SuspendLayout();
            this.panel1.SuspendLayout();
            this.tpEmpPost.SuspendLayout();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvEmplPosts)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.factStaffBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.oKOtpuskBindingSource)).BeginInit();
            this.tpBonus.SuspendLayout();
            this.tableLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvAllBonus)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.AllbonusBindingSource)).BeginInit();
            this.toolStrip3.SuspendLayout();
            this.tpEducation.SuspendLayout();
            this.splitContainer2.Panel1.SuspendLayout();
            this.splitContainer2.Panel2.SuspendLayout();
            this.splitContainer2.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.tableLayoutPanel3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.employeeDegreeBindingSource)).BeginInit();
            this.toolStrip4.SuspendLayout();
            this.groupBox5.SuspendLayout();
            this.tableLayoutPanel4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.employeeRankBindingSource)).BeginInit();
            this.toolStrip1.SuspendLayout();
            this.tpEmplBonusReport.SuspendLayout();
            this.tableLayoutPanel6.SuspendLayout();
            this.toolStrip6.SuspendLayout();
            this.tpEmplBonus.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.tcEmployee);
            this.groupBox1.Size = new System.Drawing.Size(909, 387);
            // 
            // tcEmployee
            // 
            this.tcEmployee.Controls.Add(this.tpEmployee);
            this.tcEmployee.Controls.Add(this.tpEmpPost);
            this.tcEmployee.Controls.Add(this.tpBonus);
            this.tcEmployee.Controls.Add(this.tpEducation);
            this.tcEmployee.Controls.Add(this.tpEmplBonusReport);
            this.tcEmployee.Controls.Add(this.tpEmplBonus);
            this.tcEmployee.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tcEmployee.Location = new System.Drawing.Point(3, 16);
            this.tcEmployee.Name = "tcEmployee";
            this.tcEmployee.SelectedIndex = 0;
            this.tcEmployee.Size = new System.Drawing.Size(903, 368);
            this.tcEmployee.TabIndex = 0;
            this.tcEmployee.SelectedIndexChanged += new System.EventHandler(this.tcEmployee_SelectedIndexChanged);
            // 
            // tpEmployee
            // 
            this.tpEmployee.AutoScroll = true;
            this.tpEmployee.Controls.Add(this.tableLayoutPanel5);
            this.tpEmployee.Location = new System.Drawing.Point(4, 22);
            this.tpEmployee.Name = "tpEmployee";
            this.tpEmployee.Padding = new System.Windows.Forms.Padding(3);
            this.tpEmployee.Size = new System.Drawing.Size(895, 342);
            this.tpEmployee.TabIndex = 0;
            this.tpEmployee.Text = "������ ������";
            this.tpEmployee.UseVisualStyleBackColor = true;
            // 
            // tableLayoutPanel5
            // 
            this.tableLayoutPanel5.ColumnCount = 1;
            this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel5.Controls.Add(this.cpgEmployee, 0, 0);
            this.tableLayoutPanel5.Controls.Add(this.panel1, 0, 1);
            this.tableLayoutPanel5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel5.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel5.Name = "tableLayoutPanel5";
            this.tableLayoutPanel5.RowCount = 2;
            this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
            this.tableLayoutPanel5.Size = new System.Drawing.Size(889, 336);
            this.tableLayoutPanel5.TabIndex = 3;
            // 
            // cpgEmployee
            // 
            this.cpgEmployee.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cpgEmployee.CommandRegister = null;
            this.cpgEmployee.Location = new System.Drawing.Point(3, 3);
            this.cpgEmployee.Name = "cpgEmployee";
            this.cpgEmployee.Size = new System.Drawing.Size(883, 290);
            this.cpgEmployee.TabIndex = 0;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.btnCancel);
            this.panel1.Controls.Add(this.btnOk);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(3, 299);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(883, 34);
            this.panel1.TabIndex = 1;
            // 
            // btnCancel
            // 
            this.btnCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnCancel.Location = new System.Drawing.Point(571, 0);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(138, 32);
            this.btnCancel.TabIndex = 2;
            this.btnCancel.Text = "�������� ���������";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnOk
            // 
            this.btnOk.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnOk.Location = new System.Drawing.Point(715, 0);
            this.btnOk.Name = "btnOk";
            this.btnOk.Size = new System.Drawing.Size(165, 32);
            this.btnOk.TabIndex = 1;
            this.btnOk.Text = "��������� ���������";
            this.btnOk.UseVisualStyleBackColor = true;
            this.btnOk.Click += new System.EventHandler(this.btnOk_Click);
            // 
            // tpEmpPost
            // 
            this.tpEmpPost.AutoScroll = true;
            this.tpEmpPost.Controls.Add(this.splitContainer1);
            this.tpEmpPost.Location = new System.Drawing.Point(4, 22);
            this.tpEmpPost.Name = "tpEmpPost";
            this.tpEmpPost.Padding = new System.Windows.Forms.Padding(3);
            this.tpEmpPost.Size = new System.Drawing.Size(895, 342);
            this.tpEmpPost.TabIndex = 1;
            this.tpEmpPost.Text = "���������� ���������";
            this.tpEmpPost.UseVisualStyleBackColor = true;
            // 
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(3, 3);
            this.splitContainer1.Name = "splitContainer1";
            this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.dgvEmplPosts);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.dataGridView1);
            this.splitContainer1.Size = new System.Drawing.Size(889, 336);
            this.splitContainer1.SplitterDistance = 168;
            this.splitContainer1.TabIndex = 2;
            // 
            // dgvEmplPosts
            // 
            this.dgvEmplPosts.AllowUserToAddRows = false;
            this.dgvEmplPosts.AllowUserToDeleteRows = false;
            this.dgvEmplPosts.AutoGenerateColumns = false;
            this.dgvEmplPosts.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvEmplPosts.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Department,
            this.Post,
            this.WorkType,
            this.HourCount,
            this.FinancingSource,
            this.PKCategory,
            this.Category,
            this.SalarySize,
            this.StaffCount,
            this.FStDateBegin,
            this.FStPrikazBegin,
            this.dateEndDataGridViewTextBoxColumn,
            this.Prikaz});
            this.dgvEmplPosts.DataSource = this.factStaffBindingSource;
            this.dgvEmplPosts.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvEmplPosts.Location = new System.Drawing.Point(0, 0);
            this.dgvEmplPosts.Name = "dgvEmplPosts";
            this.dgvEmplPosts.ReadOnly = true;
            this.dgvEmplPosts.RowHeadersVisible = false;
            this.dgvEmplPosts.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvEmplPosts.Size = new System.Drawing.Size(889, 168);
            this.dgvEmplPosts.TabIndex = 0;
            // 
            // Department
            // 
            this.Department.DataPropertyName = "Department";
            this.Department.HeaderText = "�����";
            this.Department.Name = "Department";
            this.Department.ReadOnly = true;
            this.Department.Width = 110;
            // 
            // Post
            // 
            this.Post.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Post.DataPropertyName = "Post";
            this.Post.HeaderText = "���������";
            this.Post.Name = "Post";
            this.Post.ReadOnly = true;
            // 
            // WorkType
            // 
            this.WorkType.DataPropertyName = "WorkType";
            this.WorkType.HeaderText = "��� ������";
            this.WorkType.Name = "WorkType";
            this.WorkType.ReadOnly = true;
            this.WorkType.Width = 55;
            // 
            // HourCount
            // 
            this.HourCount.DataPropertyName = "HourCount";
            this.HourCount.HeaderText = "���-�� �����";
            this.HourCount.Name = "HourCount";
            this.HourCount.ReadOnly = true;
            this.HourCount.Width = 45;
            // 
            // FinancingSource
            // 
            this.FinancingSource.DataPropertyName = "FinSource";
            this.FinancingSource.HeaderText = "��� ���";
            this.FinancingSource.Name = "FinancingSource";
            this.FinancingSource.ReadOnly = true;
            this.FinancingSource.Width = 45;
            // 
            // PKCategory
            // 
            this.PKCategory.DataPropertyName = "PKCategory";
            this.PKCategory.HeaderText = "���/ ��/ �� (/���)";
            this.PKCategory.Name = "PKCategory";
            this.PKCategory.ReadOnly = true;
            this.PKCategory.Width = 50;
            // 
            // Category
            // 
            this.Category.DataPropertyName = "Category";
            this.Category.HeaderText = "�����.";
            this.Category.Name = "Category";
            this.Category.ReadOnly = true;
            this.Category.Width = 50;
            // 
            // SalarySize
            // 
            this.SalarySize.DataPropertyName = "SalarySize";
            this.SalarySize.HeaderText = "������ ������/ �����. ����";
            this.SalarySize.Name = "SalarySize";
            this.SalarySize.ReadOnly = true;
            this.SalarySize.Width = 70;
            // 
            // StaffCount
            // 
            this.StaffCount.DataPropertyName = "StaffCount";
            this.StaffCount.HeaderText = "���-�� ������";
            this.StaffCount.Name = "StaffCount";
            this.StaffCount.ReadOnly = true;
            this.StaffCount.Width = 50;
            // 
            // FStDateBegin
            // 
            this.FStDateBegin.DataPropertyName = "DateBegin";
            this.FStDateBegin.HeaderText = "���� ����.";
            this.FStDateBegin.Name = "FStDateBegin";
            this.FStDateBegin.ReadOnly = true;
            this.FStDateBegin.Width = 70;
            // 
            // FStPrikazBegin
            // 
            this.FStPrikazBegin.DataPropertyName = "PrikazBegin";
            this.FStPrikazBegin.HeaderText = "������ ����.";
            this.FStPrikazBegin.Name = "FStPrikazBegin";
            this.FStPrikazBegin.ReadOnly = true;
            this.FStPrikazBegin.Width = 55;
            // 
            // dateEndDataGridViewTextBoxColumn
            // 
            this.dateEndDataGridViewTextBoxColumn.DataPropertyName = "DateEnd";
            this.dateEndDataGridViewTextBoxColumn.HeaderText = "���� ������";
            this.dateEndDataGridViewTextBoxColumn.Name = "dateEndDataGridViewTextBoxColumn";
            this.dateEndDataGridViewTextBoxColumn.ReadOnly = true;
            this.dateEndDataGridViewTextBoxColumn.Width = 70;
            // 
            // Prikaz
            // 
            this.Prikaz.DataPropertyName = "Prikaz";
            this.Prikaz.HeaderText = "������ ������";
            this.Prikaz.Name = "Prikaz";
            this.Prikaz.ReadOnly = true;
            this.Prikaz.Width = 55;
            // 
            // factStaffBindingSource
            // 
            this.factStaffBindingSource.DataSource = typeof(Kadr.Data.FactStaff);
            this.factStaffBindingSource.PositionChanged += new System.EventHandler(this.factStaffBindingSource_PositionChanged);
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.AutoGenerateColumns = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.idOtpuskVidDataGridViewTextBoxColumn,
            this.idOtpuskPrikazDataGridViewTextBoxColumn,
            this.OtpDateBegin,
            this.dataGridViewTextBoxColumn8});
            this.dataGridView1.DataSource = this.oKOtpuskBindingSource;
            this.dataGridView1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridView1.Location = new System.Drawing.Point(0, 0);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.RowHeadersVisible = false;
            this.dataGridView1.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridView1.Size = new System.Drawing.Size(889, 164);
            this.dataGridView1.TabIndex = 1;
            // 
            // idOtpuskVidDataGridViewTextBoxColumn
            // 
            this.idOtpuskVidDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.idOtpuskVidDataGridViewTextBoxColumn.DataPropertyName = "OK_Otpuskvid";
            this.idOtpuskVidDataGridViewTextBoxColumn.HeaderText = "��� �������";
            this.idOtpuskVidDataGridViewTextBoxColumn.Name = "idOtpuskVidDataGridViewTextBoxColumn";
            this.idOtpuskVidDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // idOtpuskPrikazDataGridViewTextBoxColumn
            // 
            this.idOtpuskPrikazDataGridViewTextBoxColumn.DataPropertyName = "Prikaz";
            this.idOtpuskPrikazDataGridViewTextBoxColumn.HeaderText = "������";
            this.idOtpuskPrikazDataGridViewTextBoxColumn.Name = "idOtpuskPrikazDataGridViewTextBoxColumn";
            this.idOtpuskPrikazDataGridViewTextBoxColumn.ReadOnly = true;
            this.idOtpuskPrikazDataGridViewTextBoxColumn.Width = 140;
            // 
            // OtpDateBegin
            // 
            this.OtpDateBegin.DataPropertyName = "DateBegin";
            this.OtpDateBegin.HeaderText = "���� ������";
            this.OtpDateBegin.Name = "OtpDateBegin";
            this.OtpDateBegin.ReadOnly = true;
            // 
            // dataGridViewTextBoxColumn8
            // 
            this.dataGridViewTextBoxColumn8.DataPropertyName = "DateEnd";
            this.dataGridViewTextBoxColumn8.HeaderText = "���� ���������";
            this.dataGridViewTextBoxColumn8.Name = "dataGridViewTextBoxColumn8";
            this.dataGridViewTextBoxColumn8.ReadOnly = true;
            // 
            // oKOtpuskBindingSource
            // 
            this.oKOtpuskBindingSource.DataSource = typeof(Kadr.Data.OK_Otpusk);
            // 
            // tpBonus
            // 
            this.tpBonus.AutoScroll = true;
            this.tpBonus.Controls.Add(this.tableLayoutPanel1);
            this.tpBonus.Location = new System.Drawing.Point(4, 22);
            this.tpBonus.Name = "tpBonus";
            this.tpBonus.Padding = new System.Windows.Forms.Padding(3);
            this.tpBonus.Size = new System.Drawing.Size(895, 342);
            this.tpBonus.TabIndex = 2;
            this.tpBonus.Text = "��������";
            this.tpBonus.UseVisualStyleBackColor = true;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.AutoScroll = true;
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this.tableLayoutPanel1.Controls.Add(this.dgvAllBonus, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.toolStrip3, 0, 0);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 2;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(889, 336);
            this.tableLayoutPanel1.TabIndex = 3;
            // 
            // dgvAllBonus
            // 
            this.dgvAllBonus.AllowUserToAddRows = false;
            this.dgvAllBonus.AllowUserToDeleteRows = false;
            this.dgvAllBonus.AutoGenerateColumns = false;
            this.dgvAllBonus.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvAllBonus.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.BonusLevel,
            this.BonusPost,
            this.dataGridViewTextBoxColumn1,
            this.BnLastFinancingSource,
            this.AllBonusCount,
            this.AllDateBegin,
            this.PrikazBegin,
            this.IntermediateDateEnd0,
            this.dataGridViewTextBoxColumn5,
            this.dataGridViewTextBoxColumn6,
            this.dataGridViewTextBoxColumn7});
            this.dgvAllBonus.DataSource = this.AllbonusBindingSource;
            this.dgvAllBonus.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvAllBonus.Location = new System.Drawing.Point(3, 28);
            this.dgvAllBonus.MultiSelect = false;
            this.dgvAllBonus.Name = "dgvAllBonus";
            this.dgvAllBonus.ReadOnly = true;
            this.dgvAllBonus.RowHeadersVisible = false;
            this.dgvAllBonus.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvAllBonus.Size = new System.Drawing.Size(883, 496);
            this.dgvAllBonus.TabIndex = 9;
            this.dgvAllBonus.RowPrePaint += new System.Windows.Forms.DataGridViewRowPrePaintEventHandler(this.dgvAllBonus_RowPrePaint);
            this.dgvAllBonus.DoubleClick += new System.EventHandler(this.dgvAllBonus_DoubleClick);
            // 
            // BonusLevel
            // 
            this.BonusLevel.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.BonusLevel.DataPropertyName = "BonusLevel";
            this.BonusLevel.HeaderText = "������� ��������";
            this.BonusLevel.Name = "BonusLevel";
            this.BonusLevel.ReadOnly = true;
            this.BonusLevel.Width = 116;
            // 
            // BonusPost
            // 
            this.BonusPost.DataPropertyName = "Post";
            this.BonusPost.HeaderText = "���������";
            this.BonusPost.Name = "BonusPost";
            this.BonusPost.ReadOnly = true;
            this.BonusPost.Width = 120;
            // 
            // dataGridViewTextBoxColumn1
            // 
            this.dataGridViewTextBoxColumn1.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.dataGridViewTextBoxColumn1.DataPropertyName = "BonusType";
            this.dataGridViewTextBoxColumn1.HeaderText = "��� ��������";
            this.dataGridViewTextBoxColumn1.Name = "dataGridViewTextBoxColumn1";
            this.dataGridViewTextBoxColumn1.ReadOnly = true;
            this.dataGridViewTextBoxColumn1.Width = 94;
            // 
            // BnLastFinancingSource
            // 
            this.BnLastFinancingSource.DataPropertyName = "LastFinancingSource";
            this.BnLastFinancingSource.HeaderText = "��� ���-�";
            this.BnLastFinancingSource.Name = "BnLastFinancingSource";
            this.BnLastFinancingSource.ReadOnly = true;
            this.BnLastFinancingSource.Width = 65;
            // 
            // AllBonusCount
            // 
            this.AllBonusCount.DataPropertyName = "BonusCount";
            this.AllBonusCount.HeaderText = "������ ��������";
            this.AllBonusCount.Name = "AllBonusCount";
            this.AllBonusCount.ReadOnly = true;
            this.AllBonusCount.Width = 80;
            // 
            // AllDateBegin
            // 
            this.AllDateBegin.DataPropertyName = "DateBegin";
            this.AllDateBegin.HeaderText = "���� ����������";
            this.AllDateBegin.Name = "AllDateBegin";
            this.AllDateBegin.ReadOnly = true;
            this.AllDateBegin.Width = 70;
            // 
            // PrikazBegin
            // 
            this.PrikazBegin.DataPropertyName = "PrikazBegin";
            this.PrikazBegin.HeaderText = "������ ����������";
            this.PrikazBegin.Name = "PrikazBegin";
            this.PrikazBegin.ReadOnly = true;
            this.PrikazBegin.Width = 110;
            // 
            // IntermediateDateEnd0
            // 
            this.IntermediateDateEnd0.DataPropertyName = "IntermediateDateEnd";
            this.IntermediateDateEnd0.HeaderText = "����. ���� ������";
            this.IntermediateDateEnd0.Name = "IntermediateDateEnd0";
            this.IntermediateDateEnd0.ReadOnly = true;
            this.IntermediateDateEnd0.Width = 70;
            // 
            // dataGridViewTextBoxColumn5
            // 
            this.dataGridViewTextBoxColumn5.DataPropertyName = "DateEnd";
            this.dataGridViewTextBoxColumn5.HeaderText = "���� ������";
            this.dataGridViewTextBoxColumn5.Name = "dataGridViewTextBoxColumn5";
            this.dataGridViewTextBoxColumn5.ReadOnly = true;
            this.dataGridViewTextBoxColumn5.Width = 70;
            // 
            // dataGridViewTextBoxColumn6
            // 
            this.dataGridViewTextBoxColumn6.DataPropertyName = "Prikaz";
            this.dataGridViewTextBoxColumn6.HeaderText = "������ ������";
            this.dataGridViewTextBoxColumn6.Name = "dataGridViewTextBoxColumn6";
            this.dataGridViewTextBoxColumn6.ReadOnly = true;
            this.dataGridViewTextBoxColumn6.Width = 90;
            // 
            // dataGridViewTextBoxColumn7
            // 
            this.dataGridViewTextBoxColumn7.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.dataGridViewTextBoxColumn7.DataPropertyName = "Comment";
            this.dataGridViewTextBoxColumn7.HeaderText = "����������";
            this.dataGridViewTextBoxColumn7.Name = "dataGridViewTextBoxColumn7";
            this.dataGridViewTextBoxColumn7.ReadOnly = true;
            // 
            // AllbonusBindingSource
            // 
            this.AllbonusBindingSource.DataSource = typeof(Kadr.Data.Bonus);
            // 
            // toolStrip3
            // 
            this.toolStrip3.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsbBonusHistory,
            this.toolStripSeparator3,
            this.tsbBonusFilter});
            this.toolStrip3.Location = new System.Drawing.Point(0, 0);
            this.toolStrip3.Name = "toolStrip3";
            this.toolStrip3.Size = new System.Drawing.Size(889, 25);
            this.toolStrip3.TabIndex = 7;
            this.toolStrip3.Text = "toolStrip3";
            // 
            // tsbBonusHistory
            // 
            this.tsbBonusHistory.Image = global::Kadr.Properties.Resources.FillDownHS;
            this.tsbBonusHistory.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tsbBonusHistory.Name = "tsbBonusHistory";
            this.tsbBonusHistory.Size = new System.Drawing.Size(117, 22);
            this.tsbBonusHistory.Text = "����� ������� ";
            this.tsbBonusHistory.Click += new System.EventHandler(this.tsbBonusHistory_Click);
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            this.toolStripSeparator3.Size = new System.Drawing.Size(6, 25);
            // 
            // tsbBonusFilter
            // 
            this.tsbBonusFilter.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.�������ToolStripMenuItem,
            this.����������ToolStripMenuItem});
            this.tsbBonusFilter.Image = global::Kadr.Properties.Resources.Filter2HS;
            this.tsbBonusFilter.ImageTransparentColor = System.Drawing.Color.Black;
            this.tsbBonusFilter.Name = "tsbBonusFilter";
            this.tsbBonusFilter.Size = new System.Drawing.Size(80, 22);
            this.tsbBonusFilter.Text = "������";
            this.tsbBonusFilter.ToolTipText = "������ ������ �� ���������";
            this.tsbBonusFilter.DropDownItemClicked += new System.Windows.Forms.ToolStripItemClickedEventHandler(this.tsbBonusFilter_DropDownItemClicked);
            // 
            // �������ToolStripMenuItem
            // 
            this.�������ToolStripMenuItem.Checked = true;
            this.�������ToolStripMenuItem.CheckOnClick = true;
            this.�������ToolStripMenuItem.CheckState = System.Windows.Forms.CheckState.Checked;
            this.�������ToolStripMenuItem.Name = "�������ToolStripMenuItem";
            this.�������ToolStripMenuItem.Size = new System.Drawing.Size(145, 22);
            this.�������ToolStripMenuItem.Text = "�������";
            // 
            // ����������ToolStripMenuItem
            // 
            this.����������ToolStripMenuItem.CheckOnClick = true;
            this.����������ToolStripMenuItem.Name = "����������ToolStripMenuItem";
            this.����������ToolStripMenuItem.Size = new System.Drawing.Size(145, 22);
            this.����������ToolStripMenuItem.Text = "����������";
            // 
            // tpEducation
            // 
            this.tpEducation.AutoScroll = true;
            this.tpEducation.Controls.Add(this.splitContainer2);
            this.tpEducation.Location = new System.Drawing.Point(4, 22);
            this.tpEducation.Name = "tpEducation";
            this.tpEducation.Padding = new System.Windows.Forms.Padding(3);
            this.tpEducation.Size = new System.Drawing.Size(895, 342);
            this.tpEducation.TabIndex = 3;
            this.tpEducation.Text = "�����������";
            this.tpEducation.UseVisualStyleBackColor = true;
            // 
            // splitContainer2
            // 
            this.splitContainer2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer2.Location = new System.Drawing.Point(3, 3);
            this.splitContainer2.Name = "splitContainer2";
            this.splitContainer2.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer2.Panel1
            // 
            this.splitContainer2.Panel1.Controls.Add(this.groupBox4);
            // 
            // splitContainer2.Panel2
            // 
            this.splitContainer2.Panel2.Controls.Add(this.groupBox5);
            this.splitContainer2.Size = new System.Drawing.Size(889, 336);
            this.splitContainer2.SplitterDistance = 168;
            this.splitContainer2.TabIndex = 2;
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.tableLayoutPanel3);
            this.groupBox4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox4.Location = new System.Drawing.Point(0, 0);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(889, 168);
            this.groupBox4.TabIndex = 2;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "������ �������";
            // 
            // tableLayoutPanel3
            // 
            this.tableLayoutPanel3.AutoScroll = true;
            this.tableLayoutPanel3.ColumnCount = 1;
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this.tableLayoutPanel3.Controls.Add(this.dataGridView2, 0, 1);
            this.tableLayoutPanel3.Controls.Add(this.toolStrip4, 0, 0);
            this.tableLayoutPanel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel3.Location = new System.Drawing.Point(3, 16);
            this.tableLayoutPanel3.Name = "tableLayoutPanel3";
            this.tableLayoutPanel3.RowCount = 2;
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tableLayoutPanel3.Size = new System.Drawing.Size(883, 149);
            this.tableLayoutPanel3.TabIndex = 3;
            // 
            // dataGridView2
            // 
            this.dataGridView2.AllowUserToAddRows = false;
            this.dataGridView2.AllowUserToDeleteRows = false;
            this.dataGridView2.AutoGenerateColumns = false;
            this.dataGridView2.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.degreeDataGridViewTextBoxColumn,
            this.scienceTypeDataGridViewTextBoxColumn,
            this.educDocumentDataGridViewTextBoxColumn,
            this.dissertCouncilDataGridViewTextBoxColumn,
            this.degreeDateDataGridViewTextBoxColumn,
            this.diplWhereDataGridViewTextBoxColumn});
            this.dataGridView2.DataSource = this.employeeDegreeBindingSource;
            this.dataGridView2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridView2.Location = new System.Drawing.Point(3, 28);
            this.dataGridView2.MultiSelect = false;
            this.dataGridView2.Name = "dataGridView2";
            this.dataGridView2.ReadOnly = true;
            this.dataGridView2.RowHeadersVisible = false;
            this.dataGridView2.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridView2.Size = new System.Drawing.Size(877, 227);
            this.dataGridView2.TabIndex = 8;
            this.dataGridView2.DoubleClick += new System.EventHandler(this.EditDegreeBtn_Click);
            // 
            // degreeDataGridViewTextBoxColumn
            // 
            this.degreeDataGridViewTextBoxColumn.DataPropertyName = "Degree";
            this.degreeDataGridViewTextBoxColumn.HeaderText = "������ �������";
            this.degreeDataGridViewTextBoxColumn.Name = "degreeDataGridViewTextBoxColumn";
            this.degreeDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // scienceTypeDataGridViewTextBoxColumn
            // 
            this.scienceTypeDataGridViewTextBoxColumn.DataPropertyName = "ScienceType";
            this.scienceTypeDataGridViewTextBoxColumn.HeaderText = "����. ����.";
            this.scienceTypeDataGridViewTextBoxColumn.Name = "scienceTypeDataGridViewTextBoxColumn";
            this.scienceTypeDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // educDocumentDataGridViewTextBoxColumn
            // 
            this.educDocumentDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.educDocumentDataGridViewTextBoxColumn.DataPropertyName = "EducDocument";
            this.educDocumentDataGridViewTextBoxColumn.HeaderText = "������ �������";
            this.educDocumentDataGridViewTextBoxColumn.Name = "educDocumentDataGridViewTextBoxColumn";
            this.educDocumentDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // dissertCouncilDataGridViewTextBoxColumn
            // 
            this.dissertCouncilDataGridViewTextBoxColumn.DataPropertyName = "DissertCouncil";
            this.dissertCouncilDataGridViewTextBoxColumn.HeaderText = "������� �����";
            this.dissertCouncilDataGridViewTextBoxColumn.Name = "dissertCouncilDataGridViewTextBoxColumn";
            this.dissertCouncilDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // degreeDateDataGridViewTextBoxColumn
            // 
            this.degreeDateDataGridViewTextBoxColumn.DataPropertyName = "degreeDate";
            this.degreeDateDataGridViewTextBoxColumn.HeaderText = "���� ���������� �������";
            this.degreeDateDataGridViewTextBoxColumn.Name = "degreeDateDataGridViewTextBoxColumn";
            this.degreeDateDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // diplWhereDataGridViewTextBoxColumn
            // 
            this.diplWhereDataGridViewTextBoxColumn.DataPropertyName = "diplWhere";
            this.diplWhereDataGridViewTextBoxColumn.HeaderText = "������ �����";
            this.diplWhereDataGridViewTextBoxColumn.Name = "diplWhereDataGridViewTextBoxColumn";
            this.diplWhereDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // employeeDegreeBindingSource
            // 
            this.employeeDegreeBindingSource.DataSource = typeof(Kadr.Data.EmployeeDegree);
            // 
            // toolStrip4
            // 
            this.toolStrip4.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.AddDegreeBtn,
            this.EditDegreeBtn,
            this.DelDegreeBtn});
            this.toolStrip4.Location = new System.Drawing.Point(0, 0);
            this.toolStrip4.Name = "toolStrip4";
            this.toolStrip4.Size = new System.Drawing.Size(883, 25);
            this.toolStrip4.TabIndex = 7;
            this.toolStrip4.Text = "toolStrip4";
            // 
            // AddDegreeBtn
            // 
            this.AddDegreeBtn.Image = global::Kadr.Properties.Resources.AddTableHS;
            this.AddDegreeBtn.ImageTransparentColor = System.Drawing.Color.Black;
            this.AddDegreeBtn.Name = "AddDegreeBtn";
            this.AddDegreeBtn.Size = new System.Drawing.Size(125, 22);
            this.AddDegreeBtn.Text = "�������� �������";
            this.AddDegreeBtn.Click += new System.EventHandler(this.AddDegreeBtn_Click);
            // 
            // EditDegreeBtn
            // 
            this.EditDegreeBtn.Image = global::Kadr.Properties.Resources.EditTableHS;
            this.EditDegreeBtn.ImageTransparentColor = System.Drawing.Color.Black;
            this.EditDegreeBtn.Name = "EditDegreeBtn";
            this.EditDegreeBtn.Size = new System.Drawing.Size(107, 22);
            this.EditDegreeBtn.Text = "�������������";
            this.EditDegreeBtn.ToolTipText = "������������� �������";
            this.EditDegreeBtn.Click += new System.EventHandler(this.EditDegreeBtn_Click);
            // 
            // DelDegreeBtn
            // 
            this.DelDegreeBtn.Image = global::Kadr.Properties.Resources.DelTableHS;
            this.DelDegreeBtn.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.DelDegreeBtn.Name = "DelDegreeBtn";
            this.DelDegreeBtn.Size = new System.Drawing.Size(71, 22);
            this.DelDegreeBtn.Text = "�������";
            this.DelDegreeBtn.ToolTipText = "������� �������";
            this.DelDegreeBtn.Click += new System.EventHandler(this.DelDegreeBtn_Click);
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.tableLayoutPanel4);
            this.groupBox5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox5.Location = new System.Drawing.Point(0, 0);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(889, 164);
            this.groupBox5.TabIndex = 2;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "������� ������";
            // 
            // tableLayoutPanel4
            // 
            this.tableLayoutPanel4.AutoScroll = true;
            this.tableLayoutPanel4.ColumnCount = 1;
            this.tableLayoutPanel4.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this.tableLayoutPanel4.Controls.Add(this.dataGridView3, 0, 1);
            this.tableLayoutPanel4.Controls.Add(this.toolStrip1, 0, 0);
            this.tableLayoutPanel4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel4.Location = new System.Drawing.Point(3, 16);
            this.tableLayoutPanel4.Name = "tableLayoutPanel4";
            this.tableLayoutPanel4.RowCount = 2;
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tableLayoutPanel4.Size = new System.Drawing.Size(883, 145);
            this.tableLayoutPanel4.TabIndex = 2;
            // 
            // dataGridView3
            // 
            this.dataGridView3.AllowUserToAddRows = false;
            this.dataGridView3.AllowUserToDeleteRows = false;
            this.dataGridView3.AutoGenerateColumns = false;
            this.dataGridView3.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView3.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.rankDataGridViewTextBoxColumn,
            this.educDocumentDataGridViewTextBoxColumn1,
            this.rankWhereDataGridViewTextBoxColumn});
            this.dataGridView3.DataSource = this.employeeRankBindingSource;
            this.dataGridView3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridView3.Location = new System.Drawing.Point(3, 28);
            this.dataGridView3.MultiSelect = false;
            this.dataGridView3.Name = "dataGridView3";
            this.dataGridView3.ReadOnly = true;
            this.dataGridView3.RowHeadersVisible = false;
            this.dataGridView3.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridView3.Size = new System.Drawing.Size(877, 208);
            this.dataGridView3.TabIndex = 8;
            this.dataGridView3.DoubleClick += new System.EventHandler(this.EditRankBtn_Click);
            // 
            // rankDataGridViewTextBoxColumn
            // 
            this.rankDataGridViewTextBoxColumn.DataPropertyName = "Rank";
            this.rankDataGridViewTextBoxColumn.HeaderText = "������ ������";
            this.rankDataGridViewTextBoxColumn.MinimumWidth = 200;
            this.rankDataGridViewTextBoxColumn.Name = "rankDataGridViewTextBoxColumn";
            this.rankDataGridViewTextBoxColumn.ReadOnly = true;
            this.rankDataGridViewTextBoxColumn.Width = 200;
            // 
            // educDocumentDataGridViewTextBoxColumn1
            // 
            this.educDocumentDataGridViewTextBoxColumn1.DataPropertyName = "EducDocument";
            this.educDocumentDataGridViewTextBoxColumn1.HeaderText = "������ �������";
            this.educDocumentDataGridViewTextBoxColumn1.MinimumWidth = 200;
            this.educDocumentDataGridViewTextBoxColumn1.Name = "educDocumentDataGridViewTextBoxColumn1";
            this.educDocumentDataGridViewTextBoxColumn1.ReadOnly = true;
            this.educDocumentDataGridViewTextBoxColumn1.Width = 200;
            // 
            // rankWhereDataGridViewTextBoxColumn
            // 
            this.rankWhereDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.rankWhereDataGridViewTextBoxColumn.DataPropertyName = "rankWhere";
            this.rankWhereDataGridViewTextBoxColumn.HeaderText = "������ ����������";
            this.rankWhereDataGridViewTextBoxColumn.Name = "rankWhereDataGridViewTextBoxColumn";
            this.rankWhereDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // employeeRankBindingSource
            // 
            this.employeeRankBindingSource.DataSource = typeof(Kadr.Data.EmployeeRank);
            // 
            // toolStrip1
            // 
            this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.AddRankBtn,
            this.EditRankBtn,
            this.DelRankBtn});
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(883, 25);
            this.toolStrip1.TabIndex = 7;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // AddRankBtn
            // 
            this.AddRankBtn.Image = global::Kadr.Properties.Resources.AddTableHS;
            this.AddRankBtn.ImageTransparentColor = System.Drawing.Color.Black;
            this.AddRankBtn.Name = "AddRankBtn";
            this.AddRankBtn.Size = new System.Drawing.Size(119, 22);
            this.AddRankBtn.Text = "�������� ������";
            this.AddRankBtn.Click += new System.EventHandler(this.AddRankBtn_Click);
            // 
            // EditRankBtn
            // 
            this.EditRankBtn.Image = global::Kadr.Properties.Resources.EditTableHS;
            this.EditRankBtn.ImageTransparentColor = System.Drawing.Color.Black;
            this.EditRankBtn.Name = "EditRankBtn";
            this.EditRankBtn.Size = new System.Drawing.Size(107, 22);
            this.EditRankBtn.Text = "�������������";
            this.EditRankBtn.ToolTipText = "������������� ������";
            this.EditRankBtn.Click += new System.EventHandler(this.EditRankBtn_Click);
            // 
            // DelRankBtn
            // 
            this.DelRankBtn.Image = global::Kadr.Properties.Resources.DelTableHS;
            this.DelRankBtn.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.DelRankBtn.Name = "DelRankBtn";
            this.DelRankBtn.Size = new System.Drawing.Size(71, 22);
            this.DelRankBtn.Text = "�������";
            this.DelRankBtn.ToolTipText = "������� ������";
            this.DelRankBtn.Click += new System.EventHandler(this.DelRankBtn_Click);
            // 
            // tpEmplBonusReport
            // 
            this.tpEmplBonusReport.Controls.Add(this.btnBonusRepLoad);
            this.tpEmplBonusReport.Controls.Add(this.dtpBonRepPeriodEnd);
            this.tpEmplBonusReport.Controls.Add(this.label1);
            this.tpEmplBonusReport.Controls.Add(this.dtpBonRepPeriodBegin);
            this.tpEmplBonusReport.Controls.Add(this.tableLayoutPanel6);
            this.tpEmplBonusReport.Location = new System.Drawing.Point(4, 22);
            this.tpEmplBonusReport.Name = "tpEmplBonusReport";
            this.tpEmplBonusReport.Padding = new System.Windows.Forms.Padding(3);
            this.tpEmplBonusReport.Size = new System.Drawing.Size(895, 342);
            this.tpEmplBonusReport.TabIndex = 4;
            this.tpEmplBonusReport.Text = "����� �� ���������";
            this.tpEmplBonusReport.UseVisualStyleBackColor = true;
            // 
            // btnBonusRepLoad
            // 
            this.btnBonusRepLoad.Location = new System.Drawing.Point(460, 3);
            this.btnBonusRepLoad.Name = "btnBonusRepLoad";
            this.btnBonusRepLoad.Size = new System.Drawing.Size(132, 23);
            this.btnBonusRepLoad.TabIndex = 21;
            this.btnBonusRepLoad.Text = "��������� �����";
            this.btnBonusRepLoad.UseVisualStyleBackColor = true;
            this.btnBonusRepLoad.Click += new System.EventHandler(this.btnBonusRepLoad_Click);
            // 
            // dtpBonRepPeriodEnd
            // 
            this.dtpBonRepPeriodEnd.Location = new System.Drawing.Point(317, 7);
            this.dtpBonRepPeriodEnd.Name = "dtpBonRepPeriodEnd";
            this.dtpBonRepPeriodEnd.Size = new System.Drawing.Size(137, 20);
            this.dtpBonRepPeriodEnd.TabIndex = 20;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(292, 11);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(19, 13);
            this.label1.TabIndex = 19;
            this.label1.Text = "��";
            // 
            // dtpBonRepPeriodBegin
            // 
            this.dtpBonRepPeriodBegin.Location = new System.Drawing.Point(150, 6);
            this.dtpBonRepPeriodBegin.Name = "dtpBonRepPeriodBegin";
            this.dtpBonRepPeriodBegin.Size = new System.Drawing.Size(137, 20);
            this.dtpBonRepPeriodBegin.TabIndex = 18;
            // 
            // tableLayoutPanel6
            // 
            this.tableLayoutPanel6.AutoScroll = true;
            this.tableLayoutPanel6.ColumnCount = 1;
            this.tableLayoutPanel6.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel6.Controls.Add(this.toolStrip6, 0, 0);
            this.tableLayoutPanel6.Controls.Add(this.employeeBonusReportFrame1, 0, 1);
            this.tableLayoutPanel6.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel6.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel6.Name = "tableLayoutPanel6";
            this.tableLayoutPanel6.RowCount = 2;
            this.tableLayoutPanel6.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 24F));
            this.tableLayoutPanel6.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tableLayoutPanel6.Size = new System.Drawing.Size(889, 336);
            this.tableLayoutPanel6.TabIndex = 22;
            // 
            // toolStrip6
            // 
            this.toolStrip6.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripLabel2});
            this.toolStrip6.Location = new System.Drawing.Point(0, 0);
            this.toolStrip6.Name = "toolStrip6";
            this.toolStrip6.Size = new System.Drawing.Size(889, 24);
            this.toolStrip6.TabIndex = 17;
            this.toolStrip6.Text = "toolStrip6";
            // 
            // toolStripLabel2
            // 
            this.toolStripLabel2.Name = "toolStripLabel2";
            this.toolStripLabel2.Size = new System.Drawing.Size(133, 21);
            this.toolStripLabel2.Text = "������ ���������� ��";
            // 
            // employeeBonusReportFrame1
            // 
            this.employeeBonusReportFrame1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.employeeBonusReportFrame1.Location = new System.Drawing.Point(3, 27);
            this.employeeBonusReportFrame1.Name = "employeeBonusReportFrame1";
            this.employeeBonusReportFrame1.PeriodBegin = new System.DateTime(((long)(0)));
            this.employeeBonusReportFrame1.PeriodEnd = new System.DateTime(((long)(0)));
            this.employeeBonusReportFrame1.ReportNumber = 0;
            this.employeeBonusReportFrame1.ReportParam = -1;
            this.employeeBonusReportFrame1.ReportType = null;
            this.employeeBonusReportFrame1.Size = new System.Drawing.Size(883, 497);
            this.employeeBonusReportFrame1.TabIndex = 18;
            this.employeeBonusReportFrame1.WithSubReports = true;
            this.employeeBonusReportFrame1.Load += new System.EventHandler(this.employeeBonusReportFrame1_Load);
            // 
            // tpEmplBonus
            // 
            this.tpEmplBonus.Controls.Add(this.bonusFrame1);
            this.tpEmplBonus.Location = new System.Drawing.Point(4, 22);
            this.tpEmplBonus.Name = "tpEmplBonus";
            this.tpEmplBonus.Padding = new System.Windows.Forms.Padding(3);
            this.tpEmplBonus.Size = new System.Drawing.Size(895, 342);
            this.tpEmplBonus.TabIndex = 6;
            this.tpEmplBonus.Text = "��������";
            this.tpEmplBonus.UseVisualStyleBackColor = true;
            // 
            // bonusFrame1
            // 
            this.bonusFrame1.BonusObject = null;
            this.bonusFrame1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.bonusFrame1.Location = new System.Drawing.Point(3, 3);
            this.bonusFrame1.Name = "bonusFrame1";
            this.bonusFrame1.Size = new System.Drawing.Size(889, 336);
            this.bonusFrame1.TabIndex = 0;
            // 
            // KadrEmployeeFrame
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Name = "KadrEmployeeFrame";
            this.Size = new System.Drawing.Size(909, 387);
            this.Load += new System.EventHandler(this.KadrEmployeeFrame_Load);
            this.groupBox1.ResumeLayout(false);
            this.tcEmployee.ResumeLayout(false);
            this.tpEmployee.ResumeLayout(false);
            this.tableLayoutPanel5.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.tpEmpPost.ResumeLayout(false);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvEmplPosts)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.factStaffBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.oKOtpuskBindingSource)).EndInit();
            this.tpBonus.ResumeLayout(false);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvAllBonus)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.AllbonusBindingSource)).EndInit();
            this.toolStrip3.ResumeLayout(false);
            this.toolStrip3.PerformLayout();
            this.tpEducation.ResumeLayout(false);
            this.splitContainer2.Panel1.ResumeLayout(false);
            this.splitContainer2.Panel2.ResumeLayout(false);
            this.splitContainer2.ResumeLayout(false);
            this.groupBox4.ResumeLayout(false);
            this.tableLayoutPanel3.ResumeLayout(false);
            this.tableLayoutPanel3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.employeeDegreeBindingSource)).EndInit();
            this.toolStrip4.ResumeLayout(false);
            this.toolStrip4.PerformLayout();
            this.groupBox5.ResumeLayout(false);
            this.tableLayoutPanel4.ResumeLayout(false);
            this.tableLayoutPanel4.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.employeeRankBindingSource)).EndInit();
            this.toolStrip1.ResumeLayout(false);
            this.toolStrip1.PerformLayout();
            this.tpEmplBonusReport.ResumeLayout(false);
            this.tpEmplBonusReport.PerformLayout();
            this.tableLayoutPanel6.ResumeLayout(false);
            this.tableLayoutPanel6.PerformLayout();
            this.toolStrip6.ResumeLayout(false);
            this.toolStrip6.PerformLayout();
            this.tpEmplBonus.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #region Properties
        private System.Windows.Forms.TabControl tcEmployee;
        private System.Windows.Forms.TabPage tpEmployee;
        private System.Windows.Forms.TabPage tpEmpPost;
        private System.Windows.Forms.TabPage tpBonus;
        private UIX.UI.CommandPropertyGrid cpgEmployee;
        private System.Windows.Forms.DataGridView dgvEmplPosts;
        private System.Windows.Forms.BindingSource factStaffBindingSource;
        private System.Windows.Forms.BindingSource AllbonusBindingSource;
        private System.Windows.Forms.TabPage tpEducation;
        private System.Windows.Forms.SplitContainer splitContainer2;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.GroupBox groupBox5;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel4;
        private System.Windows.Forms.DataGridView dataGridView3;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.ToolStripButton AddRankBtn;
        private System.Windows.Forms.ToolStripButton EditRankBtn;
        private System.Windows.Forms.ToolStripButton DelRankBtn;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.ToolStrip toolStrip3;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel3;
        private System.Windows.Forms.DataGridView dataGridView2;
        private System.Windows.Forms.ToolStrip toolStrip4;
        private System.Windows.Forms.ToolStripButton AddDegreeBtn;
        private System.Windows.Forms.ToolStripButton EditDegreeBtn;
        private System.Windows.Forms.ToolStripButton DelDegreeBtn;
        private System.Windows.Forms.DataGridView dgvAllBonus;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Button btnOk;
        private System.Windows.Forms.BindingSource employeeDegreeBindingSource;
        private System.Windows.Forms.DataGridViewTextBoxColumn rankDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn educDocumentDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn rankWhereDataGridViewTextBoxColumn;
        private System.Windows.Forms.BindingSource employeeRankBindingSource;
        public System.Windows.Forms.ToolStripSplitButton tsbBonusFilter;
        private System.Windows.Forms.ToolStripMenuItem �������ToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem ����������ToolStripMenuItem;
        private System.Windows.Forms.DataGridViewTextBoxColumn staffCountDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn dateBeginDataGridViewTextBoxColumn;
        private System.Windows.Forms.TabPage tpEmplBonusReport;
        private System.Windows.Forms.Button btnBonusRepLoad;
        private System.Windows.Forms.DateTimePicker dtpBonRepPeriodEnd;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DateTimePicker dtpBonRepPeriodBegin;
        private System.Windows.Forms.ToolStrip toolStrip6;
        private System.Windows.Forms.ToolStripLabel toolStripLabel2;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn17;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn19;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn2;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn4;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn18;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn3;
        private System.Windows.Forms.BindingSource oKOtpuskBindingSource;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel5;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel6;
        private System.Windows.Forms.DataGridViewTextBoxColumn degreeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn scienceTypeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn educDocumentDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn dissertCouncilDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn degreeDateDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn diplWhereDataGridViewTextBoxColumn;
        private System.Windows.Forms.ToolStripButton tsbBonusHistory;
        private Reports.Frames.ReportBaseFrameForPeriod employeeBonusReportFrame1;
        private System.Windows.Forms.DataGridViewTextBoxColumn BonusLevel;
        private System.Windows.Forms.DataGridViewTextBoxColumn BonusPost;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn BnLastFinancingSource;
        private System.Windows.Forms.DataGridViewTextBoxColumn AllBonusCount;
        private System.Windows.Forms.DataGridViewTextBoxColumn AllDateBegin;
        private System.Windows.Forms.DataGridViewTextBoxColumn PrikazBegin;
        private System.Windows.Forms.DataGridViewTextBoxColumn IntermediateDateEnd0;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn5;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn6;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn7;
        private System.Windows.Forms.DataGridViewTextBoxColumn Department;
        private System.Windows.Forms.DataGridViewTextBoxColumn Post;
        private System.Windows.Forms.DataGridViewTextBoxColumn WorkType;
        private System.Windows.Forms.DataGridViewTextBoxColumn HourCount;
        private System.Windows.Forms.DataGridViewTextBoxColumn FinancingSource;
        private System.Windows.Forms.DataGridViewTextBoxColumn PKCategory;
        private System.Windows.Forms.DataGridViewTextBoxColumn Category;
        private System.Windows.Forms.DataGridViewTextBoxColumn SalarySize;
        private System.Windows.Forms.DataGridViewTextBoxColumn StaffCount;
        private System.Windows.Forms.DataGridViewTextBoxColumn FStDateBegin;
        private System.Windows.Forms.DataGridViewTextBoxColumn FStPrikazBegin;
        private System.Windows.Forms.DataGridViewTextBoxColumn dateEndDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn Prikaz;
        private System.Windows.Forms.TabPage tpEmplBonus;
        private BonusFrame bonusFrame1;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.DataGridViewTextBoxColumn idOtpuskVidDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn idOtpuskPrikazDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn OtpDateBegin;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn8;
        #endregion



    }
}
