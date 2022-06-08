using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 后台管理
{
    public partial class subNavigation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadPage();
            }
        }
        protected void Databind(DataSet ds,Repeater rep)
        {
            rep.DataSource = ds;
            rep.DataBind();
        }
        private void LoadPage()
        {
            DataSet ds = GetsubClassDs();
            Databind(ds, Rep1);
        }

        protected DataSet GetsubClassDs()
        {
            DataSet ds = GetsubClassInfo();
            DataTable dt = ds.Tables[0];
            dt.Columns.Add("html");
            int i = 0;
            foreach(DataRow dr in dt.Rows)
            {
                string id = "coll" + i;
                dr["html"] = String.Format("<div  class='mypanel panel panel-default'>" +
                    "<div class='panel-heading'style='background-color:#BDC0C9;' data-toggle='collapse'  data-target='#{0}'>" +
                    "<h4 class='panel-title'name='title' >{1}</h4></div>" +
                    "<div id='{0}' class='panel-collapse collapse in'>" +
                    "<div class='panel-body'name='panelbody' ></div></div></div>",id,dr["学科大类名称"]);
                i++;
               
            }
            return ds;
        }

        private DataSet GetsubClassInfo()
        {
            string sql = "select * from 学科大类 ";
            DataSet ds = SqlHelper.Query(sql);
            return ds;
        }
    }
}