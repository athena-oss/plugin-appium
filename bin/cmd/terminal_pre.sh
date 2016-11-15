CMD_DESCRIPTION="Starts a shell inside Appium server container."

if athena.arg_exists "--help"; then
	athena.argument.set_arguments
	athena.usage 1 "[--help|<options>...]" "$(cat <<EOF
	[--port=<port>]   ; In case 'start --port=<port>' was called, then specify the same <port>
EOF
)"
fi

if athena.argument.argument_exists_and_remove "--port" "port"; then
	athena.os.set_instance "$port"
fi

if ! athena.docker.is_current_container_running; then
	athena.exit_with_msg "Appium server is not running..."
fi

container_name="$(athena.plugin.get_container_name)"
athena.info "Placing you in a shell (${container_name})..."
athena.docker.exec -ti "$container_name" /usr/bin/env bash
