package com.olx;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import static org.junit.Assert.assertEquals;

public class StepsDefinition {
    private HttpURLConnection connection;

    @Given("^I perform a request to \"([^\"]+)\"$")
    public void iPerformARequestTo(String url) throws Throwable {
        try {
            URL serverUrl = new URL(url);
            connection = (HttpURLConnection) serverUrl.openConnection();
            connection.setConnectTimeout(2);
            connection.connect();
        } catch (IOException e) {
            System.err.println("Error creating HTTP connection");
            e.printStackTrace();
            throw e;
        }
    }

    @Then("^I should get a \"([^\"]+)\" status code$")
    public void iShouldGetAStatusCode(int statusCode) throws Throwable {
        assertEquals(statusCode, connection.getResponseCode());
    }
}
