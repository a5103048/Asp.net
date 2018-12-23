using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ContactUs : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
    SqlCommand sqlcommand;
    SqlDataReader dr = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        if (txt_Name.Text != string.Empty || txt_Email.Text != string.Empty || txt_Content.Text != string.Empty)
        {
            string ID = DateTime.Now.ToString("yyyyMMddHHmmss");//以日期時間(年月日時分秒)作為ID儲存

            conn.Open();
            if (FileUpload_Img.HasFile)//若有包含圖片
            {
                String fileExtension = System.IO.Path.GetExtension(FileUpload_Img.FileName).ToLower();//得到檔的尾碼
                String allowedExtensions = ".jpg";//允許檔的尾碼

                //看包含的檔是否是被允許的檔的尾碼
                if (fileExtension == allowedExtensions)//若為允許的尾碼(.jpg)，則上傳
                {
                    
                    FileUpload_Img.SaveAs(Server.MapPath("ContactUsImg/" + ID + ".jpg"));

                    sqlcommand = new SqlCommand("INSERT INTO [ContactUs] VALUES('" +
                        ID + "','" +
                        txt_Name.Text + "','" +
                        txt_Email.Text + "','" +
                        txt_Content.Text + "','" +
                        "ContactUsImg/" + ID + ".jpg" + "')", conn);
                    sqlcommand.ExecuteNonQuery();
                }
                else//若為非允許的尾碼(.jpg)，則拒絕上傳
                {
                    Response.Write("<script>alert('只能上傳jpg圖像檔喔！');</script>");
                    conn.Close();
                    return;
                } 
            }
            else//若無包含圖片
            {
                sqlcommand = new SqlCommand("INSERT INTO [ContactUs] VALUES('" +
                    ID + "','" +
                    txt_Name.Text + "','" +
                    txt_Email.Text + "','" +
                    txt_Content.Text + "',NULL)", conn);
                sqlcommand.ExecuteNonQuery();
            }

            conn.Close();
            //提醒用戶訊息以傳送成功，並導向回首頁
            Response.Write("<script>alert('您的訊息以傳送成功囉!\\n我們將會盡快回復您。');location.href='index.aspx'; </script>");
        }
        else
            Response.Write("<script>alert('錯誤\\n下方姓名,Email,內容等皆須填寫不可空白喔!');</script>");
    }
}