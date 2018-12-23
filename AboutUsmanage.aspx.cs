using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AboutUsmanage : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
    SqlCommand sqlcommand = null;
    SqlDataReader dr = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            conn.Open();
            sqlcommand = new SqlCommand("select * from [AboutUs]", conn); //查詢所有會員資訊
            dr = sqlcommand.ExecuteReader();
            dr.Read();
            txt_Tital.Text = dr["Tital"].ToString();
            txt_Contents.Text = dr["Contents"].ToString();
            dr.Close();
            conn.Close();
        }
    }

    protected void btn_Edit_Click(object sender, EventArgs e)
    {
        conn.Open();
        sqlcommand = new SqlCommand("UPDATE [AboutUs] SET " + //進行關於我們的資料庫更新
                "[Tital]='" + txt_Tital.Text + "'," +
                "[Contents]='" + txt_Contents.Text + "'", conn);
        sqlcommand.ExecuteNonQuery();
        conn.Close();
    }
}