<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<form class="form-horizontal" role="form">
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="unitNameEdit">栋座名称</label>
		<div class="col-sm-9">
			<input type="text" id="unitNameEdit" placeholder="栋座名称" class="col-xs-5 col-sm-5" />
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label no-padding-right" for="unitFloorEdit">栋座楼层</label>
		<div class="col-sm-9">
			<input type="text" id="unitFloorEdit" placeholder="栋座楼层" class="col-xs-5 col-sm-5" />
		</div>
	</div>
	
	<div class="form-group">
		<div class="col-md-offset-3 col-md-9">
			<button class="btn btn-sm btn-info" type="button" id="btn-updateUnit"><i class="icon-ok bigger-110"></i>保 存</button>
		</div>
	</div>
</form>
<script type="text/javascript">	
$(document).ready(function() {
	var url = "${ctx}/manage/buildingUnit/getData?random="+ Math.random();
	var params = {
		id: "${param.id}"
	};
	$.post(url, params, function(result) {
		if ("500" == result.code) {
			dialog({
			    title: '消息',
			    width: 200,
			    content: result.message,
			    okValue: '确定',
			    ok: true,
			    cancel: false
			}).showModal();
		} else {
			$("#unitNameEdit").val(result.data.name);
			$("#unitFloorEdit").val(result.data.floor);
		}
	}, "json");
	
	$("#btn-updateUnit").click(function() {
		url = "${ctx}/manage/buildingUnit/update?random="+ Math.random();
		params = {
			id: "${param.id}",
			name: $("#unitNameEdit").val(),
			floor: $("#unitFloorEdit").val()
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
			    		doSearchUnit();
			    	}
		    	},
			    cancel: false
			}).showModal();
		}, "json");
	});
});
</script>