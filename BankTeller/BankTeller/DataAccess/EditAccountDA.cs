using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace BankTeller.DataAccess
{
    public class EditAccountDA
    {
        private static SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["BankConnectionString"].ConnectionString);

        public static DataTable ACM_List(int AcctId)
        {
            using (SqlCommand cmd = new SqlCommand("ACM_List", connect))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@AccountId", AcctId));
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                return dt;
            }
        }

        public static DataTable ViewMobile(string LblCustIdFK)
        {
            using (SqlCommand rcmd = new SqlCommand("ViewMobile", connect))
            {
                rcmd.CommandType = CommandType.StoredProcedure;
                rcmd.Parameters.Add(new SqlParameter("@CustomerFK", LblCustIdFK));
                SqlDataAdapter rsda = new SqlDataAdapter(rcmd);
                DataTable rdt = new DataTable();
                rsda.Fill(rdt);

                return rdt;
                
            }
        }

        public static int INSERTCustomer(string Txtname)
        {
            //***Execute Insert command and return inserted Id in Sql!
            using (SqlCommand cmd = new SqlCommand("INSERTCustomer", connect))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CustomerName", Txtname);
                cmd.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@UpdateDate", DateTime.Now);
                connect.Open();

                 int CustomerFK = (int)cmd.ExecuteScalar();

                if (connect.State == System.Data.ConnectionState.Open)
                    connect.Close();

                return CustomerFK;
            }
        }

        public static DataTable Count()
        {
            //***Get the Row Count!
            using (SqlCommand cmdacct = new SqlCommand("COUNTAccount", connect))
            {
                cmdacct.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter sdaacct = new SqlDataAdapter(cmdacct);
                DataTable dtacct = new DataTable();
                sdaacct.Fill(dtacct);

                return dtacct;
            }
        }

        public static void INSERTAccount(string acctnum, int CustomerFK)
        {
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
        }

        public static void INSERTMobileNum(string numbers, int CustomerFK)
        {
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
        }

        public static void INSERTTrans(string amount, int CustomerFK)
        {
            using (SqlCommand cmd = new SqlCommand("INSERTTrans", connect))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Amount", amount);
                cmd.Parameters.AddWithValue("@CustomerFK", CustomerFK);
                cmd.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@UpdateDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@RemainingBalance", amount);

                connect.Open();
                cmd.ExecuteNonQuery();

            }
            connect.Close();
        }

        public static void UpdateCustomer(string cidFK, string name)
        {
            using (SqlCommand cmd = new SqlCommand("EditUpdate", connect))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CustomerFK", cidFK));
                cmd.Parameters.AddWithValue("@CustomerName", name);

                connect.Open();
                cmd.ExecuteNonQuery();

            }
            connect.Close();
        }

        public static void UpdateMobileNum(Label mblId, TextBox txtNo)
        {
            using (SqlCommand cmd = new SqlCommand("UpdateMobileNum", connect))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@MobileID", mblId.Text));
                cmd.Parameters.AddWithValue("@MobileNumber", txtNo.Text.ToString());
                cmd.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@UpdateDate", DateTime.Now);

                connect.Open();
                cmd.ExecuteNonQuery();
            }
            connect.Close();
        }

        public static void InsertUpdateMobileNum(string cidFK, string newnumbers)
        {
            using (SqlCommand cmd = new SqlCommand("INSERTMobileNum", connect))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MobileNumber", newnumbers);
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