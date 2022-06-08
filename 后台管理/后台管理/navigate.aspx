<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="navigate.aspx.cs" Inherits="后台管理.navigate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
    <title>华航核心期刊投稿信息服务平台</title>
    <link href="css/bootstrap.css" rel="stylesheet" />
   <style>
        body{
            position:absolute;top: 0;bottom:0;left:0;right:0;
            min-width: 1100px;background-image:url('Files/img/index.jpg') ;background-size: 1900px 1100px; 
            background-repeat:no-repeat;min-height: 600px;
        }
        #allcontent{
            height: 330px;width: 1100px;margin: auto;position: absolute;left: 0;right: 0;
            border-radius: 4px 0px 0px 4px;
            box-shadow: 1px 5px 20px 1px #757f80b0;
        }
        #left{
            height: 330px;
            width: 160px;
            background-color: white;
            border-radius: 4px 0px 0px 4px;
        }
        #mynav{
            margin: auto;top:0;bottom: 0;position: absolute;left: 0;height: 210px;width: 160px;
            font-size: 20px;
            padding-right: 0px;
        }
        #mynav li{
            height: 60px;
        }
        #mynav li a{
            line-height: 2;
            padding-left: 35px;
        }
        #right{
            position: absolute;margin: auto;top: 0;bottom: 0;right: 0;
            height: 330px;
            width: 940px;
            border-radius: 0px 4px 4px 0px;
            background-color: #EEEEF2;
        }
        #content{
             height: 100%;
             width: 100%;    
        }
        .char{
            padding-top:30px;width:510px;height:160px;
            position: absolute;margin: auto;right: 0;left: 0;
            color:#F7D26A;
        }
        .active{
            background-color: #EEEEF2;
        }
        table tr td{
            border: 0px !important;
            line-height: 2 !important;
            font-size: 17px;
        }
        table tr td input{
            height: 18px;
            width: 18px;
            vertical-align: sub;
        }
        .myinput{
            font-size: 20px; display: inline;height: 60px; width:600px
        }
        .mybut{
            font-size: 20px;display: inline;height: 60px; width: 170px;margin-left: 10px;  
            vertical-align: initial;
        }
        #foot{
            position: absolute;left: 0;right: 0; color:white;margin: auto;margin-top: 390px;
            height: 100px;width: 600px;
        }
        .content3{
            margin-left:90px;margin-top:70px;
            font-size: 19px;width: 800px;height: 200px;
        }
       
    </style>

</head> 
    
