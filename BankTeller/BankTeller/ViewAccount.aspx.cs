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
    public partial class ViewAccount : System.Web.UI.Page
    {
        SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["BankConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            int id = 0;
            if (Request.QueryString["Id"] != null)
            {
                id = Convert.ToInt32(Request.QueryString["Id"]);
            }

            //***For Textboxes!

            DataTable dt = ViewAccountDA.ViewAccount(id);

            if (dt.Rows.Count > 0)
            {
                LblId.Text = dt.Rows[0]["AccountId"].ToString();
                Txtacctno.Text = dt.Rows[0]["AccountNo"].ToString();
                Txtname.Text = dt.Rows[0]["CustomerName"].ToString();
            }


            //***For Gridview!

            DataTable gdt = ViewAccountDA.ViewTrans(id);

            if (gdt.Rows.Count > 0)
            {
                GridView1.DataSource = gdt;
                GridView1.DataBind();
            }
            
        }

        protected void BtnEdit_Click(object sender, EventArgs e)
        {
            string acctid = LblId.Text.ToString();
            Response.Redirect("EditAccount.aspx?Id=" + acctid);
        }

        protected void Btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void BtnTeller_Click(object sender, EventArgs e)
        {
            int id = 0;
            if (Request.QueryString["Id"] != null)
            {
                id = Convert.ToInt32(Request.QueryString["Id"]);
            }
            Response.Redirect("Teller.aspx?Id=" + id);
        }
    }
}