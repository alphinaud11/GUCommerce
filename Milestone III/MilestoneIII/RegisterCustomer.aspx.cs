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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void register(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd1 = new SqlCommand("checkUsernameExist", conn);
            cmd1.CommandType = CommandType.StoredProcedure;

            SqlCommand cmd2 = new SqlCommand("customerRegister", conn);
            cmd2.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = txt_username.Text;
            string fname = txt_fname.Text;
            string lname = txt_lname.Text;
            string password = txt_password.Text;
            string email = txt_email.Text;

            if (String.IsNullOrEmpty(username))
            {
                Label label1 = new Label();
                label1.Text = "You have to provide a username";
                label1.ForeColor = System.Drawing.Color.Crimson;
                label1.Font.Bold = true;
                form1.Controls.Add(label1);
            }

            else
            {
                form1.Controls.Add(new Literal() { ID = "row", Text = "<br/>" });

                if (String.IsNullOrEmpty(password))
                {
                    Label label2 = new Label();
                    label2.Text = "You have to provide a password";
                    label2.ForeColor = System.Drawing.Color.Crimson;
                    label2.Font.Bold = true;
                    form1.Controls.Add(label2);
                }

                else
                {
                    //pass parameters to the stored procedure
                    cmd1.Parameters.Add(new SqlParameter("@username", username));

                    //Save the output from the procedure
                    SqlParameter output = cmd1.Parameters.Add("@output", SqlDbType.Bit);
                    output.Direction = ParameterDirection.Output;

                    //Executing the SQLCommand
                    conn.Open();
                    cmd1.ExecuteNonQuery();
                    conn.Close();

                    Boolean outBool = Convert.ToBoolean(cmd1.Parameters["@output"].Value);

                    if (outBool)
                    {
                        Label label3 = new Label();
                        label3.Text = "Username already exists, try choosing another one";
                        label3.ForeColor = System.Drawing.Color.Crimson;
                        label3.Font.Bold = true;
                        form1.Controls.Add(label3);
                    }

                    else
                    {
                        cmd2.Parameters.Add(new SqlParameter("@username", username));
                        cmd2.Parameters.Add(new SqlParameter("@first_name", fname));
                        cmd2.Parameters.Add(new SqlParameter("@last_name", lname));
                        cmd2.Parameters.Add(new SqlParameter("@password", password));
                        cmd2.Parameters.Add(new SqlParameter("@email", email));

                        conn.Open();
                        cmd2.ExecuteNonQuery();
                        conn.Close();

                        Response.Redirect("~/RegisterSuccess.aspx");
                    }
                }
            }
        }
    }
}
