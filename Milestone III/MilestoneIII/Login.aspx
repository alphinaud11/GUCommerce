<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MilestoneIII.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h1 style="color:cadetblue"> Login </h1>

            <br/>

            <asp:Label ID="lbl_username" runat="server" Text="Username: " ForeColor="DarkSlateGray"></asp:Label>
            <asp:TextBox ID="txt_username" runat="server" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"></asp:TextBox>

            <br/>
            <br/>
  
            <asp:Label ID="lbl_password" runat="server" Text="Password: " ForeColor="DarkSlateGray"></asp:Label>
            <asp:TextBox ID="txt_password" runat="server" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"></asp:TextBox>

            <br/>
            <br/>

            <asp:Button ID="btn_login" runat="server" Text="Login" onclick="login" Width="90px" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"/>

            <br/>
            <br/>

            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/RegisterChooseType.aspx">I dont have an account</asp:HyperLink>

        </div>
    </form>
</body>
</html>
