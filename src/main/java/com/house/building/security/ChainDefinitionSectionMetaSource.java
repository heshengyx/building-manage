package com.house.building.security;

import java.text.MessageFormat;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.config.Ini;
import org.apache.shiro.config.Ini.Section;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;

import com.house.building.entity.Permission;
import com.house.building.service.IPermissionService;


public class ChainDefinitionSectionMetaSource implements
		FactoryBean<Ini.Section> {
	
	private final static Logger logger = LoggerFactory
			.getLogger(ChainDefinitionSectionMetaSource.class);

	@Autowired  
    private IPermissionService permissionService;
	
	private String filterChainDefinitions;

	public static final String PREMISSION_STRING = "perms[\"{0}\"]";

	public void setFilterChainDefinitions(String filterChainDefinitions) {
		this.filterChainDefinitions = filterChainDefinitions;
	}

	public Section getObject() throws Exception {
		List<Permission> permissions = permissionService.queryPermissions();
        Ini ini = new Ini();  
        ini.load(filterChainDefinitions);
        
        Ini.Section section = ini.getSection(Ini.DEFAULT_SECTION_NAME);  
        if (!CollectionUtils.isEmpty(permissions)) {
			for (Permission permission : permissions) {
				if(StringUtils.isNotEmpty(permission.getUrl()) && StringUtils.isNotEmpty(permission.getTag())) {
					logger.info("系统角色[{}][{}]", new Object[]{permission.getTag(), permission.getUrl()});
					section.put(permission.getUrl(),  MessageFormat.format(PREMISSION_STRING, permission.getTag()));
				}
			}
		}
		return section;
	}

	public Class<?> getObjectType() {
		return this.getClass();
	}

	public boolean isSingleton() {
		return false;
	}

}
