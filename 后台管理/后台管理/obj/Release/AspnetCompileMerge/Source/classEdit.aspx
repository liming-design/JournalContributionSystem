<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="classEdit.aspx.cs" Inherits="后台管理.classEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
	<link href="css/Site.css" rel="stylesheet" />
    <link href="css/zy.all.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="css/amazeui.min.css" rel="stylesheet" />
    <link href="css/admin.css" rel="stylesheet" />		
	<link href="css/aspnetpager.css" rel="stylesheet" />
</head>
<body>
    <div class="am-cf admin-main" style="padding-top: 0px;">
		<!-- content start -->
        <form id="form1" runat="server">
			<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
					<Services>
							<asp:ServiceReference Path="~/WebService1.asmx" />
					</Services>
			</asp:ScriptManager>
	    </form>	
		<div class="admin-content">
				<div class="admin-content-body">				
						<div class="am-g">
								<div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">						
								</div>
								<div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4"style="padding-top: 30px;">						
										<form id="formadd" class="am-form am-form-horizontal">																								
												<div class="am-form-group">
															<label for="user-name" class="am-u-sm-3 am-form-label">分类名称</label>						
															<div class="am-u-sm-9">
																<input type="text" id="classname" required placeholder="分类名称" name="name"/>							
																
															</div>
														</div>														
												<div class="am-form-group">
																<div class="am-u-sm-9 am-u-sm-push-3">
																	<input onclick="OnUpdate()" class="am-btn am-btn-success" value="修改" />
																</div>
															</div>
										</form>
								</div>
						</div>
				</div>		
		</div>
		<!-- content end -->
	</div>
	<script>
        var URL = window.location.search; //？xx=aa&yy=b  形式
        URL = URL.split('?')[1]; //获取参数列表
		var id = URL.split('=')[1];
        var table = parent.document.getElementById('tbRecord');
        //根据传过来的id在父页面中找到相应的名称填入到对应框中
        for (var i = 0; i < table.rows.length; i++) {                                         //遍历Table的所有Row
            var td = table.rows[i].cells[1];
            var currentid = td.firstChild.id;
            if (currentid == id) {
                var classname = table.rows[i].cells[0].innerHTML;               
                var input = document.getElementById('classname');
                input.value = classname;                
                break;
            }
		}
		function OnUpdate() {
            var className = document.getElementById("classname").value;
            args = [id, className];
			后台管理.WebService1.ClaUpdate(args,UpSuccess, UpFaile, args);
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index);
		}
        function UpSuccess(result, args) {
            if (result == true) {
                window.alert("修改成功！");
                var ClaName = args[1]; 
                var table = parent.document.getElementById('tbRecord');
                //修改父页面中的内容
                for (var i = 0; i < table.rows.length; i++) {                                         //遍历Table的所有Row
                    var td = table.rows[i].cells[1];
                    var currentid = td.firstChild.id;
                    if (currentid == id) {
                        table.rows[i].cells[0].innerHTML = ClaName;                       
                        break;
                    }
                }
            }
            else
                window.alert("修改失败！错误代码：0");

        }
        function UpFaile(result) {
            window.alert("修改失败！错误代码：1");
        }

    </script>
</body>
</html>
