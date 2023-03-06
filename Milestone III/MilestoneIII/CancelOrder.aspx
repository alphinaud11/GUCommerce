<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CancelOrder.aspx.cs" Inherits="MilestoneIII.CancelOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cancel Order</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/HomeCustomer.aspx">Go to homepage</asp:HyperLink>

            <h1 style="color:cadetblue"> Cancel order </h1>

            <br/>

            <asp:Label ID="lbl_choose" runat="server" Text="Order ID: " ForeColor="DarkSlateGray"></asp:Label>

            <asp:DropDownList ID="DropDownList1" runat="server" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue">
            </asp:DropDownList>

            <br/>
            <br/>

            <asp:Button ID="btn_next" runat="server" Text="Cancel" onclick="cancel" Width="90px" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"/>

            <br/>

            <asp:Label ID="lbl_success" runat="server" ForeColor="DodgerBlue"></asp:Label>

        </div>
    </form>
</body>
</html>
