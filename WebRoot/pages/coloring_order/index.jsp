<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@page import="com.fuwei.entity.ordergrid.ColoringOrder"%>
<%@page import="com.fuwei.entity.Salesman"%>
<%@page import="com.fuwei.entity.Company"%>
<%@page import="com.fuwei.entity.Factory"%>
<%@page import="com.fuwei.entity.User"%>
<%@page import="com.fuwei.commons.Pager"%>
<%@page import="com.fuwei.util.DateTool"%>
<%@page import="com.fuwei.constant.OrderStatus"%>
<%@page import="com.fuwei.commons.SystemCache"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.fuwei.entity.ordergrid.ColoringOrderDetail"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Pager pager = (Pager) request.getAttribute("pager");
	if (pager == null) {
		pager = new Pager();
	}
	List<ColoringOrder> coloringOrderlist = new ArrayList<ColoringOrder>();
	if (pager != null & pager.getResult() != null) {
		coloringOrderlist = (List<ColoringOrder>) pager.getResult();
	}

	Date start_time = (Date) request.getAttribute("start_time");
	String start_time_str = "";
	if (start_time != null) {
		start_time_str = DateTool.formatDateYMD(start_time);
	}
	Date end_time = (Date) request.getAttribute("end_time");
	String end_time_str = "";
	if (end_time != null) {
		end_time_str = DateTool.formatDateYMD(end_time);
	}

	
	Integer companyId = (Integer) request.getAttribute("companyId");
	String company_str = "";
	
	if (companyId != null) {
		company_str = String.valueOf(companyId);
	}
	
	if (companyId == null) {
		companyId = -1;
	}
	//订单状态status
	Integer status = (Integer) request.getAttribute("status");
	String status_str = "";
	if (status != null) {
		status_str = String.valueOf(status);
	}
	//订单状态status
	
	
	
	//2015-4-4添加
	Integer factoryId = (Integer) request.getAttribute("factoryId");
	String factory_str = "";
	if (factoryId != null) {
		factory_str = String.valueOf(factoryId);
	}
	
	if (factoryId == null) {
		factoryId = -1;
	}
	
	//2015-4-16添加orderNumber
	String number = (String) request.getAttribute("number");
	if (number == null) {
		number = "";
	}


	//权限相关
	Boolean has_order_detail = SystemCache.hasAuthority(session,
			"coloring_order/detail");
	Boolean has_order_edit = SystemCache.hasAuthority(session,
			"coloring_order/edit");
	Boolean has_order_delete = SystemCache.hasAuthority(session,
			"coloring_order/delete");
	
	//权限相关
%>
<!DOCTYPE html>

<html>
	<head>
		<base href="<%=basePath%>">
		<title>染色单管理 -- 桐庐富伟针织厂</title>
		<meta charset="utf-8">
		<meta http-equiv="keywords" content="针织厂,针织,富伟,桐庐">
		<meta http-equiv="description" content="富伟桐庐针织厂">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<!-- 为了让IE浏览器运行最新的渲染模式 -->
		<link href="css/plugins/bootstrap.min.css" rel="stylesheet"
			type="text/css" />
		<link href="css/plugins/font-awesome.min.css" rel="stylesheet"
			type="text/css" />
		<link href="css/common/common.css" rel="stylesheet" type="text/css" />
		<script src="js/plugins/jquery-1.10.2.min.js"></script>
		<script src="js/plugins/bootstrap.min.js" type="text/javascript"></script>
		<script src="<%=basePath%>js/plugins/WdatePicker.js"></script>
		<script src="js/common/common.js" type="text/javascript"></script>

		<link href="css/order/index.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
.body {
	min-width: 0;
}

