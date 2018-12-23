using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        /*
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString); //連接資料庫字串
        SqlCommand sqlcommand;
        conn.Open();
        sqlcommand = new SqlCommand("INSERT INTO [Score] VALUES('" + //把輸入會員的資料存入資料庫中
                    Request.Form["message-text"].ToString() + "','" +
                    Request.Form["Select"].ToString() + "','" +
                    Session["Login"] + "','" +
                    Request.Form["ItemID"].ToString() + "')", conn);
        sqlcommand.ExecuteNonQuery();
        string url = Request.UrlReferrer.ToString();
        Response.Redirect(url);*/
        Label2.Text = Request.Form["Select"].ToString();
        Label1.Text = Request.Form["message-text"].ToString();
        Label3.Text = Session["Login"].ToString();
        Label4.Text = Request.Form["ItemID"].ToString();
    }
}