<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<form class="form-search">
	<div class="row">
		<div class="col-xs-8 col-sm-8">
			<div class="input-group">
				<input type="text" id="unitName" class="form-control search-query" placeholder="栋座" />
				<span class="input-group-btn">
					<button type="button" class="btn btn-info btn-sm" id="btn-query">查 询<i class="icon-search icon-on-right bigger-110"></i></button>
				</span>
			</div>
		</div>
		<div class="col-xs-4 col-sm-4 text-right">
			<button type="button" class="btn btn-info btn-sm">新 增</button>
		</div>
	</div>
</form>
<br>
<table id="unitGridTable"></table>
<div id="unitGridPager"></div>
<script type="text/javascript">	
$(document).ready(function() {
	/* var url = "${ctx}/manage/building/getData?random="+ Math.random();
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
			$("#buildingNameText").text(result.data.buildingName);
		}
	}, "json"); */
	
	$("#unitGridTable").jqGrid({
		url: "${ctx}/manage/buildingUnit/query?buildingId=${param.buildingId}",
		datatype: "json",
		colModel: [
			{label:'id', name:'id', key:true, index:'id', hidden:true},
			{label:'栋座名称', name:'name', index:'name'},
			{label:'楼层', name:'floor', index:'floor', width:50},
			{label:'创建时间', name:'createTime', index:'createTime', width:100, formatter:to_date_hms},
			{label:'操作', name:'opts', index:'opts', width:50, align:'center', formatter: function(cellval, options, row) {
				var content = "";
				content += "<div class=\"visible-md visible-lg hidden-sm hidden-xs action-buttons\">";
				content += "<a class=\"green\" href=\"javascript:void(0);\" onclick=\"doModifyUnit('" + row.id + "')\"><i class=\"icon-pencil bigger-130\"></i></a>";
				content += "<a class=\"red\" href=\"javascript:void(0);\" onclick=\"doTrashUnit('" + row.id + "');\"><i class=\"icon-trash bigger-130\"></i></a>";
				content += "</div>";
				return content;
			}}
		],
		rowNum: 30,
	   	rowList: [10, 20, 30],
	   	rownumbers: true,
	   	pager: "#unitGridPager",
	   	jsonReader : {
			root : 'data',
			page : 'index',
			total : 'total',
			records : 'totalRecord',
			repeatitems : false
		},
	   	viewrecords: true,
	   	//multiselect: true,
	   	//altRows: true,
	   	//multiboxonly: true,
	   	loadComplete : function() {
			/* var table = this;
			setTimeout(function(){
				styleCheckbox(table);
				updateActionIcons(table);
				updatePagerIcons(table);
				enableTooltips(table);
			}, 0); */
		},
		width: 680,
		height: 330
	});
	
	$("#btn-query").click(function() {
		doSearchUnit();
	});
});
function doSearchUnit() {
	var page = $("#unitGridTable").jqGrid("getGridParam", "page");
	$("#unitGridTable").clearGridData();
	$("#unitGridTable").jqGrid("setGridParam", {
		url : "${ctx}/manage/buildingUnit/query?random="+ Math.random(),
		page : page,
		postData : {
			buildingId : "${param.buildingId}",
			name : $.trim($("#unitName").val())
		},
		datatype: "json"
	}).trigger("reloadGrid");
}
function doModifyUnit(id) {
	var url = "${ctx}/manage/buildingUnit/edit?id=" + id + "&random=" + Math.random();
	var options = {
		title: '编辑',
		width: 300
	};
	showDialog(url, options);
}
function doTrashUnit(id) {
	dialog({
	    title: '消息',
	    width: 200,
	    content: '确定要删除吗?',
	    okValue: '确定',
	    ok: function () {
	        this.title('删除中…');
	        var url = "${ctx}/manage/buildingUnit/delete?random="+ Math.random();
			var params = {
				id: id
			};
			$.post(url, params, function(result) {
				dialog({
  				    title: '消息',
  				    width: 200,
  				    content: '删除成功',
  				  	okValue: '确定',
  			    	ok: function () {
  			    		if ("500" == result.code) {
  			    			return true;
  			    		} else {
  			    			doSearchUnit();		
  			    		}  			    	
  			    	},
  			    	cancel: false
  				}).showModal();
			}, "json");
	    },
	    cancelValue: '取消',
	    cancel: true
	}).showModal();
}
</script>