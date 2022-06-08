using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 后台管理
{
    public partial class perioDatabase : System.Web.UI.Page
    {

        public class Info
        {
            public static string ID;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Info.ID = Request.QueryString["id"];
                LoadFirstPage();             
                LoadSecondPage();
            }
        }

        private void LoadFirstPage()
        {
            AspNetPager1.PageSize = 9;
            AspNetPager1.RecordCount = GetIncludeSum();
            DataSet ds1 = GetCloumName();
            RepHead.DataSource = ds1;
            RepHead.DataBind();
        }

        private void LoadSecondPage()
        {

            AspNetPager2.PageSize = 9;
            AspNetPager2.RecordCount = GetNotIncludeSum();
            DataSet ds = GetCloumName();
            LoadData(Repeater1, ds);

        }

        /// <summary>
        /// 得到除了ID的所有列名
        /// </summary>
        /// <returns></returns>
        public DataSet GetCloumName()
        {
            string sql;
            sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.columns WHERE TABLE_NAME='核心期刊数据库'";
            DataSet ds1 = SqlHelper.Query(sql);
            DataTable dt = ds1.Tables[0];
            dt.Rows.Remove(dt.Rows[0]);
            return ds1;
        }
        private int GetNotIncludeSum()
        {
            string sql = String.Format("select count(*) from 核心期刊数据库 where 核心期刊数据库ID not in " +
                " (select 核心期刊数据库ID from 收录关系 where 期刊ID='{0}')", Info.ID);
            int count = (int)SqlHelper.GetSingle(sql);
            return count;
        }

        private int GetIncludeSum()
        {
            string sql = String.Format("select count(*) from 核心期刊数据库 where 核心期刊数据库ID  in " +
                " (select 核心期刊数据库ID from 收录关系 where 期刊ID='{0}')", Info.ID);
            int count = (int)SqlHelper.GetSingle(sql);
            return count;
        }
  

        private void LoadData(Repeater Rep, DataSet ds)
        {
            Rep.DataSource = ds;
            Rep.DataBind();
        }


        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            DataSet ds = GetIncludeCoredatabase();
            LoadData(Repbody, ds);
        }
        protected void AspNetPager2_PageChanged(object sender, EventArgs e)
        {
            DataSet ds = GetNotIncludeCoredatabase();
            LoadData(Repeater2, ds);
        }


        private DataSet GetIncludeCoredatabase()
        {
            string sql;
            sql = String.Format("select * from 核心期刊数据库 where 核心期刊数据库ID in " +
                " (select 核心期刊数据库ID from 收录关系 where 期刊ID='{0}')",Info.ID);
            DataSet ds2 = SqlHelper.Query(sql, AspNetPager1.CurrentPageIndex, AspNetPager1.PageSize);
            DataTable dt = ds2.Tables[0];
            dt.Columns.Add("删除");
            foreach (DataRow dr in dt.Rows)
            {
                dr["删除"] = String.Format("<button id='{0}' onclick='OnDelete(this)'><i class='icon - trash bigger - 120'></i>删除</button>", dr["核心期刊数据库ID"]);
            }
            return ds2;
        }

        private DataSet GetNotIncludeCoredatabase()
        {
            string sql;
            sql = String.Format("select * from 核心期刊数据库 where 核心期刊数据库ID not in " +
                " (select 核心期刊数据库ID from 收录关系 where 期刊ID='{0}')", Info.ID);
            DataSet ds2 = SqlHelper.Query(sql, AspNetPager2.CurrentPageIndex, AspNetPager2.PageSize);
            DataTable dt = ds2.Tables[0];
            dt.Columns.Add("添加");
            foreach (DataRow dr in dt.Rows)
            {
                dr["添加"] = String.Format("<button id='{0}' onclick='OnAdd(this)'><i class='icon - plus bigger - 120'></i>添加</button>", dr["核心期刊数据库ID"]);
            }
            return ds2;
        }
        
    }

    }