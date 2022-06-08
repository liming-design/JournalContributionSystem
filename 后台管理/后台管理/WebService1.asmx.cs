using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI.HtmlControls;

namespace 后台管理
{
    /// <summary>
    /// WebService1 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {
        /// <summary>
        /// 表的添加功能，可以是任意表，但必须是拥有一个主键的表
        /// </summary>
        /// <param name="tablename"></param>
        /// <param name="args"></param>
        /// <returns></returns>
        [WebMethod]
        public string SingleTableAdd(string tablename, string[] args)
        {
            string name = args[0];
            string id = GetIdByName(tablename, name);
            if (id == "")
            {
                string ID = Guid.NewGuid().ToString("N");
                string sql = String.Format("insert into {0} values(", tablename);
                sql += String.Format("'{0}',", ID);
                int n = args.Length;
                for (int i = 0; i < n - 1; i++)
                {
                    sql += String.Format("'{0}',", args[i].Trim());
                }
                sql += String.Format("'{0}')", args[n - 1].Trim());

                int m = SqlHelper.ExecuteSql(sql);
                if (m == 1)
                    return ID;
            }
            return "";
        }

        /// <summary>
        /// 向期刊中插入一项，成功返回ID
        /// </summary>
        /// <param name="args"></param>
        /// <returns></returns>
        [WebMethod]
        public string PerioAdd(string[] args)
        {
            string ID = SingleTableAdd("期刊", args);
            return ID;
        }

        /// <summary>
        /// 向学科中插入一项，成功返回ID
        /// </summary>
        /// <param name="arguments"></param>
        /// <returns></returns>
        [WebMethod]
        public string SubAdd(string[] arguments)
        {
            string ID = "";
            string subClassName = arguments[1];
            string ClassID = GetIdByName("学科大类", subClassName);
            if (ClassID != "")
            {
                arguments[1] = ClassID;
                ID = SingleTableAdd("学科", arguments);
            }
            return ID;
        }

        /// <summary>
        /// 向学科大类中插入一项，成功返回ID
        /// </summary>
        /// <param name="args"></param>
        /// <returns></returns>
        [WebMethod]
        public string ClassAdd(string[] args)
        {
            string ID = SingleTableAdd("学科大类", args);
            return ID;
        }


        /// <summary>
        /// 向核心数据库中插入一项，成功返回ID
        /// </summary>
        /// <param name="args"></param>
        /// <returns></returns>
        [WebMethod]
        public string CoredatabaseAdd(string[] args)
        {
            string ID = SingleTableAdd("核心期刊数据库", args);
            return ID;
        }

        [WebMethod]
        public bool MessageAdd(string[] args)
        {
            string ID = Guid.NewGuid().ToString("N");
            string sql = String.Format("insert into 留言 values(");
            sql += String.Format("'{0}',", ID);
            int n = args.Length;
            for (int i = 0; i < n - 1; i++)
            {
                sql += String.Format("'{0}',", args[i].Trim());
            }
            sql += String.Format("'{0}')", args[n - 1].Trim());

            int m = SqlHelper.ExecuteSql(sql);
            if (m == 1)
                return true;
            
            return false;
        }

