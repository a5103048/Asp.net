using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyAccount_SHProductRequire : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
    SqlCommand sqlcommand;
    SqlDataReader dr = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Login"] == null) //是否有登入
            Response.Write("<script>alert('請先登入!');location.href='Signin.aspx?From=MyAccount_SHProductRequire'; </script>");
    }

    protected void btn_AccEdit_Click(object sender, EventArgs e)
    {
        conn.Open();
        sqlcommand = new SqlCommand("select M_Name,M_Tel from [Member] WHERE M_num='" + Session["Login"].ToString() + "'", conn);
        dr = sqlcommand.ExecuteReader();
        dr.Read();
        string Name = dr["M_Name"].ToString();
        string Phone = dr["M_Tel"].ToString();
        dr.Close();

        sqlcommand = new System.Data.SqlClient.SqlCommand("SELECT MAX(SHPR_num) FROM [SecondHandProductRequire]", conn);//查詢資料個數
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
        if (FileUpload_Img.HasFile)
        {
            string SaveImg = "SecondHandProductRequireImg/" + FileUpload_Img.FileName;
            FileUpload_Img.SaveAs(Server.MapPath(SaveImg));
            SaveImg = @"SecondHandProductRequireImg\" + FileUpload_Img.FileName;
            sqlcommand = new SqlCommand("INSERT INTO [SecondHandProductRequire] VALUES('" + //把輸入資料的資料存入資料庫中
                InsertID + "','" +
                txt_Name.Text + "','" +
                txt_Price.Text + "','" +
                txt_Info.Text + "','" +
                SaveImg + "','" +
                Name + "','" +
                Phone + "')", conn);
            sqlcommand.ExecuteNonQuery();
        }
        else
        {
            sqlcommand = new SqlCommand("INSERT INTO [SecondHandProductRequire] VALUES('" + //把輸入資料的資料存入資料庫中
                InsertID + "','" +
                txt_Name.Text + "','" +
                txt_Price.Text + "','" +
                txt_Info.Text + "'," +
                "NULL" + ",'" +
                Name + "','" +
                Phone + "')", conn);
            sqlcommand.ExecuteNonQuery();
        }

        conn.Close();

        Response.Write("<script>alert('已完成上架申請!');location.href='MyAccount_SHProductRequire.aspx'; </script>");
    }
}