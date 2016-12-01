CMD_DESCRIPTION="Start Appium server."

if athena.arg_exists "--help"; then
	athena.argument.set_arguments
	athena.usage 1 "[<options>...] [<appium_options>...]" "$(cat <<EOF
       [--with-avd=<container_name>|<ip>:<port>] ; Container with the AVD, running in the host machine, or a remote AVD.
       [--apks-dir=<dir>]                        ; Directory where your APKs are.
       [--port=<port>]                           ; Specifies which port to be exposed on the host machine.
       [--adb-port=<port>]                       ; Expose ADB port externally to <port>.
       [--skip-hub]                              ; Dont link automatically with local selenium hub container.
       [--link-hub=<container_name>]             ; Link the local selenium hub <container_name>. (link name: athena-selenium-hub)
       [<appium_options>...]                     ; Optional appium options.
EOF
)"
fi

if athena.argument.argument_exists_and_remove "--port" "port"; then
	athena.docker.add_option "-p ${port}:4723"
	athena.os.set_instance "$port"
fi

if athena.docker.is_current_container_running; then
	athena.fatal "Appium Server is already started."
fi

athena.plugins.appium.try_to_auto_link_containers "hub" "athena-selenium-hub"

if athena.argument.argument_exists_and_remove "--with-avd" "connection_string"; then
	if [[ "$connection_string" =~ ^athena-plugin-.* ]]; then
		athena.docker.add_option "--link ${connection_string}:athena-device"
		athena.docker.add_env "ATHENA_DEVICE_ADDRESS" "athena-device"
	else
		athena.docker.add_env "ATHENA_DEVICE_ADDRESS" "$connection_string"
	fi
fi

if athena.arg_exists "--apks-dir"; then
	apks_dir=$(athena.argument.get_path_from_argument "--apks-dir")
	athena.info "Mounting '${apks_dir}' in '/opt/apks'"
	athena.docker.mount_dir "$apks_dir" "/opt/apks"
	athena.argument.remove_argument "--apks-dir"
fi

if athena.arg_exists "--nodeconfig"; then
	node_config_file="$(athena.argument.get_path_from_argument --nodeconfig)"
	athena.argument.remove_argument "--nodeconfig"
	athena.docker.add_option "-v ${node_config_file}:/opt/user_node_config.json"
	athena.argument.append_to_arguments "--nodeconfig" "/opt/node_config.json"
fi

if athena.arg_exists "--adb-port"; then
	adb_port=$(athena.argument.get_argument "--adb-port")
	athena.docker.add_option "-p ${adb_port}:5037"
fi

athena.docker.add_daemon
athena.info "Starting Appium Server..."
