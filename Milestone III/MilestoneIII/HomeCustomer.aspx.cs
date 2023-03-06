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
    public partial class HomeCustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("returnPoints", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = (string)(Session["username"]);

            if(String.IsNullOrEmpty(username))
            {
                Response.Redirect("~/Login.aspx");
            }

            else
            {
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@username", username));

                //Save the output from the procedure
                SqlParameter points = cmd.Parameters.Add("@points", SqlDbType.Float);
                points.Direction = ParameterDirection.Output;

                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                lbl_welcome.Text = "Welcome " + username;
                lbl_points.Text = "Your points: " + points.Value;
            }
        }

        protected void viewPoints(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);

            if (String.IsNullOrEmpty(username))
            {
                Response.Redirect("~/Login.aspx");
            }

            else
            {
                Response.Redirect("~/ViewPoints.aspx");
            }
        }

        protected void addMobile(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);

            if (String.IsNullOrEmpty(username))
            {
                Response.Redirect("~/Login.aspx");
            }

            else
            {
                Response.Redirect("~/AddMobile.aspx");
            }
        }

        protected void order(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);

            if (String.IsNullOrEmpty(username))
            {
                Response.Redirect("~/Login.aspx");
            }

            else
            {
                //Get the information of the connection to the database
                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

                //create a new connection
                SqlConnection conn = new SqlConnection(connStr);

                /*create a new SQL command which takes as parameters the name of the stored procedure and
                 the SQLconnection name*/
                SqlCommand cmd = new SqlCommand("itemsCount", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@username", username));

                //Save the output from the procedure
                SqlParameter count = cmd.Parameters.Add("@count", SqlDbType.Int);
                count.Direction = ParameterDirection.Output;

                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (count.Value.ToString().Equals("0"))
                {
                    Response.Redirect("~/OrderFail.aspx");
                }

                else
                {
                    Response.Redirect("~/OrderSuccess.aspx");
                }
            }
        }

        protected void pay(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);

            if (String.IsNullOrEmpty(username))
            {
                Response.Redirect("~/Login.aspx");
            }

            else
            {
                //Get the information of the connection to the database
                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

                //create a new connection
                SqlConnection conn = new SqlConnection(connStr);

                /*create a new SQL command which takes as parameters the name of the stored procedure and
                 the SQLconnection name*/
                SqlCommand cmd = new SqlCommand("checkNotPayOrder", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@username", username));

                //Save the output from the procedure
                SqlParameter output = cmd.Parameters.Add("@output", SqlDbType.Bit);
                output.Direction = ParameterDirection.Output;

                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Boolean outputBool = Convert.ToBoolean(cmd.Parameters["@output"].Value);

                if (outputBool)
                {
                    Response.Redirect("~/ChoosePayment.aspx");
                }
                else
                {
                    Response.Redirect("~/NoOrdersToPay.aspx");
                }
            }
        }

        protected void cancel(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);

            if (String.IsNullOrEmpty(username))
            {
                Response.Redirect("~/Login.aspx");
            }

            else
            {
                //Get the information of the connection to the database
                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

                //create a new connection
                SqlConnection conn = new SqlConnection(connStr);

                /*create a new SQL command which takes as parameters the name of the stored procedure and
                 the SQLconnection name*/
                SqlCommand cmd = new SqlCommand("OrderToBeCanceledExist", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@username", username));

                //Save the output from the procedure
                SqlParameter output = cmd.Parameters.Add("@output", SqlDbType.Bit);
                output.Direction = ParameterDirection.Output;

                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Boolean outputBool = Convert.ToBoolean(cmd.Parameters["@output"].Value);

                if (outputBool)
                {
                    Response.Redirect("~/CancelOrder.aspx");
                }
                else
                {
                    Response.Redirect("~/CancelOrderFail.aspx");
                }
            }
        }

    }
}
