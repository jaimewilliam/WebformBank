<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Teller.aspx.cs" Inherits="BankTeller.Teller" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h2>Money Bank</h2>
        <h4>Manual Teller Machine</h4>

        <div class="form-horizontal">
            <div class="form-group">
                <div class="col-md-10">
                    <asp:Label ID="Label1" runat="server" Text="Transaction Type:" class="control-label col-xs-3"></asp:Label><asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="true"
                    DataTextField="TransactionName" DataValueField="TransactionTypeID" class="form-control">
                    <asp:ListItem>Select Your Transaction Type</asp:ListItem>
                </asp:DropDownList>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-10">
                    <asp:Label ID="Label2" runat="server" Text="Amount:" class="control-label col-xs-3"></asp:Label><asp:TextBox ID="Txtamount" runat="server" class="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="form-control-static">
            <p style="float: right">
                <asp:Button class="btn btn-success" ID="Btncont" runat="server" Text="Continue" OnClick="Btncont_Click" />
            </p>
        </div>
        </div>
    </div>
</asp:Content>
