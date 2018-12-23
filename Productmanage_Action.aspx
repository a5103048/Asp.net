<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Productmanage_Action.aspx.cs" Inherits="Productmanage_Action" %>

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
            string HasMultipleStyle = "";
            switch (Request.Form["Sele_HasMultipleStyle"].ToString())// 產生多款式選項
            {
                case "0":
                    HasMultipleStyle = "0";
                    break;
                case "1":
                    HasMultipleStyle = "1";
                    break;
            }
            HttpPostedFile file = Request.Files["File_Img"];

            conn.Open();//Connected
            sqlcommand = new System.Data.SqlClient.SqlCommand("SELECT MAX(P_num) FROM [Product]", conn);//查詢會員個數
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
                string SaveImg = "ProductImg/" + file.FileName;
                file.SaveAs(Server.MapPath(SaveImg));
                SaveImg = @"ProductImg\" + file.FileName;
                sqlcommand = new System.Data.SqlClient.SqlCommand("INSERT INTO [Product] VALUES('" + //把輸入會員的資料存入資料庫中
                    InsertID + "','" +
                    Request.Form["txt_Name"].ToString() + "','" +
                    Request.Form["txt_Price"].ToString() + "','" +
                    Request.Form["txt_Description"].ToString() + "','" +
                    Request.Form["txt_Dimension"].ToString() + "','" +
                    SaveImg + "','" +
                    HasMultipleStyle + "','" +
                    "1" + "'," +
                    Request.Form["Sele_Classify"].ToString() + ")", conn);
                sqlcommand.ExecuteNonQuery();
            }
            else
            {
                sqlcommand = new System.Data.SqlClient.SqlCommand("INSERT INTO [Product] VALUES('" + //把輸入會員的資料存入資料庫中
                    InsertID + "','" +
                    Request.Form["txt_Name"].ToString() + "','" +
                    Request.Form["txt_Price"].ToString() + "','" +
                    Request.Form["txt_Description"].ToString() + "','" +
                    Request.Form["txt_Dimension"].ToString() + "'," +
                    "NULL" + ",'" +
                    HasMultipleStyle + "','" +
                    "1" + "'," +
                    Request.Form["Sele_Classify"].ToString() + ")", conn);
                sqlcommand.ExecuteNonQuery();
            }

            conn.Close();
        }
        else if (Request.Form["btn_Act"] == "編輯")//後台商品名單點選編輯
        {
            string HasMultipleStyle = "";
            switch (Request.Form["Sele_HasMultipleStyle"].ToString())// 產生多款式選項
            {
                case "0":
                    HasMultipleStyle = "0";
                    break;
                case "1":
                    HasMultipleStyle = "1";
                    break;
            }
            HttpPostedFile file = Request.Files["File_Img"];

            conn.Open();
            if (file != null && file.ContentLength > 0)
            {
                string SaveImg = "ProductImg/" + file.FileName;
                file.SaveAs(Server.MapPath(SaveImg));
                SaveImg = @"ProductImg\" + file.FileName;
                sqlcommand = new System.Data.SqlClient.SqlCommand("UPDATE [Product] SET " + //進行該筆會員資料 的資料庫更新
                    "[P_Name]='" + Request.Form["txt_Name"].ToString() + "'," +
                    "[P_Price]='" + Request.Form["txt_Price"].ToString() + "'," +
                    "[P_Description]='" + Request.Form["txt_Description"].ToString() + "'," +
                    "[P_Dimension]='" + Request.Form["txt_Dimension"].ToString() + "'," +
                    "[P_Image]='" + SaveImg + "'," +
                    "[P_HasMultipleStyle]='" + HasMultipleStyle + "'," +
                    "[PClassify_num]='" + Request.Form["Sele_Classify"].ToString() + "' " +
                    "WHERE [P_num]='" + Request.Form["Hid_Num"].ToString() + "'", conn);
                sqlcommand.ExecuteNonQuery();
            }
            else
            {
                sqlcommand = new System.Data.SqlClient.SqlCommand("UPDATE [Product] SET " + //進行該筆會員資料 的資料庫更新
                    "[P_Name]='" + Request.Form["txt_Name"].ToString() + "'," +
                    "[P_Price]='" + Request.Form["txt_Price"].ToString() + "'," +
                    "[P_Description]='" + Request.Form["txt_Description"].ToString() + "'," +
                    "[P_Dimension]='" + Request.Form["txt_Dimension"].ToString() + "'," +
                    "[P_HasMultipleStyle]='" + HasMultipleStyle + "'," +
                    "[PClassify_num]='" + Request.Form["Sele_Classify"].ToString() + "' " +
                    "WHERE [P_num]='" + Request.Form["Hid_Num"].ToString() + "'", conn);
                sqlcommand.ExecuteNonQuery();
            }

            conn.Close();
        }
        else if (Request.Form["btn_Act"] == "刪除")//後台會員名單點選刪除
        {
            conn.Open();//Connected
            sqlcommand = new System.Data.SqlClient.SqlCommand("DELETE FROM [Product] WHERE [P_num]='" + Request.Form["Hid_Num"].ToString() + "'", conn);
            sqlcommand.ExecuteNonQuery();
            conn.Close();
        }

        Response.Redirect("Productmanage.aspx");
    %>
</body>
</html>
