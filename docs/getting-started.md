# Start Appium Server

Appium is already installed and prepared for you to use.

```bash
$ athena appium start
```

If you have one or more APK files in your machine, and your tests need to access them, then start the server with `--apks-dir=<dir>`.

The `<dir>` must be where you store your APK files.

When you define the Appium desired capabilities, in your tests, the key `apps` should point to `/opt/apks/<the_remaining_path_to_my_apk>`.

Inside the container `/opt/apks` will be the mount point for the directory you specified in `--apks-dir`.

In case you run your tests on your local machine, you can expose appium server by passing the option `--port=4723`.

# Connect with Local Devices

For Appium server to recognize your devices automatically, you'll need `--adb-port=5037` option to be passed when you start the server.

```
$ athena appium start --adb-port=5037
```

In case you want to connect with a device running inside a container on your local machine:

```
$ athena appium start --with-avd=<athena_avd_container_name>
```

We'll find the container IP and connect with it automatically.

# Connect with Remote Devices

```
$ athena appium start --with-avd=<ip>:<port>
```

That's it :)

# Connect with Genymotion

There's two ways of doing this. Refer to the [Connect with Local Devices](getting-started.md#connect-with-local-devices) or [Connect with Remote Devices](getting-started.md#connect-with-remote-devices) section.

**NOTE:** In case you want the Appium server to access APKs in your machine, use `--apks-dir` option.

# Connect with Selenium Hub

First step is to create a configuration file called `node_config.json`.

The configuration has our device capabilities and necessary information on where the Selenium Hub and the Appium server are located inside the network.

```json
{
  "capabilities":
      [
        {
          "browserName": "Google Nexus 5",
          "version":"5.0.0",
          "maxInstances": 1,
          "platform":"Android"
        }
      ],
  "configuration":
  {
    "cleanUpCycle":2000,
    "timeout":30000,
    "proxy": "org.openqa.grid.selenium.proxy.DefaultRemoteProxy",
    "url":"http://ENV[ATHENA_APPIUM_SERVER_IP]:4723/wd/hub",
    "host": "ENV[ATHENA_APPIUM_SERVER_IP]",
    "port": 4723,
    "maxSession": 1,
    "register": true,
    "registerCycle": 5000,
    "hubPort": 4444,
    "hubHost": "athena-selenium-hub"
  }
}
```

* `ENV[ATHENA_APPIUM_SERVER_IP]` will automatically get replaced with the right IP, so that Selenium Hub can connect back to the Appium server
* `athena-selenium-hub` will be resolved to the Selenium Hub IP automatically, so that Appium Server can register itself

Start the Selenium Hub `athena selenium start hub 2.49.1` (choose whatever version suits you best).

Start the Appium server with our configuration file: `athena appium start --with-avd=<device> --nodeconfig=./node_config.json`

Selenium Hub and Appium server containers are linked automatically when they are running on the same machine, which is the case in this example.

