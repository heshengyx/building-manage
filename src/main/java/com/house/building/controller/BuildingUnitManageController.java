package com.house.building.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.house.building.entity.BuildingUnit;
import com.house.building.param.BuildingUnitQueryParam;
import com.house.building.service.IBuildingUnitService;
import com.myself.common.exception.ServiceException;
import com.myself.common.message.JsonMessage;

@Controller
@RequestMapping("/manage/buildingUnit")
public class BuildingUnitManageController extends BaseController {

	private final static Logger logger = LoggerFactory
			.getLogger(BuildingUnitManageController.class);
	
	@Autowired
	private IBuildingUnitService buildingUnitService;
	
	@RequestMapping("")
	public String page() {
		return "buildingUnit-list";
	}
	
	@RequestMapping("/edit")
	public String edit() {
		return "buildingUnit-edit";
	}
	
	@RequestMapping("/query")
	@ResponseBody
	public Object query(BuildingUnitQueryParam param, int page, int rows) {
		return buildingUnitService.query(param, page, rows);
	}
	
	@RequestMapping("/getData")
	@ResponseBody
	public Object getData(String id) {
		JsonMessage jMessage = new JsonMessage();
		BuildingUnit data = null;
		try {
			data = buildingUnitService.getDataById(id);
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
	
	@RequestMapping("/update")
	@ResponseBody
	public Object update(BuildingUnit param) {
		JsonMessage jMessage = new JsonMessage();
		try {
			buildingUnitService.update(param);
			jMessage.setCode(JsonMessage.SUCCESS_CODE);
			jMessage.setMessage("更新成功");
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
