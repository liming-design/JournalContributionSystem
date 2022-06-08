﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="periodical.aspx.cs" Inherits="后台管理.periodical" %>

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
		<div class="dvcontent">
			<div>
				<!--tab start-->
				<div class="tabs" style="margin: 30px;">
					<%--tab的表头--%>
					<div class="hd">
						<ul>
							<li class="" style="box-sizing: initial;-webkit-box-sizing: initial;">期刊管理</li>
							<li class="" style="box-sizing: initial;-webkit-box-sizing: initial;">添加期刊</li>
							<li class="" style="box-sizing: initial;-webkit-box-sizing: initial;">批量添加</li>
						</ul>
					</div>

					<%--tab的主体--%>
					<div class="bd">
						<%--第一个tab的窗体--%>
						<ul style="display: none;padding: 20px;">
							<li>
								<div class="form-search">
									<input  id="inputname" type="text" class="input-medium search-query">
									<button type="" class="btn" onclick="selectbyname()">查找</button>
								</div>
								<div id="dv1">
									<%--table--%>
									<table class="table" id="tbRecord">
										<thead>
											<tr>
												<asp:Repeater ID="RepHead" runat="server">
													<ItemTemplate>
														<th><%#Eval("COLUMN_NAME") %></th>
													</ItemTemplate>
												</asp:Repeater>
												<th>所属学科</th>
												<th>所属数据库</th>
												<th>编辑</th>
												<th>删除</th>	
											</tr>											
										</thead>
										<tbody id="tbody1">
                                            <asp:Repeater ID="Repbody" runat="server">
												<ItemTemplate>
													<tr>
														<td><%#Eval("期刊名称") %></td>												
														<td><%#Eval("出版周期") %></td>														
														<th><%#Eval("ISSN") %></th>
														<th><%#Eval("CN") %></th>
														<td><%#Eval("复合影响因子") %></td>
														<td><%#Eval("综合影响因子") %></td>
														<td><%#Eval("出版地") %></td>
														<td class="details"><%#Eval("所属学科") %></td>
														<td class="details"><%#Eval("所属数据库") %></td>
														<td class="edit"><%#Eval("编辑") %></td>
														<td class="delete"><%#Eval("删除") %></td>														
													</tr>
												</ItemTemplate>
                                            </asp:Repeater>											
										</tbody>							
									</table>
									<%--分页组件--%>
									<div class="pull-right">
										<webdiyer:AspNetPager ID="AspNetPager1" runat="server" Width="100%" UrlPaging="true" CssClass="anpager"
											FirstPageText="首页" LastPageText="尾页" NextPageText="后页" PrevPageText="前页" CurrentPageButtonClass="cpb" PagingButtonSpacing="0"  OnPageChanged="AspNetPager1_PageChanged">
										</webdiyer:AspNetPager>
									</div>                                    
								</div>
								<!--分页显示角色信息 end-->
							</li>
						</ul>

						<%--第二个tab的窗体--%>
						<ul class="theme-popbod dform" style="display: none;">							
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
														<input onclick="OnAdd(this)" class="am-btn am-btn-success" value="添加期刊" />
													</div>
												</div>
											</form>
										</div>
									</div>			
								</div>
							</div>
						</ul>

						<%--第三个tab的窗体--%>
						<ul class="" style="display: none;padding: 20px;">
							<div id="dv11">
								<form id ="form1" runat="server">
									<div class="am-g ">								
										<div class="am-u-sm-2  am-form-file">  
											<button type="button" class="am-btn  am-btn-danger am-btn-sm">
											<asp:FileUpload ID="FileUpload1"   CssClass="" runat="server" />
												<i class="am-icon-cloud-upload"></i>
												选择要上传的文件
											</button>	
										</div>
										<asp:Label ID="sheetName" runat="server"></asp:Label>
										<div class="am-u-sm-1 am-u-sm-offset-2 am-form-file" style="padding:5px;">
											<asp:Button ID="Button1" CssClass="am-btn am-btn-default am-btn-sm"  runat="server" Text="批量导入" OnClick="Button1_Click" />
										</div>
										<div class="am-u-sm-1 am-u-sm-offset-2"></div>
									</div>
									
									<div id="file-list"></div>
									
									<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
										<Services>
											<asp:ServiceReference Path="~/WebService1.asmx" />
										</Services>
									</asp:ScriptManager>
								</form>
									<%--table--%>
									<table class="table" id="tbRecord1">
										<thead>
											<tr>
												<th>选择</th>
												<asp:Repeater ID="RepHead1" runat="server">
													<ItemTemplate>
														<th><%#Eval("COLUMN_NAME") %></th>
													</ItemTemplate>
												</asp:Repeater>
												<th>编辑</th>
												<th>删除</th>
											</tr>
										</thead>
										<tbody>
                                            <asp:Repeater ID="Repeater2" runat="server">
												<ItemTemplate>
													<tr>													
														<td><input type="checkbox" checked="true" /></td>
														<td><%#Eval("期刊名称") %></td>
														<td><%#Eval("出版周期") %></td>
														<td><%#Eval("ISSN") %></td>
														<td><%#Eval("CN") %></td>
														<td><%#Eval("复合影响因子") %></td>
														<td><%#Eval("综合影响因子") %></td>
														<td><%#Eval("出版地") %></td>
														<td><%#Eval("主办单位") %></td>										
														<td><%#Eval("官方地址") %></td>
														<td><%#Eval("知网地址") %></td>		
														<td><%#Eval("联系电话") %></td>
														<td><%#Eval("邮箱") %></td>
														<td><%#Eval("投稿须知链接") %></td>
														<td><%#Eval("投稿方式") %></td>
														<td><%#Eval("在线投稿地址") %></td>		
														<td><%#Eval("投稿邮箱") %></td>
														<td><%#Eval("邮寄地址") %></td>
														<td class="edit"><button onclick="btn_edit(1)"><i class="icon-edit bigger-120"></i>编辑</button></td>
														<td class="delete"><button onclick="btn_delete(1)"><i class="icon-trash bigger-120"></i>删除</button></td>
													</tr>
												</ItemTemplate>
                                            </asp:Repeater>											
										</tbody>							
									</table>
									<%--分页组件--%>
									<div class="pull-right">
										<webdiyer:AspNetPager ID="AspNetPager2" runat="server" Width="100%" UrlPaging="true" CssClass="anpager"
											FirstPageText="首页" LastPageText="尾页" NextPageText="后页" PrevPageText="前页" CurrentPageButtonClass="cpb" PagingButtonSpacing="0"  OnPageChanged="AspNetPager1_PageChanged">
										</webdiyer:AspNetPager>
									</div> 
								
								<input class="am-btn am-btn-success" onclick="batchInsert()" value="批量插入" />
									
								</div>
						</ul>

					</div>
				</div>
				<!--tab end-->
                
			</div>
			
	 <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
     <script src="js/plugs/Jqueryplugs.js" type="text/javascript"></script>
     <script src="js/layer/layer.js"></script>
	 <script src="js/perioScrip.js"></script>
     <script src="js/plugs/jquery.SuperSlide.source.js"></script>
	 <script>
         $(function () {
             $(".tabs").slide({ trigger: "click" });
         });
     </script>
		</div>
	</body>
</html>
