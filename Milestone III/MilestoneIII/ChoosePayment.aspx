<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChoosePayment.aspx.cs" Inherits="MilestoneIII.ChooseOrderPay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Choose order</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/HomeCustomer.aspx">Go to homepage</asp:HyperLink>

            <h1 style="color:cadetblue"> Choose payment method </h1>

            <br/>

            <asp:Label ID="lbl_choose" runat="server" Text="Payment method: " ForeColor="DarkSlateGray"></asp:Label>

            <asp:DropDownList ID="DropDownList1" runat="server" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue">
                <asp:ListItem Selected="True">Cash</asp:ListItem>
                <asp:ListItem>Credit</asp:ListItem>
            </asp:DropDownList>

            <br/>
            <br/>

            <asp:Button ID="btn_next" runat="server" Text="Next" onclick="next" Width="90px" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"/>

        </div>
    </form>
</body>
</html>
