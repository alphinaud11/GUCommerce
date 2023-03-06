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
    public partial class PaymentCash : System.Web.UI.Page
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
                //Get the information of the connection to the database
                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

                //create a new connection
                SqlConnection conn = new SqlConnection(connStr);

                /*create a new SQL command which takes as parameters the name of the stored procedure and
                 the SQLconnection name*/
                SqlCommand cmd = new SqlCommand("getOrdersOfCustomer", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@username", username));

                //Executing the SQLCommand
                conn.Open();
                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "order_no";
                DropDownList1.DataValueField = "order_no";
                if (!IsPostBack)
                {
                    DropDownList1.DataBind();
                }
                conn.Close();
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
                SqlCommand cmd0 = new SqlCommand("getOrdersOfCustomer", conn);
                cmd0.CommandType = CommandType.StoredProcedure;
                SqlCommand cmd1 = new SqlCommand("checkPayAmountValid", conn);
                cmd1.CommandType = CommandType.StoredProcedure;
                SqlCommand cmd2 = new SqlCommand("SpecifyAmount", conn);
                cmd2.CommandType = CommandType.StoredProcedure;
                SqlCommand cmd3 = new SqlCommand("returnPoints", conn);
                cmd3.CommandType = CommandType.StoredProcedure;

                //To read the input from the user
                String dropDownSelected = DropDownList1.SelectedValue;

                //pass parameters to the stored procedure
                cmd0.Parameters.Add(new SqlParameter("@username", username));

                if (String.IsNullOrEmpty(dropDownSelected))
                {
                    Response.Redirect("~/NoOrdersToPay.aspx");
                }

                else
                {
                    int orderId = Int32.Parse(dropDownSelected);
                    string cashAmount = txt_cashAmount.Text;

                    decimal cashAmountDecimal = 0;
                    decimal creditAmountDecimal = 0;

                    if (!Decimal.TryParse(cashAmount, out cashAmountDecimal))
                    {
                        Label label = new Label();
                        label.Text = "Please enter a valid decimal amount";
                        label.ForeColor = System.Drawing.Color.Crimson;
                        label.Font.Bold = true;
                        form1.Controls.Add(label);
                    }

                    else
                    {
                        Decimal.TryParse(cashAmount, out cashAmountDecimal);

                        //pass parameters to the stored procedure
                        cmd1.Parameters.Add(new SqlParameter("@username", username));
                        cmd1.Parameters.Add(new SqlParameter("@orderId", orderId));
                        cmd1.Parameters.Add(new SqlParameter("@amount", cashAmountDecimal));

                        //Save the output from the procedure
                        SqlParameter valid = cmd1.Parameters.Add("@valid", SqlDbType.Bit);
                        valid.Direction = ParameterDirection.Output;
                        SqlParameter pointsCanBeUsed = cmd1.Parameters.Add("@pointsCanBeUsed", SqlDbType.Float);
                        pointsCanBeUsed.Direction = ParameterDirection.Output;
                        SqlParameter pointsUsed = cmd1.Parameters.Add("@pointsUsed", SqlDbType.Float);
                        pointsUsed.Direction = ParameterDirection.Output;
                        SqlParameter totalAmount = cmd1.Parameters.Add("@totalAmount", SqlDbType.Float);
                        totalAmount.Direction = ParameterDirection.Output;

                        //Executing the SQLCommand
                        conn.Open();
                        cmd1.ExecuteNonQuery();
                        conn.Close();

                        Boolean validBool = Convert.ToBoolean(cmd1.Parameters["@valid"].Value);

                        if (!validBool)
                        {
                            Label label = new Label();
                            label.Text = "Please enter valid amount. " + "order amount: " + totalAmount.Value + " , points can be used in this order: " + pointsCanBeUsed.Value;
                            label.ForeColor = System.Drawing.Color.Crimson;
                            label.Font.Bold = true;
                            form1.Controls.Add(label);
                        }

                        else
                        {
                            //pass parameters to the stored procedure
                            cmd2.Parameters.Add(new SqlParameter("@customername", username));
                            cmd2.Parameters.Add(new SqlParameter("@orderID", orderId));
                            cmd2.Parameters.Add(new SqlParameter("@cash", cashAmountDecimal));
                            cmd2.Parameters.Add(new SqlParameter("@credit", creditAmountDecimal));
                            cmd2.Parameters.Add(new SqlParameter("@creditCard", DBNull.Value));
                            cmd3.Parameters.Add(new SqlParameter("@username", username));

                            //Save the output from the procedure
                            SqlParameter customerPoints = cmd3.Parameters.Add("@points", SqlDbType.Float);
                            customerPoints.Direction = ParameterDirection.Output;

                            //Executing the SQLCommand
                            conn.Open();
                            cmd2.ExecuteNonQuery();
                            cmd3.ExecuteNonQuery();
                            conn.Close();

                            //Executing the SQLCommand
                            conn.Open();
                            DropDownList1.DataSource = cmd0.ExecuteReader();
                            DropDownList1.DataTextField = "order_no";
                            DropDownList1.DataValueField = "order_no";
                            DropDownList1.DataBind();
                            conn.Close();

                            lbl_success.Text = "Order [ID -> " + orderId + "] paid successfuly.";
                            lbl_pointsUsed.Text = "Points used: " + pointsUsed.Value;
                            lbl_points.Text = "Your current points: " + customerPoints.Value;
                        }
                    }
                }
            }
        }

    }
}
