<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="user.aspx.cs" Inherits="后台管理.user" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
		<link rel="stylesheet" href="css/Site.css" />
		<link rel="stylesheet" href="css/zy.all.css" />
		<link rel="stylesheet" href="css/font-awesome.min.css" />
		<link rel="stylesheet" href="css/amazeui.min.css" />
		<link rel="stylesheet" href="css/admin.css" />
		<link href="css/aspnetpager.css" rel="stylesheet" />
</head>
<body>
		<div class="dvcontent">

			<div>
				<!--tab start-->
				<div class="tabs">
					<div class="hd">
						<ul>
							<li class="on" style="box-sizing: initial;-webkit-box-sizing: initial;">查看用户</li>
							<li class="" style="box-sizing: initial;-webkit-box-sizing: initial;">添加用户</li>
						</ul>
					</div>
					<div class="bd">
						<%--第一个Tab窗体--%>
						<ul style="display: block;padding: 20px;">
							<li>
								<!--分页显示角色信息 start-->
								<div id="dv1">
									<table class="table" id="tbRecord">
										<thead>
											<tr>
                                                <asp:Repeater ID="RepHead" runat="server">
													<ItemTemplate>
														<th><%#Eval("COLUMN_NAME") %></th>
													</ItemTemplate>												
                                                </asp:Repeater>
												<th>修改</th>
												<th>删除</th>											
											</tr>
										</thead>
										<tbody id="tbody1">
                                            <asp:Repeater ID="Repbody" runat="server">
												<ItemTemplate>
													<tr>
														<td><%#Eval("账号") %></td>
														<td><%#Eval("用户名称") %></td>
														<td><%#Eval("密码") %></td>
														<td class="edit"><%#Eval("编辑") %></td>
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

						<%--第二个Tab窗体--%>
						<ul class="theme-popbod dform" style="display: none;">			
							<div class="am-cf admin-main" style="padding-top: 0px;">
							    <div class="admin-content">
								    <div class="admin-content-body">				
									    <div class="am-g">
										    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">						
											</div>
											<div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4"style="padding-top: 30px;">						
												<form class="am-form am-form-horizontal" id="formadd">																	
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
																<label for="user-email" class="am-u-sm-3 am-form-label">
																	密码确认
																</label>
																<div class="am-u-sm-9">
																	<input type = 'text' id = '' required placeholder = '密码确认' name = ''/>
																	<small></small>
																</div>
													</div>
													<div class="am-form-group">
														<div class="am-u-sm-9 am-u-sm-push-3">
															<input onclick="OnAdd(this)" class="am-btn am-btn-success" value="添加" />
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>		
								</div>
							</div>
						</ul>
						<form runat="server">
							<asp:ScriptManager ID="ScriptManager2" runat="server" EnablePageMethods="true">
										<Services>
											<asp:ServiceReference Path="~/WebService1.asmx" />
										</Services>
							</asp:ScriptManager>
						</form>			
			  <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
              <script src="js/plugs/Jqueryplugs.js" type="text/javascript"></script>
			  <script src="js/layer/layer.js"></script>
              <script src="js/_layout.js"></script>
             <script src="js/plugs/jquery.SuperSlide.source.js"></script>
             <script src="js/userScrip.js"></script>
			<script>
				var num = 1;
				$(function() {

				 $(".tabs").slide({ trigger: "click" });

				});

	
				
            </script>

		</div>
	</body>
</html>
