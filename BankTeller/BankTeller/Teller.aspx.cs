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
            string cid = null;
            string oldbal = null;
            decimal newbal = 0;
            int id = 0;

            if (Request.QueryString["Id"] != null)
            {
                id = Convert.ToInt32(Request.QueryString["Id"]);
            }

            using (SqlCommand vacmd = new SqlCommand("ViewAccount", connect))
            {
                vacmd.CommandType = CommandType.StoredProcedure;
                vacmd.Parameters.Add(new SqlParameter("@AccountId", id));
                SqlDataAdapter vasda = new SqlDataAdapter(vacmd);
                DataTable vadt = new DataTable();
                vasda.Fill(vadt);

                if (vadt.Rows.Count > 0)
                {
                    cid = vadt.Rows[0]["CustomerFK"].ToString();
                }
            }

            using (SqlCommand obcmd = new SqlCommand("ORDERBYTrans", connect))
            {
                obcmd.CommandType = CommandType.StoredProcedure;
                obcmd.Parameters.Add(new SqlParameter("@CustomerFK", cid));
                SqlDataAdapter obsda = new SqlDataAdapter(obcmd);
                DataTable obdt = new DataTable();
                obsda.Fill(obdt);

                if (obdt.Rows.Count > 0)
                {
                    oldbal = obdt.Rows[0]["RemainingBalance"].ToString();

                    if (DropDownList1.SelectedValue == "1")
                    {
                        newbal = Convert.ToDecimal(Txtamount.Text.ToString()) + Convert.ToDecimal(oldbal);

                        //***Sum the two string values in c#!
                        //string newbal = TxtAmount.Text.ToString() + oldbal;
                        //string[] val = newbal.Split(',');
                        //string ans = (Int32.Parse(val[0]) + Int32.Parse(val[1])).ToString();

                        //if more numbers:
                        //string num = "878.97,878.97";
                        //string[] val = num.Split(',');
                        //int ans = 0;
                        //for (int i = 0; i < val.Length; i++)
                        //{
                        //    ans = ans + (double.Parse(val[i])).ToString();
                        //}

                        //string val = newbal;
                        //string[] splitval = val.Split(',');
                        //double total = 0;
                        //foreach (string item in splitval)
                        //{
                        //    string temp;
                        //    if (item == "")
                        //    {
                        //        temp = 0;
                        //    }
                        //    else
                        //    {
                        //        temp = item;
                        //    }
                        //    total = total + Convert.ToDouble(temp);
                        //}
                    }
                    else
                    {
                        //***Math.Abs: Remove Negative Sign!
                        newbal = Convert.ToDecimal(oldbal) - Convert.ToDecimal(Txtamount.Text.ToString());
                    }
                }
            }

            if (!string.IsNullOrEmpty(Txtamount.Text) || Txtamount.Text != "0")
            {

                if (DropDownList1.SelectedValue == "1" || (DropDownList1.SelectedValue == "2" && Convert.ToDecimal(Txtamount.Text) <= Convert.ToDecimal(oldbal)))
                {
                    using (SqlCommand cmd = new SqlCommand("INSERTTrans", connect))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Amount", Txtamount.Text.ToString());
                        cmd.Parameters.AddWithValue("@TransTypeFK", Convert.ToInt32(value));
                        cmd.Parameters.AddWithValue("@CustomerFK", Convert.ToInt32(cid));
                        cmd.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                        cmd.Parameters.AddWithValue("@UpdateDate", DateTime.Now);
                        cmd.Parameters.AddWithValue("@RemainingBalance", newbal);

                        connect.Open();
                        cmd.ExecuteNonQuery();

                    }
                    connect.Close();
                }

            }
        }
    }
}