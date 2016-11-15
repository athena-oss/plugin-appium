CMD_DESCRIPTION="Execute Java Cucumber tests."

if athena.arg_exists "--help"; then
	athena.argument.set_arguments
fi

athena.usage 1 "<tests_dir> [<options>...] [<maven_args>...]" "$(cat <<EOF
   <tests_dir>                      ; Directory where your pom.xml file and features are.
   [--update-dependencies]          ; Update project dependencies, in case you changed you pom.xml file.
   [--cache-dir=<dir>]              ; Use <dir> instead of <tests_dir>/.m2 as a maven local repository.
   [--skip-appium]                  ; Dont link automatically with local Appium container.
   [--link-appium=<container_name>] ; Link current container with Appium <container_name>. (link name: athena-appium).
   [--skip-hub]                     ; Dont link automatically with local Selenium Hub container.
   [--link-hub=<container_name>]    ; Link current container with Selenium Hub <container_name>. (link name: athena-selenium-hub).
   [--java-version=<version>]       ; Java version to use. Default: 3-jdk-8. Check 'maven' org at dockerhub for a list of available versions.
   [<maven_args>...]                ; Optional maven arguments. E.g. clean test
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

java_version="3-jdk-8"
athena.argument.argument_exists_and_remove "--java-version" "java_version"
athena.plugin.use_container "maven:${java_version}"

maven_repository=
if athena.argument.argument_exists_and_remove "--cache-dir" "cache_dir"; then
	maven_repository="$cache_dir"
else
	athena.fs.dir_exists_or_create "${tests_dir}/.m2"
	maven_repository="${tests_dir}/.m2"
fi

athena.docker.mount_dir "$maven_repository" "/root/.m2"
athena.info "Maven local repository is located at ${maven_repository}..."
