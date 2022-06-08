﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="coreDatabaseEdit.aspx.cs" Inherits="后台管理.coreDatabaseEdit" %>

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
    <form id="form2" runat="server">
			<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
					<Services>
							<asp:ServiceReference Path="~/WebService1.asmx" />
					</Services>
			</asp:ScriptManager>
	</form>	
   <div class="am-cf admin-main" style="padding-top: 0px;">
							    <div class="admin-content">
								    <div class="admin-content-body">				
									    <div class="am-g">
										    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">						
											</div>
											<div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4"style="padding-top: 30px;">						
												<form class="am-form am-form-horizontal" id="form1">																	
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
															<input onclick="OnUpdate()" class="am-btn am-btn-success" value="修改" />
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>		
								</div>
							</div>
	<script>
        var URL = window.location.search; //？xx=aa&yy=b  形式
        URL = URL.split('?')[1]; //获取参数列表
        var id = URL.split('=')[1];
        var table = parent.document.getElementById('tbRecord');
		//根据传过来的id在父页面中找到相应的名称填入到对应框中
        var cellsnum = table.rows[0].cells.length;
        for (var i = 0; i < table.rows.length; i++) {      //遍历Table的所有Row
            var td = table.rows[i].cells[cellsnum - 2];
            var currentid = td.firstChild.id;
            if (currentid == id) {
                var corename = table.rows[i].cells[0].innerHTML;
				var shortname = table.rows[i].cells[1].innerHTML;
                var inputs = document.getElementById('form1').getElementsByTagName("input");
                for (var j = 0; j < cellsnum - 2; j++) {
                    inputs[j].value = table.rows[i].cells[j].innerHTML;
                }
                
                break;
            }
		}

        function OnUpdate() {          
            args = [id];
            var inputs = document.getElementById('form1').getElementsByTagName("input");
            for (var i = 0; i < inputs.length - 1; i++) {
                args.push(inputs[i].value);
            }
            后台管理.WebService1.CoreUpdate(args, UpSuccess, UpFaile, args);
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index);
        }
        function UpSuccess(result, args) {
            if (result == true) {
                window.alert("修改成功！");
                
                var table = parent.document.getElementById('tbRecord');
                //修改父页面中的内容
                for (var i = 0; i < table.rows.length; i++) {                                         //遍历Table的所有Row
                    var td = table.rows[i].cells[cellsnum-2];
                    var currentid = td.firstChild.id;
                    if (currentid == id) {
                        for (var j = 1; j < args.length; j++) {
                            table.rows[i].cells[j-1].innerHTML = args[j];
                        }
                       
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
