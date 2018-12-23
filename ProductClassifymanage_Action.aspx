<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductClassifymanage_Action.aspx.cs" Inherits="ProductClassifymanage_Action" %>

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
        System.Data.SqlClient.SqlDataReader dr = null;

        if (Request.Form["btn_Act"] == "新增") //後台商品名單點選新增
        {
            conn.Open();//Connected
            sqlcommand = new System.Data.SqlClient.SqlCommand("SELECT MAX(PC_num) FROM [ProductClassify]", conn);//查詢會員個數
            dr = sqlcommand.ExecuteReader();
            dr.Read();
            string InsertID = "";
            if (dr[0].ToString() == string.Empty) //當商品個數為0 則該筆商品的編號為1
                InsertID = 1.ToString();
            else
                InsertID = (Convert.ToInt32(dr[0]) + 1).ToString();//不為0 該筆商品編號為會員個數+1 
            dr.Close();
            conn.Close();

            conn.Open();
            sqlcommand = new System.Data.SqlClient.SqlCommand("INSERT INTO [ProductClassify] VALUES('" + //把輸入會員的資料存入資料庫中
                    InsertID + "','" +
                    Request.Form["txt_Name"].ToString() + "')", conn);
                sqlcommand.ExecuteNonQuery();

            conn.Close();
        }
        else if (Request.Form["btn_Act"] == "編輯")//後台商品名單點選編輯
        {
            conn.Open();
            sqlcommand = new System.Data.SqlClient.SqlCommand("UPDATE [ProductClassify] SET " + //進行該筆會員資料 的資料庫更新
                    "[PC_Name]='" + Request.Form["txt_Name"].ToString() + "' " +
                    "WHERE [PC_num]='" + Request.Form["Hid_Num"].ToString() + "'", conn);
                sqlcommand.ExecuteNonQuery();

            conn.Close();
        }
        else if (Request.Form["btn_Act"] == "刪除")//後台會員名單點選刪除
        {
            conn.Open();//Connected
            sqlcommand = new System.Data.SqlClient.SqlCommand("DELETE FROM [ProductClassify] WHERE [PC_num]='" + Request.Form["Hid_Num"].ToString() + "'", conn);
            sqlcommand.ExecuteNonQuery();
            conn.Close();
        }

        Response.Redirect("ProductClassifymanage.aspx");
    %>
</body>
</html>
