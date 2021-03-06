<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="class.aspx.cs" Inherits="后台管理._class" %>

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
		<div class="dvcontent">
			<div>
				<!--tab start-->
				<div class="tabs">
					<div class="hd">
						<ul style="">
							<li style="box-sizing: initial;-webkit-box-sizing: initial;" class="on">查看分类</li>
							<li class="" style="box-sizing: initial;-webkit-box-sizing: initial;">添加分类</li>
							<li class="" style="box-sizing: initial;-webkit-box-sizing: initial;">批量添加</li>
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
												<asp:Repeater ID="RepHead" runat="server">
													<ItemTemplate>
														<th><%#Eval("COLUMN_NAME") %></th>							
													</ItemTemplate>												
												</asp:Repeater>
												<th>编辑</th>
												<th>删除</th>
											</tr>											
										</thead>
										<tbody id="tbody1">								
                                            <asp:Repeater ID="Repeater1" runat="server">
												<ItemTemplate>
													<tr>														
														<td><%#Eval("学科大类名称") %></td>												
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

						<%--第二个tab窗体--%>
						<ul class="theme-popbod dform" style="display: none;">
			<!-- content start -->
			
								<div class="am-cf admin-main" style="padding-top: 0px;">
		<!-- content start -->
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
																<input type="text" id="user-name" required placeholder="分类名称" name="name"/>							
																
															</div>
														</div>
														
															<div class="am-form-group">
																<div class="am-u-sm-9 am-u-sm-push-3">
																	<input  onclick="OnAdd()" class="am-btn am-btn-success" value="添加分类" />
																</div>
															</div>
													</form>
												</div>
											</div>
										</div>		
									</div>
		<!-- content end -->
								</div>
							<!-- end-->
						</ul>

						<%--第三个tab窗体--%>
						<ul class="" style="display: none;padding: 20px;">
							<div id="dv11">
								<form id ="form2" runat="server">
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
									<div id="file-list2"></div>									
									<asp:ScriptManager ID="ScriptManager2" runat="server" EnablePageMethods="true">
										<Services>
											<asp:ServiceReference Path="~/WebService1.asmx" />
										</Services>
									</asp:ScriptManager>
								
									<%--table--%>
									<table class="table" id="tbRecord1">
										<thead>
											<tr>
												<th>选择</th>
												<th>大类名称</th>
												<th>编辑</th>
												<th>删除</th>
											</tr>
										</thead>
										<tbody>
                                            <asp:Repeater ID="Repeater2" runat="server">
												<ItemTemplate>
													<tr>													
														<td><input type="checkbox" checked="true" /></td>													
														<td><%#Eval("大类名称") %></td>										
														<td class="edit"><button onclick="OnEdit(this)"><i class="icon-edit bigger-120"></i>编辑</button></td>
														<td class="delete"><button onclick="OnDelete(this)"><i class="icon-trash bigger-120"></i>删除</button></td>
													</tr>
												</ItemTemplate>
                                            </asp:Repeater>											
										</tbody>							
									</table>
									<%--分页组件--%>
									
								
								<input class="am-btn am-btn-success" onclick="batchInsertClass()" value="批量插入" />
									
							</div>
						</ul>

					</form>
					</div>
				</div>
				<!--tab end-->
			</div>		
			 <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
             <script src="js/plugs/Jqueryplugs.js" type="text/javascript"></script>
             <script src="js/_layout.js"></script>
             <script src="js/plugs/jquery.SuperSlide.source.js"></script>
            <script src="js/classScrip.js"></script>
			<script src="js/layer/layer.js"></script>
			 <script>
                var num = 1;
                $(function () {

                    $(".tabs").slide({ trigger: "click" });

                });
            </script>
		</div>
	</body>
</html>
