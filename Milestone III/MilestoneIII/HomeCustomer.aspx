<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeCustomer.aspx.cs" Inherits="MilestoneIII.HomeCustomer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer homepage</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h1 style="color:cadetblue"> Customer homepage </h1>

            <br/>
            <asp:Label ID="lbl_welcome" runat="server" ForeColor="CadetBlue"></asp:Label>
            <br/>
            <asp:Label ID="lbl_points" runat="server" ForeColor="CadetBlue"></asp:Label>

            <br/>
            <br/>

            <asp:Label ID="Lbl_addMobile" runat="server" Text="Add telephone number(s): " ForeColor="DarkSlateGray"></asp:Label>
            <br/>
            <asp:Button ID="btn_addMobile" runat="server" Text="Click" onclick="addMobile" Width="90px" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"/>

            <br/>
            <br/>

            <asp:Label ID="lbl_order" runat="server" Text="Order products in my cart: " ForeColor="DarkSlateGray"></asp:Label>
            <br/>
            <asp:Button ID="btn_order" runat="server" Text="Click" onclick="order" Width="90px" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"/>

            <br/>
            <br/>

            <asp:Label ID="lbl_payOrder" runat="server" Text="Pay order: " ForeColor="DarkSlateGray"></asp:Label>
            <br/>
            <asp:Button ID="btn_payOrder" runat="server" Text="Click" onclick="pay" Width="90px" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"/>

            <br/>
            <br/>

            <asp:Label ID="lbl_cancelOrder" runat="server" Text="Cancel order: " ForeColor="DarkSlateGray"></asp:Label>
            <br/>
            <asp:Button ID="btn_cancelOrder" runat="server" Text="Click" onclick="cancel" Width="90px" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"/>

        </div>
    </form>
</body>
</html>
