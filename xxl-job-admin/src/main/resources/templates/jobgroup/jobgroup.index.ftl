<!DOCTYPE html>
<html>
<head>
    <#import "../common/common.macro.ftl" as netCommon>
    <@netCommon.commonStyle />
  <!-- DataTables -->
  <link rel="stylesheet"
        href="${request.contextPath}/static/adminlte/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
  <title>${I18n.admin_name}</title>
</head>
<body class="hold-transition skin-blue sidebar-mini <#if cookieMap?exists && cookieMap["xxljob_adminlte_settings"]?exists && "off" == cookieMap["xxljob_adminlte_settings"].value >sidebar-collapse</#if> ">
<div class="wrapper layout-top-nav">
  <!-- header -->
    <@netCommon.commonHeader2 "jobgroup" />
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
              <div class="row">
                <div class="col-xs-3">
                  <div class="input-group">
                    <span class="input-group-addon">AppName</span>
                    <input type="text" class="form-control" id="appname"
                           placeholder="${I18n.system_please_input}AppName">
                  </div>
                </div>
                <div class="col-xs-3">
                  <div class="input-group">
                    <span class="input-group-addon">${I18n.jobgroup_field_title}</span>
                    <input type="text" class="form-control" id="title"
                           placeholder="${I18n.jobgroup_field_title}">
                  </div>
                </div>
                <div class="col-xs-1">
                  <button class="btn btn-block btn-info" id="searchBtn">${I18n.system_search}</button>
                </div>
                <div class="col-xs-1">
                  <button class="btn btn-block btn-success add"
                          type="button">${I18n.jobinfo_field_add}</button>
                </div>
              </div>
              <table id="jobgroup_list" class="table table-bordered table-striped display" width="100%">
                <thead>
                <tr>
                  <th name="id">ID</th>
                  <th name="appname">AppName</th>
                  <th name="title">${I18n.jobgroup_field_title}</th>
                  <th name="addressType">${I18n.jobgroup_field_addressType}</th>
                  <th name="registryList">OnLine ${I18n.jobgroup_field_registryList}</th>
                  <th>${I18n.system_opt}</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>

  <!-- 注册列表查看.模态框 -->
  <div class="modal fade" id="showRegistryListModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">${I18n.jobinfo_opt_registryinfo}</h4>
        </div>
        <div class="modal-body">
          <div class="data" style="word-wrap: break-word;"></div>
        </div>
        <div class="modal-footer">
          <div class="text-center">
            <button type="button" class="btn btn-info ok" data-dismiss="modal">${I18n.system_ok}</button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 新增.模态框 -->
  <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog ">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">${I18n.jobgroup_add}</h4>
        </div>
        <div class="modal-body">
          <form class="form" role="form" name="add-form" id="add-form">
            <div class="form-group">
              <label for="appname" class="control-label required">AppName</label>
              <input type="text" class="form-control" name="appname" id="appname"
                     placeholder="${I18n.system_please_input}AppName" maxlength="64">
            </div>
            <div class="form-group">
              <label for="title" class="control-label required">${I18n.jobgroup_field_title}</label>
              <input type="text" class="form-control" name="title" id="title"
                     placeholder="${I18n.system_please_input}${I18n.jobgroup_field_title}"
                     maxlength="12">
            </div>
            <div class="form-group">
              <label for="lastname" class="control-label required">${I18n.jobgroup_field_addressType}</label>
              <div class="radio"><label>
                  <input type="radio" name="addressType" value="0"/>${I18n.jobgroup_field_addressType_0}
                </label></div>
              <div class="radio">
                <label><input type="radio" name="addressType" value="1"/>${I18n.jobgroup_field_addressType_1}</label>
              </div>
            </div>
            <div class="form-group">
              <label for="addressList" class="control-label required">${I18n.jobgroup_field_registryList}</label>
              <textarea id="addressList" class="textarea" name="addressList" maxlength="20000"
                        placeholder="${I18n.jobgroup_field_registryList_placeholder}" readonly="readonly"
                        style="background-color:#eee; width: 100%; height: 100px; font-size: 14px; line-height: 15px; border: 1px solid #dddddd; padding: 5px;"></textarea>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default pull-left" data-dismiss="modal">${I18n.system_cancel}</button>
          <button type="submit" class="btn btn-primary" form="add-form">${I18n.system_save}</button>
        </div>
      </div>
    </div>
  </div>

  <!-- 更新.模态框 -->
  <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog ">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">${I18n.jobgroup_edit}</h4>
        </div>
        <div class="modal-body">
          <form class="form" role="form" name="update-form" id="update-form">
            <div class="form-group">
              <label for="appname" class="control-label required">AppName</label>
              <input type="text" class="form-control" name="appname" id="appname"
                     placeholder="${I18n.system_please_input}AppName" maxlength="64">
            </div>
            <div class="form-group">
              <label for="title" class="control-label required">${I18n.jobgroup_field_title}</label>
              <input type="text" class="form-control" name="title" id="title"
                     placeholder="${I18n.system_please_input}${I18n.jobgroup_field_title}"
                     maxlength="12">
            </div>
            <div class="form-group">
              <label for="lastname" class="control-label required">${I18n.jobgroup_field_addressType}</label>
              <div class="radio"><label>
                  <input type="radio" name="addressType" value="0"/>${I18n.jobgroup_field_addressType_0}
                </label></div>
              <div class="radio">
                <label><input type="radio" name="addressType" value="1"/>${I18n.jobgroup_field_addressType_1}</label>
              </div>
            </div>
            <div class="form-group">
              <label for="addressList" class="control-label required">${I18n.jobgroup_field_registryList}</label>
              <textarea class="textarea" name="addressList" maxlength="20000" id="addressList"
                        placeholder="${I18n.jobgroup_field_registryList_placeholder}" readonly="readonly"
                        style="background-color:#eee; width: 100%; height: 100px; font-size: 14px; line-height: 15px; border: 1px solid #dddddd; padding: 5px;"></textarea>
            </div>
            <input type="hidden" name="id">
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default pull-left" data-dismiss="modal">${I18n.system_cancel}</button>
          <button type="submit" class="btn btn-primary" form="update-form">${I18n.system_save}</button>
        </div>
      </div>
    </div>
  </div>

  <!-- footer -->
    <@netCommon.commonFooter />
</div>

<@netCommon.commonScript />
<!-- DataTables -->
<script src="${request.contextPath}/static/adminlte/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${request.contextPath}/static/adminlte/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script src="${request.contextPath}/static/js/jobgroup.index.1.js"></script>
</body>
</html>
