using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AboutUs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            SqlCommand sqlcommand = null;
            SqlDataReader dr = null;

            conn.Open();
            sqlcommand = new SqlCommand("select * from [AboutUs]", conn); //查詢關於我們資訊
            dr = sqlcommand.ExecuteReader();
            dr.Read();
            lab_Tital.Text = dr["Tital"].ToString();
            lab_Contents.Text = dr["Contents"].ToString().Replace("\n", "<br/>");
            dr.Close();
            conn.Close();
        }
    }
}