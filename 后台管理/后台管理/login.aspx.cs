using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 后台管理
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string Uname = this.uName.Value;
            string Upwd = this.uPassword.Value;
            if(Uname=="")
            {

            }
            string sql = "select count(*) from 用户 where 账号=@username and 密码=@password";
            SqlParameter[] parameters = new SqlParameter[2];
            parameters[0] = new SqlParameter("username", Uname);
            parameters[1] = new SqlParameter("password", Upwd);
            int result=(int)SqlHelper.GetSingle(sql, parameters);
            if (result == 1)
            {
                Session["User"] = Uname;
                Response.Write("<script>window.top.location='index.aspx'</script>");
                
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('用户名或密码错误！');</script>");
                
            }
        }
    }
}