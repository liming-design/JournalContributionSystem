using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 后台管理
{
    public partial class subEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadSelectData();
            }
            
        }
        private void LoadSelectData()
        {
            string sql;
            #region 绑定select标签
            sql = "select * from 学科大类";
            DataSet ds1 = SqlHelper.Query(sql);
            this.RepSelect.DataSource = ds1;
            this.RepSelect.DataBind();
            #endregion
        }
    }
}