namespace APG.CodeHelper.Actions
{
    /// <summary>
    /// ����� ������� ��������, ������� ����� ���� 
    /// ��������� ��� �������� ����������������� ����������
    /// </summary>
    public enum UIObjectAction
    {
        taAdd, taDelete, taCopy, taCut, taUpdate, taPaste
    }

    /// <summary>
    /// ��������� ��������� ���������� ��� ���������� ������� 
    /// �������� ��� �������� ����������������� ����������
    /// </summary>
    public abstract class UIAction
    {
        /// <summary>
        /// ����� �������������� ��������
        /// </summary>
        public static readonly int Count = 6;
        /// <summary>
        /// �������������� � ����������� ������� ��� ���������� �������� ���������� �������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        protected abstract void AddExecute(object sender);
        /// <summary>
        /// �������������� � ����������� ������� ��� ���������� �������� �������� �������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        protected abstract void DeleteExecute(object sender);
        /// <summary>
        /// �������������� � ����������� ������� ��� ���������� �������� ������� �������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        protected abstract void CutExecute(object sender);
        /// <summary>
        /// �������������� � ����������� ������� ��� ���������� �������� ����������� �������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        protected abstract void CopyExecute(object sender);
        /// <summary>
        /// �������������� � ����������� ������� ��� ���������� �������� ������� �������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        protected abstract void PasteExecute(object sender);
        /// <summary>
        /// �������������� � ����������� ������� ��� ���������� �������� �������������� �������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        protected abstract void UpdateExecute(object sender);

        /// <summary>
        /// �������������� � ����������� ������� ��� ����������� ����������� ���������
        /// ���������� �������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        /// <returns>true, ���� ������� ���������, false - � ��������� ������</returns>
        protected abstract bool CanAdd(object sender);
        /// <summary>
        /// �������������� � ����������� ������� ��� ����������� ����������� ���������
        /// �������� �������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        /// <returns>true, ���� ������� ���������, false - � ��������� ������</returns>
        protected abstract bool CanDelete(object sender);
        /// <summary>
        /// �������������� � ����������� ������� ��� ����������� ����������� ���������
        /// ������� �������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        /// <returns>true, ���� ������� ���������, false - � ��������� ������</returns>
        protected abstract bool CanCut(object sender);
        /// <summary>
        /// �������������� � ����������� ������� ��� ����������� ����������� ���������
        /// ����������� �������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        /// <returns>true, ���� ������� ���������, false - � ��������� ������</returns>
        protected abstract bool CanCopy(object sender);
        /// <summary>
        /// �������������� � ����������� ������� ��� ����������� ����������� ���������
        /// ������� �������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        /// <returns>true, ���� ������� ���������, false - � ��������� ������</returns>
        protected abstract bool CanPaste(object sender);
        /// <summary>
        /// �������������� � ����������� ������� ��� ����������� ����������� ���������
        /// �������������� �������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        /// <returns>true, ���� ������� ���������, false - � ��������� ������</returns>
        protected abstract bool CanUpdate(object sender);
        
        /// <summary>
        /// �������������� � ����������� ������� ��� ���������� ����� ������� ��������
        /// </summary>
        /// <param name="index">��� ������� ��������</param>
        /// <param name="val">��� ������� ��������</param>
        protected abstract void SetCaption(UIObjectAction index, string caption);
             
        /// <summary>
        /// �������������� � ����������� ������� ��� ��������� ����� ������� ��������
        /// </summary>
        /// <param name="index">��� ������� ��������</param>
        /// <returns>��� ������� ��������</returns>
        protected abstract string GetCaption(UIObjectAction index);


        /// <summary>
        /// ��������� ������� �������� ��� ��������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        /// <param name="index">��� ������� �������� ��� ����������</param>
        public void Execute(object sender, UIObjectAction index)
        {
            switch (index)
            {
                case UIObjectAction.taAdd: AddExecute(sender); break;
                case UIObjectAction.taDelete: DeleteExecute(sender); break;
                case UIObjectAction.taUpdate: UpdateExecute(sender); break;
                case UIObjectAction.taCopy: CopyExecute(sender); break;
                case UIObjectAction.taPaste: PasteExecute(sender); break;
                case UIObjectAction.taCut: CutExecute(sender); break;
            }
        }

        /// <summary>
        /// ��������� ����������� ���������� ������� ��������
        /// </summary>
        /// <param name="sender">���������� ������, ��������� ���������</param>
        /// <param name="index">��� ������� ��������</param>
        /// <returns>true, ���� �������� ����� ���� ����������, false - � ��������� ������</returns>
        public bool CanDoThis(object sender, UIObjectAction index)
        {
            switch (index)
            {
                case UIObjectAction.taAdd: return CanAdd(sender);
                case UIObjectAction.taDelete: return CanDelete(sender);
                case UIObjectAction.taUpdate: return CanUpdate(sender);
                case UIObjectAction.taCopy: return CanCopy(sender);
                case UIObjectAction.taPaste: return CanPaste(sender);
                case UIObjectAction.taCut: return CanCut(sender);
                default: return false;
            }
        }

        /// <summary>
        /// ���������� ��� ��� ������� ��������
        /// </summary>
        /// <param name="index">��� ������� ��������</param>
        /// <returns>��� ������� ��������</returns>
        public string this[UIObjectAction index]
        {
            get
            {
                return GetCaption(index);
            }
            set
            {
                SetCaption(index, value);
            }
        }
    }
}