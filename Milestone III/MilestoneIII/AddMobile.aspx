<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddMobile.aspx.cs" Inherits="MilestoneIII.AddMobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Telephone number</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/HomeCustomer.aspx">Go to homepage</asp:HyperLink>

            <h1 style="color:cadetblue"> Add telephone number </h1>

            <br/>

            <asp:Label ID="lbl_number" runat="server" Text="Telephone number: " ForeColor="DarkSlateGray"></asp:Label>
            <asp:TextBox ID="txt_number" runat="server" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"></asp:TextBox>

            <br/>
            <br/>

            <asp:Button ID="btn_add" runat="server" Text="Add" onclick="add" Width="90px" BackColor="DarkSlateGray" BorderColor="DarkSlateGray" style="color:aliceblue"/>

        </div>
    </form>
</body>
</html>
