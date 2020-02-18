using BankTeller.DataAccess;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BankTeller
{
    public partial class EditAccount : System.Web.UI.Page
    {
        SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["BankConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int AcctId = 0;
                if (Request.QueryString["Id"] != null)
                {
                    AcctId = Convert.ToInt32(Request.QueryString["Id"]);
                }

                DataTable dt = EditAccountDA.ACM_List(AcctId);

                if (dt.Rows.Count > 0)
                {
                    LblCustIdFK.Text = dt.Rows[0]["CustomerFK"].ToString();
                    LblAcctId.Text = dt.Rows[0]["AccountId"].ToString();
                    Txtacctno.Text = dt.Rows[0]["AccountNo"].ToString();
                    Txtname.Text = dt.Rows[0]["CustomerName"].ToString();
                    //Txtmobile.Text = dt.Rows[0]["MobileNumber"].ToString();
                }

                DataTable rdt = EditAccountDA.ViewMobile(LblCustIdFK.Text);

                if (rdt.Rows.Count > 0)
                {
                    Repeater1.DataSource = rdt;
                    Repeater1.DataBind();
                }

                if (AcctId == 0)
                {
                    Btnsave.Text = "Save New";
                    Lbltitle.Text = "Add New";
                }
            }
        }

        protected void Btnsave_Click(object sender, EventArgs e)
        {
            string cidFK = LblCustIdFK.Text.ToString();
            string btnType = Btnsave.Text.ToString();
            int CustomerFK = 0;
            string name = Txtname.Text.ToString();
            string amount = Txtamount.Text.ToString();

            if (btnType == "Save New")
            {
                CustomerFK = EditAccountDA.INSERTCustomer(name);


                //***Get the Row Count!
                string count = null;
                DataTable dtacct = EditAccountDA.Count();

                if (dtacct.Rows.Count > 0)
                {
                    count = dtacct.Rows[0]["rowcount"].ToString();
                }


                //***Generate Account number from Row Count!
                string acctnum = (0 + count).ToString().PadLeft(10, '0');
                EditAccountDA.INSERTAccount(acctnum, CustomerFK);

                string numbers = Request["additionalnumber"].ToString();
                EditAccountDA.INSERTMobileNum(numbers, CustomerFK);
                

                EditAccountDA.INSERTTrans(amount, CustomerFK);
                
            }
            else
            {
                EditAccountDA.UpdateCustomer(cidFK, name);
                

                foreach (RepeaterItem item in Repeater1.Items)
                {
                    Label mblId = (Label)item.FindControl("Lblmblnum");
                    TextBox txtNo = (TextBox)item.FindControl("Txtmobile");

                    EditAccountDA.UpdateMobileNum(mblId, txtNo);
                    
                }

                string numbers = Request["additionalnumber"].ToString();
                if (!string.IsNullOrEmpty(numbers))
                {
                    string[] newnumbers = numbers.Split(',');

                    for (int i = 0; i < newnumbers.Count(); i++)
                    {
                        
                        EditAccountDA.InsertUpdateMobileNum(cidFK, newnumbers[i]);
                        
                    }
                }
            }
        }

        protected void Btncancel_Click(object sender, EventArgs e)
        {
            string acctid = LblAcctId.Text;
            if (!string.IsNullOrEmpty(acctid))
            {
                Response.Redirect("ViewAccount.aspx?Id=" + acctid);
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
            
            
        }

        
    }
}