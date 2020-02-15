<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BankTeller._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Scripts/bootstrap.min.js" type="text/javascript"></script>

    <style>
        body {
            width: 100%;
            margin: 5px;
        }

        .table-condensed tr th {
            border: 0px solid #6e7bd9;
            color: white;
            background-color: #6e7bd9;
        }

        .table-condensed, .table-condensed tr td {
            border: 0px solid #000;
        }

        tr:nth-child(even) {
            background: #f8f7ff
        }

        tr:nth-child(odd) {
            background: #fff;
        }
    </style>

    <div class="jumbotron">
        <h2>Money Bank</h2>
        <p class="lead">List of Account</p>
        <div class="form-control-static">
            <p style="float: right">
                <asp:Button class="btn btn-primary" ID="BtnNew" runat="server" Text="Add New Account" OnClick="BtnNew_Click" />
            </p>
        </div>
        <div class="row">
            <asp:GridView ID="datagrid1" runat="server" DataKeyNames="AccountId" CssClass="table table-condensed table-hover" Width="100%" AutoGenerateColumns="False" OnRowCommand="datagrid1_RowCommand" OnRowDeleting="datagrid1_RowDeleting">
                <Columns>
                    <%--<asp:BoundField DataField="AccountId" HeaderText="AccountId" ReadOnly="True" InsertVisible="False" SortExpression="AccountId"></asp:BoundField>--%>
                    <asp:BoundField DataField="AccountNo" HeaderText="Account No" SortExpression="AccountNo">
                    </asp:BoundField>
                    <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" SortExpression="CustomerName"></asp:BoundField>
                    <asp:BoundField DataField="MobileNumber" HeaderText="Mobile Number" SortExpression="MobileNumber"></asp:BoundField>
                    <%--<asp:BoundField DataField="UpdateDate" HeaderText="UpdateDate" SortExpression="UpdateDate"></asp:BoundField>--%>
                    <asp:ButtonField Text="View" CommandName="ViewAccount" ></asp:ButtonField>
                    <asp:ButtonField Text="Delete" CommandName="Delete" ></asp:ButtonField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

    
</asp:Content>
