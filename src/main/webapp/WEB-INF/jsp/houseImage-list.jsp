<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>房源图片管理</title>
		<link rel="stylesheet" href="${ctx}/css/ui-dialog.css" />
	</head>

	<body>
		<div class="main-content">
			<div class="breadcrumbs" id="breadcrumbs">
				<script type="text/javascript">
					try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
				</script>

				<ul class="breadcrumb">
					<li>
						<i class="icon-home home-icon"></i>
						<a href="#">Home</a>
					</li>

					<li>
						<a href="#">Tables</a>
					</li>
					<li class="active">jqGrid plugin</li>
				</ul><!-- .breadcrumb -->

				<!-- <div class="nav-search" id="nav-search">
					<form class="form-search">
						<span class="input-icon">
							<input type="text" placeholder="Search ..." class="nav-search-input" id="nav-search-input" autocomplete="off" />
							<i class="icon-search nav-search-icon"></i>
						</span>
					</form>
				</div> -->
				<!-- #nav-search -->
			</div>

			<div class="page-content">
				<div class="page-header">
					<h1>
						房源图片管理
						<small><i class="icon-double-angle-right"></i>房源图片查询</small>
					</h1>
				</div>
				<!-- /.page-header -->

				<div class="row">
					<div class="col-xs-12">
						<!-- PAGE CONTENT BEGINS -->

						<!-- <div class="alert alert-info">
							<i class="icon-hand-right"></i>
							Please note that demo server is not configured to save the changes, therefore you may get an error message.
							<button class="close" data-dismiss="alert">
								<i class="icon-remove"></i>
							</button>
						</div> -->
						<form class="form-horizontal" role="form">
							<div class="form-group">
								<label class="col-sm-1 control-label no-padding-right" for="buildingName">楼盘名称</label>
								<div class="col-sm-11">
									<input type="text" id="buildingName" placeholder="楼盘名称" class="col-xs-10 col-sm-5" />
								</div>
							</div>
							
							
							<div class="form-group">
								<div class="col-md-offset-1 col-md-11">
									<button class="btn btn-sm btn-info" type="button" id="btn-search"><i class="icon-ok bigger-110"></i>查 询</button>
									&nbsp; &nbsp; &nbsp;
									<button class="btn btn-sm" type="reset"><i class="icon-undo bigger-110"></i>重 置</button>
									&nbsp; &nbsp; &nbsp;
									<button class="btn btn-sm btn-info" type="button" id="btn-add"><i class="icon-ok bigger-110"></i>新 增</button>
								</div>
							</div>
						</form>
						
						<table id="dataGridTable"></table>
						<div id="dataGridPager"></div>
						
						<!-- PAGE CONTENT ENDS -->
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.page-content -->
		</div><!-- /.main-content -->
		<jscript>
		<script src="${ctx}/js/date-time/bootstrap-datepicker.min.js"></script>
		<script src="${ctx}/js/jqGrid/jquery.jqGrid.min.js"></script>
		<script src="${ctx}/js/jqGrid/i18n/grid.locale-cn.js"></script>
		<script src="${ctx}/js/format-util.js"></script>
		<script src="${ctx}/js/dialog-min.js"></script>
		<script src="${ctx}/js/dialog-util.js"></script>
		<script type="text/javascript">	
		$(document).ready(function() {
			$("#dataGridTable").jqGrid({
				url: "${ctx}/manage/houseImage/query",
				datatype: "json",
				colModel: [
					{label:'id', name:'id', key:true, index:'id', hidden:true},
					{label:'创建时间', name:'createTime', index:'createTime', width:100, formatter:to_date_hms},
					{label:'操作', name:'opts', index:'opts', width:80, align:'center', formatter: function(cellval, options, row) {
						var content = "";
						content += "<div class=\"visible-md visible-lg hidden-sm hidden-xs action-buttons\">";
						content += "<a class=\"blue\" href=\"#\"><i class=\"icon-zoom-in bigger-130\"></i></a>";
						content += "<a class=\"green\" href=\"javascript:void(0);\" onclick=\"doModify('" + row.id + "')\"><i class=\"icon-pencil bigger-130\"></i></a>";
						content += "<a class=\"red\" href=\"javascript:void(0);\" onclick=\"doTrash('" + row.id + "');\"><i class=\"icon-trash bigger-130\"></i></a>";
						content += "</div>";
						return content;
					}}
				],
				rowNum: 30,
			   	rowList: [10, 20, 30],
			   	rownumbers: true,
			   	pager: "#dataGridPager",
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
				caption: "房源图片列表",
				autowidth: true
			});
			//navButtons
			jQuery('#dataGridTable').jqGrid('navGrid', '#dataGridPager',
				{ 	//navbar options
					edit: true,
					editicon : 'icon-pencil blue',
					add: true,
					addicon : 'icon-plus-sign purple',
					del: true,
					delicon : 'icon-trash red',
					search: true,
					searchicon : 'icon-search orange',
					refresh: true,
					refreshicon : 'icon-refresh green',
					view: true,
					viewicon : 'icon-zoom-in grey',
				}
			);
			
			$('#btn-search').click(function() {
				doSearch();
			});
			$("#btn-add").click(function() {
				var url = "${ctx}/manage/houseImage/add?random=" + Math.random();
				var options = {
					title: '新增',
					width: 500
				};
				showDialog(url, options);
			});
		});
		function styleCheckbox(table) {
		/**
			$(table).find('input:checkbox').addClass('ace')
			.wrap('<label />')
			.after('<span class="lbl align-top" />')
	
	
			$('.ui-jqgrid-labels th[id*="_cb"]:first-child')
			.find('input.cbox[type=checkbox]').addClass('ace')
			.wrap('<label />').after('<span class="lbl align-top" />');
		*/
		}
		function updateActionIcons(table) {
			/**
			var replacement = 
			{
				'ui-icon-pencil' : 'icon-pencil blue',
				'ui-icon-trash' : 'icon-trash red',
				'ui-icon-disk' : 'icon-ok green',
				'ui-icon-cancel' : 'icon-remove red'
			};
			$(table).find('.ui-pg-div span.ui-icon').each(function(){
				var icon = $(this);
				var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
				if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
			})
			*/
		}
		function updatePagerIcons(table) {
			var replacement = 
			{
				'ui-icon-seek-first' : 'icon-double-angle-left bigger-140',
				'ui-icon-seek-prev' : 'icon-angle-left bigger-140',
				'ui-icon-seek-next' : 'icon-angle-right bigger-140',
				'ui-icon-seek-end' : 'icon-double-angle-right bigger-140'
			};
			$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
				var icon = $(this);
				var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
				
				if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
			})
		}
		function enableTooltips(table) {
			$('.navtable .ui-pg-button').tooltip({container:'body'});
			$(table).find('.ui-pg-div').tooltip({container:'body'});
		}
		function doSearch() {
			var page = $("#dataGridTable").jqGrid("getGridParam", "page");
			$("#dataGridTable").clearGridData();
			$("#dataGridTable").jqGrid("setGridParam", {
				url : "${ctx}/manage/houseImage/query?random="+ Math.random(),
				page : page,
				postData : {
					//buildingName : $.trim($("#buildingName").val())
				},
				datatype: "json"
			}).trigger("reloadGrid");
		}
		function doModify(id) {
			var url = "${ctx}/manage/houseImage/edit?id=" + id + "&random=" + Math.random();
			var options = {
				title: '编辑',
				width: 500
			};
			showDialog(url, options);
		}
		function doTrash(id) {
			dialog({
			    title: '消息',
			    width: 200,
			    content: '确定要删除吗?',
			    okValue: '确定',
			    ok: function () {
			        this.title('删除中…');
			        var url = "${ctx}/manage/houseImage/delete?random="+ Math.random();
					var params = {
						id: id
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
			  				dialog({
			  				    title: '消息',
			  				    width: 200,
			  				    content: '删除成功',
			  				  	okValue: '确定',
			  			    	ok: function () {
			  			    		doSearch();			  			    	
			  			    	},
			  			    	cancel: false
			  				}).showModal();
			  			}
					}, "json");
			        //return false;
			    },
			    cancelValue: '取消',
			    cancel: true
			}).showModal();
		}
		</script>
		</jscript>
	</body>
</html>