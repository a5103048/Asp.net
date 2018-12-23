using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) //登出後 清掉所有紀錄
    {
        Session["Login"] = null;
        Session.Clear();
        Response.Write("<script>alert('登出成功!');location.href='http://140.137.61.163'; </script>");

    }
}