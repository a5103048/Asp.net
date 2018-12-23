<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cart_Action.aspx.cs" Inherits="Cart_Action" %>

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

        string Mnum = Request.Form["Hid_MNum"].ToString();
        string Cnum = Request.Form["Hid_CNum"].ToString();
        string style = Request.Form["Hid_Style"].ToString();

        conn.Open();//Connected
        sqlcommand = new System.Data.SqlClient.SqlCommand("DELETE FROM [Cart] WHERE [M_num]=" + Mnum + " AND [C_num]=" + Cnum + " AND [P_style]='" + style + "'", conn);
        sqlcommand.ExecuteNonQuery();
        conn.Close();
        
        Response.Redirect("Cart.aspx");
    %>
</body>
</html>
