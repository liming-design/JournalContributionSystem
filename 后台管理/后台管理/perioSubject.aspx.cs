using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 后台管理
{
    public partial class perio_subject : System.Web.UI.Page
    {
        public string ID;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ID = Request.QueryString["id"];
                LoadFirstPage();
                LoadSecondPage();
                
            }
        }

        private void LoadFirstPage()
        {
            AspNetPager1.PageSize = 10;
            AspNetPager1.RecordCount = GetIncludeSum();
        }

        private void LoadSecondPage()
        {
            AspNetPager2.PageSize = 10;
            AspNetPager2.RecordCount = GetNotIncludeSum();
        }

        private int GetIncludeSum()
        {
            string sql = String.Format("select count(*) from 学科 where 学科ID in (select 学科ID from 学科期刊关系 where 期刊ID='{0}')",ID);
            int count = (int)SqlHelper.GetSingle(sql);
            return count;
        }

       

        private int GetNotIncludeSum()
        {
            string sql = String.Format("select count(*) from 学科 where 学科ID not in (select 学科ID from 学科期刊关系 where 期刊ID='{0}')", ID);
            int count = (int)SqlHelper.GetSingle(sql);
            return count;
        }

     

        
        public void LoadData(Repeater Rep,DataSet dataSet)
        {
            Rep.DataSource = dataSet;
            Rep.DataBind();
        }

        public DataSet GetInclude()
        {
            string sql;
            #region 绑定学科表body
            sql = String.Format("select 学科ID,学科名称, 学科大类名称 as 学科所属类 from 学科,学科大类" +
                " where 学科.学科大类ID=学科大类.学科大类ID and 学科ID in (select 学科ID from " +
                "学科期刊关系 where 期刊ID='{0}')",ID);
            DataSet ds = SqlHelper.Query(sql, AspNetPager1.CurrentPageIndex, AspNetPager1.PageSize);
            DataTable dt = ds.Tables[0];
            dt.Columns.Add("删除");
            foreach (DataRow dr in dt.Rows)
            {
                dr["删除"] = String.Format("<button id='{0}' onclick='OnDelete(this)'><i class='icon - trash bigger - 120'></i>删除</button>", dr["学科ID"]);
            }
            return ds;
            #endregion
        }

        public DataSet GetNotInclude()
        {
            string sql;
            #region 绑定学科表body
            sql = String.Format("select 学科ID,学科名称, 学科大类名称 as 学科所属类 from 学科,学科大类" +
                " where 学科.学科大类ID=学科大类.学科大类ID and 学科ID not in (select 学科ID from " +
                "学科期刊关系 where 期刊ID='{0}')", ID);
            DataSet ds = SqlHelper.Query(sql, AspNetPager2.CurrentPageIndex, AspNetPager2.PageSize);
            DataTable dt = ds.Tables[0];

            dt.Columns.Add("添加");
            foreach (DataRow dr in dt.Rows)
            {
                dr["添加"] = String.Format("<button id='{0}' onclick='OnAdd(this)'><i class='icon - trash bigger - 120'></i>添加</button>", dr["学科ID"]);
            }
            return ds;
            #endregion
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            DataSet ds = GetInclude();
            LoadData(Repbody, ds);
        }

        protected void AspNetPager2_PageChanged(object sender, EventArgs e)
        {
            DataSet ds = GetNotInclude();
            LoadData(Repeater1, ds);
        }



    }
}