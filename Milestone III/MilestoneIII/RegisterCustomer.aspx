<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterCustomer.aspx.cs" Inherits="MilestoneIII.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h1 style="color:cadetblue"> Customer registration </h1>

            <br/>

            <asp:Label ID="lbl_username" runat="server" Text="Username: " ForeColor="DarkSlateGray"></asp:Label>
            <asp:TextBox ID="txt_username" runat="server" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"></asp:TextBox>

            <br/>
            <br/>

            <asp:Label ID="lbl_fname" runat="server" Text="First name: " ForeColor="DarkSlateGray"></asp:Label>
            <asp:TextBox ID="txt_fname" runat="server" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"></asp:TextBox>

            <br/>
            <br/>

            <asp:Label ID="lbl_lname" runat="server" Text="Last name: " ForeColor="DarkSlateGray"></asp:Label>
            <asp:TextBox ID="txt_lname" runat="server" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"></asp:TextBox>

            <br/>
            <br/>

            <asp:Label ID="lbl_password" runat="server" Text="Password: " ForeColor="DarkSlateGray"></asp:Label>
            <asp:TextBox ID="txt_password" runat="server" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"></asp:TextBox>

            <br/>
            <br/>

            <asp:Label ID="lbl_email" runat="server" Text="Email: " ForeColor="DarkSlateGray"></asp:Label>
            <asp:TextBox ID="txt_email" runat="server" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"></asp:TextBox>

            <br/>
            <br/>

            <asp:Button ID="btn_register" runat="server" Text="Register" onclick="register" Width="90px" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"/>

        </div>
    </form>
</body>
</html>
