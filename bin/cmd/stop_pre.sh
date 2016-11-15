CMD_DESCRIPTION="Stop Appium server."

if athena.arg_exists "--help"; then
	athena.argument.set_arguments
	athena.usage 1 "[--help|<options>...]" "$(cat <<EOF
	[--port=<port>] ; In case 'start --port=<port>' was called, then specify the same <port>
EOF
)"
fi

if athena.argument.argument_exists_and_remove "--port" "port"; then
	athena.os.set_instance "$port"
fi

if ! athena.docker.is_current_container_running; then
	athena.fatal "Appium Server is already stopped."
fi

athena.docker.stop_container
athena.info "Stopped Appium Server..."
