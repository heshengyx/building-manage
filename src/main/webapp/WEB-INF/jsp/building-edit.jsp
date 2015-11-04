<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<form class="form-horizontal" role="form">
	<div class="form-group">
		<label class="col-sm-2 control-label no-padding-right" for="buildingNameEdit">楼盘名称</label>
		<div class="col-sm-10">
			<input type="text" id="buildingNameEdit" placeholder="楼盘名称" class="col-xs-10 col-sm-10" />
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-2 control-label no-padding-right" for="buildingAddressEdit">楼盘地址</label>
		<div class="col-sm-10">
			<input type="text" id="buildingAddressEdit" placeholder="楼盘地址" class="col-xs-10 col-sm-10" />
		</div>
	</div>
	
	<div class="form-group">
		<div class="col-md-offset-2 col-md-10">
			<button class="btn btn-sm btn-info" type="button" id="btn-edit"><i class="icon-ok bigger-110"></i>查 询</button>
			&nbsp; &nbsp; &nbsp;
			<button class="btn btn-sm" type="reset"><i class="icon-undo bigger-110"></i>重 置</button>
		</div>
	</div>
</form>
<script type="text/javascript">	
$(document).ready(function() {
	alert(1);
});
</script>