using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 后台管理
{
    public partial class userEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadPage();               
        }
        private void LoadPage()
        {
            DataSet ds1 = GetCloumName();
            DataTable dt = ds1.Tables[0];

            dt.Columns.Add("Input");
            foreach (DataRow dr in dt.Rows)
            {
                dr["Input"] = String.Format("<input type = 'text' id = '{0}' " +
                    "required placeholder = '{0}' name = '{1}'/>", dr["COLUMN_NAME"], dr["COLUMN_NAME"], dr["COLUMN_NAME"]);
            }

            RepPage2.DataSource = ds1;
            RepPage2.DataBind();

        }

        /// <summary>
        /// 得到除了ID的所有列名
        /// </summary>
        /// <returns></returns>
        public DataSet GetCloumName()
        {
            string sql;
            sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.columns WHERE TABLE_NAME='用户'";
            DataSet ds1 = SqlHelper.Query(sql);
            DataTable dt = ds1.Tables[0];
            dt.Rows.Remove(dt.Rows[0]);
            return ds1;
        }

    }
}