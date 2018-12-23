<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SecondHandProductmanage_Action.aspx.cs" Inherits="SecondHandProductmanage_Action" %>

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
            HttpPostedFile file = Request.Files[0];

            conn.Open();//Connected
            sqlcommand = new System.Data.SqlClient.SqlCommand("SELECT MAX(SHP_num) FROM [SecondHandProduct]", conn);//查詢會員個數
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
            if (file != null && file.ContentLength > 0)
            {
                string SaveImg = "SecondHandProductImg/" + "P" + InsertID + ".jpg";
                file.SaveAs(Server.MapPath(SaveImg));

                sqlcommand = new System.Data.SqlClient.SqlCommand("INSERT INTO [SecondHandProduct] VALUES('" + //把輸入會員的資料存入資料庫中
                    InsertID + "','" +
                    Request.Form["txt_Name"].ToString() + "','" +
                    Request.Form["txt_Price"].ToString() + "','" +
                    Request.Form["txt_Info"].ToString() + "','" +
                    SaveImg + "','" +
                    Request.Form["txt_SellerName"].ToString() + "','" +
                    Request.Form["txt_SellerPhone"].ToString() + "')", conn);
                sqlcommand.ExecuteNonQuery();
            }
            else
            {
                sqlcommand = new System.Data.SqlClient.SqlCommand("INSERT INTO [SecondHandProduct] VALUES('" + //把輸入會員的資料存入資料庫中
                    InsertID + "','" +
                    Request.Form["txt_Name"].ToString() + "','" +
                    Request.Form["txt_Price"].ToString() + "','" +
                    Request.Form["txt_Info"].ToString() + "'," +
                    "NULL" + ",'" +
                    Request.Form["txt_SellerName"].ToString() + "','" +
                    Request.Form["txt_SellerPhone"].ToString() + "')", conn);
                sqlcommand.ExecuteNonQuery();
            }

            conn.Close();
        }
        else if (Request.Form["btn_Act"] == "編輯")//後台商品名單點選編輯
        {
            HttpPostedFile file = Request.Files["File_Img"];

            conn.Open();
            if (file != null && file.ContentLength > 0)
            {
                string SaveImg = "SecondHandProductImg/" + "P" + Request.Form["Hid_Num"].ToString() + ".jpg";
                file.SaveAs(Server.MapPath(SaveImg));

                sqlcommand = new System.Data.SqlClient.SqlCommand("UPDATE [SecondHandProduct] SET " + //進行該筆會員資料 的資料庫更新
                    "[SHP_Name]='" + Request.Form["txt_Name"].ToString() + "'," +
                    "[SHP_Price]='" + Request.Form["txt_Price"].ToString() + "'," +
                    "[SHP_Info]='" + Request.Form["txt_Info"].ToString() + "'," +
                    "[SHP_Img]='" + SaveImg + "'," +
                    "[SHP_SellerName]='" + Request.Form["txt_SellerName"].ToString() + "'," +
                    "[SHP_SellerPhone]='" + Request.Form["txt_SellerPhone"].ToString() + "' " +
                    "WHERE [SHP_num]='" + Request.Form["Hid_Num"].ToString() + "'", conn);
                sqlcommand.ExecuteNonQuery();
            }
            else
            {
                sqlcommand = new System.Data.SqlClient.SqlCommand("UPDATE [SecondHandProduct] SET " + //進行該筆會員資料 的資料庫更新
                    "[SHP_Name]='" + Request.Form["txt_Name"].ToString() + "'," +
                    "[SHP_Price]='" + Request.Form["txt_Price"].ToString() + "'," +
                    "[SHP_Info]='" + Request.Form["txt_Info"].ToString() + "'," +
                    "[SHP_SellerName]='" + Request.Form["txt_SellerName"].ToString() + "'," +
                    "[SHP_SellerPhone]='" + Request.Form["txt_SellerPhone"].ToString() + "' " +
                    "WHERE [SHP_num]='" + Request.Form["Hid_Num"].ToString() + "'", conn);
                sqlcommand.ExecuteNonQuery();
            }

            conn.Close();
        }
        else if (Request.Form["btn_Act"] == "刪除")//後台會員名單點選刪除
        {
            conn.Open();//Connected
            sqlcommand = new System.Data.SqlClient.SqlCommand("DELETE FROM [SecondHandProduct] WHERE [SHP_num]='" + Request.Form["Hid_Num"].ToString() + "'", conn);
            sqlcommand.ExecuteNonQuery();
            conn.Close();
            System.IO.File.Delete("C:/test/SecondHandProductImg/" + "P" + Request.Form["Hid_Num"].ToString() + ".jpg");
        }

        Response.Redirect("SecondHandProductmanage.aspx");
    %>
</body>
</html>
