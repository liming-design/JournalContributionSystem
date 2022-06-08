<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="subNavigation.aspx.cs" Inherits="后台管理.subNavigation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>学科导航</title>
    <link href="css/bootstrap.css" rel="stylesheet" />

    <style>
        body{
            background-color:#F5F5FA;position:absolute;top: 0;bottom:0;left:0;right:0;
            min-width: 1100px;
        }
        .char{
            width:510px;height:92px;
            position: absolute;margin: auto;left: 150px;top: 15px;
            color: #424242;
        }
        .head{
            height:92px;background-color: ivory;width:100%;min-width:1150px;
        }
        #foot{
            position: absolute;left: 0;right: 0; color:#424242;margin: auto;
            height: 100px;width: 500px;margin-top: 40px;
        }
        #contain{
          background-color:white;
          padding: 0px;height: 100%;width: 1150px;min-height:900px;
        }
       #nav{
        width: 100%;
        height: 60px;background-color: #F5F5FA;padding-bottom: 20px;
       }
       #content{
        width: 100%;
       }
       .mypanel{         
           margin-bottom:20px !important;	
           width: 1000px;margin-left: 75px;margin-top: 40px;font-size:17px;
       }
       .panel-title{
           font-size: 18px !important;
       }

    </style>
</head>
<body>
    <div class="head" >
        <div class="char" >
            <div style="float:left;font-size:40px; ">华航</div>
            <div style=" font-size:15px; padding-top: 10px;padding-left: 100px;">核心期刊投稿信息服务平台</div>
            <div style="font-size:10px; padding-left: 90px;">——Journal Submission platform——</div>
        </div>            
    </div>
    
    <div id="contain" class="container">
        <div id="nav">
            <div style="padding-top:20px;float:left;font-size:20px;" >
                <a href="navigate.aspx" style="text-decoration: none; color:#424242;font-size:inherit;">
                    <span class="glyphicon glyphicon-home"></span> 首页
                </a> / 学科导航
            </div>
        </div>

        <div id="content">
            <div class="panel-group " id="accordion">          
               <asp:Repeater ID="Rep1" runat="server">
                      <ItemTemplate>
                        <%#Eval("html") %>
                      </ItemTemplate>
                  </asp:Repeater>
            </div>   
        </div>

    

    </div>
    <div id="foot" align="center"style="color:#606266" >
        <div style="height:30px;">
            <a style=" text-decoration:none;cursor:pointer;color: inherit;"  href="manual.aspx">
                <p style="display:inline; ">使用指南</p>
            </a>&nbsp &nbsp|&nbsp &nbsp 
            <span style='display:none' id="busuanzi_container_site_uv">
                本站访客数<span id="busuanzi_value_site_uv"></span>人次
            </span>
        </div>
        <p style="margin-bottom:30px;">备注说明：目前该系统为1.0测试版，如您在使用过程中遇到问题请及时反馈。由于期刊的官网地址和投稿方式会发生变更，也请您反馈给我们。让我们共同把他变得更加完美。</p>           
    </div>
    
   <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager2" runat="server" EnablePageMethods="true">
			<Services>
				<asp:ServiceReference Path="~/WebService1.asmx" />
			</Services>
	   </asp:ScriptManager>
   </form>
    <script src="js/jquery.min.js"></script>         
    <script src="js/bootstrap/bootstrap.js"></script>
    <script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
    <script>
        //填上所有学科
        var panels = document.getElementsByName("panelbody");
        var titles = document.getElementsByName("title");
        for (var i = 0; i < panels.length; i++) {
            var subnames = 后台管理.WebService1.GetSubByClass(titles[i].innerHTML, f1, f2,i);            
        }
        function f1(result, i) {
            for (var j = 0; j < result.length; j++) {
                panels[i].innerHTML += '<div class="col-md-2 col-xs-2 col-sm-3" style="float:left; margin-bottom: 15px;"><a  target="_blank"  href="home.aspx?class=' + titles[i].innerHTML + '&subject=' + result[j] + '">' + result[j] + '</a></div>';                   
            }
        }
        function f2(){

        }
       
        
    </script>
</body>
</html>
