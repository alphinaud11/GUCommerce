<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterSuccess.aspx.cs" Inherits="MilestoneIII.RegisterSuccess" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register success</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h1 style="color:cadetblue"> Registration completed </h1>

            <br/>

            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Login.aspx">You can login now</asp:HyperLink>

        </div>
    </form>
</body>
</html>
