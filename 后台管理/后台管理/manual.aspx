<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manual.aspx.cs" Inherits="后台管理.manual" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>用户指南</title>
    <link href="css/bootstrap.css" rel="stylesheet" />
    <style>
        body{
            background-color:#F5F5FA;position:absolute;top: 0;bottom:0;left:0;right:0;
            min-width: 1100px;
        }
        .char{
            width:510px;height:92px;
            position: absolute;margin: auto;left: 150px;top: 15px;
            color: white;
        }
        .head{
            height:92px;background-color: #337AB7;min-width: 1150px;
        }
        #foot{
            position: absolute;left: 0;right: 0; color:#424242;margin: auto;
            height: 100px;width: 500px;margin-top: 40px;margin-bottom: 20px;
        }
        #contain{
          background-color:white;
          padding: 0px;width: 1150px;min-height:1200px;
        }
       #nav{
        width: 100%;
        height: 60px;background-color: #F5F5FA;padding-bottom: 20px;
       }
       #content{
        width: 100%;padding-top: 80px;
       }
       #content p{
           font-size: 20px;
           text-indent:2em;line-height: 2;width: 1000px;margin-left: 75px;
       }
       #mytable{
           width: 800px;margin-left: 175px;font-size: 18px;
       }
       #mytable th{
           text-align: center;
       }
       .title{
        font-size: 22px !important;text-indent:0 !important;
       }
    </style>
</head>
<body>
    <div class="head" >
        <div class="char" >
            <div style="float:left;font-size:40px; ">华航</div>
            <div style=" font-size:15px; padding-top: 10px;padding-left: 100px;">核心期刊投稿信息服务平台</div>
            <div style="font-size:10px; padding-left: 103px;">——Journal Submission platform——</div>
        </div>            
    </div>
    
    <div id="contain" class="container">
            
        <div id="nav">
            <div style="padding-top:20px;float:left;font-size:20px;" >
                <a href="navigate.aspx" style="text-decoration: none; color:#424242;font-size:inherit;">
                    <span class="glyphicon glyphicon-home"></span> 首页
                </a> / 使用指南
            </div>
        </div>
        <div id="content">
            <h1 style="margin-left:240px; height:70px;">华航核心期刊投稿信息服务平台使用指南</h1>
           <p>
            华航核心期刊投稿信息服务平台以我校学院专业设置为学科分类基础，供用户全面了解期刊信息的服务平台。系统收录了国内核心期刊数据1400余种，涵盖这些期刊延伸字段，提供出版周期、官网地址、投稿方式等信息。
           </p>
           <p>
            用户可以通过检索框输入检索词进行期刊检索，也可以通过学科导航选择期刊查阅信息。
           </p>     
           <p>
            若在使用过程中出现问题，您可以通过反馈功能对本平台提出意见和建议，促进平台更加完善。
           </p>  
           <p class="title">核心评价指标：</p>   
           <table id="mytable" class="table table-bordered">
               <tr>
                <th>核心期刊标识</th>
                <th>收录数据库</th>
               </tr>
               <tbody>
                <tr>
                    <td>北大核心期刊</td>
                    <td>北京大学《中文核心期刊要目总览》来源期刊2017年版</td>
                </tr>
                <tr>
                    <td>CSSCI来源期刊</td>
                    <td>中文社会科学引文索引(2019-2020)来源期刊</td>
                </tr>
                <tr>
                    <td>CSSCI来源期刊扩展版</td>
                    <td>中文社会科学引文索引(2019-2020)来源期刊扩展版</td>
                </tr>
                <tr>
                    <td>SCI</td>
                    <td>科学引文索引(美)(2018)</td>
                </tr>
                <tr>
                    <td>EI</td>
                    <td>工程索引(美)(2019)</td>
                </tr>
               </tbody>
               
           </table>
           <p class="title" >影响因子：</p>   
           <p>
            CNKI综合影响因子主要是指文、理科综合，是以科技类期刊及人文社会科学类期刊综合统计源文献计算，被评价期刊前两年发表的可被引文献在统计年的被引用总次数与该期刊在前两年内发表的可被引文献总量之比。
           </p>
           <p>
            CNKI复合影响因子是以期刊综合统计源文献、博硕士学位论文统计源文献、会议论文统计源文献为复合统计源文献计算，被评价期刊前两年发表的可被引文献在统计年的被引用总次数与该期刊在前两年内发表的可被引文献总量之比。
           </p>     
            </div>   
        </div>
   
    <div id="foot" align="center"style="color:#606266" >
        <div style="height:30px;">
            <a style=" text-decoration:none;cursor:pointer;color: inherit;" href="manual.aspx">
                <p style="display:inline; ">使用指南</p>
            </a>&nbsp &nbsp|&nbsp &nbsp 
            <span style='display:none' id="busuanzi_container_site_uv">
                本站访客数<span id="busuanzi_value_site_uv"></span>人次
            </span>
        </div>
        <p style="margin-bottom:30px;">备注说明：目前该系统为1.0测试版，如您在使用过程中遇到问题请及时反馈。由于期刊的官网地址和投稿方式会发生变更，也请您反馈给我们。让我们共同把它变得更加完美。</p>           
    </div>
    <script src="js/jquery.min.js"></script>         
    <script src="js/bootstrap/bootstrap.js"></script>
    <script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
</body>
</html>
