<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyAccount_AccEdit.aspx.cs" Inherits="MyAccount_Edit" %>

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
                <form id="form1" runat="server"> 
                    <div class="form-group">
                        <label>帳號: </label>
                        <asp:TextBox CssClass="form-control" ID="M_Account" runat="server" placeholder="帳號" ReadOnly="True"></asp:TextBox>
                    </div>
                    <br />

                    <div class="form-group">
                        <label>密碼: </label>
                        <asp:TextBox CssClass="form-control" ID="M_Password" runat="server"  placeholder="密碼"  TextMode="Password"></asp:TextBox>
                    </div>
                    <br />

                    <div class="form-group">
                        <label>姓名: </label>
                        <asp:TextBox CssClass="form-control" ID="M_Name" runat="server" placeholder="姓名"></asp:TextBox>
                    </div>
                    <br />

                    <div class="form-group">
                        <label>地址: </label>
                        <asp:TextBox CssClass="form-control" ID="M_Address" runat="server" placeholder="地址"></asp:TextBox>
                    </div>
                    <br />

                    <div class="form-group">
                        <label>電話: </label>
                        <asp:TextBox CssClass="form-control" ID="M_Tel" runat="server"  placeholder="電話"></asp:TextBox>
                    </div>
                    <br />

                    <div class="form-group">
                        <label>性別: </label>
                        <asp:DropDownList ID="GenderList" runat="server" CssClass="form-control">
                            <asp:ListItem>男</asp:ListItem>
                            <asp:ListItem>女</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <br /><br />

                    <center><asp:Button ID="btn_AccEdit" runat="server" Text="修改會員資料" CssClass="btn btn-primary btn-block" OnClick="btn_AccEdit_Click" Width="150px"/></center>
                </form>
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
