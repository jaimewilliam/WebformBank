using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace BankTeller.DataAccess
{
    public class ViewAccountDA
    {
        private static SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["BankConnectionString"].ConnectionString);

        public static DataTable ViewAccount(int id)
        {
            using (SqlCommand cmd = new SqlCommand("ViewAccount", connect))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@AccountId", id));
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                return dt;
            }
        }

        public static DataTable ViewTrans(int id)
        {
            using (SqlCommand gcmd = new SqlCommand("ViewTrans", connect))
            {
                gcmd.CommandType = CommandType.StoredProcedure;
                gcmd.Parameters.Add(new SqlParameter("@AccountId", id));
                SqlDataAdapter gsda = new SqlDataAdapter(gcmd);
                DataTable gdt = new DataTable();
                gsda.Fill(gdt);

                return gdt;
            }
        }
    }
}