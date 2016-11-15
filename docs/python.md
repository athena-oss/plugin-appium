# Introduction

```
$ athena appium pyhton
...
usage: athena appium python <tests_dir> [--cache-dir=<dir>] [--update-dependencies] [<behave_args>...]

    <tests_dir>                Directory where your features are located.
    [--update-dependencies]    Update dependencies inside requirements.txt.
    [--cache-dir=<dir>]        Use <dir> instead of <tests_dir>/.pip as a pip cache directory.
    [<behave_args>...]         Optional Behave arguments.
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
$ athena appium python ./python
```

The tests might not start right way; you might have to wait until the virtual device is up and running.

After the waiting time, you should see the test result:

```gherkin
$ athena appium python ./python

...

Feature: I would like to log in to the system # features/android_login.feature:1

  Scenario: Successful login                        # features/android_login.feature:3
    Given I am on the login screen                  # features/steps/android_login.py:5 0.000s
    When I fill in "username" with "athena@olx.com" # features/steps/android_login.py:9 14.169s
    And I fill in "password" with "123456"          # features/steps/android_login.py:9 7.426s
    And I tap "login"                               # features/steps/android_login.py:14 0.992s
    Then I should see "Success!" message            # features/steps/android_login.py:18 1.018s

  Scenario: Unsuccessful login                     # features/android_login.feature:10
    Given I am on the login screen                 # features/steps/android_login.py:5 0.001s
    When I fill in "username" with "wrong email"   # features/steps/android_login.py:9 20.373s
    And I fill in "password" with "wrong password" # features/steps/android_login.py:9 11.309s
    And I tap "login"                              # features/steps/android_login.py:14 2.572s
    Then I should see "Failure!" message           # features/steps/android_login.py:18 0.179s

1 feature passed, 0 failed, 0 skipped
2 scenarios passed, 0 failed, 0 skipped
10 steps passed, 0 failed, 0 skipped, 0 undefined
```

To execute the tests in your Genymotion device, refer to [Connect with Genymotion](getting-started.md#connect-with-genymotion).

# Update/Install Dependencies

When you execute `athena appium python <test_directory>` command, you can optionally provide `--update-dependencies` option, to force the container plugin, to read the `requirements.txt` inside your `<tests_directory>` and install the specified dependencies.

## Custom Cache Directory

By default when you run `athena appium python <tests_directory> --update-dependencies`, the plugin will store any downloaded dependencies in `<tests_directory>/.pip`.

To change this behaviour, you need to specify the `--cache-dir=<my_custom_cache_dir>` with the directory  where you want the store all the downloaded dependencies.
