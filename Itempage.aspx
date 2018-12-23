<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Itempage.aspx.cs" Inherits="Itempage" %>



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
        background-image:url(ip.jpg);
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
              <div class="col-lg-12">
                  <div id="ui">
                     <form id="form1" runat="server" class="form-group "> 
                         <div class="row">
           <div class="col-lg-12">
			<div class="row">

				<div class="col-lg-6 col-lg-offset-6">
                    <asp:Image ID="P_Img" runat="server" CssClass="img-fluid" ImageUrl="sp.jpg" Height="90%" Width="90%" />
				</div>

				<div class="col-lg-6  col-lg-offset-6">
                    <h1 class="text-center"><asp:Label ID="lab_Name" runat="server" Text="Items"></asp:Label></h1>
                    <hr  size="10" />
                    <label>
                        <h3>商品價格</h3>
                        &nbsp;&nbsp; &nbsp;&nbsp;
                        <asp:Label ID="lab_Price" runat="server" Text="" Font-Size="14px" Font-Names="微軟正黑體"> NTD</asp:Label>
                    </label>
                    <br />
                    <label style="width:100%">
                        <h3>商品特色</h3>
                        &nbsp;&nbsp; &nbsp;&nbsp;
                        <asp:Label ID="lab_Feat" runat="server" Text="#############" Font-Size="14px" Font-Names="微軟正黑體" style="word-break:break-all;" Width="90%"></asp:Label>
                    </label>
                    <br />
                    <label>
                        <h3>商品尺寸</h3>
                        &nbsp;&nbsp; &nbsp;&nbsp;
                        <asp:Label ID="lab_Size" runat="server" Text="###" Font-Size="14px" Font-Names="微軟正黑體"></asp:Label>
                    </label>
                    <br />
                    <label>
                        <h3>商品編號</h3>
                        &nbsp;&nbsp; &nbsp;&nbsp;
                        <asp:Label ID="lab_ID" runat="server" Text="000" Font-Size="14px" Font-Names="微軟正黑體"></asp:Label>
                    </label>
                    <br />
                    <label><h3>顏色風格</h3></label>
                    &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
                    <asp:DropDownList class="btn btn-danger dropdown-toggle" ID="S_Style" runat="server" Width="200px" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="S_Style_SelectedIndexChanged"></asp:DropDownList>
                    <br />
                    <br />
                    <label><h3>數量</h3></label>
                    &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
                    <asp:DropDownList class="btn btn-danger dropdown-toggle" ID="S_Amount" runat="server" Width="200px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                        <asp:ListItem>6</asp:ListItem>
                        <asp:ListItem>7</asp:ListItem>
                        <asp:ListItem>8</asp:ListItem>
                        <asp:ListItem>9</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <br />
                    <asp:Button class="btn btn-outline-primary" ID="Button1" runat="server" Text="加入購物車" OnClick="Button1_Click" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button class="btn btn-outline-primary"  ID="Button2" runat="server" Text="直接購買" OnClick="Button2_Click" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton class="btn btn-outline-primary"  ID="Button3" runat="server" Text="回首頁" PostBackUrl="index.aspx" />
			</div>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalLong">評價</button>
		</div>
	</div>
 </div>                    </form>
                  </div>
              </div>
              <div class="col-lg-3"></div>
          </div>
        </div>

    <!-- Modal -->
<div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">評分</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
         <div class="modal-body">
            <form  method="post" action="Itempage.aspx?Identity=<%Response.Write(Request.QueryString["Identity"].ToString());%>">
                <div class="form-group">
                    <label for="Score-text" class="col-form-label">評分:</label>
                    <select name="Select">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="message-text" class="col-form-label">Message:</label>
                    <textarea class="form-control" name="message-text"></textarea>
                    <input name="ItemID" style="display:none" value="<%Response.Write(Request.QueryString["Identity"].ToString()); %>" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <input type="submit" name="submit" value="留言"  class="btn btn-primary" />
                </div>
            </form>

     <%
            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            System.Data.SqlClient.SqlCommand sqlcommand = null;
            System.Data.SqlClient.SqlDataReader dr = null;

           
            conn.Open();
            sqlcommand = new System.Data.SqlClient.SqlCommand("Select Member.M_Name,Score.Rate,Score.Comment from Member JOIN Score  ON Member.M_num=Score.M_num JOIN Product on Product.P_num=Score.P_num Where Product.P_num='" +Request.QueryString["Identity"].ToString() + "'" , conn); //查詢所有會員資訊
            //sqlcommand = new System.Data.SqlClient.SqlCommand("Select Member.M_Name,Score.Rate,Score.Comment from Member JOIN Score  ON Member.M_num=Score.M_num" , conn); //查詢所有會員資訊
            dr = sqlcommand.ExecuteReader();
            while(dr.Read())
            {
               
        %>
      <div class="modal-body">
          <%Response.Write(dr["M_Name"].ToString()); %>   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <%Response.Write(dr["Rate"].ToString()); %>
          <br />
          <%Response.Write(dr["Comment"].ToString()); %>
      </div>
          <%
              
            }
           
        %>



      
    </div>
  </div>
</div>











</body>
</html>
