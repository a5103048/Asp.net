
Partial Class _Default
    Inherits System.Web.UI.Page

    Public Sub Login1_Authenticate(sender As Object, e As AuthenticateEventArgs) Handles Login1.Authenticate
        For Each R As TableRow In GridView1.Rows
            If Login1.UserName = R.Cells(0).Text Then
                If Login1.Password = R.Cells(1).Text Then
                    Session("role") = R.Cells(3).Text
                    If R.Cells(3).Text = "管理者" Then
                        Response.Redirect("Default2.aspx")
                    Else
                        Response.Redirect("Default3.aspx")
                    End If
                End If
            End If
        Next
    End Sub
    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Response.Redirect("Default4.aspx")
    End Sub
End Class
