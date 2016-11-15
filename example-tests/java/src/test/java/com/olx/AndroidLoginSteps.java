package com.olx;

import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import io.appium.java_client.android.AndroidDriver;
import org.openqa.selenium.remote.DesiredCapabilities;

import java.net.URL;

public class AndroidLoginSteps {
    private AndroidDriver driver;

    @Before
    public void setUp() throws Throwable {
        DesiredCapabilities capabilities = new DesiredCapabilities();
        capabilities.setCapability("platformName", "Android");
        capabilities.setCapability("deviceName", "device");
        capabilities.setCapability("appActivity", ".MainActivity");
        capabilities.setCapability("automationName", "uiautomator2");
        capabilities.setCapability("app", "/opt/apks/android/athena-login-sample.apk");

        driver = new AndroidDriver(new URL("http://athena-appium:4723/wd/hub"), capabilities);
    }

    @Given("^I am on the login screen$")
    public void i_am_on_the_login_screen() {
        assert true;
    }

    @When("^I fill in \"([^\"]*)\" with \"([^\"]*)\"$")
    public void i_fill_in_with(String elementId, String text) throws Throwable {
        driver.findElementById(elementId).sendKeys(text);
    }

    @When("^I tap \"([^\"]*)\"$")
    public void i_tap(String elementId) throws Throwable {
        driver.findElementById(elementId).click();
    }

    @Then("^I should see \"([^\"]*)\" message$")
    public void i_should_see_message(String text) throws Throwable {
        assert driver.findElementById("message").getText().equals(text);
    }

    @After
    public void tearDown() throws Throwable {
        Thread.sleep(1000);
        driver.quit();
    }
}
