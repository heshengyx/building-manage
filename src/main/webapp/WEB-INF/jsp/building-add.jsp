<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<form class="form-horizontal" role="form">
	<div class="form-group">
		<label class="col-sm-2 control-label no-padding-right" for="buildingNameAdd">楼盘名称</label>
		<div class="col-sm-10">
			<input type="text" id="buildingNameAdd" placeholder="楼盘名称" class="col-xs-10 col-sm-10" />
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-2 control-label no-padding-right" for="buildingAddressAdd">楼盘地址</label>
		<div class="col-sm-10">
			<input type="text" id="buildingAddressAdd" placeholder="楼盘地址" class="col-xs-10 col-sm-10" />
		</div>
	</div>
	
	<div class="form-group">
		<div class="col-md-offset-2 col-md-10">
			<button class="btn btn-sm btn-info" type="button" id="btn-save"><i class="icon-ok bigger-110"></i>保 存</button>
			&nbsp; &nbsp; &nbsp;
			<button class="btn btn-sm" type="button" id="btn-close"><i class="icon-undo bigger-110"></i>关 闭</button>
		</div>
	</div>
</form>
<script type="text/javascript">	
$(document).ready(function() {
	$("#btn-save").click(function() {
		var url = "${ctx}/manage/building/save?random="+ Math.random();
		var params = {
			buildingName: $("#buildingNameAdd").val(),
			buildingAddress: $("#buildingAddressAdd").val()
		};
		$.post(url, params, function(result) {
			dialog({
			    title: '消息',
			    width: 200,
			    content: result.message,
			    okValue: '确定',
			    ok: function () {
			    	if (result.code == "500") {
			    		return true;	
			    	} else {
			    		_myDialog.close().remove();
		                doSearch();	
			    	}
		    	},
			    cancel: false
			}).showModal();
		}, "json");
	});
});
</script>