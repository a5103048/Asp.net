using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

public partial class Accountmanage : System.Web.UI.Page
{
    StringBuilder table = new StringBuilder();

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            SqlCommand sqlcommand = null;
            SqlDataReader dr = null;
            try
            {
                conn.Open();
                sqlcommand = new SqlCommand("select * from [Member]", conn);
                dr = sqlcommand.ExecuteReader();
                if (dr.Read() == true)
                {
                   


                    conn.Close();
                }


                conn.Close();





            }
            catch (Exception ee)
            {
                Response.Write(ee.Message); 
            }
        }

    }
}