<!DOCTYPE html>
<html>
<head>
  	<#import "../common/common.macro.ftl" as netCommon>
	<@netCommon.commonStyle />
	<!-- DataTables -->
  	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
    <title>${I18n.admin_name}</title>
</head>
<body class="hold-transition skin-blue sidebar-mini <#if cookieMap?exists && cookieMap["xxljob_adminlte_settings"]?exists && "off" == cookieMap["xxljob_adminlte_settings"].value >sidebar-collapse</#if>">
<div class="wrapper layout-top-nav">
	<!-- header -->
	<@netCommon.commonHeader2 "user" />

	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
	    <section class="content">
			<div class="row">
				<div class="col-xs-12">
					<div class="box">
						<div class="box-body">
							<div class="row">
								<div class="col-xs-3">
									<div class="input-group">
										<span class="input-group-addon">${I18n.user_role}</span>
										<select class="form-control" id="role">
											<option value="-1">${I18n.system_all}</option>
											<option value="1">${I18n.user_role_admin}</option>
											<option value="0">${I18n.user_role_normal}</option>
										</select>
									</div>
								</div>
								<div class="col-xs-3">
									<div class="input-group">
										<span class="input-group-addon">${I18n.user_username}</span>
										<input type="text" class="form-control" id="username" autocomplete="on">
									</div>
								</div>
								<div class="col-xs-1">
									<button class="btn btn-block btn-info" id="searchBtn">${I18n.system_search}</button>
								</div>
								<div class="col-xs-1">
									<button class="btn btn-block btn-success add"
											type="button">${I18n.user_add}</button>
								</div>
							</div>
							<table id="user_list" class="table table-bordered table-striped" width="100%">
								<thead>
								<tr>
									<th name="id">ID</th>
									<th name="username">${I18n.user_username}</th>
									<th name="password">${I18n.user_password}</th>
									<th name="role">${I18n.user_role}</th>
									<th name="permission">${I18n.user_permission}</th>
									<th>${I18n.system_opt}</th>
								</tr>
								</thead>
								<tbody></tbody>
								<tfoot></tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
	    </section>
	</div>

	<!-- footer -->
	<@netCommon.commonFooter />
</div>

<!-- 新增.模态框 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">${I18n.user_add}</h4>
			</div>
			<div class="modal-body">
				<form class="form" role="form" id="add-new-user">
					<div class="form-group">
						<label for="username" class="control-label required">${I18n.user_username}</label>
						<input type="text" class="form-control" name="username" id="username"
									 placeholder="${I18n.system_please_input}${I18n.user_username}" maxlength="20">
					</div>
					<div class="form-group">
						<label class="control-label required">${I18n.user_password}</label>
						<input type="text" class="form-control" name="password"
									 placeholder="${I18n.system_please_input}${I18n.user_password}" maxlength="20">
					</div>
					<div class="form-group">
						<label class="control-label required">${I18n.user_role}</label>
						<div class="radio">
							<label>
								<input type="radio" name="role" value="0" checked/>${I18n.user_role_normal}
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="role" value="1"/>${I18n.user_role_admin}
							</label>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label">${I18n.user_permission}</label>
						<#if groupList?exists && groupList?size gt 0>
							<#list groupList as item>
								<div class="checkbox">
									<label>
										<input type="checkbox" name="permission" value="${item.id}" />${item.title}(${item.appname})
									</label>
								</div>
							</#list>
						</#if>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default pull-left" data-dismiss="modal">${I18n.system_cancel}</button>
				<button type="submit" class="btn btn-primary" form="add-new-user">${I18n.system_save}</button>
			</div>
		</div>
	</div>
</div>

<!-- 更新.模态框 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">${I18n.user_update}</h4>
			</div>
			<div class="modal-body">
				<form class="form" role="form" id="edit-user">
					<div class="form-group">
						<label for="username" class="control-label required">${I18n.user_username}</label>
						<input type="text" class="form-control" name="username" id="username"
									 placeholder="${I18n.system_please_input}${I18n.user_username}" maxlength="20">
					</div>
					<div class="form-group">
						<label class="control-label required">${I18n.user_password}</label>
						<input type="text" class="form-control" name="password"
									 placeholder="${I18n.system_please_input}${I18n.user_password}" maxlength="20">
					</div>
					<div class="form-group">
						<label class="control-label required">${I18n.user_role}</label>
						<div class="radio">
							<label>
								<input type="radio" name="role" value="0" checked/>${I18n.user_role_normal}
							</label>
						</div>
						<div class="radio">
							<label>
								<input type="radio" name="role" value="1"/>${I18n.user_role_admin}
							</label>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label">${I18n.user_permission}</label>
						<#if groupList?exists && groupList?size gt 0>
							<#list groupList as item>
								<div class="checkbox">
									<label>
										<input type="checkbox" name="permission" value="${item.id}" />${item.title}(${item.appname})
									</label>
								</div>
							</#list>
						</#if>
					</div>
					<input type="hidden" name="id">
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default pull-left" data-dismiss="modal">${I18n.system_cancel}</button>
				<button type="submit" class="btn btn-primary" form="edit-user">${I18n.system_save}</button>
			</div>
		</div>
	</div>
</div>

<@netCommon.commonScript />
<!-- DataTables -->
<script src="${request.contextPath}/static/adminlte/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${request.contextPath}/static/adminlte/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script src="${request.contextPath}/static/js/user.index.1.js"></script>
</body>
</html>
