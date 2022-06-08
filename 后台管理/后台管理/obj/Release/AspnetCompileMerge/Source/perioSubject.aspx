<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="perioSubject.aspx.cs" Inherits="后台管理.perio_subject" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
	<link rel="stylesheet" href="css/Site.css" />
	<link rel="stylesheet" href="css/zy.all.css" />
	<link rel="stylesheet" href="css/font-awesome.min.css" />
    <link href="css/bootstrap.css" rel="stylesheet" />
	<link rel="stylesheet" href="css/amazeui.min.css" />
	<link rel="stylesheet" href="css/admin.css" />
    <link href="css/aspnetpager.css" rel="stylesheet" /> 
</head>
<body>
	<form runat="server">
		<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
			<Services>
					<asp:ServiceReference Path="~/WebService1.asmx" />
			</Services>
		</asp:ScriptManager>
	</form>
    <div class="dvcontent">
			<div>
				<!--tab start-->
				<div class="tabs">
					<div class="hd">
						<ul>
							<li class="on" style="box-sizing: initial;-webkit-box-sizing: initial;">所属学科</li>
							<li class="" style="box-sizing: initial;-webkit-box-sizing: initial;">添加学科期刊关系</li>							
						</ul>
					</div>
                    
					<div class="bd">
						<%--第一个tab窗体--%>
						<ul style="display: block;padding: 20px;">
							<li>
								<!--分页显示角色信息 start-->
								<div id="dv1">
									<table class="table" id="tbRecord">
										<thead>
											<tr>
												<th>选择</th>
												<th>学科名称</th>
												<th>学科所属类</th>											
												<th>删除</th>
											</tr>											
										</thead>
										<tbody id="tbody1">
                                            <asp:Repeater ID="Repbody" runat="server">
												<ItemTemplate>
													<tr>			
														<td><input type='checkbox' id='' /></td>
														<td><%#Eval("学科名称") %></td>
														<td><%#Eval("学科所属类") %></td>														
														<td class="delete"><%#Eval("删除") %></td>
													</tr>
												</ItemTemplate>
                                            </asp:Repeater>	
										</tbody>									
									</table>
                                    
									<div class="pull-right">
										<webdiyer:AspNetPager ID="AspNetPager1" runat="server" Width="100%" UrlPaging="true" CssClass="anpager"
											FirstPageText="首页" LastPageText="尾页" NextPageText="后页" PrevPageText="前页" CurrentPageButtonClass="cpb" PagingButtonSpacing="0"  OnPageChanged="AspNetPager1_PageChanged">
										</webdiyer:AspNetPager>
									 </div>
								
								</div>
								<!--分页显示角色信息 end-->
							</li>
						</ul>

						<%--第二个tab窗体--%>
						<ul style="display: block;padding: 20px;">
							<li>
								<!--分页显示角色信息 start-->
								<div id="dv2">
									<table class="table" id="tbRecord2">
										<thead>
											<tr>
												<th>选择</th>
												<th>学科名称</th>
												<th>学科所属类</th>
												<th>添加</th>						
											</tr>											
										</thead>
										<tbody id="tbody2">
                                            <asp:Repeater ID="Repeater1" runat="server">
												<ItemTemplate>
													<tr>			
														<td><input type='checkbox' id='' /></td>
														<td><%#Eval("学科名称") %></td>
														<td><%#Eval("学科所属类") %></td>														
														<td class="edit"><%#Eval("添加") %></td>														
													</tr>
												</ItemTemplate>
                                            </asp:Repeater>	
										</tbody>									
									</table>
                                    
									<div class="pull-right">
										<webdiyer:AspNetPager ID="AspNetPager2" runat="server" Width="100%" UrlPaging="true" CssClass="anpager"
											FirstPageText="首页" LastPageText="尾页" NextPageText="后页" PrevPageText="前页" CurrentPageButtonClass="cpb" PagingButtonSpacing="0"  OnPageChanged="AspNetPager2_PageChanged">
										</webdiyer:AspNetPager>
									 </div>								
								</div>
								<!--分页显示角色信息 end-->
							</li>
						</ul>						
					</div>
				</div>
				<!--tab end-->

			</div>
			<script src="js/jquery-1.7.2.min.js"></script>	
			<script src="js/layer/layer.js"></script>
            <script src="js/plugs/Jqueryplugs.js" type="text/javascript"></script>
            <script src="js/_layout.js"></script>
            <script src="js/plugs/jquery.SuperSlide.source.js"></script>
			<script>
                var num = 1;
                $(function () {

                    $(".tabs").slide({ trigger: "click" });

				});

                var URL = window.location.search; //？xx=aa&yy=b  形式
                URL = URL.split('?')[1]; //获取参数列表
                var id = URL.split('=')[1];
                function OnAdd(obj) {
                    args = [id, obj.id];

                    后台管理.WebService1.SubPerioRelaAddById(args, AddSuccess, AddFailed, obj);
                }
                function AddSuccess(resut, obj) {
                    var tr = obj.parentNode.parentNode;
                    if (resut == "成功") {
                        window.alert("添加成功！");
                        var tbody = tr.parentNode;
                        tbody.removeChild(tr);
                        var table1 = document.getElementById("tbody1");
                        var x = table1.insertRow(0);
                        for (var i = 0; i < 3; i++) {
                            x.insertCell(i).innerHTML = tr.cells[i].innerHTML;
                        }
                        x.innerHTML += "<td class='delete'><button id='" + obj.id + "' onclick='OnDelete(this)'><i class='icon - trash bigger - 120'></i>删除</button></td>"
                    }
                }
                function AddFailed(result) {
                    window.alert("添加失败！");
                }


                function OnDelete(obj) {
                    var args = [id, obj.id];
                    后台管理.WebService1.PerioSubDelete(args, DeleteSuccess, DeleteFailed, obj);
                }

                function DeleteSuccess(resut, obj) {
                    var tr = obj.parentNode.parentNode;
                    if (resut == true) {
                        window.alert("删除成功！");
                        var tbody = tr.parentNode;
                        tbody.removeChild(tr);
                        var table1 = document.getElementById("tbody2");
                        var x = table1.insertRow(0);
                        for (var i = 0; i < 3; i++) {
                            x.insertCell(i).innerHTML = tr.cells[i].innerHTML;
                        }
                        x.innerHTML += "<td class='edit'><button id='" + obj.id + "' onclick='OnAdd(this)'><i class='icon - plus bigger - 120'></i>添加</button></td>";
                    }
                }
                function DeleteFailed(result) {
                    window.alert("删除失败！");
                }
            </script>

		</div>
</body>
</html>
