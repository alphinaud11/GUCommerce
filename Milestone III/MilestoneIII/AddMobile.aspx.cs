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
    public partial class AddMobile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);

            if (String.IsNullOrEmpty(username))
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void add(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);

            if (String.IsNullOrEmpty(username))
            {
                Response.Redirect("~/Login.aspx");
            }

            else
            {
                string number = txt_number.Text;

                if (String.IsNullOrEmpty(number))
                {
                    Label label1 = new Label();
                    label1.Text = "You have to write something !";
                    label1.ForeColor = System.Drawing.Color.Crimson;
                    label1.Font.Bold = true;
                    form1.Controls.Add(label1);
                }

                else
                {
                    //Get the information of the connection to the database
                    string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

                    //create a new connection
                    SqlConnection conn = new SqlConnection(connStr);

                    /*create a new SQL command which takes as parameters the name of the stored procedure and
                     the SQLconnection name*/
                    SqlCommand cmd1 = new SqlCommand("mobileExist", conn);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    SqlCommand cmd2 = new SqlCommand("addMobile", conn);
                    cmd2.CommandType = CommandType.StoredProcedure;

                    //pass parameters to the stored procedure
                    cmd1.Parameters.Add(new SqlParameter("@username", username));
                    cmd1.Parameters.Add(new SqlParameter("@mobile", number));
                    cmd2.Parameters.Add(new SqlParameter("@username", username));
                    cmd2.Parameters.Add(new SqlParameter("@mobile_number", number));

                    //Save the output from the procedure
                    SqlParameter output = cmd1.Parameters.Add("@output", SqlDbType.Bit);
                    output.Direction = ParameterDirection.Output;

                    //Executing the SQLCommand
                    conn.Open();
                    cmd1.ExecuteNonQuery();
                    conn.Close();

                    Boolean outputBool = Convert.ToBoolean(cmd1.Parameters["@output"].Value);

                    if (outputBool)
                    {
                        Label label2 = new Label();
                        label2.Text = "Telephone number already exists in your account";
                        label2.ForeColor = System.Drawing.Color.Crimson;
                        label2.Font.Bold = true;
                        form1.Controls.Add(label2);
                    }

                    else
                    {
                        //Executing the SQLCommand
                        conn.Open();
                        cmd2.ExecuteNonQuery();
                        conn.Close();

                        Label label3 = new Label();
                        label3.Text = "Telephone number [" + number + "] added successfully";
                        label3.ForeColor = System.Drawing.Color.DodgerBlue;
                        label3.Font.Bold = true;
                        form1.Controls.Add(label3);
                    }
                }
            }
        }
    }
}
