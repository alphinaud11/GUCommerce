<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderSuccess.aspx.cs" Inherits="MilestoneIII.Order" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Order</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h1 style="color:cadetblue"> Order success </h1>

            <br/>
            <asp:Label ID="lbl_success" runat="server" ForeColor="DodgerBlue"></asp:Label>
            <br/>
            <asp:Label ID="lbl_orderID" runat="server" ForeColor="DodgerBlue"></asp:Label>
            <br/>
            <asp:Label ID="lbl_totalAmount" runat="server" ForeColor="DodgerBlue"></asp:Label>

        </div>
    </form>
</body>
</html>
