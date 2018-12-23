<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Adminlogin.aspx.cs" Inherits="Adminlogin" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style type="text/css">
    body
    {
        background-image:url(image.jpg);
    }
   #ui
   {
       background:rgba(0,0,0,0.5);
       opacity:.7;
       padding:50px;
       margin-top:100px;
       border-radius:10px;
   }
   #ui label 
   {
       color:#ffff;
        font-size:medium;
   }
    #ui  h1
   {
       color:#ffff;
        font-size:xx-large;
   }
</style>

</head>
<body>
        <div class="container">
          <div class="row">
              <div class="col-lg-3"></div>
              <div class="col-lg-6">
                  <div id="ui">
                     <form id="form1" runat="server" class="form-group text-center"> 
                         <h1 >管理者登入</h1>
                          <br />
                         <div class="row">
                             <div class="col-lg-12">
                                 <label>帳號:</label>
                                 <asp:TextBox CssClass="form-control" ID="Account" runat="server" placeholder="帳號"></asp:TextBox>                          
                                   <br />
                                 <label>密碼:</label>
                                 <asp:TextBox ID="Password" class="form-control" placeholder="密碼" runat="server"  TextMode="Password"></asp:TextBox>
                                                         
                             </div>                       
                         </div>
                        <br />
                         <br />
                         <asp:Button CssClass="btn btn-primary btn-block" ID="Adlogin_btn" runat="server" Text="登入" OnClick="Signin_Click" />
                         <a href="index.aspx">回首頁</a>
                               <div class="row">
                                   <br />
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-4">
				</div>
				<div class="col-md-4">
				</div>
				<div class="col-md-4">
			</div>
			</div>
		</div>
	</div>

                     </form>
                  </div>
              </div>
              <div class="col-lg-3"></div>
          </div>
        </div>
   
</body>
</html>
