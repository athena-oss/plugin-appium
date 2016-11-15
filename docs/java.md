# Introduction

```
$ athena appium java
...
usage: athena appium java <tests_dir> [--update-dependencies] [--cache-dir=<dir>] [<maven_args>...]

    <tests_dir>                    Directory where your pom.xml file and features are.
    [--update-dependencies]        Update project dependencies, in case you changed you pom.xml file.
    [--cache-dir=<dir>]            Use <dir> instead of <tests_dir>/.m2 as a maven local repository.
    [<maven_args>...]              Optional maven arguments. E.g. clean test
```

# Run a Example Test

We wrote and implemented a test `android_login.feature`, to validate if a fictional login system is working properly.

## Clone

The `example-tests` are located inside the Appium plugin repository.

```
$ git clone https://github.com/athena-oss/plugin-appium.git
```

Inside the directory, where you cloned the repository to, there is a `example-tests` folder. Go inside it.

## Run the Test

Make sure you have a local device running, you can refer to [Connect with Local Devices](getting-started.md#connect-with-local-devices) or [Connect with Genymotion](getting-started.md#connect-with-genymotion).

```
$ athena appium start --apks-dir=./apps --adb-port=5037
$ athena appium java ./java test
```

The tests might not start right way; you might have to wait until the virtual device is up and running.

After the waiting time, you should see the test result:

```gherkin
$ athena appium java ./java test
...

-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running com.olx.MainTest
Feature: I would like to log in to the system

  Scenario: Successful login                        # com/olx/android_login.feature:3
    Given I am on the login screen                  # AndroidLoginSteps.i_am_on_the_login_screen()
    When I fill in "username" with "athena@olx.com" # AndroidLoginSteps.i_fill_in_with(String,String)
    And I fill in "password" with "123456"          # AndroidLoginSteps.i_fill_in_with(String,String)
    And I tap "login"                               # AndroidLoginSteps.i_tap(String)
    Then I should see "Success!" message            # AndroidLoginSteps.i_should_see_message(String)

  Scenario: Unsuccessful login                     # com/olx/android_login.feature:10
    Given I am on the login screen                 # AndroidLoginSteps.i_am_on_the_login_screen()
    When I fill in "username" with "wrong email"   # AndroidLoginSteps.i_fill_in_with(String,String)
    And I fill in "password" with "wrong password" # AndroidLoginSteps.i_fill_in_with(String,String)
    And I tap "login"                              # AndroidLoginSteps.i_tap(String)
    Then I should see "Failure!" message           # AndroidLoginSteps.i_should_see_message(String)

2 Scenarios (2 passed)
10 Steps (10 passed)
3m0.985s

Tests run: 12, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 182.119 sec

Results :

Tests run: 12, Failures: 0, Errors: 0, Skipped: 0
```

To execute the tests in your Genymotion device, refer to [Connect with Genymotion](getting-started.md#connect-with-genymotion).

# Update/Install Dependencies

When you execute `athena appium java <test_directory> test` command, you can optionally provide `--update-dependencies` option, to force the container plugin, to read the `pom.xml` inside your `<tests_directory>` and install the specified dependencies.

## Custom Cache Directory

By default when you run `athena appium java <tests_directory> test --update-dependencies`, the plugin will store any downloaded dependencies in `<tests_directory>/.m2`.

To change this behaviour, you need to specify the `--cache-dir=<my_custom_cache_dir>` with the directory  where you want the store all the downloaded dependencies.
