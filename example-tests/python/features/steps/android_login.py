from behave import *
from time import sleep
from appium import webdriver

@given(u'I am on the login screen')
def step_impl(context):
	pass

@when(u'I fill in "{element_id}" with "{text}"')
def step_impl(context, element_id, text):
	element = context.driver.find_element_by_id(element_id)
	element.send_keys(text)

@when(u'I tap "{element_id}"')
def step_impl(context, element_id):
	context.driver.find_element_by_id(element_id).click();

@then(u'I should see "{text}" message')
def step_impl(context, text):
    assert text in context.driver.find_element_by_id('message').text
