<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterChooseType.aspx.cs" Inherits="MilestoneIII.RegisterChooseType" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Choose type</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h1 style="color:cadetblue"> Choose type </h1>

            <br/>

            <asp:Label ID="lbl_choose" runat="server" Text="Register As: " ForeColor="DarkSlateGray"></asp:Label>

            <asp:DropDownList ID="DropDownList1" runat="server" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue">
                <asp:ListItem Selected="True">Customer</asp:ListItem>
                <asp:ListItem>Vendor</asp:ListItem>
            </asp:DropDownList>

            <br/>
            <br/>

            <asp:Button ID="btn_next" runat="server" Text="Next" onclick="next" Width="90px" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"/>

        </div>
    </form>
</body>
</html>
