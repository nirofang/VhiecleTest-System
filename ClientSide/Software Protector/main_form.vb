' Copyright (C) 2012 Artem Los, All rights reserved.
' To view the full license, goto http://softwareprotector.codeplex.com/license
Imports System.Threading.Tasks
Public Class main_form
    Dim skc As SKGL.SerialKeyConfiguration = New SKGL.SerialKeyConfiguration()
    Dim generate As SKGL.Generate = New SKGL.Generate(skc)
    Dim validateKey As SKGL.Validate = New SKGL.Validate(skc)

    Dim generatedKeys As New Dictionary(Of String, String)

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        DateTimePicker2.Value = Today.AddDays(30)
        NumericUpDown1.Value = 30





    End Sub


    Private Sub DateTimePicker2_ValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles DateTimePicker2.ValueChanged

        Dim num As Integer = DateDiff(DateInterval.DayOfYear, DateTimePicker1.Value, DateTimePicker2.Value)
        If num <= 999 Then
            NumericUpDown1.Value = DateDiff(DateInterval.DayOfYear, DateTimePicker1.Value, DateTimePicker2.Value)
        Else
            DateTimePicker2.Value = DateTimePicker1.Value.AddDays(999)
            NumericUpDown1.Value = 999
        End If
    End Sub
    Private Sub DateTimePicker1_ValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles DateTimePicker1.ValueChanged
        Dim num As Integer = DateDiff(DateInterval.DayOfYear, DateTimePicker1.Value, DateTimePicker2.Value)
        If num <= 999 Then
            NumericUpDown1.Value = DateDiff(DateInterval.DayOfYear, DateTimePicker1.Value, DateTimePicker2.Value)
        Else
            DateTimePicker2.Value = DateTimePicker1.Value.AddDays(999)
            NumericUpDown1.Value = 999
        End If
    End Sub

    Private Sub NumericUpDown1_ValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles NumericUpDown1.KeyUp, NumericUpDown1.ValueChanged
        DateTimePicker2.Value = DateTimePicker1.Value.AddDays(NumericUpDown1.Value)
    End Sub

    Private Sub CheckBox1_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CheckBox1.CheckedChanged
        If CheckBox1.Checked = True Then
            TextBox1.PasswordChar = ""
        Else
            TextBox1.PasswordChar = "*"
        End If
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim machinecode As Integer = 0
        If TextBox3.Text = "" Then
            machinecode = 0
        Else
            Dim reg As New System.Text.RegularExpressions.Regex("^\d$")
            If reg.IsMatch(TextBox3.Text) Then
                MsgBox("The machine code should only consist of digits!", MsgBoxStyle.Critical)
                TabControl1.SelectTab(1)
                TextBox3.Focus()
                TextBox3.SelectAll()
                Exit Sub
            Else
                Try
                    machinecode = TextBox3.Text
                Catch ex As Exception
                    MsgBox("The machine code should only consist of digits!", MsgBoxStyle.Critical)
                    TabControl1.SelectTab(1)
                    TextBox3.Focus()
                    TextBox3.SelectAll()
                    Exit Sub

                End Try
            End If
        End If

        generate.secretPhase = TextBox1.Text
        skc.Features = New Boolean(7) {CheckBox2.Checked, CheckBox3.Checked, CheckBox4.Checked, CheckBox5.Checked, CheckBox6.Checked, CheckBox7.Checked, CheckBox8.Checked, CheckBox9.Checked}
        If NumericUpDown2.Value > 1 Then
            If machinecode > 0 Then
                GoTo singleKeyMode
            End If
            Dim frmKeys As New keys

            For i As Integer = 0 To NumericUpDown2.Value - 1

                ' checking, whether the key already exists in our record
                Dim key As String = generate.doKey(NumericUpDown1.Value, DateTimePicker1.Value, machinecode) & Environment.NewLine
                If generatedKeys.ContainsKey(key) = False Then
                    frmKeys.TextBox1.Text &= key
                    generatedKeys.Add(key, TextBox1.Text)
                Else
                    i -= 1
                End If
            Next

            frmKeys.Show()
        Else
