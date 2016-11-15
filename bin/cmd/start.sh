if athena.argument.argument_exists_and_remove "--adb-port"; then
	docker_ip=$(ip addr list eth0|grep "inet "|cut -d' ' -f6|cut -d/ -f1)
	echo "${docker_ip} 5037 127.0.0.1 5037" >> /etc/rinetd.conf
	rinetd restart
fi

if athena.arg_exists "--nodeconfig"; then
	docker_ip=$(ip addr list eth0|grep "inet "|cut -d' ' -f6|cut -d/ -f1)
	# dont replace directly the user file otherwise he gets the harcoded IP on his json config file
	cat /opt/user_node_config.json | sed -e "s/ENV\[ATHENA_APPIUM_SERVER_IP\]/${docker_ip}/g" > /opt/node_config.json
fi

adb -P 5037 start-server

if [[ -n "$ATHENA_DEVICE_ADDRESS" ]]; then
	adb connect $ATHENA_DEVICE_ADDRESS
fi

appium $(athena.args)
