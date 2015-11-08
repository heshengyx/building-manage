package com.house.building.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.house.building.entity.BuildingImage;
import com.house.building.param.BuildingImageQueryParam;
import com.house.building.service.IBuildingImageService;
import com.myself.common.exception.ServiceException;
import com.myself.common.message.JsonMessage;
import com.myself.common.utils.FileUtil;

@Controller
@RequestMapping("/manage/buildingImage")
public class BuildingImageManageController extends BaseController {

	private final static Logger logger = LoggerFactory
			.getLogger(BuildingImageManageController.class);
	
	@Autowired
	private IBuildingImageService buildingImageService;
	
	@RequestMapping("")
	public String page(HttpServletRequest request, Model model) {
		String uploads = request.getSession().getServletContext()
				.getRealPath(FileUtil.UPLOAD_FOLDER);
		model.addAttribute("uploads", uploads);
		return "buildingImage-list";
	}
	
	@RequestMapping("/add")
	public String add() {
		return "buildingImage-add";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(BuildingImageQueryParam param) {
		JsonMessage jMessage = new JsonMessage();
		List<BuildingImage> data = null;
		try {
			data = buildingImageService.list(param);
			jMessage.setCode(JsonMessage.SUCCESS_CODE);
			jMessage.setData(data);
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
	
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(String id, HttpServletRequest request) {
		String uploads = request.getSession().getServletContext()
				.getRealPath(FileUtil.UPLOAD_FOLDER);
		JsonMessage jMessage = new JsonMessage();
		try {
			buildingImageService.delete(id, uploads);
			jMessage.setCode(JsonMessage.SUCCESS_CODE);
			jMessage.setMessage("删除成功");
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
