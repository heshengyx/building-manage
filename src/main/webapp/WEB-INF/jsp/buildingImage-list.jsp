<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<%@ taglib uri="/WEB-INF/tld/image-tag.tld" prefix="ImageTag" %>
<link rel="stylesheet" href="${ctx}/css/colorbox.css" />
<script src="${ctx}/js/jquery.colorbox-min.js"></script>
<div style="padding-left:2px;">
	<button class="btn btn-sm btn-info" type="button" id="btn-addImage"><i class="icon-ok bigger-110"></i>新 增</button>
</div>
<div class="row-fluid">
	<ul class="ace-thumbnails">
		<li>
			<a href="${ctx}/images/gallery/image-1.jpg" title="Photo Title" data-rel="colorbox">
				<img alt="150x150" src="${ctx}/images/gallery/thumb-1.jpg" />
				<div class="tags">
					<span class="label-holder">
						<span class="label label-info">breakfast</span>
					</span>
					<span class="label-holder">
						<span class="label label-danger">fruits</span>
					</span>
					<span class="label-holder">
						<span class="label label-success">toast</span>
					</span>
					<span class="label-holder">
						<span class="label label-warning arrowed-in">diet</span>
					</span>
				</div>
			</a>

			<div class="tools">
				<a href="#"><i class="icon-link"></i></a>
				<a href="#"><i class="icon-paper-clip"></i></a>
				<a href="#"><i class="icon-pencil"></i></a>
				<a href="#"><i class="icon-remove red"></i></a>
			</div>
		</li>

		<li>
			<a href="${ctx}/images/gallery/image-2.jpg" data-rel="colorbox">
				<img alt="150x150" src="${ctx}/images/gallery/thumb-2.jpg" />
				<div class="text">
					<div class="inner">Sample Caption on Hover</div>
				</div>
			</a>
		</li>
		<li>
			<a href="${ctx}/images/gallery/image-3.jpg" data-rel="colorbox">
				<img alt="150x150" src="${ctx}/images/gallery/thumb-3.jpg" />
				<div class="text">
					<div class="inner">Sample Caption on Hover</div>
				</div>
			</a>
			<div class="tools tools-bottom">
				<a href="#"><i class="icon-link"></i></a>
				<a href="#"><i class="icon-paper-clip"></i></a>
				<a href="#"><i class="icon-pencil"></i></a>
				<a href="#"><i class="icon-remove red"></i></a>
			</div>
		</li>

		<li>
			<a href="${ctx}/images/gallery/image-4.jpg" data-rel="colorbox">
				<img alt="150x150" src="${ctx}/images/gallery/thumb-4.jpg" />
				<div class="tags">
					<span class="label-holder">
						<span class="label label-info arrowed">fountain</span>
					</span>

					<span class="label-holder">
						<span class="label label-danger">recreation</span>
					</span>
				</div>
			</a>

			<div class="tools tools-top">
				<a href="#"><i class="icon-link"></i></a>
				<a href="#"><i class="icon-paper-clip"></i></a>
				<a href="#"><i class="icon-pencil"></i></a>
				<a href="#"><i class="icon-remove red"></i></a>
			</div>
		</li>

		<li>
			<div>
				<img alt="150x150" src="${ctx}/images/gallery/thumb-5.jpg" />
				<div class="text">
					<div class="inner">
						<span>Some Title!</span>
						<br />
						<a href="${ctx}/images/gallery/image-5.jpg" data-rel="colorbox"><i class="icon-zoom-in"></i></a>
						<a href="#"><i class="icon-user"></i></a>
						<a href="#"><i class="icon-share-alt"></i></a>
					</div>
				</div>
			</div>
		</li>

		<li>
			<a href="${ctx}/images/gallery/image-6.jpg" data-rel="colorbox">
				<img alt="150x150" src="${ctx}/images/gallery/thumb-6.jpg" />
			</a>
			<div class="tools tools-right">
				<a href="#"><i class="icon-link"></i></a>
				<a href="#"><i class="icon-paper-clip"></i></a>
				<a href="#"><i class="icon-pencil"></i></a>
				<a href="#"><i class="icon-remove red"></i></a>
			</div>
		</li>

		<li>
			<a href="${ctx}/images/gallery/image-1.jpg" data-rel="colorbox">
				<img alt="150x150" src="${ctx}/images/gallery/thumb-1.jpg" />
			</a>
			<div class="tools">
				<a href="#"><i class="icon-link"></i></a>
				<a href="#"><i class="icon-paper-clip"></i></a>
				<a href="#"><i class="icon-pencil"></i></a>
				<a href="#"><i class="icon-remove red"></i></a>
			</div>
		</li>

		<li>
			<a href="${ctx}/images/gallery/image-2.jpg" data-rel="colorbox">
				<img alt="150x150" src="${ctx}/images/gallery/thumb-2.jpg" />
			</a>
			<div class="tools tools-top">
				<a href="#"><i class="icon-link"></i></a>
				<a href="#"><i class="icon-paper-clip"></i></a>
				<a href="#"><i class="icon-pencil"></i></a>
				<a href="#"><i class="icon-remove red"></i></a>
			</div>
		</li>
	</ul>
	
	<ul id="image-box">
		<li>
			<a href="${ctx}/uploads/#href#" data-rel="colorbox">
				<img alt="150x150" src="${ctx}/uploads/#src#" style="width:150px;height:150px" />
				<div class="text">
					<div class="inner">#title#</div>
				</div>
			</a>
			<div class="tools tools-top">
				<a href="#"><i class="icon-link"></i></a>
				<a href="#"><i class="icon-paper-clip"></i></a>
				<a href="#"><i class="icon-pencil"></i></a>
				<a href="#"><i class="icon-remove red" onclick="doTrashImage('#imageId#');"></i></a>
			</div>
		</li>
	</ul>
