using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace 后台管理
{
    public partial class _class : System.Web.UI.Page
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
        private int  GetDataSum()
        {
            string sql = "select * from 学科大类";
            DataSet ds1 = SqlHelper.Query(sql);
            int count = ds1.Tables[0].Rows.Count;
            return count;
        }
        private void LoadHeadData()
        {
            string sql;
            #region 绑定学科大类表head
            sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.columns WHERE TABLE_NAME='学科大类'";
            DataSet ds1 = SqlHelper.Query(sql);
            DataTable dt = ds1.Tables[0];
            dt.Rows[0].Delete();//ID
            this.RepHead.DataSource = ds1;
            this.RepHead.DataBind();
            #endregion
        }

        private void LoadBodyData()
        {
            string sql;
            #region 绑定学科大类表body
            sql = "select * from 学科大类";
            DataSet ds = SqlHelper.Query(sql,AspNetPager1.CurrentPageIndex,AspNetPager1.PageSize);
            DataTable dt = ds.Tables[0];
            dt.Columns.Add("编辑");
            dt.Columns.Add("删除");
            foreach (DataRow dr in dt.Rows)
            {
                dr["编辑"] = String.Format("<button id='{0}' onclick='OnEdit(this)'><i class='icon-edit bigger-120'></i>编辑</button>", dr["学科大类ID"]);
                dr["删除"] = String.Format("<button id='{0}' onclick='OnDelete(this)'><i class='icon-trash bigger-120'></i>删除</button>", dr["学科大类ID"]);
            }
            this.Repeater1.DataSource = ds;          
            this.Repeater1.DataBind();
            #endregion           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string fileName = this.FileUpload1.PostedFile.FileName;

            DataSet ds = ReadExcel(fileName, 4);
            Repeater2.DataSource = ds;
            Repeater2.DataBind();
        }

        public DataSet ReadExcel(string filepath, int sheetindex, int m, int n)
        {
            string FilePath = Server.MapPath("~/Files/" + filepath);
            //ExcelPackage.LicenseContext = LicenseContext.NonCommercial;//非商业标识           
            FileInfo file = new FileInfo(FilePath);
            DataSet ds = new DataSet();
            using (ExcelPackage package = new ExcelPackage(file))
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets[sheetindex];//创建worksheet  
                int rows = worksheet.Dimension.End.Row;
                int cols = worksheet.Dimension.End.Column;
                DataTable dt = new DataTable(worksheet.Name);
                DataRow dr = null;
                DataColumn dc = null;
                List<string> colNames = new List<string>();
                string colname = worksheet.Cells[1, m].Value.ToString();
                dt.Columns.Add(colname);
                colname = worksheet.Cells[1, n].Value.ToString();
                dt.Columns.Add(colname);
                string temp;
                for (int i = 2; i <= rows; i++)
                {
                    dr = dt.Rows.Add();
                    if (worksheet.Cells[i, m].Value != null)
                        temp = worksheet.Cells[i, m].Value.ToString();
                    else
                        temp = "";
                    dr[0] = temp;
                    if (worksheet.Cells[i, n].Value != null)
                        temp = worksheet.Cells[i, n].Value.ToString();
                    else
                        temp = "";
                    dr[1] = temp;
                }
                ds.Tables.Add(dt);
            }
            return ds;

        }
        private DataSet ReadExcel(string filepath, int sheetindex)
        {
            string FilePath = Server.MapPath("~/Files/" + filepath);
            //ExcelPackage.LicenseContext = LicenseContext.NonCommercial;//非商业标识           
            FileInfo file = new FileInfo(FilePath);
            DataSet ds = new DataSet();
            using (ExcelPackage package = new ExcelPackage(file))
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets[sheetindex];//创建worksheet                              
                int cols = worksheet.Dimension.End.Column;
                DataTable dt = new DataTable(worksheet.Name);
                DataRow dr = null;
                List<string> colNames = new List<string>();
                dt.Columns.Add("大类名称");
                for (int i = 1; i <= cols; i++)
                {
                    dr = dt.Rows.Add();                    
                    try
                    {
                        if (worksheet.Cells[1, i].Value != null)
                            dr[0]  = worksheet.Cells[1, i].Value.ToString();
                           
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                }
                ds.Tables.Add(dt);
            }
            return ds;
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            LoadBodyData();
        }      
    }
}