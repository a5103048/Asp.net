<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>

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
        <div style="text-align:center;">
            <form id="form1" runat="server">
                <asp:TextBox ID="txt_Search" runat="server" placeholder="搜尋商品"></asp:TextBox>
                <asp:Button ID="btn_Search" runat="server" Text="搜尋" OnClick="btn_Search_Click"/>
            </form>
        </div>
        <br /><br />
        <div class="container">
            <div class="row">
                <div class="col-2" style="border:solid">
                    <h4><a href="Search.aspx?Keyword=<%Response.Write(Request.QueryString["Keyword"]); %>">分類</a></h4>
                    <ul style="text-align:center;">
                        <%
                            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                            System.Data.SqlClient.SqlCommand sqlcommand = null;
                            System.Data.SqlClient.SqlDataReader dr = null;

                            conn.Open();
                            sqlcommand = new System.Data.SqlClient.SqlCommand("select * from ProductClassify", conn); //查詢所有會員資訊
                            dr = sqlcommand.ExecuteReader();
                            while (dr.Read())
                            {
                        %>
                        <li><a href="Search.aspx?Keyword=<%Response.Write(Request.QueryString["Keyword"]); %>&Classify=<%Response.Write(dr["PC_num"].ToString()); %>"><%Response.Write(dr["PC_Name"].ToString()); %></a></li>
                        <%
                            }
                            dr.Close();
                            conn.Close();
                        %>
                    </ul>
                </div>
                <div class="col-10">
                    <%
                        //System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                        //System.Data.SqlClient.SqlCommand sqlcommand = null;
                        //System.Data.SqlClient.SqlDataReader dr = null;

                        string Keyword = Request.QueryString["Keyword"];
                        conn.Open();
                        if (Request.QueryString["Classify"] == null)
                            sqlcommand = new System.Data.SqlClient.SqlCommand("select P_num,P_Name,P_Price,P_Description,P_Image from Product WHERE P_Name LIKE '%" + Keyword + "%'", conn); //查詢條件
                        else
                            sqlcommand = new System.Data.SqlClient.SqlCommand("select P_num,P_Name,P_Price,P_Description,P_Image from Product WHERE P_Name LIKE '%" + Keyword + "%' AND PClassify_num=" + Request.QueryString["Classify"], conn); //查詢條件
                        dr = sqlcommand.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                    %>
                    <div class="media" style="background-color:rgba(128, 128, 128,0.8); width:70%; margin:0 auto; border-radius:10px; padding:10px">
                        <a href="Itempage.aspx?Identity=<%Response.Write(dr["P_num"].ToString()); %>"><img class="align-self-start mr-3" src="<%Response.Write(dr["P_Image"].ToString()); %>" alt="尚無圖片" style="height:175px; Width:250px" /></a>
                        <div class="media-body">
                            <a href="Itempage.aspx?Identity=<%Response.Write(dr["P_num"].ToString()); %>"><h5 class="mt-0" style="font-weight:bold;"><%Response.Write(dr["P_Name"].ToString()); %></h5></a>
                            <p><%Response.Write(dr["P_Description"].ToString()); %></p>
                            <p><%Response.Write(dr["P_Price"].ToString()); %> NTD</p>
                        </div>
                    </div>
                    <br />
                    <%
                            }
                        }
                        else
                        {
                    %>
                    <div style="text-align:center;">
                        <p>查無商品!</p>
                    </div>
                    <%
                        }
                    %>
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
