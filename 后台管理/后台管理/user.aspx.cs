using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 后台管理
{
    public partial class user : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Write("<script>window.top.location='login.aspx'</script>");
            }
            if (!Page.IsPostBack)
            {
                LoadSecondPage();
                LoadHeadData();
                AspNetPager1.PageSize = 10;
                AspNetPager1.RecordCount = GetDataSum();
            }
        }

        private void LoadSecondPage()
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
        /// 得到所有除ID列名
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

        private void LoadHeadData()
        {
            #region 绑定用户表head            
            DataSet ds1 = GetCloumName();
            this.RepHead.DataSource = ds1;
            this.RepHead.DataBind();
            #endregion
        }

        private int GetDataSum()
        {
            string sql = "select * from 用户";
            DataSet ds1 = SqlHelper.Query(sql, AspNetPager1.CurrentPageIndex, AspNetPager1.PageSize);
            int count = ds1.Tables[0].Rows.Count;
            return count;
        }

        private void LoadBodyData()
        {
            string sql;
            #region 绑定用户表body
            sql = "select * from 用户";
            DataSet ds2 = SqlHelper.Query(sql);
            DataTable dt = ds2.Tables[0];
            dt.Columns.Add("编辑");
            dt.Columns.Add("删除");
            foreach (DataRow dr in dt.Rows)
            {
                dr["编辑"] = String.Format("<button onclick='OnEdit(this)'id='{0}' ><i class='icon-edit bigger-120'></i>编辑</button></td>",dr["用户ID"]);
                dr["删除"] = String.Format("<button onclick='OnDelete(this)' id='{0}'><i class='icon-trash bigger-120'></i>删除</button>", dr["用户ID"]);                   
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