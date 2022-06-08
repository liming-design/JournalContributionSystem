using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 后台管理
{
    public partial class perioEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string url = Request.RawUrl;
                string ID = Request.QueryString["id"];
                LoadPage();
            }

        }

        private void LoadPage()
        {
            DataSet ds1 = GetCloumName();
            DataTable dt = ds1.Tables[0];

            dt.Columns.Add("Input");
            foreach (DataRow dr in dt.Rows)
            {
                dr["Input"] = String.Format("<input type = 'text' id = 'input{0}' " +
                    " placeholder = '{0}' name = '{0}'/>", dr["COLUMN_NAME"]);
            }           
            dt.Rows[0].Delete();//ID
            RepPage2.DataSource = ds1;
            RepPage2.DataBind();
        }

        public DataSet GetCloumName()
        {
            string sql;
            sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.columns WHERE TABLE_NAME='期刊'";
            DataSet ds1 = SqlHelper.Query(sql);
            return ds1;
        }

    }
}