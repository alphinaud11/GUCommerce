using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MilestoneIII
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("userLogin", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = txt_username.Text;
            string password = txt_password.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@password", password));

            //Save the output from the procedure
            SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;
            SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
            type.Direction = ParameterDirection.Output;

            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Boolean successBool = Convert.ToBoolean(cmd.Parameters["@success"].Value);

            if (!successBool)
            {
                Label label = new Label();
                label.Text = "Wrong username or password, please try again";
                label.ForeColor = System.Drawing.Color.Crimson;
                label.Font.Bold = true;
                form1.Controls.Add(label);
            }

            else
            {
                if(type.Value.ToString().Equals("0"))
                {
                    Session["username"] = username;
                    Response.Redirect("~/HomeCustomer.aspx");
                }

                else if (type.Value.ToString().Equals("1"))
                {
                    Session["username"] = username;
                    Response.Redirect("~/HomeVendor.aspx");
                }

                else if(type.Value.ToString().Equals("2"))
                {
                    Session["username"] = username;
                    Response.Redirect("~/HomeAdmin.aspx");
                }
            }
        }
    }
}