        [WebMethod]
        public string GetUserIdByNumber(string number)
        {
            string sql = String.Format("select 用户ID  from 用户 where 账号='{0}'",number);
            DataSet ds = SqlHelper.Query(sql);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count>0)
            {
                DataRow dr = dt.Rows[0];
                return dr["用户ID"].ToString();
            }
            return "";
        }

        [WebMethod]
        public string UserAdd(string[]args)
        {
            string sql;
            string ID = GetUserIdByNumber(args[0]);
            if (ID=="")
            {
                ID = Guid.NewGuid().ToString("N");
                sql = String.Format("insert into {0} values(","用户");
                sql += String.Format("'{0}',", ID);
                int n = args.Length;
                for (int i = 0; i < n - 1; i++)
                {
                    sql += String.Format("'{0}',", args[i].Trim());
                }
                sql += String.Format("'{0}')", args[n - 1].Trim());

                int m = SqlHelper.ExecuteSql(sql);
                if (m == 1)
                    return ID;
            }
            return "";
        }

        /// <summary>
        /// 核心数据库收录关系添加，只能用于此功能
        /// </summary>
        /// <param name="args">期刊名称，数据库名称</param>
        /// <returns></returns>
        [WebMethod]
        public string DatabaseIncludeAdd(string[] args)
        {
            string perioname = args[0].Trim();
            string databasename = args[1].Trim();
            string perioID = GetIdByName("期刊", perioname);
            string databaseID = GetIdByShort(databasename);
            string result = DataIncluAddById(new string[] { perioID,databaseID});
            return result;
        }
        [WebMethod]
        public string DataIncluAddById(string[] args)
        {
            string perioID = args[0];
            string databaseID = args[1];
            if ((perioID != null&&perioID!="") && (databaseID != null&&databaseID!=""))
            {
                string sql1 = String.Format("select count(*) from 收录关系 where 期刊ID='{0}' and 核心期刊数据库ID='{1}'", perioID, databaseID);
                int n = (int)SqlHelper.GetSingle(sql1);
                if (n > 0)
                    return "已存在";
                string sql = String.Format("insert into 收录关系 values('{0}','{1}')", perioID, databaseID);
                int m = SqlHelper.ExecuteSql(sql);
                if (m == 1)
                    return "成功";
            }
            return "失败";
        }

        /// <summary>
        /// 学科期刊关系添加，只能用于此功能
        /// </summary>
        /// <param name="args">学科名称，期刊名称</param>
        /// <returns></returns>
        [WebMethod]
        public string SubPerioRelaAdd(string[] args)
        {
            string subjectname = args[0].Trim();
            string perioname = args[1].Trim();
            string subId = GetIdByName("学科", subjectname);
            string perId = GetIdByName("期刊", perioname);
            args[0] = perId;
            args[1] = subId;
            string result=SubPerioRelaAddById(args);
            return result;           
        }

        [WebMethod]
        public string SubPerioRelaAddById(string[] args)
        {
            string perId = args[0];
            string subId = args[1];
            if (subId != "" && perId != "")
            {
                string sql1 = String.Format("select count(*) from 学科期刊关系 where 期刊ID='{0}' and 学科ID='{1}'", perId, subId);
                int n = (int)SqlHelper.GetSingle(sql1);
                if (n > 0)
                    return "已存在";
                string sql = String.Format("insert into 学科期刊关系 values('{0}','{1}')", perId, subId);
                int m = SqlHelper.ExecuteSql(sql);
                if (m == 1)
                    return "成功";
            }
            return "失败";
        }


        /// <summary>
        /// 通过ID删除，通用于一个主键的表
        /// </summary>
        /// <param name="TableName"></param>
        /// <param name="ID"></param>
        /// <returns></returns>
        [WebMethod]
        public bool DeleteById(string TableName, string ID)
        {
            string sql = String.Format("delete from {0} where {0}ID = '{1}'", TableName, ID);
            int result = SqlHelper.ExecuteSql(sql);
            if (result == 0)
                return false;
            return true;
        }

        /// <summary>
        /// 通过ID删除学科
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        [WebMethod]
        public bool SubDelete(string ID)
        {
            bool result = DeleteById("学科", ID);
            return result;
        }

        [WebMethod]
        public bool ClaDelete(string ID)
        {
            bool result = DeleteById("学科大类", ID);
            return result;
        }

        [WebMethod]
        public bool PerioDelete(string ID)
        {
            bool result = DeleteById("期刊", ID);
            return result;
        }
        [WebMethod]
        public bool UserDelete(string ID)
        {
            bool result = DeleteById("用户", ID);
            return result;
        }

        [WebMethod]
        public bool CoreDatabaseDelete(string ID)
        {
            bool result = DeleteById("核心期刊数据库", ID);
            return result;
        }


        /// <summary>
        /// 删除收录关系中的一条
        /// </summary>
        /// <param name="args">期刊ID，核心数据库ID</param>
        /// <returns></returns>
        [WebMethod]
        public bool PerioCoreRelaDelete(string []args)
        {
            string sql = String.Format("select count(*) from 收录关系 where 期刊ID='{0}' and 核心期刊数据库ID='{1}'", args[0], args[1]);
            int count = (int)SqlHelper.GetSingle(sql);
            if(count>0)
            {
                sql=String.Format("delete from 收录关系 where 期刊ID='{0}' and 核心期刊数据库ID='{1}'", args[0], args[1]);
                count = SqlHelper.ExecuteSql(sql);
                if (count > 0)
                    return true;
            }
            return false;
        }
        [WebMethod]
        public int PerioSubDelete(string[]args)
        {
            string sql = String.Format("delete from 学科期刊关系 where 期刊ID='{0}'and  学科ID='{1}' ", args[0], args[1]);
            int count = (int)SqlHelper.ExecuteSql(sql);
            return count;
        }

        [WebMethod]
        public bool MessageDelete(string ID)
        {
            bool result = DeleteById("留言",ID);
            return result;
        }


        /// <summary>
        /// 修改学科
        /// </summary>
        /// <param name="args"></param>
        /// <returns></returns>
        [WebMethod]
        public bool SubUpdate(string[] args)
        {
            string SubClassName = args[2];
            string ClassID = GetIdByName("学科大类",SubClassName);
            args[2] = ClassID;
            bool result = UpdateById("学科", args);
            return result;           
        }


        /// <summary>
        /// 修改期刊
        /// </summary>
        /// <param name="args"></param>
        /// <returns></returns>
        [WebMethod]
        public bool PerUpdate(string[] args)
        {           
            bool result = UpdateById("期刊", args);
            return result;
        }
        [WebMethod]
        public bool ClaUpdate(string[] args)
        {
            bool result = UpdateById("学科大类", args);
            return result;
        }

        [WebMethod]
        public bool CoreUpdate(string[] args)
        {
            bool result = UpdateById("核心期刊数据库", args);
            return result;
        }

        [WebMethod]
        public bool  UserUpdate(string[] args)
        {
            bool result = UpdateById("用户", args);
            return result;
        }

        /// <summary>
        /// 修改表除ID外的所有内容，按顺序传参，通用
        /// </summary>
        /// <param name="TableName"></param>
        /// <param name="args"></param>
        /// <returns></returns>
        [WebMethod]
        public bool UpdateById(string TableName,string [] args)
        {
            string sql = String.Format("select column_name from information_schema.columns where table_name='{0}'", TableName);
            DataSet ds = SqlHelper.Query(sql);
            List<string> columnName = new List<string>();
            if (ds.Tables[0].Rows.Count > 0)
            {
                for(int i =0;i< ds.Tables[0].Rows.Count;i++)
                {
                    string columnname = ds.Tables[0].Rows[i].ItemArray[0].ToString();
                    columnName.Add(columnname);
                }               
            }sql = String.Format("update {0} set ", TableName);
            for(int i=1;i<columnName.Count;i++)
            {
                sql += String.Format(" {0} = '{1}'", columnName[i], args[i]);
                if (i != columnName.Count - 1)
                    sql += ",";
            }
            sql += String.Format(" where {0}ID ='{1}'", TableName, args[0]);
            int count = SqlHelper.ExecuteSql(sql);
            if (count == 1)
                return true;
            return false;
        }


        /// <summary>
        /// 修改表，通用
        /// </summary>
        /// <param name="TableName"></param>
        /// <param name="args1"></param>
        /// <param name="args2"></param>
        /// <returns></returns>
        [WebMethod]
        public bool UpdateById(string TableName,string[] args1,string[] args2 )
        {
            string sql = String.Format("update {0} set ", TableName);
            for(int i=1;i<args1.Length;i++)
            {
                sql += String.Format(" {0}='{1}'",args1[i],args2[i]);
                if (i != args1.Length - 1)
                    sql += ",";
            }
            sql += String.Format(" where {0}ID ='{1}'", TableName, args2[0]);
            int count = SqlHelper.ExecuteSql(sql);
            if (count == 1)
                return true;
            return false;
        }

        /// <summary>
        /// 通过ID获取所有信息，通用
        /// </summary>
        /// <param name="TableName"></param>
        /// <param name="ID"></param>
        /// <returns></returns>
        [WebMethod]
        public List<string> GetInfoById(string TableName, string ID)
        {
            string sql = String.Format("select * from {0} where {0}ID='{1}'",TableName, ID);
            DataSet ds = SqlHelper.Query(sql);
            List<string> result = new List<string>();
            if (ds.Tables[0].Rows.Count>0)
            {
                DataRow row = ds.Tables[0].Rows[0];               
                foreach (object cell in row.ItemArray)
                {
                    result.Add(cell.ToString());
                }
            }
            
            return result;
        }

        /// <summary>
        /// 通过期刊ID获得期刊的所有信息
        /// </summary>
        /// <param name="PerID"></param>
        /// <returns></returns>
        [WebMethod]
        public List<string> GetInfobyPerID(string PerID)
        {         
            List<string> result = new List<string>();            
            result = GetInfoById("期刊", PerID);
            return result;
        }

        /// <summary>
        /// 通过期刊精确名称获取期刊的所有信息
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        [WebMethod]
        public List<string>GetInfobyPerName(string name)
        {
            List<string> result = new List<string>();    
            result = GetInfobyName("期刊", name);
            return result;
        }

        [WebMethod]
        public string FuzzyInfobyPerName(string name)
        {

            DataSet ds = FuzzInfobyName("期刊", name);
            DataTable dt = ds.Tables[0];
            dt.Columns.Remove(dt.Columns[0]);
            string ans = Dtb2Json(dt);
            return ans;
        }
        [WebMethod]
        public DataSet FuzzInfobyName(string TableName, string Name)
        {
            string sql = String.Format("select * from {0} where {0}名称 like '%{1}%'", TableName, Name);
            DataSet ds = SqlHelper.Query(sql);
            return ds;
        }

        /// <summary>
        /// 通过名称获取所有信息，通用
        /// </summary>
        /// <param name="TableName"></param>
        /// <param name="Name"></param>
        /// <returns></returns>
        [WebMethod]
        public List<string> GetInfobyName(string TableName, string Name)
        {
            string sql = String.Format("select * from {0} where {0}名称='{1}'", TableName, Name);
            DataSet ds = SqlHelper.Query(sql);
            List<string> result = new List<string>();
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                foreach (object cell in row.ItemArray)
                {
                    result.Add(cell.ToString());
                }
            }
            return result;
        }

        /// <summary>
        /// 通过名称获取ID，通用
        /// </summary>
        /// <param name="perioName"></param>
        /// <returns></returns>
        [WebMethod]
        public string GetIdByName(string TableName ,string Name)
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

        /// <summary>
        /// 通过核心数据库缩写获得ID，只用于核心数据库表
        /// </summary>
        /// <param name="Short"></param>
        /// <returns></returns>
        [WebMethod]
        public string GetIdByShort(string Short)
        {
            string sql = String.Format("select 核心期刊数据库ID from 核心期刊数据库 where 缩写='{0}'", Short);
            string result = "";
            DataSet ds = SqlHelper.Query(sql);
            if (ds.Tables[0].Rows.Count > 0)
            {
                result = ds.Tables[0].Rows[0].ItemArray[0].ToString();
            }
            if(result=="")
            {
                int aa = 0;
            }
            return result;
        }

        /// <summary>
        /// datatable转为json结构
        /// </summary>
        /// <param name="dtb"></param>
        /// <returns></returns>
        [WebMethod]
        public static string Dtb2Json(DataTable dtb)
        {
            JavaScriptSerializer jss = new JavaScriptSerializer();
            System.Collections.ArrayList dic = new System.Collections.ArrayList();
            foreach (DataRow dr in dtb.Rows)
            {
                System.Collections.Generic.Dictionary<string, object> drow = new System.Collections.Generic.Dictionary<string, object>();
                foreach (DataColumn dc in dtb.Columns)
                {
                    drow.Add(dc.ColumnName, dr[dc.ColumnName]);
                }
                dic.Add(drow);

            }
            //序列化  
            return jss.Serialize(dic);
        }

        /// <summary>
        /// 返回json
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetAllPerioInfo()
        {
            string sql = String.Format("select * from 期刊");
            DataSet ds = SqlHelper.Query(sql);
            DataTable dt = ds.Tables[0];
            dt.Columns.Remove(dt.Columns[0]);
            string result = Dtb2Json(dt);
            return result;
        }

        /// <summary>
        /// 前台selectclass用
        /// </summary>
        /// <param name="classname"></param>
        /// <returns></returns>
        [WebMethod]
        public List<string> GetSubByClass(string classname)
        {
            List<string> result = new List<string>();
            string sql="";
            if (classname=="不限")
            {
                sql = "select * from 学科";
                
            }
            else
            {
                string classID = GetIdByName("学科大类", classname);
                if (classID != "")
                {
                    sql = String.Format("select * from 学科 where 学科大类ID in (select 学科大类ID from 学科大类 where 学科大类ID='{0}')", classID);                    
                }
            }
            if(sql!="")
            {
                sql += " order by '优先级'";
                DataSet ds = SqlHelper.Query(sql);
                DataTable dt = ds.Tables[0];
                foreach (DataRow dr in dt.Rows)
                {
                    result.Add(dr["学科名称"].ToString());
                }
            }            
            return result;
        }

        [WebMethod]
        public int UserAuthentication(string [] args)
        {
            string Uname = args[0];
            string Upwd = args[1];           
            string sql = "select count(*) from 用户 where 账号=@username and 密码=@password";
            SqlParameter[] parameters = new SqlParameter[2];
            parameters[0] = new SqlParameter("username", Uname);
            parameters[1] = new SqlParameter("password", Upwd);
            return (int)SqlHelper.GetSingle(sql, parameters);
        }
        

        [WebMethod]
        public string GetPerioBySub(string subname)
        {
            string sql = "";
            string result = "";
            if (subname !="不限")
            {
                string subID = GetIdByName("学科", subname);
                sql = String.Format("select * from 期刊 where 期刊ID in (select 期刊ID from 学科期刊关系 where 学科ID ='{0}')", subID);
                DataSet ds = SqlHelper.Query(sql);
                DataTable dt = ds.Tables[0];
                dt.Columns.Remove(dt.Columns[0]);
                result = Dtb2Json(dt);
            }
            else
            {
                result = GetAllPerioInfo();
            }
            return result;
        }


        [WebMethod]
        public string GetPerioByClass(string[][] condition)
        {
            //string sql = "";
            //string result = "";
            //if (className != "不限")
            //{
            //    string classID = GetIdByName("学科大类", className);
            //    sql = String.Format("select * from 期刊 where 期刊ID in (select 期刊ID from 学科期刊关系 where 学科ID in (select * from 学科 where 学科大类ID='{0}' ) )", classID);
            //    DataSet ds = SqlHelper.Query(sql);
            //    DataTable dt = ds.Tables[0];
            //    dt.Columns.Remove(dt.Columns[0]);
            //    result = Dtb2Json(dt);
            //}
            //else
            //{
            //    result = GetAllPerioInfo();
            //}
            //return result;
           // string result = SearchBy(condition, 2);
            return "";

        }

        [WebMethod]
        public string SearchByCondition(string[][] condition)
        {
            string result = SearchBy(condition);
            return result;
        }

        [WebMethod]
        public string SearchBy(string [][]condition)
        {
            bool flag = false;
            string sql = "select * from 期刊 ";
            if (condition[0][0] != "" || condition[1][0] != "不限" || condition[2].Length > 0 || condition[3].Length > 0 || condition[4].Length > 0)
                sql += "where ";
            if(condition[0][0]!="" && condition[0][0] !=null)
            {
                string temp = condition[0][0].Replace("'", "");
                sql += String.Format("期刊名称 like '%{0}%'", temp);
                flag = true;
            }
            if(condition[1][0]!="不限")
            {
                if (flag == true)
                    sql += " and ";
                if(condition[1][0]=="0")
                {
                    string subID = GetIdByName("学科", condition[1][1]);
                    sql += String.Format(" 期刊ID in (select 期刊ID from 学科期刊关系 where 学科ID='{0}')", subID);
                    flag = true;
                }
                else
                {
                    string classID = GetIdByName("学科大类", condition[1][1]);
                    sql += String.Format(" 期刊ID in (select 期刊ID from 学科期刊关系 where 学科ID in (select 学科ID from 学科 where 学科大类ID='{0}' ) )", classID);
                    flag = true;
                }
                
            }
            if (condition[2].Length > 0)
            {
                if (flag == true)
                    sql += " and ";
                string result = "";
                for(int i=0;i<condition[2].Length;i++)
                {
                    string temp = condition[2][i].Trim().Substring(0, 2);
                    result += (temp + "%");
                }
                sql += String.Format("投稿方式 like '%{0}'",result);
                flag = true;
            }
            if (condition[3].Length > 0 )
            {
                if (flag == true)
                    sql += " and ";
                string result = "";
                for (int i = 0; i < condition[3].Length; i++)
                {
                    string temp = String.Format("select 期刊ID from 收录关系 where 核心期刊数据库ID in " +
                        "(select 核心期刊数据库ID from 核心期刊数据库 where 缩写 = '{0}') ", condition[3][i].Trim());
                    result += temp;
                    if (i != condition[3].Length - 1)
                        result += " INTERSECT ";
                }
                sql += String.Format(" 期刊ID in ({0})", result);
                flag = true;
            }
            if (condition[4].Length > 0)
            {
                if (flag == true)
                    sql += " and ";
                
                    sql += "(";
                string result="";               
                for (int i = 0; i < condition[4].Length; i++)
                {
                    result += String.Format(" 出版周期 ='{0}' ",condition[4][i].Trim());
                    if (i != condition[4].Length - 1)
                        result += " or ";
                }
                sql += result;
                sql += ")";
                flag = true;
            }
            DataSet ds = SqlHelper.Query(sql);
            DataTable dt = ds.Tables[0];
            dt.Columns.Remove(dt.Columns[0]);
            string ans = Dtb2Json(dt);
            return ans;
        }

        

        //[WebMethod]
        //public List<string> GetsubByClass(string classname)
        //{
        //    List<string> result = new List<string>();
        //    string classID = GetIdByName("学科大类", classname);
        //    string sql = String.Format("select * from 学科 where 学科大类ID='{0}'", classID);
        //    DataSet ds = SqlHelper.Query(sql);
        //    DataTable dt = ds.Tables[0];
        //    foreach(DataRow dr in dt.Rows)
        //    {
        //        result.Add(dr["学科名称"].ToString());
        //    }
        //    return result;
        //}


    }
}
