<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Ordersmanage_Action.aspx.cs" Inherits="Ordersmanager_Action" %>

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

        if (Request.Form["btn_Act"] == "編輯")//後台訂單點選編輯
        {
            string Status = "";
            switch (Request.Form["Sele_Status"])
            {
                case "1":
                    Status = "準備中";
                    break;
                case "2":
                    Status = "已出貨";
                    break;
                case "3":
                    Status = "到達配送地點";
                    break;
            }

            conn.Open();
            sqlcommand = new System.Data.SqlClient.SqlCommand("UPDATE [Orders] SET " + //進行該筆訂單資料 的資料庫更新
                "[O_Name]='" + Request.Form["txt_Name"].ToString() + "'," +
                "[O_Phone]='" + Request.Form["txt_Phone"].ToString() + "'," +
                "[O_Address]='" + Request.Form["txt_Address"].ToString() + "'," +
                "[Status]='" + Status + "'," +
                "[Price]='" + Request.Form["txt_Price"].ToString() + "' " +
                "WHERE [O_num]='" + Request.Form["Hid_Num"].ToString() + "'", conn);
            sqlcommand.ExecuteNonQuery();
            conn.Close();
        }
        else if (Request.Form["btn_Act"] == "刪除")//後台訂單點選刪除
        {
            conn.Open();//Connected
            sqlcommand = new System.Data.SqlClient.SqlCommand("DELETE FROM [Orders] WHERE [O_num]='" + Request.Form["Hid_Num"].ToString() + "'", conn);
            sqlcommand.ExecuteNonQuery();
            conn.Close();
        }

        Response.Redirect("Ordersmanage.aspx");
    %>
</body>
</html>
