<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!-- <p>楼盘名称：<span id="buildingNameText"></span></p> -->
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
		url: "${ctx}/manage/buildingUnit/query",
		datatype: "json",
		colModel: [
			{label:'id', name:'id', key:true, index:'id', hidden:true},
			{label:'栋座名称', name:'name', index:'name'},
			{label:'楼层', name:'floor', index:'floor', width:50},
			{label:'创建时间', name:'createTime', index:'createTime', width:100, formatter:to_date_hms},
			//{label:'操作', name:'opts', index:'opts', width:50, align:'center', formatter: "actions"}
			{label:'操作', name:'opts', index:'opts', width:50, align:'center', formatter: function(cellval, options, row) {
				var content = "";
				content += "<div class=\"visible-md visible-lg hidden-sm hidden-xs action-buttons\">";
				content += "<a class=\"green\" href=\"javascript:void(0);\" onclick=\"doModify('" + row.id + "')\"><i class=\"icon-pencil bigger-130\"></i></a>";
				content += "<a class=\"red\" href=\"javascript:void(0);\" onclick=\"doTrash('" + row.id + "');\"><i class=\"icon-trash bigger-130\"></i></a>";
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
	
	$("#btn-edit").click(function() {
		url = "${ctx}/manage/building/update?random="+ Math.random();
		params = {
			id: "${param.id}",
			buildingName: $("#buildingNameEdit").val(),
			buildingAddress: $("#buildingAddressEdit").val()
		};
		$.post(url, params, function(result) {
			dialog({
			    title: '消息',
			    width: 200,
			    content: result.message,
			    okValue: '确定',
			    ok: function () {
			    	_myDialog.close().remove();
	                doSearch();
		    	},
			    cancel: false
			}).showModal();
		}, "json");
	});
});
</script>