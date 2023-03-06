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
    public partial class ChooseOrderPay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);

            if (String.IsNullOrEmpty(username))
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void next(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);

            if (String.IsNullOrEmpty(username))
            {
                Response.Redirect("~/Login.aspx");
            }

            else
            {
                String dropDownSelected = DropDownList1.SelectedValue;

                if (dropDownSelected.Equals("Cash"))
                {
                    Response.Redirect("~/PaymentCash.aspx");
                }

                if (dropDownSelected.Equals("Credit"))
                {
                    //Get the information of the connection to the database
                    string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

                    //create a new connection
                    SqlConnection conn = new SqlConnection(connStr);

                    /*create a new SQL command which takes as parameters the name of the stored procedure and
                     the SQLconnection name*/
                    SqlCommand cmd = new SqlCommand("CustomerHasCredit", conn);
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
                        Response.Redirect("~/PaymentCredit.aspx");
                    }

                    else
                    {
                        Response.Redirect("~/NoCreditOwned.aspx");
                    }
                }
            }
        }
    }
}
