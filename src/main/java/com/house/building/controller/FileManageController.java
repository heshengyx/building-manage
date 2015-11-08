package com.house.building.controller;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.house.building.entity.BuildingImage;
import com.house.building.file.FileHandler;
import com.house.building.service.IBuildingImageService;
import com.myself.common.exception.ServiceException;
import com.myself.common.message.JsonMessage;
import com.myself.common.utils.FileUtil;

@Controller
@RequestMapping("/manage/file")
public class FileManageController extends BaseController {

	private final static Logger logger = LoggerFactory
			.getLogger(FileManageController.class);
	
	@Autowired
	private IBuildingImageService buildingImageService;
	
	@RequestMapping("/upload")
	@ResponseBody
	public Object upload(@RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request, BuildingImage param) {
		JsonMessage jMessage = new JsonMessage();
		String temps = request.getSession().getServletContext()
				.getRealPath(FileUtil.TEMP_FOLDER);
		String uploads = request.getSession().getServletContext()
				.getRealPath(FileUtil.UPLOAD_FOLDER);
		try {
			Map<String, File> map = FileHandler.upload(multipartFile, temps);
			buildingImageService.upload(param, map, uploads);
			jMessage.setCode(JsonMessage.SUCCESS_CODE);
			jMessage.setMessage("文件上传成功");
		} catch (Exception e) {
			jMessage.setCode(JsonMessage.ERROR_CODE);
			if (e instanceof ServiceException) {
				jMessage.setMessage(e.getMessage());
			} else {
				jMessage.setMessage("系统异常");
			}
			logger.error(jMessage.getMessage(), e);
		}
		return jMessage;
	}
}
