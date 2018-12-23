using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
public partial class Adminlogin : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
    SqlCommand sqlcommand;
    SqlDataReader dr = null;
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Signin_Click(object sender, EventArgs e)
    {

       
        try
        {
            conn.Open();
            SqlCommand sqlcommand = new SqlCommand("select * from [AdminAccount] where Ad_Acc='" + Account.Text + "' AND Ad_Pw='" + Password.Text + "'", conn);
            dr = sqlcommand.ExecuteReader();
            String username = "";
            if (dr.Read() == true)
            {

                username = dr["Ad_Acc"].ToString();
                Session.Add("Ad_Login", "Y");
                Response.Write("<script>alert('登入成功!');location.href='Accountmanage.aspx'; </script>");
                /*Response.Write(@"<div class='alert alert - success'>
  < strong > Success!</ strong > You should < a href = '#' class='alert-link'>read this message</a>.
        </div>");*/

                //Response.Redirect("Accountmanage.aspx", true);
            }
            //else Response.Write("<script>alert('帳號或密碼錯誤!'); </script>");


            if (username != string.Empty)
            {
                /* Lab_ErrorMess.Visible = false;*/

                Session.Add("Ad_Name", username);
                Session.Add("Ad_Login", "Y");
                Response.Redirect("Accountmanage.aspx", true);
            }
            else
            {
                Response.Redirect(Request.FilePath);
                /* Lab_ErrorMess.Visible = true;*/

            }
        }
        catch (Exception ee)
        {
            Response.Write(ee.Message);
        }
    }
}
