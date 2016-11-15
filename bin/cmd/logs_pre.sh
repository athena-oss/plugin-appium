CMD_DESCRIPTION="Show Appium server logs."

if athena.arg_exists "--help"; then
	athena.argument.set_arguments
	athena.usage 1 "[--help|<options>...]" "$(cat <<EOF
	[-f]              ; Follow logs output.
	[--port=<port>]   ; In case 'start --port=<port>' was called, then specify the same <port>
EOF
)"
fi

if athena.argument.argument_exists_and_remove "--port" "port"; then
	athena.os.set_instance "$port"
fi

if ! athena.docker.is_current_container_running; then
	athena.exit_with_msg "Appium Server is not running."
fi

follow=
if athena.argument.argument_exists_and_remove "-f"; then
	follow="-f"
fi

athena.info "Showing Appium Server logs..."
athena.docker.print_or_follow_container_logs "$(athena.plugin.get_container_name)" $follow
