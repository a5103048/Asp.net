<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cart.aspx.cs" Inherits="Cart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<script>
function getrmitem(obj){
var tr=$(obj).parent().parent();
var title = tr.children("td#title").text();
var body = tr.children("td#body").text()
alert("title:"+title+",body:"+body);
};
</script>

</head>
<body  style="background-image:url(ProductImg/onlineshopping.jpg);background-repeat:no-repeat;background-position:center top;background-size:cover">
    <form id="form1" runat="server">
    <div class="container">
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">品1名</th>
                    <th scope="col">價格</th>
                    <th scope="col">顏色</th>
                    <th scope="col">數量</th>
                </tr>
            </thead>
            <tbody>
                <%
					/*System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                    System.Data.SqlClient.SqlCommand sqlcommand = null;
                    System.Data.SqlClient.SqlDataReader dr = null;
                    List<string> BuyList = new List<string>();
                    List<string> CartList = new List<string>();
                    CartList = Session["Cart"] as List<string>; //將Session資訊(目前存在的所有購物車項目)存在CartList中

                    int i = 1; //計算比數變數
                    conn.Open();
                    foreach (string str in CartList) //把所有購物車項目(每筆 編號/數量/樣式)拿出 並利用(每筆 編號/數量/樣式)參數 進行商品資訊查詢
                    {
                        string[] P_Info = str.Split(','); //把取出購物車項目(每筆 編號/數量/樣式)進行","分割 (itempage.asp.cs中 加入購物車參數時 利用","隔開個參數)   以便進行商品sql查詢

                        //讀取購物項目(名稱/價錢/樣式(顏色))
                        sqlcommand = new System.Data.SqlClient.SqlCommand("select Product.P_Name,Product.P_Price,ProductStyle.PStyle_Name, Product.P_num from [Product],[ProductStyle] WHERE Product.P_num=" + P_Info[0] + " and ProductStyle.P_num=" + P_Info[0] + " and ProductStyle.PStyle_Name='" + P_Info[2] + "'", conn);
                        dr = sqlcommand.ExecuteReader();
                        if (dr.Read())
                        {
                            //將購物車(商品編號/商品名/商品價格/商品個數/商品顏色)加入List(BuyList)中
                            BuyList.Add(dr["P_num"].ToString()+","+dr["P_Name"].ToString()+","+
                            dr["P_Price"].ToString()+","+P_Info[1].ToString()+
                            ","+dr["PStyle_Name"].ToString());*/
					
					if(Session["Login"] == null) //是否有登入
						Response.Write("<script>alert('請先登入!');location.href='Signin.aspx?From=Cart'; </script>");
					else{
						System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
						System.Data.SqlClient.SqlCommand sqlcommand = null;
						System.Data.SqlClient.SqlDataReader dr = null;

						int i = 0;
						conn.Open();
						sqlcommand = new System.Data.SqlClient.SqlCommand("select * from [Cart] WHERE M_num='" + Session["Login"].ToString() + "'", conn);
						dr = sqlcommand.ExecuteReader();
						while (dr.Read()) //把所有購物車項目(每筆 編號/數量/樣式)拿出 並利用(每筆 編號/數量/樣式)參數 進行商品資訊查詢
						{
							i++;
                %>
                    <tr>
                        <th scope="row"><%Response.Write(i.ToString()); %></th>
                        <td><%Response.Write(dr["P_name"].ToString()); %></td>
                        <td><%Response.Write(dr["P_price"].ToString() + " NTD"); %></td>
                        <td><%if (dr["P_style"].ToString() == "0") { Response.Write("#"); } else { Response.Write(dr["P_style"].ToString()); }%></td>
                        <td><%Response.Write(dr["Amount"].ToString()); %></td>
                        <td><!--放置刪除按鈕-->
                            <form method="post" action="Cart.aspx">
                                <input name="Hid_MNum" style="display:none" value="<%Response.Write(Session["Login"].ToString()); %>" />
                                <input name="Hid_CNum" style="display:none" value="<%Response.Write(dr["C_num"].ToString()); %>" />
                                <input name="Hid_Style" style="display:none" value="<%Response.Write(dr["P_style"].ToString()); %>" />
                                <asp:ImageButton ID="Delete" runat="server" Text="移除!"  src="Deleteicon.png" OnClick="Delete_Click"/>
                            </form>
                            
                        </td>
                    </tr>
                
                <%
							/*}
							i++;
							dr.Close();
						}
						Session["Buy"] = BuyList;
						conn.Close();*/
						}
							dr.Close();
							conn.Close();
                    }
                %>
                
                <!--進行購物車刪除作業，待完成↓↓-->
                <script>
                    
                </script>
                 <tr>
                    <th scope="row"></th>
                    <td></td>
                    <td></td>
                    <td></td>
                   <td><asp:Button ID="Button2" runat="server" Text="結帳去!" OnClick="Button1_Click" CssClass="btn btn-outline-secondary" /></td>
                </tr>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    </form>
</body>
</html>
