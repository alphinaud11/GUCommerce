<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CancelOrderFail.aspx.cs" Inherits="MilestoneIII.CancelOrderFail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cancel order fail</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/HomeCustomer.aspx">Go to homepage</asp:HyperLink>

            <h1 style="color:crimson"> There are no orders you can cancel at the moment </h1>

        </div>
    </form>
</body>
</html>
