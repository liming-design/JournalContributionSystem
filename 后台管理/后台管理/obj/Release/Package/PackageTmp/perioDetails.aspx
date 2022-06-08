<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="perioDetails.aspx.cs" Inherits="后台管理.perioDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="css/bootstrap.css" rel="stylesheet" />
	<style>
	 
	
	</style>
	
</head>
	<link rel="stylesheet" href="css/amazeui.min.css" />
<body>
    <div class="admin-content">
		<div class="admin-content-body">				
			<div class="am-g">
				<div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">						
				</div>
				<div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4"style="padding-top: 30px;">		
					
					<table class="table  table-striped" id="tbRecord">
                        <asp:Repeater ID="RepPage2" runat="server">
							<ItemTemplate>
								<tr>
									<td style="width:23%;"><%#Eval("COLUMN_NAME") %>:</td>
									<td><%#Eval("value") %></td>
								</tr>
							</ItemTemplate>
                        </asp:Repeater>
					</table>

					
			   </div>
		    </div>			
		</div>
	</div>
</body>
</html>
