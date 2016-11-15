from behave import *
import urllib.request

@given(u'I perform a request to "{url}"')
def step_impl(context, url):
    context.request=urllib.request.urlopen(url)

@then(u'I should get a "{status_code}" status code')
def step_impl(context, status_code):
	assert (int(status_code)==context.request.getcode()),"Expected status code %s is different from the actual %d" % (status_code,context.request.getcode())
