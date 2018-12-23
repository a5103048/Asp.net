<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductStylemanage_Action.aspx.cs" Inherits="ProductStylemanage_Action" %>

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

        if (Request.Form["btn_Act"] == "新增") //後台會員名單點選新增
        {
            /*string Grender = "";
            switch (Request.Form["Sele_Gender"])// 產生男女選項
            {
                case "1":
                    Grender = "男";
                    break;
                case "2":
                    Grender = "女";
                    break;
            }*/
            HttpPostedFile file = Request.Files["File_Img"];

            conn.Open();//Connected
            sqlcommand = new System.Data.SqlClient.SqlCommand("SELECT MAX(PStyle_num) FROM [ProductStyle] WHERE [P_num]=" + Request.Form["Sele_P_Name"].ToString(), conn);//查詢會員個數
            dr = sqlcommand.ExecuteReader();
            dr.Read();
            string InsertID = "";
            if (dr[0].ToString() == string.Empty) //當會員個數為0 則該筆會員的編號為1
                InsertID = 1.ToString();
            else
                InsertID = (Convert.ToInt32(dr[0]) + 1).ToString();//不為0 該筆會員編號為會員個數+1 
            dr.Close();
            conn.Close();

            conn.Open();
            if (file != null && file.ContentLength > 0)
            {
                string SaveImg = "ProductImg/" + file.FileName;
                file.SaveAs(Server.MapPath(SaveImg));
                SaveImg = @"ProductImg\" + file.FileName;
                sqlcommand = new System.Data.SqlClient.SqlCommand("INSERT INTO [ProductStyle] VALUES('" + //把輸入會員的資料存入資料庫中
                    Request.Form["Sele_P_Name"].ToString() + "','" +
                    InsertID + "','" +
                    Request.Form["txt_StyleName"].ToString() + "','" +
                    SaveImg + "')", conn);
                sqlcommand.ExecuteNonQuery();
            }
            else
            {
                sqlcommand = new System.Data.SqlClient.SqlCommand("INSERT INTO [ProductStyle] VALUES('" + //把輸入會員的資料存入資料庫中
                    Request.Form["Sele_P_Name"].ToString() + "','" +
                    InsertID + "','" +
                    Request.Form["txt_StyleName"].ToString() + "'," +
                    "NULL" + ")", conn);
                sqlcommand.ExecuteNonQuery();
            }

            conn.Close();
        }
        else if (Request.Form["btn_Act"] == "編輯")//後台會員名單點選編輯
        {
            /*string Grender = "";
            switch (Request.Form["Sele_Gender"])
            {
                case "1":
                    Grender = "男";
                    break;
                case "2":
                    Grender = "女";
                    break;
            }*/
            HttpPostedFile file = Request.Files["File_Img"];

            conn.Open();
            if (file != null && file.ContentLength > 0)
            {
                string SaveImg = "ProductImg/" + file.FileName;
                file.SaveAs(Server.MapPath(SaveImg));
                SaveImg = @"ProductImg\" + file.FileName;
                sqlcommand = new System.Data.SqlClient.SqlCommand("UPDATE [ProductStyle] SET " + //進行該筆會員資料 的資料庫更新
                    "[PStyle_Name]='" + Request.Form["txt_Name"].ToString() + "'," +
                    "[PStyle_Image]='" + SaveImg + "' " +
                    "WHERE [P_num]='" + Request.Form["Hid_Num"].ToString() + "' AND [PStyle_num]='" + Request.Form["Hid_Num2"].ToString() + "'", conn);
                sqlcommand.ExecuteNonQuery();
            }
            else
            {
                sqlcommand = new System.Data.SqlClient.SqlCommand("UPDATE [ProductStyle] SET " + //進行該筆會員資料 的資料庫更新
                    "[PStyle_Name]='" + Request.Form["txt_Name"].ToString() + "' " +
                    "WHERE [P_num]='" + Request.Form["Hid_Num"].ToString() + "' AND [PStyle_num]='" + Request.Form["Hid_Num2"].ToString() + "'", conn);
                sqlcommand.ExecuteNonQuery();
            }

            conn.Close();
        }
        else if (Request.Form["btn_Act"] == "刪除")//後台會員名單點選刪除
        {
            conn.Open();//Connected
            sqlcommand = new System.Data.SqlClient.SqlCommand("DELETE FROM [ProductStyle] WHERE [P_num]='" + Request.Form["Hid_Num"].ToString() + "' AND [PStyle_num]='" + Request.Form["Hid_Num2"].ToString() + "'", conn);
            sqlcommand.ExecuteNonQuery();
            conn.Close();
        }

        Response.Redirect("ProductStylemanage.aspx");
    %>
</body>
</html>
