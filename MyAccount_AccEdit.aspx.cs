using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyAccount_Edit : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
    SqlCommand sqlcommand;
    SqlDataReader dr = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Login"] == null) //是否有登入
            Response.Write("<script>alert('請先登入!');location.href='Signin.aspx?From=MyAccount_AccEdit'; </script>");
        else
        {
            if (!IsPostBack)
            {
                conn.Open();
                sqlcommand = new SqlCommand("select * from [Member] WHERE M_num='" + Session["Login"].ToString() + "'", conn);
                dr = sqlcommand.ExecuteReader();
                dr.Read();

                //將會員資料顯示
                M_Account.Text = dr["M_Account"].ToString();
                M_Password.Text = dr["M_Password"].ToString();
                M_Name.Text = dr["M_Name"].ToString();
                M_Address.Text = dr["M_Address"].ToString();
                M_Tel.Text = dr["M_Tel"].ToString();
                switch (dr["M_Gender"].ToString())
                {
                    case "男":
                        GenderList.SelectedIndex = 0;
                        break;
                    case "女":
                        GenderList.SelectedIndex = 1;
                        break;
                }
                dr.Close();
                conn.Close();
            }
        }
    }

    protected void btn_AccEdit_Click(object sender, EventArgs e)
    {
        string Grender = "";
        switch (GenderList.SelectedIndex)
        {
            case 0:
                Grender = "男";
                break;
            case 1:
                Grender = "女";
                break;
        }

        conn.Open();
        sqlcommand = new SqlCommand("UPDATE [Member] SET " + //進行該筆會員資料 的資料庫更新
            "[M_Password]='" + M_Password.Text + "'," +
            "[M_Name]='" + M_Name.Text + "'," +
            "[M_Address]='" + M_Address.Text + "'," +
            "[M_Tel]='" + M_Tel.Text + "'," +
            "[M_Gender]='" + Grender + "' " +
            "WHERE [M_num]='" + Session["Login"].ToString() + "'", conn);
        sqlcommand.ExecuteNonQuery();
        conn.Close();

        Response.Write("<script>alert('會員資料已更新!');location.href='MyAccount_AccEdit.aspx'; </script>");
    }
}