using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Itempage : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString); //連接資料庫字串
    SqlCommand sqlcommand;
    SqlDataReader dr = null;
    List<string> id = new List<string>();

    ArrayList PStyleImg_Array = new ArrayList();
    string ItemID = "";
    private ArrayList tmpArrayList;

    public List<string> Cart { get; private set; }
   

    protected void Page_Load(object sender, EventArgs e)
    {
        ItemID = Request.QueryString["Identity"]; //讀取在首頁所點選商品編號
           if (Request.Form["submit"] == "留言")
            {
              if (Session["Login"]==null)
            {
                Response.Redirect("Signin.aspx");
            }
              conn.Open();
              sqlcommand = new SqlCommand("INSERT INTO [Score] VALUES('" + //把輸入留言/會員資料的資料存入資料庫中
                          Request.Form["message-text"].ToString() + "','" +
                          Request.Form["Select"].ToString() + "','" +
                          Session["Login"] + "','" +
                          ItemID + "')", conn);
              sqlcommand.ExecuteNonQuery();

            conn.Close();
            string url = Request.UrlReferrer.ToString();
            Response.Redirect(url);
        }
        conn.Open();
        sqlcommand = new SqlCommand("SELECT * FROM [Product] WHERE [P_num]='" + ItemID + "'", conn); //利用讀取編號查詢該商品詳細資料
        dr = sqlcommand.ExecuteReader();
        dr.Read();

        if (dr.HasRows)//當有成功讀取商品 則將商品(名稱/價錢/敘述/尺寸/編號/圖片) 放入相映LABLE中
        {
            
            lab_Name.Text = dr["P_Name"].ToString();
            lab_Price.Text = dr["P_Price"].ToString();
            lab_Feat.Text = dr["P_Description"].ToString();
            lab_Size.Text = dr["P_Dimension"].ToString();
            lab_ID.Text = dr["P_num"].ToString();
            P_Img.ImageUrl = dr["P_Image"].ToString();
            bool HasMultipleStyle = Convert.ToBoolean(dr["P_HasMultipleStyle"]);
            dr.Close();

            if (HasMultipleStyle) //利用前面讀取該商品資料庫欄位 [P_HasMultipleStyle] 判斷此商品是否存在多樣式 
            {
                //當存在多樣式時 進行該筆商品樣式資料查詢
                sqlcommand = new SqlCommand("SELECT [PStyle_Name],[PStyle_Image] FROM [ProductStyle] WHERE [P_num]='" + ItemID + "'", conn);
                //sqlcommand = new SqlCommand("SELECT [PStyle_Name],[PStyle_Image] FROM [ProductStyle] WHERE [P_num]='1'", conn);
                dr = sqlcommand.ExecuteReader();
                while (dr.Read())
                {
                    if (!Page.IsPostBack)
                        S_Style.Items.Add(dr["PStyle_Name"].ToString());
                    PStyleImg_Array.Add(dr["PStyle_Image"].ToString());
                }
            }
            else
                S_Style.Visible = false;
            dr.Close();
            conn.Close();
            //---------------------------------------------qu/-------------------------------------------------------//
          
        }
        else
            Response.Write("<script>alert('未選擇商品!');location.href='http://140.137.61.163'; </script>"); //當在首頁 未選擇商品 
    }

    protected void S_Style_SelectedIndexChanged(object sender, EventArgs e)
    {
        P_Img.ImageUrl = PStyleImg_Array[S_Style.SelectedIndex].ToString();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Session["Login"] == null) //是否有登入
            SaveToSession();//未登入，購物車以session形式儲存
        else
            SaveToDB();//已登入，購物車以資料庫形式儲存

        String url = Request.Path + "?Identity=" + ItemID; //導向回此次點選商品頁面
        Response.Write("<script>alert('已加入購物車!');location.href='" + url + "'; </script>");
    }
   
    protected void Button2_Click(object sender, EventArgs e)
    {
       

        if (Session["Login"] == null) //是否有登入
            Response.Write("<script>alert('請先登入!');location.href='Signin.aspx'; </script>");
        //SaveToSession();//未登入，購物車以session形式儲存
        else
        {
            SaveToDB();//已登入，購物車以資料庫形式儲存
            Response.Write("<script>location.href='Cart.aspx'; </script>");//導向購物車頁面
        }        
    }

    private void SaveToSession()
    {
        if (Session["Cart"] == null) //判斷是否曾經點選過購物車
        {
            if(S_Style.Visible)
                id.Add(lab_ID.Text + "," + (string)S_Amount.SelectedValue + "," + (string)S_Style.SelectedValue + "," + lab_Name.Text);//將點選購物車品項(編號/數量/樣式)加入List中 並利用","隔開不同項目
            else
                id.Add(lab_ID.Text + "," + (string)S_Amount.SelectedValue + "," + "0" + "," + lab_Name.Text);//將點選購物車品項(編號/數量/樣式)加入List中 並利用","隔開不同項目

        }
        else //購物車已經存在商品情況下
        {
            List<string> CartList = Session["Cart"] as List<string>; //將之前點選購物車品項(編號/數量/樣式) 存放在List中
            //string S_Amount_SelectedValue = S_Amount.SelectedValue.ToString();
            int Amount = int.Parse(S_Amount.SelectedValue);
            if (S_Style.Visible)
                id = CheckList(CartList, lab_ID.Text, Amount, (string)S_Style.SelectedValue, lab_Name.Text);
            else
                id = CheckList(CartList, lab_ID.Text, Amount, "0", lab_Name.Text);
        }
        Session["Cart"] = id; //把整個List中購物車品項(編號/數量/樣式) 存入Session[Cart]中 以利於下次的新增
    }

    private void SaveToDB()
    {
        List<string> BuyList = new List<string>();

        if (Session["Cart"] != null)
        {
            List<string> CartList = new List<string>();
            CartList = Session["Cart"] as List<string>; //將Session資訊(目前存在的所有購物車項目)存在CartList中
            conn.Open();
            foreach (string str in CartList) //把所有購物車項目(每筆 編號/數量/樣式)拿出 並利用(每筆 編號/數量/樣式)參數 進行商品資訊查詢
            {
                string[] P_Info = str.Split(','); //把取出購物車項目(每筆 編號/數量/樣式)進行","分割 (itempage.asp.cs中 加入購物車參數時 利用","隔開個參數)   以便進行商品sql查詢

                //讀取購物項目(名稱/價錢/樣式(顏色))
                if (P_Info[2] != "0")
                {
                    sqlcommand = new SqlCommand("select Product.P_Name,Product.P_Price,ProductStyle.PStyle_Name, Product.P_num from [Product],[ProductStyle] WHERE Product.P_num=" + P_Info[0] + " and ProductStyle.P_num=" + P_Info[0] + " and ProductStyle.PStyle_Name='" + P_Info[2] + "'", conn);
                    dr = sqlcommand.ExecuteReader();
                    if (dr.Read())
                    {
                        //將購物車(商品編號/商品名/商品價格/商品個數/商品顏色)加入List(BuyList)中
                        BuyList.Add(dr["P_num"].ToString() + "," + dr["P_Name"].ToString() + "," +
                        dr["P_Price"].ToString() + "," + P_Info[1].ToString() +
                        "," + dr["PStyle_Name"].ToString());
                    }
                }
                else
                {
                    sqlcommand = new SqlCommand("select Product.P_Name,Product.P_Price,Product.P_num from [Product] WHERE Product.P_num=" + P_Info[0] + "'", conn);
                    dr = sqlcommand.ExecuteReader();
                    if (dr.Read())
                    {
                        //將購物車(商品編號/商品名/商品價格/商品個數/商品顏色)加入List(BuyList)中
                        BuyList.Add(dr["P_num"].ToString() + "," + dr["P_Name"].ToString() + "," +
                        dr["P_Price"].ToString() + "," + P_Info[1].ToString() +
                        "," + "0");
                    }
                }

                dr.Close();
            }
            conn.Close();
        }
        else
        {
            conn.Open();
            //讀取購物項目(名稱/價錢/樣式(顏色))
            if (S_Style.Visible)
            {
                sqlcommand = new SqlCommand("select Product.P_Name,Product.P_Price,ProductStyle.PStyle_Name,Product.P_num from [Product],[ProductStyle] WHERE Product.P_num=" + lab_ID.Text + " and ProductStyle.P_num=" + lab_ID.Text + " and ProductStyle.PStyle_Name='" + (string)S_Style.SelectedValue + "'", conn);
                dr = sqlcommand.ExecuteReader();
                if (dr.Read())
                {
                    //將購物車(商品編號/商品名/商品價格/商品個數/商品顏色)加入List(BuyList)中
                    BuyList.Add(dr["P_num"].ToString() + "," + dr["P_Name"].ToString() + "," +
                    dr["P_Price"].ToString() + "," + S_Amount.SelectedValue +
                    "," + dr["PStyle_Name"].ToString());
                }
            }
            else
            {
                sqlcommand = new SqlCommand("select Product.P_Name,Product.P_Price,Product.P_num from [Product] WHERE Product.P_num=" + lab_ID.Text, conn);
                dr = sqlcommand.ExecuteReader();
                if (dr.Read())
                {
                    //將購物車(商品編號/商品名/商品價格/商品個數/商品顏色)加入List(BuyList)中
                    BuyList.Add(dr["P_num"].ToString() + "," + dr["P_Name"].ToString() + "," +
                    dr["P_Price"].ToString() + "," + S_Amount.SelectedValue +
                    "," + "0");
                }
            }
            
            dr.Close();
            conn.Close();
        }

        BuyList = CheckList(BuyList);
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
        }
        conn.Close();
        Session.Remove("Cart");//移除session的購物車
        Session.Remove("Buy");//移除session購物車項目細節
    }

    public List<string> CheckList(List<string> CartList, string Id, int Amount, string Style,string Name) //相同品項合併(Session)
    {
        for (int i = 0; i < CartList.Count; i++) ///讀取List中 所有購物車品項(編號/數量/樣式/名稱)
        {
            if (CartList[i].Split(',')[0] == Id & CartList[i].Split(',')[2] == Style)
            {
                int O_Amount = int.Parse((CartList[i].Split(',')[1].ToString()));
                O_Amount += Amount;
                CartList[i] = Id + "," + O_Amount.ToString() + "," + Style + "," + Name;

                return CartList;
            }
        }
        CartList.Add(Id + "," + Amount + "," + Style + "," + Name); //將原有的購物車品項(編號/數量/樣式/名稱)與新增購物車品項(編號/數量/樣式/名稱)合併
        return CartList;

    }

    public List<string> CheckList(List<string> BuyList)//相同品項合併(DB)，要Insert前 檢查相同購物車品項  有相同則存進SameList(之後刪除原有db資料 再重新寫進) BuyList則更新數量
    {
        List<string> SameList = new List<string>();
        conn.Open();
        sqlcommand = new SqlCommand("SELECT * FROM [Cart] where M_num='" + Session["Login"].ToString() + "'", conn);//取得該會員的購物車項目
        dr = sqlcommand.ExecuteReader();
        while (dr.Read())
        {
            for (int j = 0; j < BuyList.Count; j++) //把所有購物車項目(每筆 編號/數量/樣式)拿出 並利用(每筆 編號/數量/樣式)參數 進行商品資訊查詢
            {
                string[] P_Info = BuyList[j].Split(','); //把取出購物車項目(每筆 編號/數量/樣式)進行","分割 (itempage.asp.cs中 加入購物車參數時 利用","隔開個參數)   以便進行商品sql查詢

                if (dr["M_num"].ToString() == Session["Login"].ToString() && dr["C_num"].ToString() == P_Info[0] && dr["P_style"].ToString() == P_Info[4])//若購物車已存在相同商品，則將session的商品併入
                {

                    int dbamount = int.Parse(dr["Amount"].ToString());
                    int listmount = int.Parse(P_Info[3]);
                    listmount += dbamount;
                    BuyList[j] = (P_Info[0] + "," + P_Info[1] + "," + P_Info[2] + "," + listmount + "," + P_Info[4]);
                }
                SameList.Add(BuyList[j]);
            }

        }
        conn.Close();
        foreach (string str in SameList) //把所有購物車項目(每筆 編號/數量/樣式)拿出 並利用(每筆 編號/數量/樣式)參數 進行商品資訊查詢
        {
            string[] P_Info = str.Split(',');
            conn.Open();
            sqlcommand = new SqlCommand("DELETE FROM Cart Where M_num=" + Session["Login"].ToString() + " AND C_num=" + P_Info[0] + " AND P_style='" + P_Info[4] + "'", conn);//刪除購物車項目，以利後續填入全新購物車項目
            sqlcommand.ExecuteNonQuery();
            conn.Close();
        }

        return BuyList;//回傳整理後的購物車
    }

 
}

