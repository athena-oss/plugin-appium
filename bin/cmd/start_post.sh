if athena.arg_exists "--port"; then
	athena.argument.get_argument_and_remove "--port" "port"
	athena.os.set_instance "$port"
fi

athena.docker.wait_for_string_in_container_logs "$(athena.plugin.get_container_name)" "Appium REST http interface listener started"

if athena.arg_exists "--adb-port"; then
	if pgrep "adb" >/dev/null && hash adb 2>/dev/null; then
		athena.info "Killing local ADB server..."
		adb kill-server
	fi
fi
