<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContactUsmanage_Action.aspx.cs" Inherits="ContactUsmanage_Action" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <%
        System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        System.Data.SqlClient.SqlCommand sqlcommand = null;

        if (Request.Form["btn_Act"] == "刪除")//後台聯絡我們點選刪除
        {
            conn.Open();//Connected
            sqlcommand = new System.Data.SqlClient.SqlCommand("DELETE FROM [ContactUs] WHERE [C_num]='" + Request.Form["Hid_Num"].ToString() + "'", conn);
            sqlcommand.ExecuteNonQuery();
            conn.Close();
        }

        Response.Redirect("ContactUsmanage.aspx");
    %>
</body>
</html>