#breadcrumbs {
	min-width: 0;
}
.table{
	border-color:#000;
}
.table>thead>tr{
	  background: #AEADAD;
}
.table>thead>tr>th,.table>tbody>tr>td{
	border-color:#000;
	border-bottom-width: 1px;
	word-break: break-all;
}
</style>
	</head>
	<body>
		<%@ include file="../common/head.jsp"%>
		<div id="Content">
			<div id="main">
				<div class="breadcrumbs" id="breadcrumbs">
					<ul class="breadcrumb">
						<li>
							<i class="fa fa-home"></i>
							<a href="user/index">首页</a>
						</li>
						<li class="active">
							染色单列表
						</li>
					</ul>
				</div>
				<div class="body">

					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12 tablewidget">
								<!-- Table -->
								<div clas="navbar navbar-default">
									<form class="form-horizontal form-inline searchform"
										role="form">
										<input type="hidden" name="page" id="page"
											value="<%=1%>" />
										<div class="form-group salesgroup">
											<label for="number" class="col-sm-3 control-label">
												单号
											</label>
											<div class="col-sm-9">
												<input class="form-control" type="text" name="number" id="number" value="<%=number %>" />
											</div>
										</div>
										<div class="form-group salesgroup">
											<label for="companyId" class="col-sm-3 control-label">
												公司
											</label>
											<div class="col-sm-9">
												<select class="form-control" name="companyId" id="companyId"
													placeholder="公司">
													<option value="">
														所有
													</option>
													<%
														for (Company company : SystemCache.companylist) {
															if (companyId == company.getId()) {
													%>
													<option value="<%=company.getId()%>" selected><%=company.getFullname()%></option>
													<%
														} else {
													%>
													<option value="<%=company.getId()%>"><%=company.getFullname()%></option>
													<%
														}
														}
													%>
												</select>
											</div>
										</div>
										<div class="form-group salesgroup">
											<label for="factoryId" class="col-sm-3 control-label">
												染色单位
											</label>
											<div class="col-sm-9">
												<select class="form-control" name="factoryId" id="factoryId">
													<option value="">
														所有
													</option>
													<%
														for (Factory factory : SystemCache.coloring_factorylist) {
															if (factoryId == factory.getId()) {
													%>
													<option value="<%=factory.getId()%>" selected><%=factory.getName()%></option>
													<%
														} else {
													%>
													<option value="<%=factory.getId()%>"><%=factory.getName()%></option>
													<%
														}
														}
													%>
												</select>
											</div>
										</div>

										<div class="form-group timegroup">
											<label class="col-sm-3 control-label">
												创建时间
											</label>

											<div class="input-group col-md-9">
												<input type="text" name="start_time" id="start_time"
													class="date form-control" value="<%=start_time_str%>" />
												<span class="input-group-addon">到</span>
												<input type="text" name="end_time" id="end_time"
													class="date form-control" value="<%=end_time_str%>">
											</div>
										</div>
										<button class="btn btn-primary" type="submit">
														搜索
													</button> 
									</form>
									<ul class="pagination">
										<li>
											<a
												href="coloring_order/index?number=<%=number %>&factoryId=<%=factory_str %>&status=<%=status_str %>&companyId=<%=company_str %>&start_time=<%=start_time_str %>&end_time=<%=end_time_str %>&page=1">«</a>
										</li>

										<%
										if (pager.getPageNo() > 1) {
									%>
										<li class="">
											<a
												href="coloring_order/index?number=<%=number %>&factoryId=<%=factory_str %>&status=<%=status_str %>&companyId=<%=company_str %>&start_time=<%=start_time_str %>&end_time=<%=end_time_str %>&page=<%=pager.getPageNo() - 1%>">上一页
												<span class="sr-only"></span> </a>
										</li>
										<%
										} else {
									%>
										<li class="disabled">
											<a disabled>上一页 <span class="sr-only"></span> </a>
										</li>
										<%
										}
									%>

										<li class="active">
											<a
												href="coloring_order/index?number=<%=number %>&factoryId=<%=factory_str %>&status=<%=status_str %>&companyId=<%=company_str %>&start_time=<%=start_time_str %>&end_time=<%=end_time_str %>&page=<%=pager.getPageNo() %>"><%=pager.getPageNo()%>/<%=pager.getTotalPage()%>，共<%=pager.getTotalCount()%>条<span
												class="sr-only"></span> </a>
										</li>
										<li>
											<%
											if (pager.getPageNo() < pager.getTotalPage()) {
										%>
										
										<li class="">
											<a
												href="coloring_order/index?number=<%=number %>&factoryId=<%=factory_str %>&status=<%=status_str %>&companyId=<%=company_str %>&start_time=<%=start_time_str %>&end_time=<%=end_time_str %>&page=<%=pager.getPageNo() + 1%>">下一页
												<span class="sr-only"></span> </a>
										</li>
										<%
										} else {
									%>
										<li class="disabled">
											<a disabled>下一页 <span class="sr-only"></span> </a>
										</li>
										<%
										}
									%>

										</li>
										<li>
											<a
												href="coloring_order/index?number=<%=number %>&factoryId=<%=factory_str %>&status=<%=status_str %>&companyId=<%=company_str %>&start_time=<%=start_time_str %>&end_time=<%=end_time_str %>&page=<%=pager.getTotalPage()%>">»</a>
										</li>
									</ul>

								</div>

								<table class="table table-responsive table-bordered">
									<thead>
										<tr>
											<th width="30px">
												序号
											</th>
											<th width="55px">
												染色单号
											</th>
											<th width="50px">
												染色单位
											</th>
											<th width="60px">
												订单号
											</th>
											<th width="40px">
												公司
											</th>
											<th width="40px">
												客户
											</th>
											<th width="60px">
												公司货号
											</th><th width="70px">
												品名
											</th><th width="40px">
												跟单
											</th><th width="60px">
												材料名
											</th><th width="55px">
												颜色
											</th><th width="50px">
												数量(kg)
											</th>
											<th width="40px">
												创建人
											</th>
											<th width="60px">
												订购日期
											</th>
											<th width="60px">
												操作
											</th>
										</tr>
									</thead>
									<tbody>
										<%
											int i = (pager.getPageNo()-1) * pager.getPageSize() + 0;
											for (ColoringOrder coloringOrder : coloringOrderlist) {
												List<ColoringOrderDetail> detailist = coloringOrder.getDetaillist();
												int detailsize = coloringOrder.getDetaillist().size();
										%>
										<tr orderId="<%=coloringOrder.getId()%>">
											<td rowspan="<%=detailsize %>"><%=++i%></td>
											<td rowspan="<%=detailsize %>"><%=coloringOrder.getNumber() == null ? "" : coloringOrder.getNumber()%></td>
											<td rowspan="<%=detailsize %>"><%=SystemCache.getFactoryName(coloringOrder.getFactoryId())%></td>
											<td rowspan="<%=detailsize %>">
											<%if(coloringOrder.getOrderId()==null){ %>
											<span class="label label-warning">样纱</span>
											<%}else{ %>
											<%=coloringOrder.getOrderNumber()%>
											<%} %></td>
											<td rowspan="<%=detailsize %>"><%=SystemCache.getCompanyShortName(coloringOrder
										.getCompanyId())%></td>
											<td rowspan="<%=detailsize %>"><%=SystemCache.getCustomerName(coloringOrder.getCustomerId())%></td>
											<td rowspan="<%=detailsize %>"><%=coloringOrder.getCompany_productNumber()%></td>
											<td rowspan="<%=detailsize %>"><%=coloringOrder.getName()%></td>
											<td rowspan="<%=detailsize %>"><%=SystemCache.getEmployeeName(coloringOrder.getCharge_employee())%></td>
									
											
											<td><%=SystemCache.getMaterialName(detailist.get(0).getMaterial())%></td>
											<td><%=detailist.get(0).getColor() %></td>
											<td><%=detailist.get(0).getQuantity()%></td>
											
										
												<td rowspan="<%=detailsize %>"><%=SystemCache.getUserName(coloringOrder
										.getCreated_user())%></td>
											<td rowspan="<%=detailsize %>"><%=DateTool.formatDateYMD(coloringOrder.getCreated_at())%></td>
											<td rowspan="<%=detailsize %>">
												<%
													if (has_order_detail) {
												%>
												<a target="_blank"
													href="coloring_order/detail/<%=coloringOrder.getId()%>">详情</a>
												<%
													}
												%>
												<%
												
													if (has_order_edit && coloringOrder.isEdit()) {
												%>
												|
												<a href="coloring_order/put/<%=coloringOrder.getId()%>">编辑</a>
												<%
														}
													%>
												<%
												
													if (has_order_delete && coloringOrder.deletable()) {
												%>
												|
												<a href="#" data-cid="<%=coloringOrder.getId() %>"
													class="delete">删除</a>
												<%
														}
													%>
													
											</td>
										
										</tr><%
										detailist.remove(0);
										for(ColoringOrderDetail detail : detailist){ %>
										<tr><td><%=SystemCache.getMaterialName(detail.getMaterial())%></td><td><%=detail.getColor() %></td><td><%=detail.getQuantity() %></td></tr>
										<%} %>
										<%
										}
										%>

									
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>

		<script type="text/javascript">
	/*设置当前选中的页*/
	var $a = $("#left li a[href='coloring_order/index']");
	setActiveLeft($a.parent("li"));
	//删除单据 -- 开始
	$(".delete").click( function() {
		var id = $(this).attr("data-cid");
		if (!confirm("确定要删除该单据吗？")) {
			return false;
		}
		$.ajax( {
			url :"coloring_order/delete/" + id,
			type :'POST'
		}).done( function(result) {
			if (result.success) {
				Common.Tip("删除单据成功", function() {
					location.reload();
				});
			}
		}).fail( function(result) {
			Common.Error("删除单据失败：" + result.responseText);
		}).always( function() {

		});
		return false;
	});
	//删除单据  -- 结束
</script>
	</body>
</html>