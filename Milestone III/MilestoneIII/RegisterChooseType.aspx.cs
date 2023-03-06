using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MilestoneIII
{
    public partial class RegisterChooseType : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void next(object sender, EventArgs e)
        {
            String dropDownSelected = DropDownList1.SelectedValue;

            if(dropDownSelected.Equals("Customer"))
            {
                Response.Redirect("~/RegisterCustomer.aspx");
            }

            if (dropDownSelected.Equals("Vendor"))
            {
                Response.Redirect("~/RegisterVendor.aspx");
            }
        }

    }
}
