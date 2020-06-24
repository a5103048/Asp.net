<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BuyList.aspx.cs" Inherits="BuyList" %>


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

   

</head>
<body>
    <form id="form1" runat="server"  style="background-image:url(ProductImg/結帳頁面.jpg);background-repeat:no-repeat;background-size:cover">
    <div class="container">
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">品名1</th>
                    <th scope="col">數量</th>
                    <th scope="col">價格</th>
                    <th scope="col">顏色</th>

                   
                </tr>
            </thead>
            <tbody>
                <%
                    int count_A = 0;//用以紀錄訂單項目數量
                    List<string> OrderList = new List<string>();
                    if(Session["Login"] == null) //是否有登入
                        Response.Write("<script>alert('請先登入!');location.href='http://140.137.61.163'; </script>");
                    else
                    {
                        //Response.Write("<script>alert('購物車中尚無商品喔!');location.href='http://140.137.61.163'; </script>");

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
                            count_A += int.Parse(dr["Amount"].ToString());//紀錄訂單項目數量
                %>
                <tr>
                    <th scope="row"><%Response.Write(i); %></th>
                    <td><%Response.Write(dr["P_name"].ToString()); %></td>
                    <td><%Response.Write(dr["Amount"].ToString()); %></td>
                    <td><%Response.Write(dr["P_price"].ToString() + " NTD"); %></td>
                    <td><%Response.Write(dr["P_style"].ToString()); %></td>

                   
                </tr>
                <% 
                        }
                        dr.Close();
                        conn.Close();
                    }

                %>
                <tr>
                    <th scope="row"></th>
                    <td></td>
                    <td><%Response.Write("總數量 "+count_A); %></td>
                    <td>總金額 : <asp:Label ID="TotalPrice" runat="server" Text="123"></asp:Label> NTD</td>
                   <td><asp:Button ID="Button1" class="btn btn-outline-primary" runat="server" Text="送出訂單" OnClick="Button1_Click" /></td>
                </tr>
            </tbody>
        </table>
    </div>

        <br /><br />
    <div class="container">
        <h2><strong>收件人資訊</strong></h2>
        <div class="col-sm">收貨人姓名: <asp:TextBox ID="txt_name" class="form-control" runat="server"></asp:TextBox></div><br />
        <div class="col-sm">收貨人電話: <asp:TextBox ID="txt_phone" class="form-control" runat="server"></asp:TextBox></div><br />
        <div class="col-sm">收貨人地址: <asp:TextBox ID="txt_address"  class="form-control" runat="server"></asp:TextBox></div>
    </div>
        <br /><br />
    <div class="container">
        <h2><strong>匯款資訊</strong></h2>
        <div class="col-sm">請付款至: 富邦銀行 013 永和分行 687168363414</div>
        <div class="col-sm"><b><font color="red">請在五天內匯款</font></b></div>
        <div class="col-sm">否則訂單將不予成立!</div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    </form>
</body>
</html>
