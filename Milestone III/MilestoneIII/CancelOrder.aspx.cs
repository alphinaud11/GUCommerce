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
    public partial class CancelOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("getOrdersToBeCanceled", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = (string)(Session["username"]);

            if (String.IsNullOrEmpty(username))
            {
                Response.Redirect("~/Login.aspx");
            }

            else
            {
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@username", username));

                //Executing the SQLCommand
                conn.Open();
                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "order_no";
                DropDownList1.DataValueField = "order_no";
                if(!IsPostBack)
                {
                    DropDownList1.DataBind();
                }
                conn.Close();
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
                SqlCommand cmd0 = new SqlCommand("getOrdersToBeCanceled", conn);
                cmd0.CommandType = CommandType.StoredProcedure;
                SqlCommand cmd = new SqlCommand("cancelOrder", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                //To read the input from the user
                String dropDownSelected = DropDownList1.SelectedValue;
                int orderId = Int32.Parse(dropDownSelected);

                if(String.IsNullOrEmpty(dropDownSelected))
                {
                    Response.Redirect("~/CancelOrderFail.aspx");
                }

                else
                {
                    //pass parameters to the stored procedure
                    cmd0.Parameters.Add(new SqlParameter("@username", username));
                    cmd.Parameters.Add(new SqlParameter("@orderid", orderId));

                    //Executing the SQLCommand
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    //Executing the SQLCommand
                    conn.Open();
                    DropDownList1.DataSource = cmd0.ExecuteReader();
                    DropDownList1.DataTextField = "order_no";
                    DropDownList1.DataValueField = "order_no";
                    DropDownList1.DataBind();
                    conn.Close();

                    lbl_success.Text = "Order no. : " + orderId + " canceled successfully.";
                }
            }
        }
    }
}
