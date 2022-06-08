using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 后台管理
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadMyPage();
            }
        }

        private void LoadMyPage()
        {                       
            DataSet ds = GetClassDs();      
            Databind(ds, Repsubclass);

            ds = GetSubDs();
            Databind(ds, Repsub);

            ds = GetDateInfo();
            Databind(ds, RepDate);

            ds = GetCoreInfo();
            Databind(ds, RepShort);

            ds = GetperioWay();
            Databind(ds, RepWay);
        }

        private DataSet GetperioWay()
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("投稿方式", typeof(string)));
            
            string[] t = new string[] { "在线投稿", "邮箱投稿", "邮寄投稿"};
            for(int i=0;i<t.Length;i++)
            {
                DataRow dr = dt.NewRow();
                dr["投稿方式"] =t[i];
                dt.Rows.Add(dr);
            }
            ds.Tables.Add(dt);
            return ds;
        }

        private DataSet GetCoreInfo()
        {
            string sql = "select  缩写 from 核心期刊数据库 where 优先级!='0' order by 优先级 ";
            DataSet ds = SqlHelper.Query(sql);
            return ds;
        }
 
        private DataSet GetDateInfo()
        {
            //string sql = "select distinct 出版周期 from 期刊 ";
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("出版周期", typeof(string)));

            string[] t = new string[] { "旬刊", "半月刊", "月刊","双月刊","季刊","年刊" };
            for (int i = 0; i < t.Length; i++)
            {
                DataRow dr = dt.NewRow();
                dr["出版周期"] = t[i];
                dt.Rows.Add(dr);
            }
            ds.Tables.Add(dt);

            
            return ds;
        }

        private DataSet GetSubDs()
        {
            DataSet ds2 = GetSubjectInfo();
            DataTable dt2 = ds2.Tables[0];
            DataRow dr2 = dt2.NewRow();
            dr2[1] = "不限";
            dt2.Rows.InsertAt(dr2, 0);
            return ds2;
        }

        private DataSet GetClassDs()
        {
            DataSet ds1 = GetClassInfo();
            DataTable dt1 = ds1.Tables[0];
            DataRow dr1 = dt1.NewRow();
            dr1[1] = "不限";
            dt1.Rows.InsertAt(dr1, 0);
            return ds1;
        }

        private DataSet GetWay()
        {
            string sql = "select distinct 投稿方式 from 期刊 ";
            DataSet ds = SqlHelper.Query(sql);
            return ds;
        }
        private DataSet GetCoreDatabase()
        {
            string sql = "select 缩写 from 核心期刊数据库";
            DataSet ds = SqlHelper.Query(sql);
            return ds;
        }
        private DataSet GetSubjectInfo()
        {
            string sql = "select * from 学科";
            DataSet ds = SqlHelper.Query(sql);
            return ds;
        }
        private DataSet GetClassInfo()
        {
            string sql = "select * from 学科大类";
            DataSet ds = SqlHelper.Query(sql);
            return ds;
        }
        private void Databind(DataSet ds,Repeater rep)
        {
            rep.DataSource = ds;
            rep.DataBind();
        }

    }
}