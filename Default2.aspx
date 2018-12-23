<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default2.aspx.vb" Inherits="Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            歡迎登入，管理者!
        </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="帳號" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="帳號" HeaderText="帳號" ReadOnly="True" SortExpression="帳號" />
                <asp:BoundField DataField="密碼" HeaderText="密碼" SortExpression="密碼" />
                <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" />
                <asp:BoundField DataField="身分" HeaderText="身分" SortExpression="身分" />
                <asp:BoundField DataField="訂單資訊" HeaderText="訂單資訊" SortExpression="訂單資訊" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database.mdf;Integrated Security=True" DeleteCommand="DELETE FROM [Table] WHERE [帳號] = @帳號" InsertCommand="INSERT INTO [Table] ([帳號], [密碼], [姓名], [身分], [訂單資訊]) VALUES (@帳號, @密碼, @姓名, @身分, @訂單資訊)" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [Table]" UpdateCommand="UPDATE [Table] SET [密碼] = @密碼, [姓名] = @姓名, [身分] = @身分, [訂單資訊] = @訂單資訊 WHERE [帳號] = @帳號">
            <DeleteParameters>
                <asp:Parameter Name="帳號" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="帳號" Type="String" />
                <asp:Parameter Name="密碼" Type="String" />
                <asp:Parameter Name="姓名" Type="String" />
                <asp:Parameter Name="身分" Type="String" />
                <asp:Parameter Name="訂單資訊" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="密碼" Type="String" />
                <asp:Parameter Name="姓名" Type="String" />
                <asp:Parameter Name="身分" Type="String" />
                <asp:Parameter Name="訂單資訊" Type="String" />
                <asp:Parameter Name="帳號" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
