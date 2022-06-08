using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 后台管理
{
    public partial class navigate : System.Web.UI.Page
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

            ds = GetCoreDs();
            Databind(ds, RepShort);
        }

        private DataSet GetCoreInfo()
        {
            string sql = "select  缩写 from 核心期刊数据库 where 优先级!='0' order by 优先级 ";
            DataSet ds = SqlHelper.Query(sql);
            return ds;
        }

        private void Databind(DataSet ds, Repeater rep)
        {
            rep.DataSource = ds;
            rep.DataBind();
        }

        private DataSet GetCoreDs()
        {
            DataSet ds1 = GetCoreInfo();
            //DataTable dt1 = ds1.Tables[0];
            //DataRow dr1 = dt1.NewRow();
            //dr1[0] = "全部";
            //dt1.Rows.InsertAt(dr1, 0);
            return ds1;
        }

        private DataSet GetClassDs()
        {
            DataSet ds1 = GetClassInfo();
            DataTable dt1 = ds1.Tables[0];
            DataRow dr1 = dt1.NewRow();
            dr1[1] = "全部";
            dt1.Rows.InsertAt(dr1, 0);
            return ds1;
        }

        private DataSet GetClassInfo()
        {
            string sql = "select * from 学科大类";
            DataSet ds = SqlHelper.Query(sql);
            return ds;
        }
    }
}