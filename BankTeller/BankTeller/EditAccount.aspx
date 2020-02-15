<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditAccount.aspx.cs" Inherits="BankTeller.EditAccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h2>Money Bank</h2>
        <h4><asp:Label ID="Lbltitle" runat="server" Text="Edit Account"></asp:Label></h4>
        <asp:Label ID="LblCustIdFK" runat="server" Text="" Style="display:none"></asp:Label><asp:Label ID="LblAcctId" runat="server" Text="" Style="display:none"></asp:Label>
        <div class="form-horizontal">
            <div class="form-group">
                <div class="col-md-10">
                    <asp:Label ID="Label1" runat="server" Text="Account No:" class="control-label col-xs-3"></asp:Label><asp:TextBox ID="Txtacctno" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-10">
                    <asp:Label ID="Label2" runat="server" Text="Name:" class="control-label col-xs-3"></asp:Label><asp:TextBox ID="Txtname" runat="server" class="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="form-group editmobile divnum">
                <asp:Repeater ID="Repeater1" runat="server">
                    <ItemTemplate>
                        <asp:Label ID="Lblmblnum" runat="server" Text='<%#  Eval("MobileNumberID") %>' Style="display:none"></asp:Label>
                        <div class="col-md-10 clonenumber">
                            <asp:Label ID="Label3" runat="server" Text="Mobile No:" class="control-label col-xs-3"></asp:Label><asp:TextBox ID="Txtmobile" runat="server" class="form-control mobileinput" Text='<%#  Eval("MobileNumber") %>' onblur = "Focusout(this);" onkeyup = "onkeyUP(this);" onchange = "OnChangeEvent(this)"></asp:TextBox>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="form-group addmobile divnum">
                <div class="col-md-10 clonenumber">
                    <asp:Label ID="Label4" runat="server" Text="Mobile No:" class="control-label col-xs-3"></asp:Label><asp:TextBox ID="Txtaddmobile" runat="server" class="form-control" onblur = "Focusout(this);" onkeyup = "onkeyUP(this);" onchange = "OnChangeEvent(this)"></asp:TextBox>
                </div>
            </div>
            <div class="form-group addamount">
                <div class="col-md-10">
                    <asp:Label ID="Label5" runat="server" Text="Initial Deposit Amount:" class="control-label col-xs-3"></asp:Label><asp:TextBox ID="Txtamount" runat="server" class="form-control"></asp:TextBox>
                </div>
            </div>
        </div>
        <input id="extranum" name="additionalnumber" style="display:none" />
        <div class="form-control-static">
            <p style="float: right">
                <asp:Button class="btn btn-primary" ID="Btncancel" runat="server" Text="Back" OnClick="Btncancel_Click" />
                <asp:Button class="btn btn-success" ID="Btnsave" runat="server" Text="Save Changes" OnClick="Btnsave_Click" />
            </p>
        </div>
    </div>

    <script src="Scripts/jquery-3.3.1.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            //***check if a div is empty
            if ($('.editmobile').children().length === 0) {
                $(".editmobile").css("display", "none");
            } else {
                $(".addmobile").css("display", "none");
                $(".addamount").css("display", "none");
            }
        });

        function onkeyUP(mblinput) {
            if ($(mblinput).val().length === 0) {
                $(mblinput).addClass('noval');
            }
            else {
                $(mblinput).removeClass('noval');
            }
        }

        function Focusout(mblnum) {
            if ($('.noval').length === 0 ) {
                var num = $(".clonenumber");
                var newnum = $(num[0]).clone();
                $(newnum).find('.mobileinput').addClass('noval');
                $(newnum).appendTo(".divnum").find('input').val('');
                $(newnum).find('input').addClass('noval');
            }
        }

        function OnChangeEvent(getnum) {
        
            //if ($(getnum).parent().parent().find('.numId').val() === '') {

            //    var xnum = $(getnum).val();
            //    //***jQuery push multiple values in input tag
            //    var oldValue = $("#extranum").val();
            //    var arr = oldValue === "" ? [] : oldValue.split(',');
            //    arr.push(xnum);
            //    var newValue = arr.join(',');
            //    jQuery('#extranum').val(newValue);
            //}

                var xnum = $(getnum).val();
                //***jQuery push multiple values in input tag
                var oldValue = $("#extranum").val();
                var arr = oldValue === "" ? [] : oldValue.split(',');
                arr.push(xnum);
                var newValue = arr.join(',');
                jQuery('#extranum').val(newValue);
        }
    </script>

</asp:Content>
