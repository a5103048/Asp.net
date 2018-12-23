<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContactUs.aspx.cs" Inherits="ContactUs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
<link href="./MainPage/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="./MainPage/fonts.css" rel="stylesheet" type="text/css" media="all" />

<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/c ss" /><![endif]-->
<style>
input[type=text], select {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}


input[type=submit]:hover {
    background-color: #45a049;
}

.Inform {
    border-radius: 5px;
    background-color: #f2f2f2;
    padding: 20px;
    opacity:0.7;
}
input[type=submit] {
    width: 100%;
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}
textarea {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;

	width: 100%;
}
</style>
</head>
<body>
<div id="header" class="container">
	<div id="logo">
		<h1><a href="index.aspx">YASIN FURNITURE</a></h1>
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
<div class="Inform">
<center><h1>聯絡我們</h1></center>
    <br />
    <center>
  <form id="form1" runat=server style="width:75%;margin:5 auto;">
      <div>
          <label style="font-size:20px;font-weight:bold;">姓名</label><br />
          <asp:TextBox ID="txt_Name" runat="server"></asp:TextBox>
      </div><br />
      <div>
          <label style="font-size:20px;font-weight:bold;">Email</label><br />
          <asp:TextBox ID="txt_Email" runat="server"></asp:TextBox>
      </div><br />
      <div>
          <label style="font-size:20px;font-weight:bold;">內容</label><br />
          <asp:TextBox ID="txt_Content" runat="server" TextMode="MultiLine" Rows="15"></asp:TextBox>
      </div>
      <div>
          <label style="font-size:20px;font-weight:bold;">上傳圖片</label><br />
          <asp:FileUpload id="FileUpload_Img" runat="server" />
      </div>
      <asp:Button ID="btn_Submit" runat="server" Text="送出" OnClick="btn_Submit_Click" />
  </form>
        </center>
</div>

       
	</div>
</div>
<div id="copyright" class="container">
	<p>&copy; <a href="Adminlogin.aspx"> Admin</a> | Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</p>
</div>
</body>
</html>

