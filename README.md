# Appium Plugin [![Build Status](https://travis-ci.org/athena-oss/plugin-appium.svg?branch=master)](https://travis-ci.org/athena-oss/plugin-appium)

This plugin provides an out of the box integration with Appium and Virtual Mobile devices.

You can easily use this plugin in your local development machine, or in a CI/CD pipeline.

## How to Install ?

To install it simply run the following command :

```bash
$ athena plugins install appium https://github.com/athena-oss/plugin-appium.git
```

### On MAC OSX Use [Homebrew](http://brew.sh/):

```bash
$ brew tap athena-oss/tap
$ brew install plugin-appium
```

Read the [Documentation](http://athena-oss.github.io/plugin-appium) on using Athena.

## How to Use ?

This plugin provides the following commands :

### start - Start a Appium server

```bash
$ athena appium start [<options>...] [<appium_options>...]

$ # e.g. start Appium server and link with device from Athena AVD plugin
$ athena appium start --with-avd=athena-plugin-avd-wxga720-api-24-0

$ # e.g. start Appium server and export ABD for devices to connect automatically
$ athena appium start --adb-port=5037

$ # e.g. start Appium server and link with Genymotion device
$ athena appium start --with-avd=192.168.57.101:5555

$ # e.g. start Appium server at port 9001
$ athena appium start --port=9001
```

### stop - Stop the Appium server

```bash
$ athena appium stop [--help|<options>...]

$ # e.g. stop Appium server
$ athena appium stop
```

### logs - Show Appium server logs

```bash
$ athena appium logs [--help|<options>...]

$ # e.g. get Appium server logs
$ athena appium logs

$ # e.g. get Appium server on port 9001 logs
$ athena appium logs --port=9001
```

### terminal - Starts a shell inside device/server container

```bash
$ athena appium terminal [--help|<options>...]

$ # e.g. simple shell
$ athena appium terminal

$ # e.g. open a terminal on Appium server at port 9001
$ athena appium terminal --port=9001
```

## Contributing

Checkout our guidelines on how to contribute in [CONTRIBUTING.md](CONTRIBUTING.md).

## Versioning

Releases are managed using github's release feature. We use [Semantic Versioning](http://semver.org) for all
the releases. Every change made to the code base will be referred to in the release notes (except for
cleanups and refactorings).

## License

Licensed under the [Apache License Version 2.0 (APLv2)](LICENSE).
