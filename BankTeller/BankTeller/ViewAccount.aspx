<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewAccount.aspx.cs" Inherits="BankTeller.ViewAccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Scripts/bootstrap.min.js" type="text/javascript"></script>

    <div class="jumbotron">
        <h2>Money Bank</h2>

        <div class="form-horizontal">
            <h4>View Account</h4>
            <div class="form-control-static">
                <p style="float: right">
                    <asp:Button class="btn btn-primary" ID="BtnEdit" runat="server" Text="Edit Account" OnClick="BtnEdit_Click" />
                </p>
            </div>
            <asp:Label ID="LblId" runat="server" Text="" Style="display:none"></asp:Label>
            <hr />
            <dl class="dl-horizontal">
                
                <dt>
                    <asp:Label ID="Lblacctno" runat="server" Text="Account No:" class="control-label col-xs-3"></asp:Label>
                </dt>

                <dd>
                    <asp:TextBox ID="Txtacctno" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                </dd>

                <dt>
                    <asp:Label ID="Lblname" runat="server" Text="Name:" class="control-label col-xs-3"></asp:Label>
                </dt>

                <dd>
                    <asp:TextBox ID="Txtname" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                </dd>
            </dl>
        </div>

        <div class="form-group">
            <h2>Transaction History</h2>

            <p style="float: right">
                <asp:Button class="btn btn-primary" ID="BtnTeller" runat="server" Text="Manual Teller Machine" OnClick="BtnTeller_Click" />
            </p>

            <div class="row">
                <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" Width="100%">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>
                    <Columns>
                        
                        <asp:BoundField DataField="CreateDate" HeaderText="Create Date" SortExpression="CreateDate"></asp:BoundField>
                        <asp:BoundField DataField="TransactionName" HeaderText="Type" SortExpression="TransactionName"></asp:BoundField>
                        <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount"></asp:BoundField>
                        <asp:BoundField DataField="RemainingBalance" HeaderText="RemainingBalance" SortExpression="RemainingBalance"></asp:BoundField>

                    </Columns>
                    <EditRowStyle BackColor="#999999"></EditRowStyle>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></FooterStyle>
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></HeaderStyle>
                    <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White"></PagerStyle>
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333"></RowStyle>
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>
                    <SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>
                    <SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>
                    <SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
                </asp:GridView>
            </div>

            <div class="form-control-static">
                <p style="float: right">
                    <asp:Button class="btn btn-danger" ID="Btncancel" runat="server" Text="Cancel" OnClick="Btncancel_Click" />
                </p>
            </div>
        </div>
        
    </div>
    
</asp:Content>