<body >
    <form runat="server">
         <asp:ScriptManager ID="ScriptManager2" runat="server" EnablePageMethods="true">
		    <Services>
			    <asp:ServiceReference Path="~/WebService1.asmx" />
		    </Services>
	    </asp:ScriptManager>
    </form>
    <div style="height:180px;">
        <div class="char" >
            <div style="float:left;font-size:70px; ">华航</div>
            <div style=" font-size:25px; padding-top: 20px;padding-left: 170px;">核心期刊投稿信息服务平台</div>
            <div style="font-size:20px; padding-left: 155px;">——Journal Submission platform——</div>
        </div>            
    </div>
    <div id="allcontent" >
        <div id="left">
            <div id='mynav' class="col-xs-2">
                <ul class="nav nav-tab vertical-tab" role="tablist" id="vtab">
                    <li role="presentation"class="active" >
                        <a  href="#tab1" aria-controls="home" role="tab"
                           data-toggle="tab">期刊查询</a>
                    </li>
                    <li role="presentation">
                        <a href="subNavigation.aspx" aria-controls="inbox" >学科导航</a>
                          
                    </li>
                    <li role="presentation">
                        <a href="#tab3" aria-controls="outbox" role="tab"
                           data-toggle="tab">用户反馈</a>
                    </li>
                   
                </ul>
            </div>
        </div>
        <div id="right">
            <div id="content"  class="tab-content vertical-tab-content col-xs-10">
                <div  role="tabpanel" class="tab-pane active" id="tab1">
                    <div style=" margin-left:50px;margin-top:60px;">                        
                        <input  class="form-control myinput" id="name"  placeholder="请输入期刊名称"/>
                        <button  class="mybut btn btn-primary"id="search" >
                            检索
                        </button>

                        <table class="table" style=" margin-top:25px;">
                            <tr>
                                <td style="width: 120px;">期刊类型：</td>
                                <td >
                                    <asp:Repeater ID="Repsubclass" runat="server">
                                        <ItemTemplate>
                                            <div style="float:left;padding-right:70px;">
                                                <input  type="checkbox" name="subClass" />
                                                <%# Eval("学科大类名称")%>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </td>
                            </tr>
                            <tr>
                                <td>期刊类别：</td>
                                <td>
                                    <asp:Repeater ID="RepShort" runat="server">
                                        <ItemTemplate>
                                            <div style="float:left;padding-right:50px;">
                                                <input type="checkbox" name="short" />
                                                <%#Eval("缩写") %>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <div  role="tabpanel" class="tab-pane" id="tab3">
                    <div class="content3" >
                        <%--<textarea  id="tourMessage" class="form-control" placeholder="*请填写留言内容"></textarea> 
                        <input class="form-control"id="tourName" type="text" placeholder="*请填写姓名"/>
                        <input type="email" id="tourMail" class="form-control" placeholder="*请填写联系方式"/>
                        <button class="btn btn-primary" id="send"  class="mybtn">发送</button>--%>
                        <p>若您在使用过程中遇到问题，或者有意见、建议，欢迎联系图书馆信息服务部。</p>
                        <p>电话：2238534</p>
                        <p>QQ：458281292（杨园利），544199990（王学贤）</p>
                        <p>邮箱：458281292@qq.com，544199990@qq.com</p>
                    </div>
                </div>                   
            </div>
        </div>
            
    </div>
    <div id="foot" align="center">
        <div style="height:30px;">
            <a style=" text-decoration:none;cursor:pointer;color: inherit;" href="manual.aspx">
                <p style="display:inline; ">使用指南</p>
            </a>&nbsp &nbsp|&nbsp &nbsp 
            <span style='display:none' id="busuanzi_container_site_uv">
                本站访客数<span id="busuanzi_value_site_uv"></span>人次
            </span>
        </div>
        <p >备注说明：目前该系统为1.0测试版，如您在使用过程中遇到问题请及时反馈。由于期刊的官网地址和投稿方式会发生变更，也请您反馈给我们。让我们共同把它变得更加完美。</p>           
    </div>
    <script src="js/jQuery/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap/bootstrap.js"></script>
    <script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
    
    <script>

        //$(document).keydown(function (event) {
        //    if (event.keyCode == 13) {
        //        $("#search").click();
        //    }
        //});
        // 搜索点击事件
        $("#search").click(function () {
            var pname = $("#name").val();
            var subClass = [];
            var short = [];
            var obj = document.getElementsByName("subClass");
            if (obj[0].checked) {
                subClass = ["不限"];
            } else {
                for (var i = 1; i < obj.length; i++) {
                    if (obj[i].checked)
                        subClass.push($.trim(obj[i].parentNode.innerText)); //如果选中，将value添加到变量s中
                }
            }

            obj = document.getElementsByName("short");
            for (var i = 0; i < obj.length; i++) {
                if (obj[i].checked)
                    short.push($.trim(obj[i].parentNode.innerText)); //如果选中，将value添加到变量s中
            }
            var result = "";
            if (pname != "")
                result += ("name=" + pname);

            if (subClass.length != 0) {
                if (result != "")
                    result += "&";

                result += ("class=" + subClass);
            }
            if (short.length != 0) {
                if (result != "")
                    result += "&";
                result += ("short=" + short);
            }

            window.location.href = "home.aspx?" + result;
        })

        $("input[name='subClass']").click(function () {
            var inputs = $("input[name='subClass']");
            if (this.checked) {

                var j = 0;
                for (var i = 1; i < inputs.length; i++)
                    if (!inputs[i].checked) {
                        j = 1;
                    }
                if (j == 0) {
                    $("input[name='subClass']").first().prop("checked", true);
                }
            }
            else {
                if (inputs[0].checked) {
                    $("input[name='subClass']").first().prop("checked", false);
                }
            }
        })

        $("input[name='subClass']").first().click(function () {
            if (this.checked) {
                $("input[name='subClass']").prop("checked", true);
            }
            else {
                $("input[name='subClass']").prop("checked", false);
            }
        })
        let re = /^\w+@[a-zA-Z0-9]{2,10}(?:\.[a-z]{2,4}){1,3}$/;

        $("#send").click(function () {
            var tourName = $("#tourName").val();
            var tourMail = $("#tourMail").val();
            var tourMessage = $("#tourMessage").val();
            var date = getCurrentDate(2);
            var tourMail = $("#tourMail").val();
            if (tourName != "" && tourMail != "" && tourMessage != ""){
                var num = sessionStorage.getItem('messagenum');
                if (num < 3 || num == null) {
                    var args = [tourName, tourMail, tourMessage, date];
                    后台管理.WebService1.MessageAdd(args, function () { window.alert("留言成功，我们会尽快回复！") }, function () { window.alert("留言失败，可能是网络原因...") });
                    if (num) {
                        num++;
                        sessionStorage.setItem('messagenum', num);
                    }
                    else {
                        sessionStorage.setItem('messagenum', 1);
                    }
                }
                else {
                    window.alert("一天最多三次哦！感谢配合。");
                }
            }
            else {
                window.alert("留言失败！请检查是否有未填项！")
            }

        })

        function getCurrentDate(format) {
            var now = new Date();
            var year = now.getFullYear(); //得到年份
            var month = now.getMonth();//得到月份
            var date = now.getDate();//得到日期
            var day = now.getDay();//得到周几
            var hour = now.getHours();//得到小时
            var minu = now.getMinutes();//得到分钟
            var sec = now.getSeconds();//得到秒
            month = month + 1;
            if (month < 10) month = "0" + month;
            if (date < 10) date = "0" + date;
            if (hour < 10) hour = "0" + hour;
            if (minu < 10) minu = "0" + minu;
            if (sec < 10) sec = "0" + sec;
            var time = "";
            //精确到天
            if (format == 1) {
                time = year + "-" + month + "-" + date;
            }
            //精确到分
            else if (format == 2) {
                time = year + "-" + month + "-" + date + " " + hour + ":" + minu + ":" + sec;
            }
            return time;
        }

        function Ondownload() {
            window.open('Files/使用指南2020.12.07.docx');
        }
    </script>
</body>
</html>
