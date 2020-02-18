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
    public partial class _Default : Page
    {
        SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["BankConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt = DefaultDA.List();

                if (dt.Rows.Count > 0)
                {
                    datagrid1.DataSource = dt;
                    datagrid1.DataBind();
                }
            }



        }

        protected void datagrid1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
             
            if (e.CommandName == "ViewAccount")
            {
                int rowindex = Convert.ToInt32(e.CommandArgument.ToString());
                string id = datagrid1.DataKeys[rowindex].Values[0].ToString();
                Response.Redirect("ViewAccount.aspx?Id=" + id);
            }
            else
            {

                if (e.CommandName == "Delete")
                {
                    int rowindex = Convert.ToInt32(e.CommandArgument.ToString());
                    string id = datagrid1.DataKeys[rowindex].Values[0].ToString();

                    string cid = null;

                    using (SqlCommand cmd = new SqlCommand("ViewAccount", connect))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@AccountId", id));
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            cid = dt.Rows[0]["CustomerFK"].ToString();
                        }
                    }

                    using (SqlCommand custcmd = new SqlCommand("DELETECustomer", connect))
                    {
                        custcmd.CommandType = CommandType.StoredProcedure;
                        custcmd.Parameters.Add(new SqlParameter("@CustomerFK", cid));
                    }

                    using (SqlCommand custcmd = new SqlCommand("DELETEMobile", connect))
                    {
                        custcmd.CommandType = CommandType.StoredProcedure;
                        custcmd.Parameters.Add(new SqlParameter("@CustomerFK", cid));
                    }

                    using (SqlCommand custcmd = new SqlCommand("DELETETrans", connect))
                    {
                        custcmd.CommandType = CommandType.StoredProcedure;
                        custcmd.Parameters.Add(new SqlParameter("@CustomerFK", cid));
                    }

                    using (SqlCommand acctcmd = new SqlCommand("DELETEAccount", connect))
                    {
                        acctcmd.CommandType = CommandType.StoredProcedure;
                        acctcmd.Parameters.Add(new SqlParameter("@AccountId", id));
                    }
                }
            }
        }

        protected void BtnNew_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditAccount.aspx");
        }

        protected void datagrid1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        
    }
}