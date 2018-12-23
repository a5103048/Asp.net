using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BuyList : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
    SqlCommand sqlcommand;
    SqlDataReader dr = null;

    int totalPrice = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn.Open();
        sqlcommand = new SqlCommand("select sum(P_price*Amount) from [Cart] WHERE M_num='" + Session["Login"].ToString() + "'", conn);//取得該購物車總金額
        dr = sqlcommand.ExecuteReader();
        dr.Read();
        totalPrice = Convert.ToInt32(dr[0]);
        TotalPrice.Text = totalPrice.ToString();
        dr.Close();

        sqlcommand = new SqlCommand("select M_Name,M_Tel,M_Address from [Member] WHERE M_num='" + Session["Login"].ToString() + "'", conn);//取得會員姓名，電話及地址資訊
        dr = sqlcommand.ExecuteReader();
        dr.Read();
        txt_name.Text = dr["M_Name"].ToString();
        txt_phone.Text = dr["M_Tel"].ToString();
        txt_address.Text = dr["M_Address"].ToString();
        dr.Close();
        conn.Close();
    }
   




    protected void Button1_Click(object sender, EventArgs e)
    {
        conn.Open();
        sqlcommand = new SqlCommand("SELECT MAX(O_num) FROM [Orders]", conn);//取得訂單編號最大數
        dr = sqlcommand.ExecuteReader();
        dr.Read();
        string InsertID = "";
        if (dr[0].ToString() == string.Empty)
            InsertID = 1.ToString();
        else
            InsertID = (Convert.ToInt32(dr[0]) + 1).ToString();
        dr.Close();

        sqlcommand = new SqlCommand("INSERT INTO [Orders] VALUES('" +
                    InsertID + "','" +
                    Session["Login"].ToString() + "','" +
                    DateTime.Now.Date.ToString("yyyy/MM/dd") + "','" +
                    txt_name.Text + "','" +
                    txt_phone.Text + "','" +
                    txt_address.Text + "','" +
                    "準備中" + "','" +
                    totalPrice +
                    "')", conn);//建立訂單
        sqlcommand.ExecuteNonQuery();

        List<string> data = new List<string>();
        sqlcommand = new SqlCommand("select * from [Cart] WHERE M_num='" + Session["Login"].ToString() + "'", conn);//取得購物車項目
        dr = sqlcommand.ExecuteReader();
        while (dr.Read())//將購物車項目存取於List當中
            data.Add(dr["P_name"].ToString() + "," + dr["P_style"].ToString() + "," + dr["Amount"].ToString());
        dr.Close();

        int i = 1;
        foreach(var str in data)//將購物車項目，新增到該訂單底下
        {
            String[] str_array = str.Split(',');

            sqlcommand = new SqlCommand("INSERT INTO [Orders_Items] VALUES('" +
                    InsertID + "','" +
                    i.ToString() + "','" +
                    str_array[0] + "','" +
                    str_array[1] + "','" +
                    str_array[2]
                    + "')", conn);
            sqlcommand.ExecuteNonQuery();
            i++;
        }

        sqlcommand = new SqlCommand("delete from Cart where M_num='" + Session["Login"].ToString() + "'", conn);//刪除購物車項目
        sqlcommand.ExecuteNonQuery();

        conn.Close();
        Response.Write("<Script language='JavaScript'>alert('訂單已建立!!');location.href='http://140.137.61.163/';</Script>");//跳出訊息，返回至首頁
        //Response.Redirect("http://140.137.61.163/", true);
    }
}