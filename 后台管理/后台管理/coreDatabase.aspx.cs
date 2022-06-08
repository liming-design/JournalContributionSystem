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
    public partial class coreDatabase : System.Web.UI.Page
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
            
            RepHead.DataSource = ds1;
            RepHead.DataBind();
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
        private int GetDataSum()
        {
            string sql = "select * from 核心期刊数据库";
            DataSet ds1 = SqlHelper.Query(sql);
            int count = ds1.Tables[0].Rows.Count;
            return count;
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

            RepPage2.DataSource = ds1;
            RepPage2.DataBind();

        }


        private void LoadThirdPage()
        {

            DataSet ds1 = GetCloumName();
            DataTable dt = ds1.Tables[0];
            RepHead1.DataSource = ds1;
            RepHead1.DataBind();//表头数据
        }
        private void LoadBodyData(DataSet ds2)
        {
            this.Repbody.DataSource = ds2;
            this.Repbody.DataBind();

        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            DataSet ds2 = GetAllCoredatabase();
            LoadBodyData(ds2);
        }
        private DataSet GetAllCoredatabase()
        {
            string sql;
            sql = "select * from 核心期刊数据库 order by 优先级";
            DataSet ds2 = SqlHelper.Query(sql, AspNetPager1.CurrentPageIndex, AspNetPager1.PageSize);
            DataTable dt = ds2.Tables[0];
            dt.Columns.Add("编辑");
            dt.Columns.Add("删除");
            foreach (DataRow dr in dt.Rows)
            {
                dr["编辑"] = String.Format("<button id='{0}' onclick='OnEdit(this)'><i class='icon-edit bigger-120'></i>编辑</button>", dr["核心期刊数据库ID"]);
                dr["删除"] = String.Format("<button id='{0}' onclick='OnDelete(this)'><i class='icon-trash bigger-120'></i>删除</button>", dr["核心期刊数据库ID"]);
            }
            return ds2;
        }
        /// <summary>
        /// 防止报错必须放在runat="server"窗体内 https://www.jb51.net/article/21635.htm
        /// 查找MSDN说明，该函数的作用在于:确认在运行时为指定的 ASP.NET 移动控件呈现 Form 控件。
        /// </summary>
        /// <param name="control"></param>
        //public override void VerifyRenderingInServerForm(System.Web.UI.Control control)
        //{ }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string fileName = this.FileUpload1.PostedFile.FileName;

            DataSet ds = ReadExcel(fileName,1);
            Repeater2.DataSource = ds;
            Repeater2.DataBind();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string fileName = this.FileUpload2.PostedFile.FileName;
            DataSet ds = ReadExcel(fileName,0,1,9);
            Repeater42.DataSource = ds;
            Repeater42.DataBind();
        }
        /// <summary>
        /// 读m和n列的内容
        /// </summary>
        /// <param name="filepath"></param>
        /// <param name="sheetindex"></param>
        /// <param name="m"></param>
        /// <param name="n"></param>
        /// <returns></returns>
        public DataSet ReadExcel(string filepath,int sheetindex,int m,int n)
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

        private DataSet ReadExcel(string filepath,int sheetindex)
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
                for (int i = 1; i <= cols; i++)
                {
                    string colname = worksheet.Cells[1, i].Value.ToString();
                    colNames.Add(colname);
                    dt.Columns.Add(colname);
                }
                string temp;
                for (int i = 2; i <= rows; i++)
                {
                    dr = dt.Rows.Add();
                    for (int j = 1; j <= cols; j++)
                    {
                        try
                        {
                            if (worksheet.Cells[i, j].Value != null)
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


    }
}