<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="后台管理.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
	<link href="css/Site.css" rel="stylesheet" type="text/css" />
	<link href="css/zy.layout.css" rel="stylesheet" />
	<link href="css/zy.form.css" rel="stylesheet" />
	<link href="css/font-awesome.min.css" rel="stylesheet" />
	<link href="css/index.css" rel="stylesheet" />
	<link href="css/zy.menu.css" rel="stylesheet" />
	<script>
        function setIframeHeight(iframe) {
            if (iframe) {
                var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow;
                if (iframeWin.document.body) {
                    iframe.height = iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight;
                }
            }
        };

        window.onload = function () {
            setIframeHeight(document.getElementById('external-frame'));
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dvheader">
			<div class="dvheadertools">
				<span class="headerspantitle">期刊后台管理</span>
				<ul class="headerultools">
					<li class="headerlitools_info headerlitools" style="background-color: #075597">
						<div class="headeruserface" style="text-align: center;">
							<i class="icon-user" style="color: black;font-size: 19px;"></i>
						</div>
						管理员
						<i style="margin-left: 8px;" class="icon-caret-down"></i>
						<ul class="headerlitools_ulinfo" id="myli">
							<li style="border-top: 1px solid #E4ECF3;">
								<i class="icon-off" style="margin-right: 10px;"></i>
								<a href="home.aspx" target="_self"  style="color: black; text-decoration: none;">退出</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<div class="dvcontent">
			<ul class="ulleftmenu" style="border-right: 1px solid #ddd;">

				<li class="limenuitem">
					<i class="icon-cog menuicon"></i>系统菜单<b class="arrow icon-angle-down arrow-down"></b>
					<ul class="ulleftsubitems">
						<a href="class.aspx" target="right">
							<li>学科类管理</li>
						</a>
						<a href="subject.aspx" target="right">
							<li>学科管理</li>
						</a>
						<a href="periodical.aspx" target="right">
							<li>期刊管理</li>
						</a>							
						<a href="coreDatabase.aspx" target="right">
							<li>核心数据库管理</li>
						</a>						
						<a href="message.aspx" target="right">
							<li>留言查看</li>
						</a>
						<a href="user.aspx" target="right">
							<li>用户管理</li>
						</a>
						<a href="updatePwd.aspx" target="right">
							<li >修改密码</li>
						</a>
					</ul>
				</li>
			</ul>
			<div style="position: absolute; left: 191px; right: 20px; ">
				<iframe id="external-frame" onload="setIframeHeight(this)" src="class.aspx" scrolling="no"  width="100%" height="870" name="right" border="none"></iframe>
			</div>
		</div>
		
		<script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
		<script src="js/plugs/Jqueryplugs.js" type="text/javascript"></script>
		<script src="js/_layout.js"></script>		
    </form>
	<script>
		var showmenu = function () {
			var li = document.getElementById('myli')
            if (li.style.display == "block") {
               // li.style.display = "none"
            }
            else
                li.style.display = "block"
        }
    </script>
</body>
</html>
