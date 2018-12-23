using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class index : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);//連接資料庫字串
    SqlCommand sqlcommand = null;
    SqlDataReader dr = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn.Open();
        sqlcommand = new SqlCommand("select * from [News]", conn); //查詢所有會員資訊
        dr = sqlcommand.ExecuteReader();
        dr.Read();
        lab_Tital.Text = dr["Tital"].ToString();
        lab_Contents.Text = dr["Contents"].ToString();
        dr.Close();
        conn.Close();
    }

    protected void btn_Search_Click(object sender, EventArgs e)
    {
        Response.Redirect("Search.aspx?Keyword=" + txt_Search.Text, true);
    }
}