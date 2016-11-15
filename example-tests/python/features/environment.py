import os
from time import sleep
from appium import webdriver

def before_feature(context, feature):
	desired_caps = {}
	desired_caps['platformName'] = 'Android'
	desired_caps['deviceName'] = 'device'
	desired_caps['appActivity'] = '.MainActivity'
	desired_caps['automationName'] = 'uiautomator2'
	desired_caps['app'] = '/opt/apks/android/athena-login-sample.apk'
	context.driver = webdriver.Remote('http://athena-appium:4723/wd/hub', desired_caps)

def after_feature(context, feature):
	sleep(1)
	context.driver.quit()