</div><!-- PAGE CONTENT ENDS -->
<script type="text/javascript">	
$(document).ready(function() {
	$("#image-box").hide();
	doSearchImage();
	$("#btn-addImage").click(function() {
		var url = "${ctx}/manage/buildingImage/add?buildingId=${param.buildingId}&random=" + Math.random();
		var options = {
			title: '编辑',
			width: 500
		};
		showDialog(url, options);
	});
});
function doSearchImage() {
	var url = "${ctx}/manage/buildingImage/list?random="+ Math.random();
	var params = {
		buildingId: "${param.buildingId}"
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
			if (result.data.length > 0) {
				var html = $("#image-box").html();
				var content = html;

				for (var i=0; i<result.data.length; i++) {
					content = content.replace("#href#", result.data[i].url);
					content = content.replace("#src#", result.data[i].url);
					content = content.replace("#imageId#", result.data[i].id);
					content = content.replace("#title#", result.data[i].title);
					$(".ace-thumbnails").append(content);
				}
				
				var colorbox_params = {
					reposition: true,
					scalePhotos: true,
					scrolling: false,
					previous: '<i class="icon-arrow-left"></i>',
					next: '<i class="icon-arrow-right"></i>',
					close: '&times;',
					current: '{current} of {total}',
					maxWidth: '100%',
					maxHeight: '100%',
					onOpen: function(){
						document.body.style.overflow = 'hidden';
					},
					onClosed: function(){
						document.body.style.overflow = 'auto';
					},
					onComplete: function(){
						$.colorbox.resize();
					}
				};
				$('.ace-thumbnails [data-rel="colorbox"]').colorbox(colorbox_params);
				$("#cboxLoadingGraphic").append("<i class='icon-spinner orange'></i>");
			}
		}
	}, "json");
}
function doTrashImage(id) {
	dialog({
	    title: '消息',
	    width: 200,
	    content: '确定要删除吗?',
	    okValue: '确定',
	    ok: function () {
	        this.title('删除中…');
	        var url = "${ctx}/manage/buildingImage/delete?random="+ Math.random();
			var params = {
				id: id
			};
			$.post(url, params, function(result) {
				dialog({
  				    title: '消息',
  				    width: 200,
  				    content: result.message,
  				  	okValue: '确定',
  			    	ok: function () {
  			    		if ("500" == result.code) {
  			    			return true;
  			    		} else {
  			    			doSearchImage();
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