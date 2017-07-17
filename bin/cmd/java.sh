cd /opt/app

if athena.argument.argument_exists_and_remove "--update-dependencies"; then
    athena.fs.file_exists_or_fail "pom.xml" "Cannot update dependencies without a 'pom.xml' being present..."
	mvn clean install
fi

mvn $(athena.args)
mvnStatus=$?
cd -
exit $mvnStatus
