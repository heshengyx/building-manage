<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>房源新增</title>
		<link rel="stylesheet" href="${ctx}/css/ui-dialog.css" />
		<link rel="stylesheet" href="${ctx}/css/chosen.css" />
		<link rel="stylesheet" href="${ctx}/css/jquery-ui-1.10.3.full.min.css" />
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
						房源管理
						<small><i class="icon-double-angle-right"></i>房源查询</small>
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
								<label class="col-sm-2 control-label no-padding-right" for="buildingName">楼盘名称</label>
								<div class="col-sm-10">
								<select class="width-80 chosen-select" id="buildingName" data-placeholder="请选择一个楼盘">
									<option value="">&nbsp;</option>
									<option value="AL">Alabama</option>
									<option value="AK">Alaska</option>
									<option value="AZ">Arizona</option>
									<option value="AR">Arkansas</option>
									<option value="CA">California</option>
									<option value="CO">Colorado</option>
									<option value="CT">Connecticut</option>
									<option value="DE">Delaware</option>
									<option value="FL">Florida</option>
									<option value="GA">Georgia</option>
									<option value="HI">Hawaii</option>
									<option value="ID">Idaho</option>
									<option value="IL">Illinois</option>
									<option value="IN">Indiana</option>
									<option value="IA">Iowa</option>
									<option value="KS">Kansas</option>
									<option value="KY">Kentucky</option>
									<option value="LA">Louisiana</option>
									<option value="ME">Maine</option>
									<option value="MD">Maryland</option>
									<option value="MA">Massachusetts</option>
									<option value="MI">Michigan</option>
									<option value="MN">Minnesota</option>
									<option value="MS">Mississippi</option>
									<option value="MO">Missouri</option>
									<option value="MT">Montana</option>
									<option value="NE">Nebraska</option>
									<option value="NV">Nevada</option>
									<option value="NH">New Hampshire</option>
									<option value="NJ">New Jersey</option>
									<option value="NM">New Mexico</option>
									<option value="NY">New York</option>
									<option value="NC">North Carolina</option>
									<option value="ND">North Dakota</option>
									<option value="OH">Ohio</option>
									<option value="OK">Oklahoma</option>
									<option value="OR">Oregon</option>
									<option value="PA">Pennsylvania</option>
									<option value="RI">Rhode Island</option>
									<option value="SC">South Carolina</option>
									<option value="SD">South Dakota</option>
									<option value="TN">Tennessee</option>
									<option value="TX">Texas</option>
									<option value="UT">Utah</option>
									<option value="VT">Vermont</option>
									<option value="VA">Virginia</option>
									<option value="WA">Washington</option>
									<option value="WV">West Virginia</option>
									<option value="WI">Wisconsin</option>
									<option value="WY">Wyoming</option>
								</select>
								</div>
							</div>
							<input type="text" id="demo" value="ab" />
							<div class="form-group">
								<div class="col-md-offset-2 col-md-10">
									<button class="btn btn-sm btn-info" type="button" id="btn-save"><i class="icon-ok bigger-110"></i>保 存</button>
								</div>
							</div>
						</form>
						<input id="tags">
						<!-- PAGE CONTENT ENDS -->
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.page-content -->
		</div><!-- /.main-content -->
		<jscript>
		<script src="${ctx}/js/date-time/bootstrap-datepicker.min.js"></script>
		<script src="${ctx}/js/dialog-min.js"></script>
		<script src="${ctx}/js/dialog-util.js"></script>
		<script src="${ctx}/js/chosen.jquery.min.js"></script>
		<script src="${ctx}/js/jquery-ui-1.10.3.full.min.js"></script>
		<script type="text/javascript">
		function split( val ) {
	      	return val.split( /,\s*/ );
	    }
	    function extractLast( term ) {
	      	return split( term ).pop();
	    }
		$(document).ready(function() {
			
			var availableTags = [
              "ActionScript",
              "AppleScript",
              "Asp",
              "BASIC",
              "C",
              "C++",
              "Clojure",
              "COBOL",
              "ColdFusion",
              "Erlang",
              "Fortran",
              "Groovy",
              "Haskell",
              "Java",
              "JavaScript",
              "Lisp",
              "Perl",
              "PHP",
              "Python",
              "Ruby",
              "Scala",
              "Scheme"
            ];
            /* $("#tags").autocomplete({
              	//source: availableTags
            	serviceUrl: '${ctx}/manage/building/list',
            	onSelect: function (result) {
            		//alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
            		if (result.code != "500") {
		        		for (var i=0; i<result.data.length; i++) {
		        			alert('<option value="' + result.data[i].id + '">' + result.data[i].buildingName + '</option>');
		        		}
            		}
            	}
            }); */
            /* $("#tags").bind("keydown", function(event) {
        		if (event.keyCode === $.ui.keyCode.TAB &&
        			$(this).autocomplete("instance").menu.active) {
        			event.preventDefault();
        		}
        	}) */
        	$("#tags").autocomplete({
        		source: function( request, response ) {
        			var url = "${ctx}/manage/building/list?random="+ Math.random();
    		        var params = {
    		        	buildingName: request.term
    		        };
    		        $.post(url, params, function(result) {
    		        	if (result.code != "500") {
    		        		/* for (var i=0; i<result.data.length; i++) {
    		        			alert('<option value="' + result.data[i].id + '">' + result.data[i].buildingName + '</option>');
    		        		} */
    		        		
    		        		response( $.map( result.data, function( item ) {
    		                    return {
    		                      label: item.id,
    		                      value: item.buildingName
    		                    }
    		                }));
    		        	}
    		        }, "json");
        		}
        		/* source: function(request, response) {
        			$.getJSON("${ctx}/manage/building/list", {
        				term: extractLast(request.term)
        			}, response);
        		},
        		search: function() {
        			var term = extractLast(this.value);
        			if (term.length < 2) {
        				return false;
        			}
        		},
        		focus: function() {
        			return false;
        		},
        		select: function(event, ui) {
        			var terms = split(this.value);
        			// remove the current input
        			terms.pop();
        			// add the selected item
        			terms.push(ui.item.value);
        			// add placeholder to get the comma-and-space at the end
        			terms.push("");
        			this.value = terms.join(", ");
        			return false;
        		} */
        	});
			$("#buildingName").chosen({
				no_results_text: "没有找到",
				allow_single_de: true
			}); 
			chosen_ajaxify("buildingName", "");
			$("#buildingName").change(function() {
				alert($(this).val());
			});
			$("#btn-save").click(function() {
				var url = "${ctx}/manage/house/save?random="+ Math.random();
				var params = {
					buildingName: $("#buildingNameAdd").val()
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
		function chosen_ajaxify(id, ajax_url) {
			$('div#' + id + '_chosen .chosen-search input').keyup(function() {
				var keyword = $(this).val();
				var keyword_pattern = new RegExp(keyword, 'gi');
		        $('div#' + id + '_chosen ul.chosen-results').empty();
		        $("#"+id).empty();

		        var url = "${ctx}/manage/building/list?random="+ Math.random();
		        var params = {
		        	buildingName: keyword
		        };
		        $.post(url, params, function(result) {
		        	if (result.code != "500") {
		        		for (var i=0; i<result.data.length; i++) {
		        			$('#' + id).append('<option value="' + result.data[i].id + '">' + result.data[i].buildingName + '</option>');
		        		}
		        		
		        		$("#"+id).trigger("chosen:updated");
		        		$('div#' + id + '_chosen').removeClass('chosen-container-single-nosearch');
		                $('div#' + id + '_chosen .chosen-search input').val(keyword);
		                $('div#' + id + '_chosen .chosen-search input').removeAttr('readonly');
		                $('div#' + id + '_chosen .chosen-search input').focus();

		                $('div#' + id + '_chosen .active-result').each(function(){
		                    var html = $(this).html();
		                    $(this).html(html.replace(keyword_pattern, function(matched){
		                        return '<em>' + matched + '</em>';
		                    }));
		                });
		        	}
		        }, "json");
			});
		}
		</script>
		</jscript>
	</body>
</html>