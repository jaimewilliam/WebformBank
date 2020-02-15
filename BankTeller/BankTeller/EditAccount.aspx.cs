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

                using (SqlCommand cmd = new SqlCommand("ACM_List", connect))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@AccountId", AcctId));
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        LblCustIdFK.Text = dt.Rows[0]["CustomerFK"].ToString();
                        LblAcctId.Text = dt.Rows[0]["AccountId"].ToString();
                        Txtacctno.Text = dt.Rows[0]["AccountNo"].ToString();
                        Txtname.Text = dt.Rows[0]["CustomerName"].ToString();
                        //Txtmobile.Text = dt.Rows[0]["MobileNumber"].ToString();
                    }
                }

                using (SqlCommand rcmd = new SqlCommand("ViewMobile", connect))
                {
                    rcmd.CommandType = CommandType.StoredProcedure;
                    rcmd.Parameters.Add(new SqlParameter("@CustomerFK", LblCustIdFK.Text));
                    SqlDataAdapter rsda = new SqlDataAdapter(rcmd);
                    DataTable rdt = new DataTable();
                    rsda.Fill(rdt);

                    if (rdt.Rows.Count > 0)
                    {
                        Repeater1.DataSource = rdt;
                        Repeater1.DataBind();
                    }
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

            if (btnType == "Save New")
            {
                //***Execute Insert command and return inserted Id in Sql!
                using (SqlCommand cmd = new SqlCommand("INSERTCustomer", connect))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CustomerName", Txtname.Text.ToString());
                    cmd.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@UpdateDate", DateTime.Now);
                    connect.Open();

                    CustomerFK = (int)cmd.ExecuteScalar();

                    if (connect.State == System.Data.ConnectionState.Open)
                        connect.Close();
                }

                //***Get the Row Count!
                string count = null;
                SqlCommand cmdacct = new SqlCommand("COUNTAccount", connect);
                cmdacct.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter sdaacct = new SqlDataAdapter(cmdacct);
                DataTable dtacct = new DataTable();
                sdaacct.Fill(dtacct);

                if (dtacct.Rows.Count > 0)
                {
                    count = dtacct.Rows[0]["rowcount"].ToString();
                }
                //***Generate Account number from Row Count!
                string acctnum = (0 + count).ToString().PadLeft(10, '0');

                using (SqlCommand cmd = new SqlCommand("INSERTAccount", connect))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@AccountNo", acctnum);
                    cmd.Parameters.AddWithValue("@CustomerFK", CustomerFK);
                    cmd.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@UpdateDate", DateTime.Now);

                    connect.Open();
                    cmd.ExecuteNonQuery();

                }
                connect.Close();

                string numbers = Request["additionalnumber"].ToString();
                if (!string.IsNullOrEmpty(numbers))
                {
                    string[] newnumbers = numbers.Split(',');

                    for (int i = 0; i < newnumbers.Count(); i++)
                    {
                        using (SqlCommand cmd = new SqlCommand("INSERTMobileNum", connect))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@MobileNumber", newnumbers[i]);
                            cmd.Parameters.AddWithValue("@CustomerFK", CustomerFK);
                            cmd.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                            cmd.Parameters.AddWithValue("@UpdateDate", DateTime.Now);

                            connect.Open();
                            cmd.ExecuteNonQuery();

                        }
                        connect.Close();
                    }
                }



                using (SqlCommand cmd = new SqlCommand("INSERTTrans", connect))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Amount", Txtamount.Text.ToString());
                    cmd.Parameters.AddWithValue("@CustomerFK", CustomerFK);
                    cmd.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@UpdateDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@RemainingBalance", Txtamount.Text.ToString());

                    connect.Open();
                    cmd.ExecuteNonQuery();

                }
                connect.Close();
            }
            else
            {
                using (SqlCommand cmd = new SqlCommand("EditUpdate", connect))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@CustomerFK", cidFK));
                    cmd.Parameters.AddWithValue("@CustomerName", Txtname.Text.ToString());

                    connect.Open();
                    cmd.ExecuteNonQuery();

                }
                connect.Close();

                foreach (RepeaterItem item in Repeater1.Items)
                {
                    using (SqlCommand cmd = new SqlCommand("UpdateMobileNum", connect))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        Label mblId = (Label)item.FindControl("Lblmblnum");
                        cmd.Parameters.Add(new SqlParameter("@MobileID", mblId.Text));
                        TextBox txtNo = (TextBox)item.FindControl("Txtmobile");
                        cmd.Parameters.AddWithValue("@MobileNumber", txtNo.Text.ToString());
                        cmd.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                        cmd.Parameters.AddWithValue("@UpdateDate", DateTime.Now);

                        connect.Open();
                        cmd.ExecuteNonQuery();
                    }
                    connect.Close();
                }

                string numbers = Request["additionalnumber"].ToString();
                if (!string.IsNullOrEmpty(numbers))
                {
                    string[] newnumbers = numbers.Split(',');

                    for (int i = 0; i < newnumbers.Count(); i++)
                    {
                        using (SqlCommand cmd = new SqlCommand("INSERTMobileNum", connect))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@MobileNumber", newnumbers[i]);
                            cmd.Parameters.AddWithValue("@CustomerFK", cidFK);
                            cmd.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                            cmd.Parameters.AddWithValue("@UpdateDate", DateTime.Now);

                            connect.Open();
                            cmd.ExecuteNonQuery();

                        }
                        connect.Close();
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