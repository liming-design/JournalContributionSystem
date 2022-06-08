using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.IO.Packaging;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml.Drawing;
using OfficeOpenXml.Drawing.Chart;
using OfficeOpenXml.Style;
using Microsoft.JScript;
using System.Windows.Forms;

namespace 后台管理
{
    public partial class periodical : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Write("<script>window.top.location='login.aspx'</script>");
            }
            if (!Page.IsPostBack)
            {
               
                LoadFirstPage();
                LoadSecondPage();
                LoadThirdPage();   
            }
        }

       
        private void LoadFirstPage()
        {
            AspNetPager1.PageSize = 9;
            AspNetPager1.RecordCount = GetDataSum();
            DataSet ds1 = GetCloumName();
            DataTable dt = ds1.Tables[0]; 
            
            dt.Rows[0].Delete();//ID
           
            for (int i=8;i<dt.Rows.Count;i++)//删除后面几项的列名
            {
                dt.Rows[i].Delete();
            }
            RepHead.DataSource = ds1;
            RepHead.DataBind();
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
            dt.Rows[0].Delete();//ID
            RepPage2.DataSource = ds1;
            RepPage2.DataBind();
        }

        private void LoadThirdPage()
        {

            DataSet ds1 = GetCloumName();
            DataTable dt = ds1.Tables[0];

            dt.Rows[0].Delete();
            RepHead1.DataSource = ds1;
            RepHead1.DataBind();//表头数据
        }

        public DataSet GetCloumName()
        {
            string sql;
            sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.columns WHERE TABLE_NAME='期刊'";
            DataSet ds1 = SqlHelper.Query(sql);
            return ds1;
        }

        /// <summary>
        /// 获取数据总数，分页时需要
        /// </summary>
        /// <returns></returns>
        private int GetDataSum()
        {
            string sql = "select * from 期刊";
            DataSet ds1 = SqlHelper.Query(sql);
            int count = ds1.Tables[0].Rows.Count;
            return count;
        }
        
        /// <summary>
        /// 得到所有的期刊信息，并加上编辑删除按钮
        /// </summary>
        /// <returns></returns>
        private DataSet GetAllPerio()
        {
            string sql;
            #region 绑定学科表body
            sql = "select * from 期刊";
            DataSet ds2 = SqlHelper.Query(sql, AspNetPager1.CurrentPageIndex, AspNetPager1.PageSize);
            DataTable dt = ds2.Tables[0];
            dt.Columns.Add("所属学科");
            dt.Columns.Add("所属数据库");
            dt.Columns.Add("编辑");
            dt.Columns.Add("删除");
            foreach (DataRow dr in dt.Rows)
            {
                dr["所属学科"] = String.Format("<button id='{0}' onclick='OnSubject(this)'><i class='icon - edit bigger - 120'></i>详情</button>", dr["期刊ID"]);
                dr["所属数据库"] = String.Format("<button id='{0}' onclick='OnDatabase(this)'><i class='icon - edit bigger - 120'></i>详情</button>", dr["期刊ID"]);
                dr["编辑"] = String.Format("<button id='{0}' onclick='OnEdit(this)'><i class='icon - edit bigger - 120'></i>编辑</button>", dr["期刊ID"]);
                dr["删除"] = String.Format("<button id='{0}' onclick='OnDelete(this)'><i class='icon - trash bigger - 120'></i>删除</button>", dr["期刊ID"]);
            }
            return ds2;
        }

        private void LoadBodyData(DataSet ds2)
        {       
            this.Repbody.DataSource = ds2;
            this.Repbody.DataBind();
            #endregion
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string fileName = this.FileUpload1.PostedFile.FileName;
            DataSet ds= ReadExcel(fileName);
            Repeater2.DataSource = ds;
            Repeater2.DataBind();
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            DataSet ds2 = GetAllPerio();
            LoadBodyData(ds2);
        }


        

        
        /// <summary>
        /// 读excel文件返回dataset,epplus方法
        /// </summary>
        private DataSet ReadExcel(string filepath)
        {
            string FilePath = Server.MapPath("~/Files/" + filepath);
            //ExcelPackage.LicenseContext = LicenseContext.NonCommercial;//非商业标识           
            FileInfo file = new FileInfo(FilePath);
            DataSet ds = new DataSet();
            using (ExcelPackage package = new ExcelPackage(file)) 
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets[0];//创建worksheet                              
                int rows= worksheet.Dimension.End.Row;
                int cols = worksheet.Dimension.End.Column;
                DataTable dt = new DataTable(worksheet.Name);
                DataRow dr = null;
                DataColumn dc = null;
                List<string> colNames = new List<string>();
                for(int i=1;i<=cols;i++)
                {
                    string colname = worksheet.Cells[1,i].Value.ToString();
                    colNames.Add(colname);
                    dt.Columns.Add(colname);
                }
                object a = worksheet.Cells[1, 1].Value;
                string temp;
                for (int i = 2; i <= rows; i++)
                {
                    dr = dt.Rows.Add();  
                    for (int j = 1; j <= cols; j++)
                    {
                        try
                        {
                            if(worksheet.Cells[i, j].Value!=null)
                                temp = worksheet.Cells[i, j].Value.ToString();
                            else
                                temp = "";
                            dr[j - 1] = temp;
                        }
                        catch (Exception ex)
                        {

                            MessageBox.Show(ex.Message);
                        }
                    }

                }
                
                ds.Tables.Add(dt);
            }
            return ds;
            
        }

        /// <summary>
        /// OleDbDataAdapter读取excel
        /// </summary>
        /// <param name="filePath"></param>
        /// <param name="tablename"></param>
        /// <returns></returns>
        private DataSet createDataSource(string filePath, string tablename)
        {
            string strCon;
            strCon = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/Files/" + filePath) + ";Extended Properties=Excel 8.0;";
            OleDbConnection con = new OleDbConnection(strCon);
            //string sql = "select * from [人文社科期刊$]";
            OleDbDataAdapter da = new OleDbDataAdapter("select * from [人文社科期刊$]", con);
            DataSet ds = new DataSet();
            //= ExcelQuery(strCon,sql, AspNetPager1.CurrentPageIndex, AspNetPager1.PageSize);

            da.Fill(ds);
            DataTable dt = ds.Tables[0];
            foreach (DataRow dr in dt.Rows)
            {


            }
            return ds;
        }
        /// <summary>
        /// 从excel中查询数据数据带分页功能,OleDbDataAdapter
        /// </summary>
        /// <param name="strCon"></param>
        /// <param name="SQLString"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        public static DataSet ExcelQuery(string strCon, string SQLString, int pageIndex, int pageSize)
        {
            using (OleDbConnection con = new OleDbConnection(strCon))
            {
                DataSet ds = new DataSet();
                try
                {
                    con.Open();
                    OleDbDataAdapter command = new OleDbDataAdapter(SQLString, con);
                    command.Fill(ds, (pageIndex - 1) * pageSize, pageSize, "ds");
                }
                catch (OleDbException ex)
                {
                    throw new Exception(ex.Message);
                }
                return ds;
            }
        }
    }
}