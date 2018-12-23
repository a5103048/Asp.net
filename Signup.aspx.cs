using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
public partial class Signup : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
    SqlCommand sqlcommand;
    SqlDataReader dr = null;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        
        if (M_Tel.Text == string.Empty || M_Account.Text == string.Empty || M_Address.Text == string.Empty || M_Name.Text == string.Empty || M_Address.Text == string.Empty || M_Password.Text == string.Empty)
            Response.Write("<Script language='JavaScript'>alert('以下所有欄位皆須確實填寫，不可留下空格!!');</Script>");
       
        else
        {
           
            conn.Open();
            sqlcommand = new SqlCommand("SELECT * FROM [Member] WHERE [M_Account]='" + M_Account.Text + "'", conn); 
            dr = sqlcommand.ExecuteReader();
            if (dr.Read() == true)  
            {
                Response.Write("<Script language='JavaScript'>alert('此帳號已存在請重新輸入!');</Script>");
                M_Account.Text = "";
                M_Password.Text = "";
            
                dr.Close();
                conn.Close();
            }
            else
            {
                dr.Close();
                conn.Close();

                conn.Open();
                sqlcommand = new SqlCommand("SELECT MAX(M_num) FROM [Member]", conn);
                dr = sqlcommand.ExecuteReader();
                dr.Read();
                string InsertID = "";
                if (dr[0].ToString() == string.Empty)
                    InsertID = 1.ToString();
                else
                    InsertID = (Convert.ToInt32(dr[0]) + 1).ToString();
                dr.Close();
                conn.Close();

                conn.Open();
                sqlcommand = new SqlCommand("INSERT INTO [Member]([M_num],[M_Name],[M_Account],[M_Password],[M_Tel],[M_Gender],[M_Address]) VALUES('" +
                    InsertID + "','" +
                    M_Name.Text + "','" +
                    M_Account.Text + "','" +
                    M_Password.Text + "','" +
                    M_Tel.Text + "','" +
                    GenderList.SelectedValue + "','"+
                    M_Address.Text
                    + "')", conn);
                sqlcommand.ExecuteNonQuery();
                conn.Close();
                Response.Write("<Script language='JavaScript'>alert('註冊完成!');location.href='http://140.137.61.163/';</Script>");
                //Response.Redirect("http://140.137.61.163/", true);
            }
        }
    }
}