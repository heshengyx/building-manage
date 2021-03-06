package com.house.building.security;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;

import com.house.building.entity.Permission;
import com.house.building.entity.Role;
import com.house.building.entity.User;
import com.house.building.service.IPermissionService;
import com.house.building.service.IRoleService;
import com.house.building.service.IUserService;

public class SecurityRealm extends AuthorizingRealm {

	private final static Logger logger = LoggerFactory
			.getLogger(SecurityRealm.class);

	@Autowired
	private IUserService userService;

	@Autowired
	private IRoleService roleService;

	@Autowired
	private IPermissionService permissionService;

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		SimpleAuthorizationInfo simpleAuthorInfo = null;
		/*
		 * String currentUsername = (String) super
		 * .getAvailablePrincipal(principals);
		 */
		User user = (User) super.getAvailablePrincipal(principals);
		List<String> roleList = new ArrayList<String>();
		List<String> permissionList = new ArrayList<String>();

		// User user = userService.getByUserName(currentUsername);
		if (null != user) {
			String level = user.getLevel();
			if ("1".equals(level)) { // 超级管理员
				List<Permission> permissions = permissionService
						.queryPermissions();
				if (!CollectionUtils.isEmpty(permissions)) {
					for (Permission permission : permissions) {
						if (!StringUtils.isEmpty(permission.getTag())) {
							logger.info("    权限名称[{}:{}]", new Object[] {
									permission.getTag(), permission.getUrl() });
							permissionList.add(permission.getTag());
						}
					}
					simpleAuthorInfo = new SimpleAuthorizationInfo();
					simpleAuthorInfo.addStringPermissions(permissionList);
				}
			} else {
				List<Role> roles = roleService.queryRolesByUserId(user.getId());
				if (!CollectionUtils.isEmpty(roles)) {
					logger.info("用户[{}]拥有的角色",
							new Object[] { user.getUsername() });
					for (Role role : roles) {
						logger.info("  角色名称[{}]",
								new Object[] { role.getName() });
						roleList.add(role.getName());
						List<Permission> permissions = permissionService
								.queryPermissionsByRoleId(role.getId());
						if (!CollectionUtils.isEmpty(permissions)) {
							for (Permission permission : permissions) {
								if (!StringUtils.isEmpty(permission.getTag())) {
									logger.info("    权限名称[{}:{}]",
											new Object[] { permission.getTag(),
													permission.getUrl() });
									permissionList.add(permission.getTag());
								}
							}
						}
					}
					simpleAuthorInfo = new SimpleAuthorizationInfo();
					// simpleAuthorInfo.addRoles(roleList);
					simpleAuthorInfo.addStringPermissions(permissionList);
				}
			}
		}
		return simpleAuthorInfo;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
		AuthenticationInfo authcInfo = null;
		// UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		CaptchaUsernamePasswordToken token = (CaptchaUsernamePasswordToken) authcToken;
		doCaptchaValidate(token);
		
		User user = new User();
		user.setUsername(token.getUsername());
		try {
			user = userService.getDataByUsername(user);
		} catch (Exception e) {
			throw new IncorrectException("用户账号或密码错误");
		}
		if (user == null) {
			throw new IncorrectException("用户账号或密码错误");
		} else {
			String password = String.valueOf(token.getPassword());
			if (!password.equals(user.getPassword())) {
				throw new IncorrectException("用户账号或密码错误");
			}
		}
		authcInfo = new SimpleAuthenticationInfo(user, user.getPassword(),
				user.getUsername());
		this.setSession("currentUser", user);
		return authcInfo;
	}

	private void setSession(Object key, Object value) {
		Subject currentUser = SecurityUtils.getSubject();
		if (null != currentUser) {
			Session session = currentUser.getSession();
			if (null != session) {
				session.setAttribute(key, value);
			}
		}
	}

	// 验证码校验
	private void doCaptchaValidate(CaptchaUsernamePasswordToken token) {
		Subject current = SecurityUtils.getSubject();
		Session session = current.getSession();
		String captcha = (String) session
				.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);

		if (captcha != null && !captcha.equalsIgnoreCase(token.getCaptcha())) {
			throw new IncorrectException("验证码错误");
		}
	}
}
