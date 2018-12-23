
Partial Class Default2
    Inherits System.Web.UI.Page

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session("role") <> "管理者" Then
            Response.Redirect("Default.aspx")
        End If
    End Sub
End Class
