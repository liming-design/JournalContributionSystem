<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="perioDatabase.aspx.cs" Inherits="后台管理.perioDatabase" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

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
						<ul style="">
							<li style="box-sizing: initial;-webkit-box-sizing: initial;" class="on">已收录数据库</li>
							<li class="" style="box-sizing: initial;-webkit-box-sizing: initial;">添加收录关系</li>
											
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
												<asp:Repeater ID="RepHead" runat="server">
													<ItemTemplate>
														<th><%#Eval("COLUMN_NAME") %></th>							
													</ItemTemplate>												
												</asp:Repeater>											
												<th>删除</th>
											</tr>											
										</thead>
										<tbody id ="tbody1">								
                                            <asp:Repeater ID="Repbody" runat="server">
												<ItemTemplate>
													<tr>
														<td><input type="checkbox"  /></td>
														<td><%#Eval("核心期刊数据库名称") %></td>
														<td><%#Eval("缩写") %></td>																										
														<td><%#Eval("优先级") %></td>																										
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
									<table class="table" id="tbRecord1">                                    
										<thead>
											<tr>
												<th>选择</th>
												<asp:Repeater ID="Repeater1" runat="server">
													<ItemTemplate>
														<th><%#Eval("COLUMN_NAME") %></th>							
													</ItemTemplate>												
												</asp:Repeater>
												<th>添加</th>												
											</tr>											
										</thead>
										<tbody id="tbody2">								
                                            <asp:Repeater ID="Repeater2" runat="server">
												<ItemTemplate>
													<tr>
														<td><input type='checkbox' id='' /></td>
														<td><%#Eval("核心期刊数据库名称") %></td>
														<td><%#Eval("缩写") %></td>	
														<td><%#Eval("优先级") %></td>
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
			 <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
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
                     
                     后台管理.WebService1.DataIncluAddById(args, AddSuccess, AddFailed,obj);
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
                     后台管理.WebService1.PerioCoreRelaDelete(args, DeleteSuccess, DeleteFailed,obj);
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
