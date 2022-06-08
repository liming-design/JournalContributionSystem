<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="perioEdit.aspx.cs" Inherits="后台管理.perioEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
	<link rel="stylesheet" href="css/amazeui.min.css" />
</head>
<body>
    <div class="admin-content">
		<div class="admin-content-body">				
			<div class="am-g">
				<div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">						
				</div>
				<div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4"style="padding-top: 30px;">						
					<form class="am-form am-form-horizontal" id="form2">	
                          <asp:Repeater ID="RepPage2" runat="server">
								<ItemTemplate>
									<div class="am-form-group">
										<label for="user-email" class="am-u-sm-3 am-form-label">
											<%#Eval("COLUMN_NAME") %>
										</label>
										<div class="am-u-sm-9">
											<%#Eval("Input") %>
											<small></small>
										</div>
									</div>
							   </ItemTemplate>
                          </asp:Repeater>																																																							
						  <div class="am-form-group">								
								<div class="am-u-sm-9 am-u-sm-push-3">
									<input onclick="OnUpdate(this)" class="am-btn am-btn-success" value="修改期刊" />
								</div>
						  </div>
				   </form>
			   </div>
		    </div>			
		</div>
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
		//根据传过来的id在父页面中找到相应的名称填入到对应框中
		后台管理.WebService1.GetInfobyPerID(id, Onsuccess, Onfailed);
		function Onsuccess(result) {
			if (result != null) {
				var form2 = document.getElementById("form2");
				var inputs = form2.getElementsByTagName("input");
				for (var i = 0; i < inputs.length-1; i++) {
					inputs[i].value = result[i + 1];
                }				
			}
			else
				window.alert("未找到该期刊！");
		}
		function Onfailed(result) {
			window.alert("加载失败！");
        }
		
  		
        function OnUpdate(obj)
		{
			var args = [];
            var form2 = document.getElementById("form2");
			var inputs = form2.getElementsByTagName("input");
			args.push(id);
			for (var i = 0; i < inputs.length-1; i++) {
				args.push(inputs[i].value);
            }           
			后台管理.WebService1.PerUpdate(args, UpSuccess, UpFaile, args);
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index);
		}

		function UpSuccess(result, args) {
			if (result == true) {
				window.alert("修改成功！");
				var SubName = args[1]; var SubClassName = args[2];
				var table = parent.document.getElementById('tbRecord');
				//修改父页面中的内容
				for (var i = 0; i < table.rows.length; i++) {                                         //遍历Table的所有Row
					var td = table.rows[i].cells[9];
					var currentid = td.firstChild.id;
					if (currentid == id) {
						for (var j = 0; j < table.rows[i].cells.length - 4; j++) {
							table.rows[i].cells[j].innerHTML = args[j+1];
                        }						
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
