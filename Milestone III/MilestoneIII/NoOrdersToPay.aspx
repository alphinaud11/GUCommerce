<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoOrdersToPay.aspx.cs" Inherits="MilestoneIII.PayOrderFail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pay order fail</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/HomeCustomer.aspx">Go to homepage</asp:HyperLink>

            <h1 style="color:crimson"> There are no orders you can pay ! </h1>

        </div>
    </form>
</body>
</html>
