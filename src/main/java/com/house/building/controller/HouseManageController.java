package com.house.building.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.house.building.entity.House;
import com.house.building.param.HouseQueryParam;
import com.house.building.service.IHouseService;
import com.myself.common.exception.ServiceException;
import com.myself.common.message.JsonMessage;

@Controller
@RequestMapping("/manage/house")
public class HouseManageController extends BaseController {

	private final static Logger logger = LoggerFactory
			.getLogger(HouseManageController.class);
	
	@Autowired
	private IHouseService houseService;
	
	@RequestMapping("")
	public String page() {
		return "house-list";
	}
	
	@RequestMapping("/add")
	public String add() {
		return "house-add";
	}
	
	@RequestMapping("/edit")
	public String edit() {
		return "house-edit";
	}
	
	@RequestMapping("/query")
	@ResponseBody
	public Object query(HouseQueryParam param, int page, int rows) {
		return houseService.query(param, page, rows);
	}
	
	@RequestMapping("/getData")
	@ResponseBody
	public Object getData(String id) {
		JsonMessage jMessage = new JsonMessage();
		House data = null;
		try {
			data = houseService.getDataById(id);
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
	
	@RequestMapping("/save")
	@ResponseBody
	public Object save(House param) {
		JsonMessage jMessage = new JsonMessage();
		try {
			houseService.save(param);
			jMessage.setCode(JsonMessage.SUCCESS_CODE);
			jMessage.setMessage("新增成功");
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
	public Object update(House param) {
		JsonMessage jMessage = new JsonMessage();
		try {
			houseService.update(param);
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
	
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(String id) {
		JsonMessage jMessage = new JsonMessage();
		try {
			houseService.deleteById(id);
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
