<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Defau1lt.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body style="background-color: #C0C0C0; color: #000000">
    <form id="form1" runat="server" style="background-color: #C0C0C0; color: #000000">
        <div style="background-color: #666633; vertical-align: middle; height: 66px; font-size: x-large; font-style: inherit; color: #FFFFFF;">YASIN FURNITURE</div>
        <div>
            <asp:Login ID="Login1" runat="server" Font-Bold="True" LoginButtonText="LOG IN" PasswordLabelText="PASSWORD:" RememberMeText="Remember Me" TitleText="LOG IN" UserNameLabelText="USER ID:">
            </asp:Login>
        </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="帳號" DataSourceID="SqlDataSource1" Visible="False">
            <Columns>
                <asp:BoundField DataField="帳號" HeaderText="帳號" ReadOnly="True" SortExpression="帳號" />
                <asp:BoundField DataField="密碼" HeaderText="密碼" SortExpression="密碼" />
                <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" />
                <asp:BoundField DataField="身分" HeaderText="身分" SortExpression="身分" />
                <asp:BoundField DataField="訂單資訊" HeaderText="訂單資訊" SortExpression="訂單資訊" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [Table]"></asp:SqlDataSource>
        <asp:Button ID="Button1" runat="server" Text="SIGN UP"/>
    </form>
</body>
</html>
