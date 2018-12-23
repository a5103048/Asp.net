using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Threading;


public partial class Signin : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
    SqlCommand sqlcommand;
    SqlDataReader dr = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["Login"] = null;
            //Response.Write("帳號或密碼不可為空!");
        //if ((Session["Login"]) != null)
        //    Response.Redirect("http://140.137.61.163", true);
    }


    protected void Signin_Click(object sender, EventArgs e)
    {
      if(Account.Text=="" || Password.Text=="")
        {
            Response.Write("<script>alert('錯誤\\n帳號或密碼不為空白');location.href='Signin.aspx'; </script>");
            //Session.Clear();
            Session["Login"] = null;
            //Response.Redirect("~/Signin.aspx"); //導向登入頁面
        }
        try
        {
            conn.Open();
            sqlcommand = new SqlCommand("select M_num from [Member] where M_Account='" + Account.Text + "' AND M_Password='" + Password.Text + "'", conn);
            dr = sqlcommand.ExecuteReader(); 
            if (dr.Read() == true) 
            {
				string BackPage = Request.QueryString["From"];
                Session["Login"] = dr[0];
				if(BackPage!=null)
                    Response.Write("<script>alert('登入成功!');location.href='"+ BackPage+".aspx'; </script>");
                else
                    Response.Write("<script>alert('登入成功!');location.href='http://140.137.61.163'; </script>");
                
            }
            else
            {
                Response.Write("<script>alert('錯誤\\n帳號或密碼錯誤');location.href='Signin.aspx'; </script>");
                Session["Login"] = null;
                //Session.Clear();

            }
        }
        catch (Exception ee)
        {
            Response.Write(ee.Message); 
        }
    }
}