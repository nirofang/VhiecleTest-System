namespace GenerateMachineCode
{
    partial class MainForm
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要修改
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.MachineCode = new System.Windows.Forms.TextBox();
            this.GetCodeBtn = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // MachineCode
            // 
            this.MachineCode.Location = new System.Drawing.Point(56, 35);
            this.MachineCode.Name = "MachineCode";
            this.MachineCode.ReadOnly = true;
            this.MachineCode.Size = new System.Drawing.Size(103, 21);
            this.MachineCode.TabIndex = 0;
            // 
            // GetCodeBtn
            // 
            this.GetCodeBtn.Location = new System.Drawing.Point(211, 35);
            this.GetCodeBtn.Name = "GetCodeBtn";
            this.GetCodeBtn.Size = new System.Drawing.Size(75, 21);
            this.GetCodeBtn.TabIndex = 1;
            this.GetCodeBtn.Text = "产生机器码";
            this.GetCodeBtn.UseVisualStyleBackColor = true;
            this.GetCodeBtn.Click += new System.EventHandler(this.GetCodeBtn_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.ClientSize = new System.Drawing.Size(359, 110);
            this.Controls.Add(this.GetCodeBtn);
            this.Controls.Add(this.MachineCode);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "MainForm";
            this.Text = "机器码生成";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox MachineCode;
        private System.Windows.Forms.Button GetCodeBtn;
    }
}