singleKeyMode:
            ' checking, whether the key already exists in our record
            Dim key As String
            key = generate.doKey(NumericUpDown1.Value, DateTimePicker1.Value, machinecode)

            If generatedKeys.ContainsKey(key) = False Then
                TextBox2.Text = key
                generatedKeys.Add(key, TextBox1.Text)
            ElseIf (generatedKeys.ContainsKey(key) = True And Not (generatedKeys.Item(key) = TextBox1.Text)) Then
                TextBox2.Text = key
            Else
                If machinecode > 0 Then
                    TextBox2.Text = key
                Else
                    GoTo singleKeyMode
                End If
            End If
        End If



    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim validator As New validateCheck
        validateKey.Key = TextBox2.Text

        If TextBox1.Text = "" Then
            validateKey.secretPhase = Nothing
        Else
            validateKey.secretPhase = TextBox1.Text
        End If


        If （validateKey.IsValid And TextBox3.Text = "") Or
            (validateKey.IsValid And TextBox3.Text <> "" And
            validateKey.IsOnRightMachine) Then

            If TextBox3.Text = "" Then
                validator.Label9.Text = validator.Label9.Text + ": N/A"
            Else
                validator.Label9.Text = validator.Label9.Text + ": CORRECT"
            End If


            validator.TextBox2.Text = TextBox2.Text
            validator.TextBox1.Text = validateKey.CreationDate.ToShortDateString
            validator.TextBox3.Text = validateKey.ExpireDate.ToShortDateString
            validator.TextBox4.Text = validateKey.SetTime
            validator.TextBox5.Text = validateKey.DaysLeft
            If validateKey.IsExpired Then
                validator.TextBox6.Text = "True"
                validator.TextBox6.ForeColor = Color.Red
            Else
                validator.TextBox6.Text = "False"
                validator.TextBox6.ForeColor = Color.Blue
            End If

            validator.CheckBox2.Checked = validateKey.Features(0)
            validator.CheckBox3.Checked = validateKey.Features(1)
            validator.CheckBox4.Checked = validateKey.Features(2)
            validator.CheckBox5.Checked = validateKey.Features(3)
            validator.CheckBox6.Checked = validateKey.Features(4)
            validator.CheckBox7.Checked = validateKey.Features(5)
            validator.CheckBox8.Checked = validateKey.Features(6)
            validator.CheckBox9.Checked = validateKey.Features(7)


            If NumericUpDown2.Enabled = False Then
                validator.Label18.Visible = True
            End If

            validator.Show()
        Else
            validator.Label2.ForeColor = Color.Red
            validator.Label2.Text = "Error"


            ' Means the machine code is incorrect
            If validateKey.IsValid Then
                validator.Label9.Text = validator.Label9.Text + ": INCORRECT"
                validator.Label9.ForeColor = Color.Red
            Else
                validator.Label9.Text = validator.Label9.Text + ": N/A"
            End If

            validator.TextBox2.Text = TextBox2.Text

            validator.Show()
        End If

    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        My.Computer.Clipboard.SetText(TextBox2.Text)
    End Sub

    'Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
    '    Try
    '        Process.Start("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=3R59VSU8LKETW")
    '    Catch ex As Exception

    '    End Try
    'End Sub

    Private Sub LinkLabel1_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs)
        Try
            Process.Start("http://softwareprotector.codeplex.com")
        Catch ex As Exception

        End Try
    End Sub

    Private Sub Button5_Click(sender As System.Object, e As System.EventArgs) Handles Button5.Click

        Label16.Text = "Your machine code is: " + generate.MachineCode.ToString
    End Sub

    Private Sub TextBox3_TextChanged(sender As System.Object, e As System.EventArgs) Handles TextBox3.TextChanged, TextBox3.MouseClick

        If TextBox3.Text = "" Then
            Label18.Visible = False
            NumericUpDown2.Enabled = True
        Else
            Label18.Visible = True
            NumericUpDown2.Enabled = False
        End If
    End Sub

    Private Sub Button6_Click(sender As System.Object, e As System.EventArgs) Handles Button6.Click
        TextBox3.Text = ""
        TextBox3.Focus()
    End Sub

    Private Sub CheckBox10_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox10.CheckedChanged
        If (CheckBox10.Checked = True) Then
            CheckBox2.Checked = True
        Else
            CheckBox2.Checked = False
        End If
    End Sub
End Class
