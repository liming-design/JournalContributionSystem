<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="后台管理.home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>检索期刊</title>
    <link rel="shortcut icon" href="#"/>
    <link href="css/bootstrap.css" rel="stylesheet" />
      <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-table/bootstrap-table.min.css" rel="stylesheet" />
  <style>
   #ftable>tbody>tr>td{
    border:0px;
    }
   #ftable>tbody>tr>td>div{
    padding:0px 5px 10px 0px;
    }
   
    .my-skin .layui-layer-btn .layui-layer-btn0{
        border-color:gray;
       background-color:gray;
   }
  *{
      font-size:16px;
  }
  </style>
</head>
<body overflow: auto">
    <div class="news_main">

    <form id="form2" runat="server">
            <asp:ScriptManager ID="ScriptManager2" runat="server" EnablePageMethods="true">
                    <Services>
                        <asp:ServiceReference Path="~/WebService1.asmx" />
                    </Services>
            </asp:ScriptManager>
    </form>
        <div style="padding:0px; margin:0px;
        width:100%; height:102px; background-image:url('Files/img/top2.jpg') ;
        background-size: 100%; background-repeat:no-repeat;">
            <div style="float:left; height:90%; width:36%;" ><a style=" display:inline-block; height:100%; width:100%;" href="navigate.aspx"></a></div>
            <div style=" float:right;width:150px;" class="col-md-2 col-sm-2 col-xs-2"><a style="text-decoration:none; color:aliceblue;" href="login.aspx" target="_blank">管理员登录</a></div>
        </div> 
        <%--width:60%;--%>
             <div class="container" style=" width:940px;">     
                        <div class="row" style="height:10px;">

                        </div>
                         <div class="row" style="height:50px;">
                            <div class="col-xs-4 col-md-4 col-sm-4">
                                <select class="form-control" id="subclass" onchange="subclassChange()">
                                    <asp:Repeater ID="Repsubclass" runat="server">
                                        <ItemTemplate>
                                            <option><%# Eval("学科大类名称")%></option>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </select> 
                            </div>
                            <div class="col-xs-4 col-md-4 col-sm-4">
                                <select class="form-control" id="sub" onchange="OnConditionChange()">
                                      <asp:Repeater ID="Repsub" runat="server">
                                        <ItemTemplate>
                                            <option><%# Eval("学科名称")%></option>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </select> 
                            </div>        
                            <div class="col-xs-3 col-md-3 col-sm-3">
                                <input id="search" type="text" class="form-control" placeholder="搜索" />                               
                            </div> 
                            <div class="col-xs-1 col-md-1 col-sm-1">
                              <button class=" btn" style="background-color:#5CB85C;color: white;" onclick="OnConditionChange()">
                                  <span class="glyphicon glyphicon-search" aria-hidden="true"></span> 搜索
                              </button>
                            </div>
                        </div>
                        <div class='panel panel-default' > 
                            <div class='panel-heading' data-toggle='collapse'  data-target='#pan1'> 
                                <h4 class='panel-title'name='title' >
                                    筛选
                                </h4>
                            </div>
                            <div id='pan1' class='panel-collapse collapse in'>
                                <div style="background-image:url('Files/img/mid3.jpg') ;background-size:100% 100%; background-repeat:no-repeat;"> 
                                     <div class='panel-body'   name='panelbody' style="padding-bottom:8px;" >
                                        <table class="table" id="ftable"style="margin-bottom:0px;">                
                                            <tbody>                         
                                        <tr>
                                            <td>数据库来源：</td>
                                            <td>
                                                <asp:Repeater ID="RepShort" runat="server">
                                                    <ItemTemplate>
                                                        <div style="float:left;padding-right:50px;" >
                                                            <input onclick="OnConditionChange()" type="checkbox" name="short"  value="option1" />
                                                            <%#Eval("缩写") %>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>                                            
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>出版周期：</td>
                                            <td>
                                                <asp:Repeater ID="RepDate" runat="server">
                                                    <ItemTemplate>
                                                        <div style="float:left;padding-right:60px;" >
                                                            <input onclick="OnConditionChange()" type="checkbox"  name="date" value="option1" />
                                                            <%#Eval("出版周期") %>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>                                            
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:13%;">投稿方式：</td>
                                            <td>
                                                <asp:Repeater ID="RepWay" runat="server">
                                                    <ItemTemplate>
                                                        <div style="float:left;padding-right:50px;"  >
                                                            <input onclick="OnConditionChange()" name="way" type="checkbox"  value="123" />
                                                            <%#Eval("投稿方式") %>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </td>
                                        </tr>
                                        </tbody>                
                                        </table>
                                    </div>
                                </div>
                               
                   
                            </div>
                        </div>
            
                        <table id="table" class="table table-bordered"></table>       
                    </div>
        
       <div  style=" background-image:url('Files/img/bottom2.jpg') ;background-size: 100%;background-repeat:no-repeat;position:relative;text-align:center;padding:0px;margin:0px;margin-top:50px; width:100%; height: 102px; "> 
  
  
  
        
    
        
   <%-- <div style=" padding-top:45px; font-family:arial;color:#E7E6EC;letter-spacing: 2px;font-size:20px;">版权所有：北华航天工业学院图书馆             联系电话：0316-2238534

    </div>
       --%>
       
   

</div>

   </div>
    <script src="js/jQuery/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap/bootstrap.js"></script>
    <script src="js/bootstrap-table/bootstrap-table.js"></script>
    <script src="js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script src="js/home.js"></script>
   
        
</body>
</html>
