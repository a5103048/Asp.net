<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

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
            <li><a href="SHProductDisplay.aspx" accesskey="6" title="">二手商品</a></li>
		</ul>
	</div>
</div>
<div id="page">
	<div class="container">
        <div style="text-align:right;">
            <form id="form1" runat="server">
                <asp:TextBox ID="txt_Search" runat="server" placeholder="搜尋商品"></asp:TextBox>
                <asp:Button ID="btn_Search" runat="server" Text="搜尋" OnClick="btn_Search_Click"/>
            </form>
        </div>
		<div class="title" >
			<h2><asp:Label ID="lab_Tital" runat="server" Text="Tital"></asp:Label></h2>
			<p><asp:Label ID="lab_Contents" runat="server" Text="Contents"></asp:Label></p>
		</div>
        <%
            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);//連接資料庫字串
            System.Data.SqlClient.SqlCommand sqlcommand = null;
            System.Data.SqlClient.SqlDataReader dr = null;
            conn.Open();
            sqlcommand = new System.Data.SqlClient.SqlCommand("select P_num,P_Name,P_Image from [Product]", conn); //查詢資料庫 商品 訊息
            dr = sqlcommand.ExecuteReader(); //讀取資料庫 查詢之資料
            string[] P_Namearray = new string[6];
            string[] P_Imagearray = new string[6];
            string[] P_numarray = new string[6];

            try
            {
                for (int i = 0; i < 6; i++) //當有取讀到資料 則會進行 商品 名稱/圖片/編號 讀取 並存在各自(名稱/圖片/編號)陣列中
                {
                    dr.Read();
                    P_Namearray[i] = dr["P_Name"].ToString();
                    P_Imagearray[i]=dr["P_Image"].ToString();
                    P_numarray[i] = dr["P_num"].ToString();
                }
            }
            catch (Exception ee)
            {
                Response.Write(ee.Message);
            }
       %>
        <!-- 以下為將每筆(名稱/圖片/編號)陣列資料 套入到對映商品-->
		<div class="boxA">
			<div class="box margin-btm">
				<img src="<%Response.Write( P_Imagearray[0]);%>" width="320" height="180" alt="" />
				<div class="details">
					<p><%Response.Write(P_Namearray[0]);%></p>
				</div>
				<a href="Itempage.aspx?Identity=<%Response.Write(P_numarray[0]);%>" class="button">DETAIL</a>
			</div>
			<div class="box">
				<img src="<%Response.Write(P_Imagearray[1]);%>" width="320" height="220" alt="" />
				<div class="details">
					<p><%Response.Write(P_Namearray[1]);%></p>
				</div>
				<a href="Itempage.aspx?Identity=<%Response.Write(P_numarray[1]);%>" class="button">DETAIL</a>
			</div>
		</div>

		<div class="boxB">
			<div class="box">
				<img src="<%Response.Write(P_Imagearray[2]);%>" width="320" height="280" alt="" />
				<div class="details">
					<p><%Response.Write(P_Namearray[2]);%></p>
				</div>
				<a href="Itempage.aspx?Identity=<%Response.Write(P_numarray[2]);%>" class="button">DETAIL</a>
			</div>
			<div class="box">
				<img src="<%Response.Write(P_Imagearray[3]);%>" width="320" height="140" alt="" />
				<div class="details">
					<p><%Response.Write(P_Namearray[3]);%></p>
				</div>
				<a href="Itempage.aspx?Identity=<%Response.Write(P_numarray[3]);%>" class="button">DETAIL</a>
			</div>
		</div>

		<div class="boxC">
			<div class="box">
				<img src="<%Response.Write(P_Imagearray[4]);%>" width="320" height="200" alt="" />
				<div class="details">
					<p><%Response.Write(P_Namearray[4]);%></p>
				</div>
				<a href="Itempage.aspx?Identity=<%Response.Write(P_numarray[4]);%>" class="button">DETAIL</a>
			</div>
			<div class="box">
				<img src="<%Response.Write(P_Imagearray[5]);%>" width="320" height="200" alt="" />
				<div class="details">
					<p><%Response.Write(P_Namearray[5]);%></p>
				</div>
				<a href="Itempage.aspx?Identity=<%Response.Write(P_numarray[5]);%>" class="button">DETAIL</a>
			</div>
		</div>
	</div>
    <center><a href="ProductDisplay.aspx" class="button">看更多</a></center>
    </div>
    <div id="copyright" class="container">
	    <p>&copy; <a href="Adminlogin.aspx"> Admin</a> | Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</p>
    </div>
</body>
</html>