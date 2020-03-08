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
    public partial class Teller : System.Web.UI.Page
    {
        SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["BankConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using (SqlCommand cmd = new SqlCommand("ViewTransType", connect))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        DropDownList1.DataSource = dt;
                        DropDownList1.DataBind();
                    }
                }
                
            }
        }

        protected void Btncont_Click(object sender, EventArgs e)
        {
            string value = DropDownList1.SelectedValue;
            string name = Txtamount.Text.ToString();
            string cid = null;
            string oldbal = null;
            decimal newbal = 0;
            int id = 0;

            if (Request.QueryString["Id"] != null)
            {
                id = Convert.ToInt32(Request.QueryString["Id"]);
            }

            DataTable vadt = TellerDA.ViewAccount(id);

            if (vadt.Rows.Count > 0)
            {
                cid = vadt.Rows[0]["CustomerFK"].ToString();
            }

            DataTable obdt = TellerDA.ORDERBYTrans(cid);
            if (obdt.Rows.Count > 0)
            {
                oldbal = obdt.Rows[0]["RemainingBalance"].ToString();

                if (DropDownList1.SelectedValue == "1")
                {
                    newbal = Convert.ToDecimal(Txtamount.Text.ToString()) + Convert.ToDecimal(oldbal);
                }
                else
                {
                    //***Math.Abs: Remove Negative Sign!
                    newbal = Convert.ToDecimal(oldbal) - Convert.ToDecimal(Txtamount.Text.ToString());
                }
            }

            if (!string.IsNullOrEmpty(Txtamount.Text) || Txtamount.Text != "0")
            {

                if (DropDownList1.SelectedValue == "1" || (DropDownList1.SelectedValue == "2" && Convert.ToDecimal(Txtamount.Text) <= Convert.ToDecimal(oldbal)))
                {
                    TellerDA.INSERTTrans(name, value, cid, newbal);
                    
                }

            }
        }
    }
}