using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace BankTeller.DataAccess
{
    public class TellerDA
    {
        private static SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["BankConnectionString"].ConnectionString);

        public static DataTable ViewAccount(int id)
        {
            using (SqlCommand vacmd = new SqlCommand("ViewAccount", connect))
            {
                vacmd.CommandType = CommandType.StoredProcedure;
                vacmd.Parameters.Add(new SqlParameter("@AccountId", id));
                SqlDataAdapter vasda = new SqlDataAdapter(vacmd);
                DataTable vadt = new DataTable();
                vasda.Fill(vadt);

                return vadt;
            }
        }

        public static DataTable ORDERBYTrans(string cid)
        {
            using (SqlCommand obcmd = new SqlCommand("ORDERBYTrans", connect))
            {
                obcmd.CommandType = CommandType.StoredProcedure;
                obcmd.Parameters.Add(new SqlParameter("@CustomerFK", cid));
                SqlDataAdapter obsda = new SqlDataAdapter(obcmd);
                DataTable obdt = new DataTable();
                obsda.Fill(obdt);

                return obdt;
            }
        }

        public static void INSERTTrans(string name, string value, string cid, decimal newbal)
        {
            using (SqlCommand cmd = new SqlCommand("INSERTTrans", connect))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Amount", name);
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