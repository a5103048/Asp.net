using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
            txt_Search.Text = Request.QueryString["Keyword"].ToString();
    }

    protected void btn_Search_Click(object sender, EventArgs e)
    {
        Response.Redirect("Search.aspx?Keyword=" + txt_Search.Text, true);
    }
}