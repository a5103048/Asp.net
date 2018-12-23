<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyAccount_Orders_Detail.aspx.cs" Inherits="MyAccount_Orders_Detail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
    <link href="./MainPage/default.css" rel="stylesheet" type="text/css" media="all" />
    <link href="./MainPage/fonts.css" rel="stylesheet" type="text/css" media="all" />

    <!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/c ss" /><![endif]-->
</head>
<body>
    <div id="header" class="container">
	    <div id="logo">
		    <h2><a href="index.aspx">YASIN FURNITURE</a></h2>
	    </div>
	    <div id="menu">
		    <ul>
                <%
                    if( Session["Login"]==null) //利用session判斷是否有登錄過 登錄過顯示登入 否則顯示登出
                    {
                %>
                <li class="active"><a href="Signin.aspx?From=index" accesskey="1" title="">登入</a></li>
                <li><a href="Signup.aspx" accesskey="2" title="">註冊</a></li>
                <%
                    }
                    else
                    {
                %>
                <li class="active"><a href="Logout.aspx" accesskey="1" title="">登出</a></li>
                <%
                    }
                %>

			    <li><a href="AboutUs.aspx" accesskey="3" title="">關於我們</a></li>
			    <li><a href="ContactUs.aspx" accesskey="4" title="">聯絡我們</a></li>
                <li><a href="Cart.aspx" accesskey="5" title="">購物車</a></li>
                <li><a href="MyAccount_Orders.aspx" accesskey="5" title="">會員中心</a></li>
                <li><a href="SHProductDisplay.aspx" accesskey="5" title="">二手商品</a></li>
		    </ul>
	    </div>
    </div>
    <div id="page">
        <div class="container">
          <div class="row">
            <div class="col-2" style="border:solid">
                <ul>
                    <li><a href="MyAccount_Orders.aspx">訂單管理</a></li>
                    <li><a href="MyAccount_AccEdit.aspx">修改會員資料</a></li>
                    <li><a href="MyAccount_SHProductRequire.aspx">二手商品拍賣申請</a></li>
                </ul>
            </div>
            <div class="col-1"></div>
            <div class="col-9">
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
                    <br /><br />
                <div class="container">
                    <h2><strong>收件人資訊</strong></h2>
                    <div class="col-sm">收貨人姓名: <%Response.Write(dr["O_Name"].ToString()); %></div>
                    <div class="col-sm">收貨人電話: <%Response.Write(dr["O_Phone"].ToString()); %></div>
                    <div class="col-sm">收貨人地址: <%Response.Write(dr["O_Address"].ToString()); %></asp:TextBox></div>
                </div>
                <center><input id="Button1" type="button" class="btn btn-outline-secondary" value="確定" onclick="location.href='MyAccount_Orders.aspx'" /></center>
            </div>    
          </div>
        </div>
    </div>
    <div id="copyright" class="container">
	    <p>&copy; Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</p>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
