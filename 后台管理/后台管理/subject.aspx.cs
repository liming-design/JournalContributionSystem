using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace 后台管理
{
    public partial class subject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Write("<script>window.top.location='login.aspx'</script>");
            }
            if (!Page.IsPostBack)
            {                              
                LoadSelectData();
                AspNetPager1.PageSize = 10;
                AspNetPager1.RecordCount = GetDataSum();             
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

        private int GetDataSum()
        {
            string sql = "select count(*) from 学科";
            int count = (int)SqlHelper.GetSingle(sql);       
            return count;
        }
        
        public void LoadBodyData()
        {
            string sql;
            #region 绑定学科表body
            sql = "select 学科ID,学科名称, 学科大类名称 as 学科所属类,优先级 from 学科,学科大类 where 学科.学科大类ID=学科大类.学科大类ID order by '优先级'";
            DataSet ds = SqlHelper.Query(sql, AspNetPager1.CurrentPageIndex, AspNetPager1.PageSize);
            DataTable dt = ds.Tables[0];
            dt.Columns.Add("编辑");
            dt.Columns.Add("删除");
            foreach (DataRow dr in dt.Rows)
            {               
                dr["编辑"] = String.Format("<button id='{0}' onclick='OnEdit(this)'><i class='icon - edit bigger - 120'></i>编辑</button>", dr["学科ID"]);
                dr["删除"] = String.Format("<button id='{0}' onclick='OnDelete(this)'><i class='icon - trash bigger - 120'></i>删除</button>",dr["学科ID"]);       
            }
            this.Repbody.DataSource = ds;
            this.Repbody.DataBind();
            #endregion
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            LoadBodyData();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string fileName = this.FileUpload1.PostedFile.FileName;

            DataSet ds = ReadExcel(fileName, 4);
            Repeater2.DataSource = ds;
            Repeater2.DataBind();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string fileName = this.FileUpload2.PostedFile.FileName;
            DataSet ds = ReadExcel(fileName, 2,3);
            Repeater42.DataSource = ds;
            Repeater42.DataBind();
        }

        public DataSet ReadExcel(string filepath, int sheetindex1, int sheetindex2)
        {
            string FilePath = Server.MapPath("~/Files/" + filepath);
            //ExcelPackage.LicenseContext = LicenseContext.NonCommercial;//非商业标识           
            FileInfo file = new FileInfo(FilePath);
            DataSet ds = new DataSet();
            using (ExcelPackage package = new ExcelPackage(file))
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets[sheetindex1];//创建worksheet  
                int rows = worksheet.Dimension.End.Row;
                int cols = worksheet.Dimension.End.Column;
                DataTable dt = new DataTable(worksheet.Name);
                dt.Columns.Add("期刊名称");
                dt.Columns.Add("学科名称");
                DataRow dr = null;
                string subjectname;
                for (int j = 1; j <= cols; j++)
                {
                    subjectname= worksheet.Cells[1, j].Value.ToString();
                    for (int i = 2; i <= rows; i++)
                    {
                        if (worksheet.Cells[i, j].Value != null)
                        {
                            dr = dt.Rows.Add();
                            dr[0] = worksheet.Cells[i, j].Value.ToString();
                            dr[1] = subjectname;
                        }
                    }
                }
                worksheet = package.Workbook.Worksheets[sheetindex2];
                rows = worksheet.Dimension.End.Row;
                cols = worksheet.Dimension.End.Column;
                for (int j = 1; j <= cols; j++)
                {
                    subjectname = worksheet.Cells[1, j].Value.ToString();
                    for (int i = 2; i <= rows; i++)
                    {
                        if (worksheet.Cells[i, j].Value != null)
                        {
                            dr = dt.Rows.Add();
                            dr[0] = worksheet.Cells[i, j].Value.ToString();
                            dr[1] = subjectname;
                        }
                    }
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
                int rows = worksheet.Dimension.End.Row;
                int cols = worksheet.Dimension.End.Column;
                DataTable dt = new DataTable(worksheet.Name);
                DataRow dr = null;
                dt.Columns.Add("学科名称");
                dt.Columns.Add("学科大类名称");
                string classname;
                for(int j=1;j<=cols;j++)
                {
                    classname = worksheet.Cells[1, j].Value.ToString();
                    
                    for (int i=2;i<=rows;i++)
                    {
                        if (worksheet.Cells[i, j].Value != null)
                        {
                            dr = dt.Rows.Add();                            
                            dr[0] = worksheet.Cells[i, j].Value.ToString();
                            dr[1] = classname;
                        } 
                    }
                }
                ds.Tables.Add(dt);
            }
            
            return ds;

        }
    }
}