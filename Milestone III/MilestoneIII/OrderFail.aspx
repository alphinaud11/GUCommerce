<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderFail.aspx.cs" Inherits="MilestoneIII.OrderFail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/HomeCustomer.aspx">Go to homepage</asp:HyperLink>

            <h1 style="color:crimson"> There are no items in your cart ! </h1>

        </div>
    </form>
</body>
</html>
