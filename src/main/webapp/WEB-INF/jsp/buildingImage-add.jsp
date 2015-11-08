<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<link rel="stylesheet" href="${ctx}/css/dropzone.css" />
<script src="${ctx}/js/dropzone.min.js"></script>
<div id="dropzone">
	<form action="//dummy.html" class="dropzone">
		<div class="fallback">
			<input name="file" type="file" multiple="" />
		</div>
	</form>
</div>
<script type="text/javascript">	
$(document).ready(function() {
	try {
		$(".dropzone").dropzone({
			url: "${ctx}/manage/file/upload?buildingId=${param.buildingId}",
			paramName: "file", // The name that will be used to transfer the file
			maxFilesize: 0.5, // MB
			acceptedFiles: ".jpg,.gif",
			addRemoveLinks: true,
			dictDefaultMessage: '<span class="bigger-150 bolder"><i class="icon-caret-right red"></i> Drop files</span> to upload \
			<span class="smaller-80 grey">(or click)</span> <br /> \
			<i class="upload-icon icon-cloud-upload blue icon-3x"></i>',
			dictResponseError: 'Error while uploading file!',
			//change the previewTemplate to use Bootstrap progress bars
			previewTemplate: "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name></span></div>\n    <div class=\"dz-size\" data-dz-size></div>\n    <img data-dz-thumbnail />\n  </div>\n  <div class=\"progress progress-small progress-striped active\"><div class=\"progress-bar progress-bar-success\" data-dz-uploadprogress></div></div>\n  <div class=\"dz-success-mark\"><span></span></div>\n  <div class=\"dz-error-mark\"><span></span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n</div>",
			init: function() {
				var myDropzone = this;
				var d = null;
				myDropzone.on("addedfile", function(file) {
		            d = dialog({}).show();
		        });
				myDropzone.on("removedfile", function(file) {
		        	alert("File " + file.name + "removed");
	            });
				myDropzone.on("success", function(file, result) {
		        	d.close().remove();
		        	dialog({
					    title: '消息',
					    width: 200,
					    content: result.message,
					    okValue: '确定',
					    ok: function () {
					    	if (result.code == "500") {
					    		myDropzone.removeFile(file);
					    	} else {
					    		return true;
					    	}
				    	},
					    cancel: false
					}).showModal();
	            });
		    }
		});
	} catch (e) {
		alert('Dropzone.js does not support older browsers!');
	}
});
</script>