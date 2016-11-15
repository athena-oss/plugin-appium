CMD_DESCRIPTION="Execute Python Behave tests."

if athena.arg_exists "--help"; then
	athena.argument.set_arguments
fi

athena.usage 1 "<tests_dir> [<options>...] [<behave_args>...]" "$(cat <<EOF
   <tests_dir>                      ; Directory where your features are located.
   [--update-dependencies]          ; Update dependencies inside requirements.txt.
   [--cache-dir=<dir>]              ; Use <dir> instead of <tests_dir>/.pip as a pip cache directory.
   [--skip-appium]                  ; Dont link automatically with local Appium container.
   [--link-appium=<container_name>] ; Link current container with Appium <container_name>. (link name: athena-appium).
   [--skip-hub]                     ; Dont link automatically with local Selenium Hub container.
   [--link-hub=<container_name>]    ; Link current container with Selenium Hub <container_name>. (link name: athena-selenium-hub).
   [--python-version=<version>]     ; Python version to use. Default: 3.3.6. Check 'python' org at dockerhub for a list of available versions.
   [<behave_args>...]               ; Optional Behave arguments.
EOF
)"


tests_dir="$(athena.path 1)"
athena.pop_args 1

athena.debug "Mounting '${tests_dir}' to '/opt/app'"
athena.docker.mount_dir "$tests_dir" "/opt/app"

# these functions must be called before any athena function that might change the container default name
# such as the athena.plugin.use_container
athena.plugins.appium.try_to_auto_link_containers "appium" "athena-appium"
athena.plugins.appium.try_to_auto_link_containers "hub" "athena-selenium-hub"

python_version="3.3.6"
athena.argument.argument_exists_and_remove "--python-version" "python_version"

athena.plugin.use_container "python:${python_version}"

pip_cache=
if athena.argument.argument_exists_and_remove "--cache-dir" "cache_dir"; then
	athena.docker.mount_dir "$cache_dir" "/opt/app/.pip"
else
	athena.fs.dir_exists_or_create "${tests_dir}/.pip"
fi

athena.info "pip dependencies will be cached in ${pip_cache}..."
athena.docker.add_env "PYTHONUSERBASE" "/opt/app/.pip"
