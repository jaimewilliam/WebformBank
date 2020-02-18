using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace BankTeller.DataAccess
{
    public class DefaultDA
    {
        private static SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["BankConnectionString"].ConnectionString);

        public static DataTable List()
        {
            using (SqlCommand cmd = new SqlCommand("ACM_List", connect))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                return dt;
                
            }
        }
    }
}