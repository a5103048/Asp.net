<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signup.aspx.cs" Inherits="Signup" %>


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
        background-image:url(sp.jpg);
    }
   #ui
   {
       background-color: #fff;
       opacity:.9;
       padding:50px;
       margin-top:100px;
       border-radius:10px;
   }
   #ui label
   {
       
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
                         <div class="row">
                             <div class="col-lg-6">
                                 <label>帳號:</label>
                                 <asp:TextBox CssClass="form-control" ID="M_Account" runat="server" placeholder="帳號"></asp:TextBox>                          
                             </div>
                             <div class="col-lg-6">
                                 <label>密碼:</label>
                                 <asp:TextBox CssClass="form-control" ID="M_Password" runat="server"  placeholder="密碼"></asp:TextBox>                          
                             </div>                       
                         </div>
                         <label>地址:</label>
                         <asp:TextBox CssClass="form-control" ID="M_Address" runat="server" placeholder="地址"></asp:TextBox> 
                          <div class="row">
                             <div class="col-lg-6">
                                 <label>姓名:</label>
                                 <asp:TextBox CssClass="form-control" ID="M_Name" runat="server" placeholder="姓名"></asp:TextBox>                          
                             </div>
                             <div class="col-lg-6">
                                 <label>電話:</label>
                                    <asp:TextBox CssClass="form-control" ID="M_Tel" runat="server"  placeholder="電話"></asp:TextBox>                          
                             </div>                       
                         </div> 
                         <br />
                         <label>性別:</label>
                         <asp:DropDownList ID="GenderList" runat="server" CssClass="form-control">
                             <asp:ListItem>男</asp:ListItem>
                             <asp:ListItem>女</asp:ListItem>
                         </asp:DropDownList>
                         <br />
                         <asp:Button ID="Button1" runat="server" Text="註冊" CssClass="btn btn-primary btn-block" OnClick="Button1_Click"  />
                     </form> &nbsp &nbsp &nbsp<a href="index.aspx">回首頁</a>
                  </div>
              </div>	
              <div class="col-lg-3"></div>
          </div>
        </div>
   
</body>
</html>
