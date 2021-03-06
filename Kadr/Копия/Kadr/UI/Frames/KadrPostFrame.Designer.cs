﻿namespace Kadr.UI.Frames
{
    partial class KadrPostFrame
    {
        /// <summary> 
        /// Требуется переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором компонентов

        /// <summary> 
        /// Обязательный метод для поддержки конструктора - не изменяйте 
        /// содержимое данного метода при помощи редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(KadrPostFrame));
            this.tcDepartment = new System.Windows.Forms.TabControl();
            this.tpPost = new System.Windows.Forms.TabPage();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.dgvPost = new System.Windows.Forms.DataGridView();
            this.postBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.AddPostBtn = new System.Windows.Forms.ToolStripButton();
            this.EditPostBtn = new System.Windows.Forms.ToolStripButton();
            this.DelPostBtn = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.btnBonus = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.btnPostToExcel = new System.Windows.Forms.ToolStripButton();
            this.tpPKCategory = new System.Windows.Forms.TabPage();
            this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
            this.dgvPKCategory = new System.Windows.Forms.DataGridView();
            this.pKGroupDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.pKCategoryNumberDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.PKCategorySalary = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.pKCategoryBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.btnPKGToExcel = new System.Windows.Forms.ToolStrip();
            this.AddPKCatBtn = new System.Windows.Forms.ToolStripButton();
            this.EditPKCatBtn = new System.Windows.Forms.ToolStripButton();
            this.DelPKCatBtn = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator4 = new System.Windows.Forms.ToolStripSeparator();
            this.EditSalaryBtn = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.btnCategoriesToExcel = new System.Windows.Forms.ToolStripButton();
            this.tpEmployee = new System.Windows.Forms.TabPage();
            this.tableLayoutPanel3 = new System.Windows.Forms.TableLayoutPanel();
            this.dgvEmployee = new System.Windows.Forms.DataGridView();
            this.EmployeeName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.birthDateDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.birthPlaceDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.EmployeeGender = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.grazdDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.semPolDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.severKoeffDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.rayonKoeffDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.employeeBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.toolStrip5 = new System.Windows.Forms.ToolStrip();
            this.AddEmployeeBtn = new System.Windows.Forms.ToolStripButton();
            this.EditEmployeeBtn = new System.Windows.Forms.ToolStripButton();
            this.DelEmployeeBtn = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator5 = new System.Windows.Forms.ToolStripSeparator();
            this.btnEmployeeToExcel = new System.Windows.Forms.ToolStripButton();
            this.dataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.postNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.PostShortName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Category = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.GlobalPrikaz = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.PKCategory = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ManagerBit = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.groupBox1.SuspendLayout();
            this.tcDepartment.SuspendLayout();
            this.tpPost.SuspendLayout();
            this.tableLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPost)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.postBindingSource)).BeginInit();
            this.toolStrip1.SuspendLayout();
            this.tpPKCategory.SuspendLayout();
            this.tableLayoutPanel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPKCategory)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pKCategoryBindingSource)).BeginInit();
            this.btnPKGToExcel.SuspendLayout();
            this.tpEmployee.SuspendLayout();
            this.tableLayoutPanel3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvEmployee)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.employeeBindingSource)).BeginInit();
            this.toolStrip5.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.tcDepartment);
            this.groupBox1.Size = new System.Drawing.Size(763, 397);
            // 
            // tcDepartment
            // 
            this.tcDepartment.Controls.Add(this.tpPost);
            this.tcDepartment.Controls.Add(this.tpPKCategory);
            this.tcDepartment.Controls.Add(this.tpEmployee);
            this.tcDepartment.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tcDepartment.Location = new System.Drawing.Point(3, 16);
            this.tcDepartment.Name = "tcDepartment";
            this.tcDepartment.SelectedIndex = 0;
            this.tcDepartment.Size = new System.Drawing.Size(757, 378);
            this.tcDepartment.TabIndex = 3;
            this.tcDepartment.SelectedIndexChanged += new System.EventHandler(this.tcDepartment_SelectedIndexChanged);
            // 
            // tpPost
            // 
            this.tpPost.Controls.Add(this.tableLayoutPanel1);
            this.tpPost.Location = new System.Drawing.Point(4, 22);
            this.tpPost.Name = "tpPost";
            this.tpPost.Padding = new System.Windows.Forms.Padding(3);
            this.tpPost.Size = new System.Drawing.Size(749, 352);
            this.tpPost.TabIndex = 1;
            this.tpPost.Text = "Должности";
            this.tpPost.UseVisualStyleBackColor = true;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel1.Controls.Add(this.dgvPost, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.toolStrip1, 0, 0);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 2;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 26F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tableLayoutPanel1.Size = new System.Drawing.Size(743, 346);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // dgvPost
            // 
            this.dgvPost.AllowUserToAddRows = false;
            this.dgvPost.AllowUserToDeleteRows = false;
            this.dgvPost.AutoGenerateColumns = false;
            this.dgvPost.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvPost.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.postNameDataGridViewTextBoxColumn,
            this.PostShortName,
            this.Category,
            this.GlobalPrikaz,
            this.PKCategory,
            this.ManagerBit});
            this.dgvPost.DataSource = this.postBindingSource;
            this.dgvPost.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvPost.Location = new System.Drawing.Point(3, 29);
            this.dgvPost.Name = "dgvPost";
            this.dgvPost.ReadOnly = true;
            this.dgvPost.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvPost.Size = new System.Drawing.Size(737, 314);
            this.dgvPost.TabIndex = 1;
            this.dgvPost.DoubleClick += new System.EventHandler(this.dgvPost_DoubleClick);
            // 
            // postBindingSource
            // 
            this.postBindingSource.DataSource = typeof(Kadr.Data.Post);
            // 
            // toolStrip1
            // 
            this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.AddPostBtn,
            this.EditPostBtn,
            this.DelPostBtn,
            this.toolStripSeparator1,
            this.btnBonus,
            this.toolStripSeparator2,
            this.btnPostToExcel});
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(743, 25);
            this.toolStrip1.TabIndex = 2;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // AddPostBtn
            // 
            this.AddPostBtn.Image = global::Kadr.Properties.Resources.NewDocumentHS;
            this.AddPostBtn.ImageTransparentColor = System.Drawing.Color.Black;
            this.AddPostBtn.Name = "AddPostBtn";
            this.AddPostBtn.Size = new System.Drawing.Size(142, 22);
            this.AddPostBtn.Text = "Добавить должность";
            this.AddPostBtn.Click += new System.EventHandler(this.AddPostBtn_Click);
            // 
            // EditPostBtn
            // 
            this.EditPostBtn.Image = global::Kadr.Properties.Resources.Open;
            this.EditPostBtn.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.EditPostBtn.Name = "EditPostBtn";
            this.EditPostBtn.Size = new System.Drawing.Size(107, 22);
            this.EditPostBtn.Text = "Редактировать";
            this.EditPostBtn.Click += new System.EventHandler(this.EditPostBtn_Click);
            // 
            // DelPostBtn
            // 
            this.DelPostBtn.Image = global::Kadr.Properties.Resources.DeleteHS;
            this.DelPostBtn.ImageTransparentColor = System.Drawing.Color.Black;
            this.DelPostBtn.Name = "DelPostBtn";
            this.DelPostBtn.Size = new System.Drawing.Size(71, 22);
            this.DelPostBtn.Text = "Удалить";
            this.DelPostBtn.Click += new System.EventHandler(this.DelPostBtn_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // btnBonus
            // 
            this.btnBonus.Image = global::Kadr.Properties.Resources.Holder;
            this.btnBonus.ImageTransparentColor = System.Drawing.Color.White;
            this.btnBonus.Name = "btnBonus";
            this.btnBonus.Size = new System.Drawing.Size(80, 22);
            this.btnBonus.Text = "Надбавки";
            this.btnBonus.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnBonus.Click += new System.EventHandler(this.btnBonus_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(6, 25);
            // 
            // btnPostToExcel
            // 
            this.btnPostToExcel.Image = ((System.Drawing.Image)(resources.GetObject("btnPostToExcel.Image")));
            this.btnPostToExcel.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnPostToExcel.Name = "btnPostToExcel";
            this.btnPostToExcel.Size = new System.Drawing.Size(142, 22);
            this.btnPostToExcel.Text = "Выгрузить в MS Excel";
            this.btnPostToExcel.Click += new System.EventHandler(this.btnPostToExcel_Click);
            // 
            // tpPKCategory
            // 
            this.tpPKCategory.Controls.Add(this.tableLayoutPanel2);
            this.tpPKCategory.Location = new System.Drawing.Point(4, 22);
            this.tpPKCategory.Name = "tpPKCategory";
            this.tpPKCategory.Padding = new System.Windows.Forms.Padding(3);
            this.tpPKCategory.Size = new System.Drawing.Size(749, 352);
            this.tpPKCategory.TabIndex = 2;
            this.tpPKCategory.Text = "Профессиональные категории ";
            this.tpPKCategory.UseVisualStyleBackColor = true;
            // 
            // tableLayoutPanel2
            // 
            this.tableLayoutPanel2.ColumnCount = 1;
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel2.Controls.Add(this.dgvPKCategory, 0, 1);
            this.tableLayoutPanel2.Controls.Add(this.btnPKGToExcel, 0, 0);
            this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel2.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel2.Name = "tableLayoutPanel2";
            this.tableLayoutPanel2.RowCount = 2;
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 26F));
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tableLayoutPanel2.Size = new System.Drawing.Size(743, 346);
            this.tableLayoutPanel2.TabIndex = 1;
            // 
            // dgvPKCategory
            // 
            this.dgvPKCategory.AllowUserToAddRows = false;
            this.dgvPKCategory.AllowUserToDeleteRows = false;
            this.dgvPKCategory.AutoGenerateColumns = false;
            this.dgvPKCategory.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvPKCategory.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.pKGroupDataGridViewTextBoxColumn,
            this.pKCategoryNumberDataGridViewTextBoxColumn,
            this.PKCategorySalary});
            this.dgvPKCategory.DataSource = this.pKCategoryBindingSource;
            this.dgvPKCategory.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvPKCategory.Location = new System.Drawing.Point(3, 29);
            this.dgvPKCategory.Name = "dgvPKCategory";
            this.dgvPKCategory.ReadOnly = true;
            this.dgvPKCategory.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvPKCategory.Size = new System.Drawing.Size(737, 314);
            this.dgvPKCategory.TabIndex = 1;
            this.dgvPKCategory.DoubleClick += new System.EventHandler(this.dgvPKCategory_DoubleClick);
            // 
            // pKGroupDataGridViewTextBoxColumn
            // 
            this.pKGroupDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.pKGroupDataGridViewTextBoxColumn.DataPropertyName = "PKGroup";
            this.pKGroupDataGridViewTextBoxColumn.HeaderText = "Профессиональная группа";
            this.pKGroupDataGridViewTextBoxColumn.Name = "pKGroupDataGridViewTextBoxColumn";
            this.pKGroupDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // pKCategoryNumberDataGridViewTextBoxColumn
            // 
            this.pKCategoryNumberDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.pKCategoryNumberDataGridViewTextBoxColumn.DataPropertyName = "PKCategoryNumber";
            this.pKCategoryNumberDataGridViewTextBoxColumn.FillWeight = 200F;
            this.pKCategoryNumberDataGridViewTextBoxColumn.HeaderText = "Номер категории";
            this.pKCategoryNumberDataGridViewTextBoxColumn.Name = "pKCategoryNumberDataGridViewTextBoxColumn";
            this.pKCategoryNumberDataGridViewTextBoxColumn.ReadOnly = true;
            this.pKCategoryNumberDataGridViewTextBoxColumn.Width = 111;
            // 
            // PKCategorySalary
            // 
            this.PKCategorySalary.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.PKCategorySalary.DataPropertyName = "PKCategorySalary";
            this.PKCategorySalary.HeaderText = "Размер оклада";
            this.PKCategorySalary.Name = "PKCategorySalary";
            this.PKCategorySalary.ReadOnly = true;
            this.PKCategorySalary.Width = 101;
            // 
            // pKCategoryBindingSource
            // 
            this.pKCategoryBindingSource.DataSource = typeof(Kadr.Data.PKCategory);
            // 
            // btnPKGToExcel
            // 
            this.btnPKGToExcel.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.AddPKCatBtn,
            this.EditPKCatBtn,
            this.DelPKCatBtn,
            this.toolStripSeparator4,
            this.EditSalaryBtn,
            this.toolStripSeparator3,
            this.btnCategoriesToExcel});
            this.btnPKGToExcel.Location = new System.Drawing.Point(0, 0);
            this.btnPKGToExcel.Name = "btnPKGToExcel";
            this.btnPKGToExcel.Size = new System.Drawing.Size(743, 25);
            this.btnPKGToExcel.TabIndex = 2;
            this.btnPKGToExcel.Text = "Выгрузить в MS Excel";
            // 
            // AddPKCatBtn
            // 
            this.AddPKCatBtn.Image = global::Kadr.Properties.Resources.NewDocumentHS;
            this.AddPKCatBtn.ImageTransparentColor = System.Drawing.Color.Black;
            this.AddPKCatBtn.Name = "AddPKCatBtn";
            this.AddPKCatBtn.Size = new System.Drawing.Size(141, 22);
            this.AddPKCatBtn.Text = "Добавить категорию";
            this.AddPKCatBtn.Click += new System.EventHandler(this.AddPKCatBtn_Click);
            // 
            // EditPKCatBtn
            // 
            this.EditPKCatBtn.Image = global::Kadr.Properties.Resources.Open;
            this.EditPKCatBtn.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.EditPKCatBtn.Name = "EditPKCatBtn";
            this.EditPKCatBtn.Size = new System.Drawing.Size(169, 22);
            this.EditPKCatBtn.Text = "Редактировать категорию";
            this.EditPKCatBtn.Click += new System.EventHandler(this.EditPKCatBtn_Click);
            // 
            // DelPKCatBtn
            // 
            this.DelPKCatBtn.Image = global::Kadr.Properties.Resources.DeleteHS;
            this.DelPKCatBtn.ImageTransparentColor = System.Drawing.Color.Black;
            this.DelPKCatBtn.Name = "DelPKCatBtn";
            this.DelPKCatBtn.Size = new System.Drawing.Size(133, 22);
            this.DelPKCatBtn.Text = "Удалить категорию";
            this.DelPKCatBtn.Click += new System.EventHandler(this.DelPKCatBtn_Click);
            // 
            // toolStripSeparator4
            // 
            this.toolStripSeparator4.Name = "toolStripSeparator4";
            this.toolStripSeparator4.Size = new System.Drawing.Size(6, 25);
            // 
            // EditSalaryBtn
            // 
            this.EditSalaryBtn.Image = global::Kadr.Properties.Resources.EditInformationHS;
            this.EditSalaryBtn.ImageTransparentColor = System.Drawing.Color.Black;
            this.EditSalaryBtn.Name = "EditSalaryBtn";
            this.EditSalaryBtn.Size = new System.Drawing.Size(61, 22);
            this.EditSalaryBtn.Text = "Оклад";
            this.EditSalaryBtn.Click += new System.EventHandler(this.EditSalaryBtn_Click);
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            this.toolStripSeparator3.Size = new System.Drawing.Size(6, 25);
            // 
            // btnCategoriesToExcel
            // 
            this.btnCategoriesToExcel.Image = global::Kadr.Properties.Resources.Excel;
            this.btnCategoriesToExcel.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnCategoriesToExcel.Name = "btnCategoriesToExcel";
            this.btnCategoriesToExcel.Size = new System.Drawing.Size(142, 22);
            this.btnCategoriesToExcel.Text = "Выгрузить в MS Excel";
            this.btnCategoriesToExcel.Click += new System.EventHandler(this.btnCategoriesToExcel_Click);
            // 
            // tpEmployee
            // 
            this.tpEmployee.Controls.Add(this.tableLayoutPanel3);
            this.tpEmployee.Location = new System.Drawing.Point(4, 22);
            this.tpEmployee.Name = "tpEmployee";
            this.tpEmployee.Padding = new System.Windows.Forms.Padding(3);
            this.tpEmployee.Size = new System.Drawing.Size(749, 352);
            this.tpEmployee.TabIndex = 3;
            this.tpEmployee.Text = "Сотрудники";
            this.tpEmployee.UseVisualStyleBackColor = true;
            // 
            // tableLayoutPanel3
            // 
            this.tableLayoutPanel3.ColumnCount = 1;
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel3.Controls.Add(this.dgvEmployee, 0, 1);
            this.tableLayoutPanel3.Controls.Add(this.toolStrip5, 0, 0);
            this.tableLayoutPanel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel3.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel3.Name = "tableLayoutPanel3";
            this.tableLayoutPanel3.RowCount = 2;
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 26F));
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tableLayoutPanel3.Size = new System.Drawing.Size(743, 346);
            this.tableLayoutPanel3.TabIndex = 6;
            // 
            // dgvEmployee
            // 
            this.dgvEmployee.AllowUserToAddRows = false;
            this.dgvEmployee.AllowUserToDeleteRows = false;
            this.dgvEmployee.AutoGenerateColumns = false;
            this.dgvEmployee.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvEmployee.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.EmployeeName,
            this.birthDateDataGridViewTextBoxColumn,
            this.birthPlaceDataGridViewTextBoxColumn,
            this.EmployeeGender,
            this.grazdDataGridViewTextBoxColumn,
            this.semPolDataGridViewTextBoxColumn,
            this.severKoeffDataGridViewTextBoxColumn,
            this.rayonKoeffDataGridViewTextBoxColumn});
            this.dgvEmployee.DataSource = this.employeeBindingSource;
            this.dgvEmployee.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvEmployee.Location = new System.Drawing.Point(3, 29);
            this.dgvEmployee.Name = "dgvEmployee";
            this.dgvEmployee.ReadOnly = true;
            this.dgvEmployee.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvEmployee.Size = new System.Drawing.Size(737, 314);
            this.dgvEmployee.TabIndex = 4;
            this.dgvEmployee.DoubleClick += new System.EventHandler(this.EditEmployeeBtn_Click);
            // 
            // EmployeeName
            // 
            this.EmployeeName.DataPropertyName = "EmployeeName";
            this.EmployeeName.FillWeight = 200F;
            this.EmployeeName.HeaderText = "ФИО";
            this.EmployeeName.Name = "EmployeeName";
            this.EmployeeName.ReadOnly = true;
            this.EmployeeName.Width = 200;
            // 
            // birthDateDataGridViewTextBoxColumn
            // 
            this.birthDateDataGridViewTextBoxColumn.DataPropertyName = "BirthDate";
            this.birthDateDataGridViewTextBoxColumn.HeaderText = "Дата рождения";
            this.birthDateDataGridViewTextBoxColumn.Name = "birthDateDataGridViewTextBoxColumn";
            this.birthDateDataGridViewTextBoxColumn.ReadOnly = true;
            this.birthDateDataGridViewTextBoxColumn.Width = 80;
            // 
            // birthPlaceDataGridViewTextBoxColumn
            // 
            this.birthPlaceDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.birthPlaceDataGridViewTextBoxColumn.DataPropertyName = "BirthPlace";
            this.birthPlaceDataGridViewTextBoxColumn.HeaderText = "Место рождения";
            this.birthPlaceDataGridViewTextBoxColumn.Name = "birthPlaceDataGridViewTextBoxColumn";
            this.birthPlaceDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // EmployeeGender
            // 
            this.EmployeeGender.DataPropertyName = "EmployeeGender";
            this.EmployeeGender.HeaderText = "Пол";
            this.EmployeeGender.Name = "EmployeeGender";
            this.EmployeeGender.ReadOnly = true;
            this.EmployeeGender.Width = 70;
            // 
            // grazdDataGridViewTextBoxColumn
            // 
            this.grazdDataGridViewTextBoxColumn.DataPropertyName = "Grazd";
            this.grazdDataGridViewTextBoxColumn.HeaderText = "Гражданство";
            this.grazdDataGridViewTextBoxColumn.Name = "grazdDataGridViewTextBoxColumn";
            this.grazdDataGridViewTextBoxColumn.ReadOnly = true;
            this.grazdDataGridViewTextBoxColumn.Width = 80;
            // 
            // semPolDataGridViewTextBoxColumn
            // 
            this.semPolDataGridViewTextBoxColumn.DataPropertyName = "SemPol";
            this.semPolDataGridViewTextBoxColumn.HeaderText = "Сем. положение";
            this.semPolDataGridViewTextBoxColumn.Name = "semPolDataGridViewTextBoxColumn";
            this.semPolDataGridViewTextBoxColumn.ReadOnly = true;
            this.semPolDataGridViewTextBoxColumn.Width = 80;
            // 
            // severKoeffDataGridViewTextBoxColumn
            // 
            this.severKoeffDataGridViewTextBoxColumn.DataPropertyName = "SeverKoeff";
            this.severKoeffDataGridViewTextBoxColumn.HeaderText = "Сев. коэф.";
            this.severKoeffDataGridViewTextBoxColumn.Name = "severKoeffDataGridViewTextBoxColumn";
            this.severKoeffDataGridViewTextBoxColumn.ReadOnly = true;
            this.severKoeffDataGridViewTextBoxColumn.Width = 50;
            // 
            // rayonKoeffDataGridViewTextBoxColumn
            // 
            this.rayonKoeffDataGridViewTextBoxColumn.DataPropertyName = "RayonKoeff";
            this.rayonKoeffDataGridViewTextBoxColumn.HeaderText = "Район. коэф.";
            this.rayonKoeffDataGridViewTextBoxColumn.Name = "rayonKoeffDataGridViewTextBoxColumn";
            this.rayonKoeffDataGridViewTextBoxColumn.ReadOnly = true;
            this.rayonKoeffDataGridViewTextBoxColumn.Width = 50;
            // 
            // employeeBindingSource
            // 
            this.employeeBindingSource.DataSource = typeof(Kadr.Data.Employee);
            // 
            // toolStrip5
            // 
            this.toolStrip5.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.AddEmployeeBtn,
            this.EditEmployeeBtn,
            this.DelEmployeeBtn,
            this.toolStripSeparator5,
            this.btnEmployeeToExcel});
            this.toolStrip5.Location = new System.Drawing.Point(0, 0);
            this.toolStrip5.Name = "toolStrip5";
            this.toolStrip5.Size = new System.Drawing.Size(743, 25);
            this.toolStrip5.TabIndex = 2;
            this.toolStrip5.Text = "toolStrip5";
            // 
            // AddEmployeeBtn
            // 
            this.AddEmployeeBtn.Image = global::Kadr.Properties.Resources.NewDocumentHS;
            this.AddEmployeeBtn.ImageTransparentColor = System.Drawing.Color.Black;
            this.AddEmployeeBtn.Name = "AddEmployeeBtn";
            this.AddEmployeeBtn.Size = new System.Drawing.Size(145, 22);
            this.AddEmployeeBtn.Text = "Добавить сотрудника";
            this.AddEmployeeBtn.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.AddEmployeeBtn.Click += new System.EventHandler(this.AddEmployeeBtn_Click);
            // 
            // EditEmployeeBtn
            // 
            this.EditEmployeeBtn.Image = global::Kadr.Properties.Resources.Open;
            this.EditEmployeeBtn.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.EditEmployeeBtn.Name = "EditEmployeeBtn";
            this.EditEmployeeBtn.Size = new System.Drawing.Size(107, 22);
            this.EditEmployeeBtn.Text = "Редактировать";
            this.EditEmployeeBtn.Click += new System.EventHandler(this.EditEmployeeBtn_Click);
            // 
            // DelEmployeeBtn
            // 
            this.DelEmployeeBtn.Image = global::Kadr.Properties.Resources.DeleteHS;
            this.DelEmployeeBtn.ImageTransparentColor = System.Drawing.Color.Black;
            this.DelEmployeeBtn.Name = "DelEmployeeBtn";
            this.DelEmployeeBtn.Size = new System.Drawing.Size(71, 22);
            this.DelEmployeeBtn.Text = "Удалить";
            this.DelEmployeeBtn.Click += new System.EventHandler(this.DelEmployeeBtn_Click);
            // 
            // toolStripSeparator5
            // 
            this.toolStripSeparator5.Name = "toolStripSeparator5";
            this.toolStripSeparator5.Size = new System.Drawing.Size(6, 25);
            // 
            // btnEmployeeToExcel
            // 
            this.btnEmployeeToExcel.Image = global::Kadr.Properties.Resources.Excel;
            this.btnEmployeeToExcel.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnEmployeeToExcel.Name = "btnEmployeeToExcel";
            this.btnEmployeeToExcel.Size = new System.Drawing.Size(142, 22);
            this.btnEmployeeToExcel.Text = "Выгрузить в MS Excel";
            this.btnEmployeeToExcel.Click += new System.EventHandler(this.btnEmployeeToExcel_Click);
            // 
            // dataGridViewTextBoxColumn1
            // 
            this.dataGridViewTextBoxColumn1.DataPropertyName = "Grazd";
            this.dataGridViewTextBoxColumn1.HeaderText = "Гражданство";
            this.dataGridViewTextBoxColumn1.Name = "dataGridViewTextBoxColumn1";
            // 
            // dataGridViewTextBoxColumn2
            // 
            this.dataGridViewTextBoxColumn2.DataPropertyName = "SemPol";
            this.dataGridViewTextBoxColumn2.HeaderText = "Сем. положение";
            this.dataGridViewTextBoxColumn2.Name = "dataGridViewTextBoxColumn2";
            // 
            // postNameDataGridViewTextBoxColumn
            // 
            this.postNameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.postNameDataGridViewTextBoxColumn.DataPropertyName = "PostName";
            this.postNameDataGridViewTextBoxColumn.HeaderText = "Должность";
            this.postNameDataGridViewTextBoxColumn.MinimumWidth = 100;
            this.postNameDataGridViewTextBoxColumn.Name = "postNameDataGridViewTextBoxColumn";
            this.postNameDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // PostShortName
            // 
            this.PostShortName.DataPropertyName = "PostShortName";
            this.PostShortName.HeaderText = "Краткое название";
            this.PostShortName.Name = "PostShortName";
            this.PostShortName.ReadOnly = true;
            this.PostShortName.Width = 175;
            // 
            // Category
            // 
            this.Category.DataPropertyName = "Category";
            this.Category.HeaderText = "Катег- ория";
            this.Category.Name = "Category";
            this.Category.ReadOnly = true;
            this.Category.Width = 45;
            // 
            // GlobalPrikaz
            // 
            this.GlobalPrikaz.DataPropertyName = "GlobalPrikaz";
            this.GlobalPrikaz.HeaderText = "Приказ министерства";
            this.GlobalPrikaz.Name = "GlobalPrikaz";
            this.GlobalPrikaz.ReadOnly = true;
            this.GlobalPrikaz.Width = 83;
            // 
            // PKCategory
            // 
            this.PKCategory.DataPropertyName = "PKCategory";
            this.PKCategory.HeaderText = "Проф. категория";
            this.PKCategory.Name = "PKCategory";
            this.PKCategory.ReadOnly = true;
            this.PKCategory.Width = 63;
            // 
            // ManagerBit
            // 
            this.ManagerBit.DataPropertyName = "ManagerBit";
            this.ManagerBit.HeaderText = "Руководитель";
            this.ManagerBit.Name = "ManagerBit";
            this.ManagerBit.ReadOnly = true;
            this.ManagerBit.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.ManagerBit.Width = 85;
            // 
            // KadrPostFrame
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Name = "KadrPostFrame";
            this.Size = new System.Drawing.Size(763, 397);
            this.groupBox1.ResumeLayout(false);
            this.tcDepartment.ResumeLayout(false);
            this.tpPost.ResumeLayout(false);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPost)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.postBindingSource)).EndInit();
            this.toolStrip1.ResumeLayout(false);
            this.toolStrip1.PerformLayout();
            this.tpPKCategory.ResumeLayout(false);
            this.tableLayoutPanel2.ResumeLayout(false);
            this.tableLayoutPanel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPKCategory)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pKCategoryBindingSource)).EndInit();
            this.btnPKGToExcel.ResumeLayout(false);
            this.btnPKGToExcel.PerformLayout();
            this.tpEmployee.ResumeLayout(false);
            this.tableLayoutPanel3.ResumeLayout(false);
            this.tableLayoutPanel3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvEmployee)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.employeeBindingSource)).EndInit();
            this.toolStrip5.ResumeLayout(false);
            this.toolStrip5.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl tcDepartment;
        private System.Windows.Forms.TabPage tpPost;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.DataGridView dgvPost;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.ToolStripButton AddPostBtn;
        private System.Windows.Forms.ToolStripButton EditPostBtn;
        private System.Windows.Forms.ToolStripButton DelPostBtn;
        private System.Windows.Forms.TabPage tpPKCategory;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel2;
        private System.Windows.Forms.DataGridView dgvPKCategory;
        private System.Windows.Forms.ToolStrip btnPKGToExcel;
        private System.Windows.Forms.ToolStripButton AddPKCatBtn;
        private System.Windows.Forms.ToolStripButton EditPKCatBtn;
        private System.Windows.Forms.ToolStripButton DelPKCatBtn;
        private System.Windows.Forms.ToolStripButton EditSalaryBtn;
        private System.Windows.Forms.BindingSource pKCategoryBindingSource;
        private System.Windows.Forms.BindingSource postBindingSource;
        private System.Windows.Forms.TabPage tpEmployee;
        private System.Windows.Forms.DataGridView dgvEmployee;
        private System.Windows.Forms.BindingSource employeeBindingSource;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn2;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel3;
        private System.Windows.Forms.ToolStrip toolStrip5;
        private System.Windows.Forms.ToolStripButton AddEmployeeBtn;
        private System.Windows.Forms.ToolStripButton EditEmployeeBtn;
        private System.Windows.Forms.ToolStripButton DelEmployeeBtn;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripButton btnBonus;
        private System.Windows.Forms.DataGridViewTextBoxColumn pKGroupDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn pKCategoryNumberDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn PKCategorySalary;
        private System.Windows.Forms.DataGridViewTextBoxColumn EmployeeName;
        private System.Windows.Forms.DataGridViewTextBoxColumn birthDateDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn birthPlaceDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn EmployeeGender;
        private System.Windows.Forms.DataGridViewTextBoxColumn grazdDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn semPolDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn severKoeffDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn rayonKoeffDataGridViewTextBoxColumn;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripButton btnPostToExcel;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator4;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
        private System.Windows.Forms.ToolStripButton btnCategoriesToExcel;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator5;
        private System.Windows.Forms.ToolStripButton btnEmployeeToExcel;
        private System.Windows.Forms.DataGridViewTextBoxColumn postNameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn PostShortName;
        private System.Windows.Forms.DataGridViewTextBoxColumn Category;
        private System.Windows.Forms.DataGridViewTextBoxColumn GlobalPrikaz;
        private System.Windows.Forms.DataGridViewTextBoxColumn PKCategory;
        private System.Windows.Forms.DataGridViewCheckBoxColumn ManagerBit;
    }
}
