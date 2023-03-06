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
    public partial class Order : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);

            if (String.IsNullOrEmpty(username))
            {
                Response.Redirect("~/Login.aspx");
            }

            else
            {
                if(!IsPostBack)
                {
                    //Get the information of the connection to the database
                    string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

                    //create a new connection
                    SqlConnection conn = new SqlConnection(connStr);

                    /*create a new SQL command which takes as parameters the name of the stored procedure and
                     the SQLconnection name*/
                    SqlCommand cmd0 = new SqlCommand("itemsCount", conn);
                    cmd0.CommandType = CommandType.StoredProcedure;

                    //pass parameters to the stored procedure
                    cmd0.Parameters.Add(new SqlParameter("@username", username));

                    //Save the output from the procedure
                    SqlParameter count = cmd0.Parameters.Add("@count", SqlDbType.Int);
                    count.Direction = ParameterDirection.Output;

                    //Executing the SQLCommand
                    conn.Open();
                    cmd0.ExecuteNonQuery();
                    conn.Close();

                    if (count.Value.ToString().Equals("0"))
                    {
                        Response.Redirect("~/OrderFail.aspx");
                    }

                    else
                    {
                        /*create a new SQL command which takes as parameters the name of the stored procedure and
                     the SQLconnection name*/
                        SqlCommand cmd1 = new SqlCommand("calculatepriceOrder", conn);
                        cmd1.CommandType = CommandType.StoredProcedure;
                        SqlCommand cmd2 = new SqlCommand("makeOrder", conn);
                        cmd2.CommandType = CommandType.StoredProcedure;
                        SqlCommand cmd3 = new SqlCommand("getOrderId", conn);
                        cmd3.CommandType = CommandType.StoredProcedure;

                        //pass parameters to the stored procedure
                        cmd1.Parameters.Add(new SqlParameter("@customername", username));
                        cmd2.Parameters.Add(new SqlParameter("@customername", username));
                        cmd3.Parameters.Add(new SqlParameter("@username", username));

                        //Save the output from the procedure
                        SqlParameter sum = cmd1.Parameters.Add("@sum", SqlDbType.Float);
                        sum.Direction = ParameterDirection.Output;
                        SqlParameter orderId = cmd3.Parameters.Add("@orderId", SqlDbType.Int);
                        orderId.Direction = ParameterDirection.Output;

                        //Executing the SQLCommand
                        conn.Open();
                        cmd1.ExecuteNonQuery();
                        cmd2.ExecuteNonQuery();
                        cmd3.ExecuteNonQuery();
                        conn.Close();

                        lbl_success.Text = "Order created successfully.";
                        lbl_orderID.Text = "Order ID: " + orderId.Value;
                        lbl_totalAmount.Text = "Total amount: " + sum.Value;
                    }
                }
            }
        }
    }
}
