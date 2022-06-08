using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 后台管理
{
    public partial class message : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Write("<script>window.top.location='login.aspx'</script>");
            }
            if (!Page.IsPostBack)
            {
                LoadHeadData();
                AspNetPager1.PageSize = 10;
                AspNetPager1.RecordCount = GetDataSum();
            }
        }

        private int GetDataSum()
        {
            string sql = "select * from 留言";
            DataSet ds1 = SqlHelper.Query(sql);
            int count = ds1.Tables[0].Rows.Count;
            return count;
        }

        private void LoadHeadData()
        {
            string sql;
            #region 绑定留言表head
            sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.columns WHERE TABLE_NAME='留言'";
            DataSet ds1 = SqlHelper.Query(sql);
            DataTable dt = ds1.Tables[0];
            dt.Rows[0].Delete();
            this.RepHead.DataSource = ds1;
            this.RepHead.DataBind();
            #endregion
        }

        private void LoadBodyData()
        {
            string sql;
            #region 绑定留言表body
            sql = "select * from 留言";
            DataSet ds2 = SqlHelper.Query(sql,AspNetPager1.CurrentPageIndex, AspNetPager1.PageSize);
            DataTable dt = ds2.Tables[0];           
            dt.Columns.Add("删除");
            foreach (DataRow dr in dt.Rows)
            {
                dr["删除"] = String.Format("<button id='{0}' onclick='OnDelete(this)'><i class='icon-trash bigger-120'></i>删除</button>", dr["留言ID"]);
            }
            this.Repbody.DataSource = ds2;
            this.Repbody.DataBind();
            #endregion
        }
        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            LoadBodyData();
        }
    }
}