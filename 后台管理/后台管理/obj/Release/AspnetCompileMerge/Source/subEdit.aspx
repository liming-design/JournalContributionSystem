<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="subEdit.aspx.cs" Inherits="后台管理.subEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
		<link rel="stylesheet" href="css/amazeui.min.css" />
</head>
<body>
    <div class="am-cf admin-main" style="padding-top: 0px;">
		<!-- content start -->
		<div class="admin-content">
			<div class="admin-content-body">			
				<div class="am-g">
					<div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
						
					</div>
					<div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4"
						style="padding-top: 30px;">
						<form class="am-form am-form-horizontal">								
							<div class="am-form-group">
								<label for="name" class="am-u-sm-3 am-form-label">
									学科名称</label>
								<div class="am-u-sm-9">
									<input type="text" id="subName" required
										placeholder="学科名称" name="name">
										<small>10字以内...</small>
								</div>
							</div>

							<div class="am-form-group">
								<label for="user-email" class="am-u-sm-3 am-form-label">
								分类</label>
								<div class="am-u-sm-9">
									<select name="groupId" id="subClassName">
                                        <asp:Repeater ID="RepSelect" runat="server">
											<ItemTemplate>
												<option value=""><%#Eval("学科大类名称") %></option>
											</ItemTemplate>
                                        </asp:Repeater>
									</select> 
									<small>学科大类</small>
								</div>
							</div>
							<div class="am-form-group">
								<label for="name" class="am-u-sm-3 am-form-label">
									优先级</label>
								<div class="am-u-sm-9">
									<input type="text" id="priority" required
										placeholder="优先级" name="name"/>
										<small>10字以内...</small>
								</div>
							</div>
							<div class="am-form-group">
								<div class="am-u-sm-9 am-u-sm-push-3">
									<input onclick='OnUpdate(this)' class="am-btn am-btn-success" value="修改学科" />
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		
		</div>
		<!-- content end -->
	</div>
	<form id="form1" runat="server">
			<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
					<Services>
							<asp:ServiceReference Path="~/WebService1.asmx" />
					</Services>
			</asp:ScriptManager>
	</form>			

	<script>
		var URL = window.location.search; //？xx=aa&yy=b  形式
		URL = URL.split('?')[1]; //获取参数列表
		var id = URL.split('=')[1];   
		var table = parent.document.getElementById('tbRecord');
        var idIndex = table.rows[0].cells.length - 2;
		//根据传过来的id在父页面中找到相应的名称填入到对应框中
		for (var i = 0; i < table.rows.length; i++)
		{                                         //遍历Table的所有Row
			var td = table.rows[i].cells[idIndex];
			var currentid = td.firstChild.id;  
			if (currentid == id)
			{
                var subname = table.rows[i].cells[0].innerHTML;
                var classname = table.rows[i].cells[1].innerHTML;
				var priority = table.rows[i].cells[2].innerHTML;
				var input = document.getElementById('subName');
				var prinput = document.getElementById('priority');
                prinput.value = priority;
				input.value = subname;
				var select = document.getElementById('subClassName');
                for (var i = 0; i < select.options.length; i++) {
                    if (select.options[i].text == classname) {
                        select.options[i].selected = true;
                    }
                }
				break;
            }
		}
  		
        function OnUpdate(obj)
		{
            var SubName = document.getElementById("subName").value;           
			var priority = document.getElementById("priority").value;           
			var subclass = document.getElementById("subClassName");
			var index = subclass.selectedIndex;
			var SubClassName = subclass.options[index].innerText;
			//加优先级
			var arg = [id, SubName, SubClassName, priority];
			后台管理.WebService1.SubUpdate(arg, UpSuccess, UpFaile, arg);
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index);
		}

		function UpSuccess(result, args) {
			if (result == true) {
				window.alert("修改成功！");
				var SubName = args[1]; var SubClassName = args[2]; var priority = args[3];
				var table = parent.document.getElementById('tbRecord');
				//修改父页面中的内容
				
				for (var i = 0; i < table.rows.length; i++) {                   //遍历Table的所有Row
					var td = table.rows[i].cells[idIndex];
					var currentid = td.firstChild.id;
					if (currentid == id) {
						table.rows[i].cells[0].innerHTML = SubName;
						table.rows[i].cells[1].innerHTML = SubClassName;
						table.rows[i].cells[2].innerHTML = priority;
						break;
					}
				}
			}
			else
				window.alert("修改失败！错误代码：0");
			
		}
		function UpFaile(result)
		{
            window.alert("修改失败！错误代码：1");            
        }
    </script>
</body>
</html>
