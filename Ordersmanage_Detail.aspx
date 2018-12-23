<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Ordersmanage_Detail.aspx.cs" Inherits="Ordersmanage_Detail" %>

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
    <form id="form1" runat="server">
        <div class="container">
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">品名</th>
                    <th scope="col">數量</th>
                    <th scope="col">顏色</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<string> OrderList = new List<string>();
                    System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                    System.Data.SqlClient.SqlCommand sqlcommand = null;
                    System.Data.SqlClient.SqlDataReader dr = null;

                    string O_num = Request.QueryString["O_num"];
                    conn.Open();
                    sqlcommand = new System.Data.SqlClient.SqlCommand("select * from [Orders_Items] WHERE O_num='" + O_num + "'", conn);
                    dr = sqlcommand.ExecuteReader();
                    while (dr.Read()) //把所有購物車項目(每筆 編號/數量/樣式)拿出 並利用(每筆 編號/數量/樣式)參數 進行商品資訊查詢
                    {
                %>
                <tr>
                    <th scope="row"><%Response.Write(dr["OItems_num"].ToString()); %></th>
                    <td><%Response.Write(dr["P_name"].ToString()); %></td>
                    <td><%Response.Write(dr["Amount"].ToString()); %></td>
                    <td><%Response.Write(dr["P_style"].ToString()); %></td>
                </tr>
                <% 
                    }
                    dr.Close();
                    conn.Close();

                    conn.Open();
                    sqlcommand = new System.Data.SqlClient.SqlCommand("select * from [Orders] WHERE O_num='" + O_num + "'", conn);
                    dr = sqlcommand.ExecuteReader();
                    dr.Read();
                %>
                <tr>
                    <th scope="row"></th>
                    <td></td>
                    <td>總金額 : <%Response.Write(dr["Price"].ToString()); %> NTD</td>
                </tr>
            </tbody>
        </table>
    </div>

        <br /><br />
    <div class="container">
        <h2><strong>收件人資訊</strong></h2>
        <div class="col-sm">收貨人姓名: <%Response.Write(dr["O_Name"].ToString()); %></div>
        <div class="col-sm">收貨人電話: <%Response.Write(dr["O_Phone"].ToString()); %></div>
        <div class="col-sm">收貨人地址: <%Response.Write(dr["O_Address"].ToString()); %></asp:TextBox></div>
    </div>
    <center><input id="Button1" type="button" class="btn btn-outline-secondary" value="確定" onclick="history.back()" /></center>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    </form>
</body>
</html>
