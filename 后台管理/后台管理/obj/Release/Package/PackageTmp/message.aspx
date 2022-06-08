<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="message.aspx.cs" Inherits="后台管理.message" %>

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
		<%--<link href="css/bootstrap.css" rel="stylesheet" />--%>	
</head>
    <body>
		<div class="dvcontent">
			<div>
				<!--tab start-->
				<div class="tabs">
					<div class="hd">
						<%--<ul>
							<li class="on" style="box-sizing: initial;-webkit-box-sizing: initial;">留言查看</li>						 
						</ul>--%>
					</div>
					<div class="bd">
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
												<th>删除</th>
											</tr>
										</thead>
										<tbody>
											<asp:Repeater ID="Repbody" runat="server">
												<ItemTemplate>
													<tr>														
														<td style="width:8%;"><%#Eval("姓名") %></td>	
														<td style="width:10%;"><%#Eval("联系方式") %></td>	
														<td><%#Eval("消息") %></td>	
														<td style="width:15%;"><%#Eval("时间") %></td>	
														<td style="width:10%;" class="delete"><%#Eval("删除") %></td>
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
					</div>				
				</div>
				<!--tab end-->

			</div>
			<form runat="server">
				<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
					<Services>
						<asp:ServiceReference Path="~/WebService1.asmx" />
					</Services>
				</asp:ScriptManager>
			</form>
			
			
			 <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
              <script src="js/plugs/Jqueryplugs.js" type="text/javascript"></script>
              <script src="js/_layout.js"></script>
             <script src="js/plugs/jquery.SuperSlide.source.js"></script>
			<script>
				var num = 1;
				$(function() {

				 $(".tabs").slide({ trigger: "click" });

				});
				function OnDelete(obj) {
                    var tr = obj.parentNode.parentNode;
                    var name = tr.cells[0].innerText;
                    if (confirm("确定要删除'" + name + "'这一项吗?")) {
                        var id = obj.id;
                        后台管理.WebService1.MessageDelete(id, Delsuccess, Delfailed, tr);
                    }
                }
	
                function Delsuccess(result, tr) {
                    if (result == true) {
                        window.alert("删除成功！");
                        tbody = tr.parentNode;
                        tbody.removeChild(tr);
                    }
                }

                function Delfailed(result, content) {
                    window.alert("删除失败！");
                }
            </script>

		</div>
	</body>
</html>
