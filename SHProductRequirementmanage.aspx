﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SHProductRequirementmanage.aspx.cs" Inherits="SHProductRequirementmanage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
    <link rel="stylesheet" href="css/estilo.css">
    <style type="text/css">
        body {
            overflow-x: hidden;
        }

        /* Toggle Styles */
        #wrapper {
            padding-left: 0;
            -webkit-transition: all 0.5s ease;
            -moz-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            transition: all 0.5s ease;
        }

        #wrapper.toggled {
            padding-left: 250px;
        }

        #sidebar-wrapper {
            z-index: 1000;
            position: fixed;
            left: 250px;
            width: 0;
            height: 100%;
            margin-left: -250px;
            overflow-y: auto;
            background: #000;
            -webkit-transition: all 0.5s ease;
            -moz-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            transition: all 0.5s ease;
        }

        #wrapper.toggled #sidebar-wrapper {
            width: 250px;
        }

        #page-content-wrapper {
            width: 100%;
            position: absolute;
            padding: 15px;
        }

        #wrapper.toggled #page-content-wrapper {
            position: absolute;
            margin-right: -250px;
        }

        /* Sidebar Styles */

        .sidebar-nav {
            position: absolute;
            top: 0;
            width: 250px;
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .sidebar-nav li {
            text-indent: 20px;
            line-height: 40px;
        }

        .sidebar-nav li a {
            display: block;
            text-decoration: none;
            color: #999999;
        }

        .sidebar-nav li a:hover {
            text-decoration: none;
            color: #fff;
            background: rgba(255,255,255,0.2);
        }

        .sidebar-nav li a:active,
        .sidebar-nav li a:focus {
            text-decoration: none;
        }

        .sidebar-nav > .sidebar-brand {
            height: 65px;
            font-size: 18px;
            line-height: 60px;
        }

        .sidebar-nav > .sidebar-brand a {
            color: #999999;
        }

        .sidebar-nav > .sidebar-brand a:hover {
            color: #fff;
            background: none;
        }

        @media(min-width:768px) {
            #wrapper {
                padding-left: 250px;
            }

            #wrapper.toggled {
                padding-left: 0;
            }

            #sidebar-wrapper {
                width: 250px;
            }

            #wrapper.toggled #sidebar-wrapper {
                width: 0;
            }

            #page-content-wrapper {
                padding: 20px;
                position: relative;
            }

            #wrapper.toggled #page-content-wrapper {
                position: relative;
                margin-right: 0;
            }
        }
    </style>
</head>
<body>
    <div id="wrapper">
        <!-- Sidebar -->
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li class="sidebar-brand">
                    <a href="#">
                        後台
                    </a>
                </li>

                <li>
                    <a href="#pageSubmenu_PM" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">商品處理</a>
                    <ul class="collapse list-unstyled" id="pageSubmenu_PM">
                        <li>
                            <a href="Productmanage.aspx">商品管理</a>
                        </li>
                        <li>
                            <a href="ProductStylemanage.aspx">商品樣式管理</a>
                        </li>
                        <li>
                            <a href="ProductClassifymanage.aspx">商品分類管理</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">二手拍賣處理</a>
                    <ul class="collapse list-unstyled" id="pageSubmenu">
                        <li>
                            <a href="SecondHandProductmanage.aspx">二手商品管理</a>
                        </li>
                        <li>
                            <a href="SHProductRequirementmanage.aspx">二手商品請求管理</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="Accountmanage.aspx">會員管理</a>
                </li>
                <li>
                    <a href="Ordersmanage.aspx">訂單管理</a>
                </li>
                <li>
                    <a href="#pageSubmenu_WebMan" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">網頁處理</a>
                    <ul class="collapse list-unstyled" id="pageSubmenu_WebMan">
                        <li>
                            <a href="Newsmanage.aspx">最新消息</a>
                        </li>
                        <li>
                            <a href="AboutUsmanage.aspx">關於我們</a>
                        </li>
                        <li>
                            <a href="ContactUsmanage.aspx">聯絡我們</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="Adminmanage.aspx">管理者登入處理</a>
                </li>
                 <a href="index.aspx">回首頁</a>
            </ul>
        </div>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1>二手商品請求管理</h1>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">編號</th>
                                    <th scope="col">名稱</th>
                                    <th scope="col">價格</th>
                                    <th scope="col">說明</th>
                                    <th scope="col">圖片</th>
                                    <th scope="col">賣家姓名</th>
                                    <th scope="col">賣家連絡電話</th>
                                    <th scope="col">動作</th>
                                </tr>
                            </thead>
                            
                            <tbody>
                            <%
                                System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                                System.Data.SqlClient.SqlCommand sqlcommand = null;
                                System.Data.SqlClient.SqlDataReader dr = null;
                                conn.Open();
                                sqlcommand = new System.Data.SqlClient.SqlCommand("select * from [SecondHandProductRequire]", conn); //查詢所有會員資訊
                                dr = sqlcommand.ExecuteReader();
                                try
                                {
                                    int i = 0;
                                    while(dr.Read())
                                    {
                            %>
                                <form  method="post" action="SHProductRequirementmanage_Action.aspx">
                                    <tr>
                                       <!-- 將讀取所有會員資料 套入到表格中  -->

                                        <td><%Response.Write(dr["SHPR_num"].ToString()); %></td>
                                        <td><input name="txt_Name" type="text" style="width:70px" value="<%Response.Write(dr["SHPR_Name"].ToString()); %>" /></td>
                                        <td><input name="txt_Price" type="text" style="width:70px" value="<%Response.Write(dr["SHPR_Price"].ToString()); %>" /></td>
                                        <td><textarea name="txt_Info" rows="5"><%Response.Write(dr["SHPR_Info"].ToString()); %></textarea></td>
                                        <td>
                                            <img style="width:100px; height:100px" src="<%Response.Write(dr["SHPR_Img"].ToString()); %>" />
                                            <input name="Hid_Img" style="display:none" value="<%Response.Write(dr["SHPR_Img"].ToString()); %>" />
                                        </td>
                                        <td><input name="txt_SellerName" type="text" style="width:100px" value="<%Response.Write(dr["SHPR_SellerName"].ToString()); %>" /></td>
                                        <td><input name="txt_SellerPhone" type="text" style="width:100px" value="<%Response.Write(dr["SHPR_SellerPhone"].ToString()); %>" /></td>

                                        <td>
                                                                                   <!-- 進行 編輯/刪除 導向Accountmanage_Action.aspx.cs進行程式執行  -->
                                            <input name="Hid_Num" style="display:none" value="<%Response.Write(dr["SHPR_num"].ToString()); %>" />
                                            <input name="btn_Act" type="submit" value="新增至二手商品" style="font-family:微軟正黑體; font-size:14px;" /><br />
                                            <input name="btn_Act" type="submit" value="刪除" style="font-family:微軟正黑體; font-size:14px;"/>
                                        </td>
                                    </tr>
                                </form>
                            <%    
                                        i++;
                                    }
                                    conn.Close();
                                }
                                catch (Exception ee)
                                {
                                    Response.Write(ee.Message);
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- /#page-content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="/js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/js/bootstrap.min.js"></script>

    <!-- Menu Toggle Script -->
    <script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
    
    </script>
   

    <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
    
    <script src="app.js" charset="utf-8"></script>
</body>
</html>
