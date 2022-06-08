using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 后台管理
{
    public partial class perioDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string url = Request.RawUrl;
                string name = Request.QueryString["name"];
                LoadPage(name);
            }
        }

        private void LoadPage(string name)
        {
            DataSet ds1 = GetCloumName();
            DataSet ds2 = GetPerioInfo(name);
            DataTable dt1 = ds1.Tables[0];
            DataTable dt2 = ds2.Tables[0];
            dt1.Columns.Add("value");            
            int i = 0;
            foreach (DataRow dr in dt1.Rows)
            {
                string t=dt2.Rows[0].ItemArray[i].ToString();
                string cname = dr["COLUMN_NAME"].ToString();
                string cn = cname.Substring(cname.Length - 2, 2);
              if ((cn == "地址"&&cname!="邮寄地址") ||cn=="链接")
               {
                    if (t != "")
                        dr["value"] = String.Format("<a href='{0}' target='_blank'>{1}</a>", t, dr["COLUMN_NAME"].ToString());
                    else
                        dr["value"] = "待完善";
                }
                else
                {
                    dr["value"] = t;
                }                
                i++;
            }
            string coredatabase = GetCoreDatabaseByPerioName(name);
            DataRow dr1 = dt1.NewRow();
            dr1[0]= "核心数据库收录";
            dr1[1]= coredatabase;
            dt1.Rows.Add(dr1);
            dt1.Rows[0].Delete();//ID
            RepPage2.DataSource = ds1;
            RepPage2.DataBind();
        }

        private string GetCoreDatabaseByPerioName(string name)
        {
            string perioID = GetIdByName("期刊", name);
            string result="";
            string sql = String.Format("select * from 核心期刊数据库 where 核心期刊数据库ID in (select 核心期刊数据库ID from 收录关系 where 期刊ID='{0}')", perioID);
            DataSet ds = SqlHelper.Query(sql);
            DataTable dt = ds.Tables[0];
            foreach(DataRow dr in dt.Rows)
            {
                result +=(dr["核心期刊数据库名称"].ToString()+"；") ;
            }
            return result;
        }

        private DataSet GetPerioInfo(string name)
        {
            string sql = String.Format("select * from 期刊 where 期刊名称='{0}'", name);
            DataSet ds1 = SqlHelper.Query(sql);
            return ds1;
        }
        public string GetIdByName(string TableName, string Name)
        {
            string sql = String.Format("select {0}ID from {0} where {0}名称='{1}'", TableName, Name);
            string result = "";
            DataSet ds = SqlHelper.Query(sql);
            if (ds.Tables[0].Rows.Count > 0)
            {
                result = ds.Tables[0].Rows[0].ItemArray[0].ToString();
            }
            return result;
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