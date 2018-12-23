using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
public partial class Cart : System.Web.UI.Page
{
    private ArrayList tmpArrayList;
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
    SqlCommand sqlcommand;
    SqlDataReader dr = null;
    protected void Page_Load(object sender, EventArgs e)
    {
		if(Session["Login"] == null) //是否有登入
			Response.Write("<script>alert('請先登入!');location.href='Signin.aspx?From=Cart'; </script>");
        else if (Session["Cart"] == null) //購物車是否有加入過商品
        {
            conn.Open();
            sqlcommand = new SqlCommand("select M_num from [Cart] WHERE M_num='" + Session["Login"].ToString() + "'", conn);
            dr = sqlcommand.ExecuteReader();
            if (!dr.HasRows)
                Response.Write("<script>alert('購物車中尚無商品喔!');location.href='index.aspx'; </script>");
            dr.Close();
            conn.Close();
        }
        else if(Session["Cart"]!=null)
		{
			List<string> BuyList = new List<string>();
            List<string> CartList = new List<string>();
            CartList = Session["Cart"] as List<string>; //將Session資訊(目前存在的所有購物車項目)存在CartList中
			conn.Open();
			foreach (string str in CartList) //把所有購物車項目(每筆 編號/數量/樣式)拿出 並利用(每筆 編號/數量/樣式)參數 進行商品資訊查詢
            {
                string[] P_Info = str.Split(','); //把取出購物車項目(每筆 編號/數量/樣式)進行","分割 (itempage.asp.cs中 加入購物車參數時 利用","隔開個參數)   以便進行商品sql查詢

                //讀取購物項目(名稱/價錢/樣式(顏色))
                sqlcommand = new SqlCommand("select Product.P_Name,Product.P_Price,ProductStyle.PStyle_Name, Product.P_num from [Product],[ProductStyle] WHERE Product.P_num=" + P_Info[0] + " and ProductStyle.P_num=" + P_Info[0] + " and ProductStyle.PStyle_Name='" + P_Info[2] + "'", conn);
                dr = sqlcommand.ExecuteReader();
                if (dr.Read())
                {
                    //將購物車(商品編號/商品名/商品價格/商品個數/商品顏色)加入List(BuyList)中
                    BuyList.Add(dr["P_num"].ToString()+","+dr["P_Name"].ToString()+","+
                    dr["P_Price"].ToString()+","+P_Info[1].ToString()+
                    ","+dr["PStyle_Name"].ToString());
				}
				dr.Close();
			}
			conn.Close();
			
			BuyList = CheckList(BuyList);
			int i = 0; //計算比數變數
			conn.Open();
			foreach (string str in BuyList) //把所有購物車項目(每筆 編號/數量/樣式)拿出 並利用(每筆 編號/數量/樣式)參數 進行商品資訊查詢
			{
				string[] P_Info = str.Split(','); //把取出購物車項目(每筆 編號/數量/樣式)進行","分割 (itempage.asp.cs中 加入購物車參數時 利用","隔開個參數)   以便進行商品sql查詢

				sqlcommand = new SqlCommand("INSERT INTO [Cart] VALUES('" +
						Session["Login"].ToString() + "','" +
						 P_Info[0].ToString() + "','" +
						 P_Info[1].ToString() + "','" +
						 Convert.ToInt32(P_Info[2]) + "','" +
						 Convert.ToInt32(P_Info[3]) + "','" +
						 P_Info[4].ToString()
						 + "')", conn);
				sqlcommand.ExecuteNonQuery();
				i++;

			}
			conn.Close();
			Session.Remove("Cart");//移除session的購物車
			Session.Remove("Buy");//移除session購物車項目細節
		}
    }
    public List<string> CheckList(List<string> BuyList) 
  //要Insert前 檢查相同購物車品項  有相同則存進SameList(之後刪除原有db資料 再重新寫進) BuyList則更新數量
    {
        List<string> SameList = new List<string>();
        conn.Open();
        sqlcommand = new SqlCommand("SELECT * FROM [Cart] where M_num='" + Session["Login"].ToString() + "'", conn);//取得該會員的購物車項目
        dr = sqlcommand.ExecuteReader();
        while (dr.Read())
        {
            for (int j=0;j<BuyList.Count;j++) //把所有購物車項目(每筆 編號/數量/樣式)拿出 並利用(每筆 編號/數量/樣式)參數 進行商品資訊查詢
            {
                string[] P_Info = BuyList[j].Split(','); //把取出購物車項目(每筆 編號/數量/樣式)進行","分割 (itempage.asp.cs中 加入購物車參數時 利用","隔開個參數)   以便進行商品sql查詢

                if (dr["M_num"].ToString()== Session["Login"].ToString() && dr["C_num"].ToString() == P_Info[0] && dr["P_style"].ToString() == P_Info[4])//若購物車已存在相同商品，則將session的商品併入
                {
                    
                    int dbamount = int.Parse(dr["Amount"].ToString());
                    int listmount = int.Parse(P_Info[3]);
                    listmount += dbamount;
                    SameList.Add(BuyList[j]);
                    BuyList[j] = (P_Info[0] + "," + P_Info[1] + "," + P_Info[2]  + "," + listmount + "," + P_Info[4]);
                   
                }
                
            }
                
        }
        conn.Close();
        foreach (string str in SameList) //把所有購物車項目(每筆 編號/數量/樣式)拿出 並利用(每筆 編號/數量/樣式)參數 進行商品資訊查詢
        {
            string[] P_Info = str.Split(',');
            conn.Open();
            sqlcommand = new SqlCommand("DELETE FROM Cart Where M_num=" + Session["Login"].ToString() + " AND C_num="+P_Info[0] + " AND P_style='" + P_Info[4] + "'", conn);//刪除購物車項目，以利後續填入全新購物車項目
            sqlcommand.ExecuteNonQuery();
            conn.Close();
        }
        
        return BuyList;//回傳整理後的購物車
    }
   
 
    protected void Button1_Click(object sender, EventArgs e)
    {
        //  Response.Redirect("~/Payment.aspx?transfer=Y");

        
        Response.Redirect("~/BuyList.aspx");//前往商品確認頁面
    }

   
   

    protected void Delete_Click(object sender, ImageClickEventArgs e)
    {
        string Mnum = Request.Form["Hid_MNum"].ToString();
        string Cnum = Request.Form["Hid_CNum"].ToString();
        string style = Request.Form["Hid_Style"].ToString();

        conn.Open();//Connected
        sqlcommand = new System.Data.SqlClient.SqlCommand("DELETE FROM [Cart] WHERE [M_num]=" + Mnum + " AND [C_num]=" + Cnum + " AND [P_style]='" + style + "'", conn);
        sqlcommand.ExecuteNonQuery();
        conn.Close();

        Response.Redirect("Cart.aspx");
    }
}