cd /opt/app

if [[ ! -f ".pip/.athena_lock" ]]; then
	athena.info "Installing requirements for the first time..."
	pip install --user --upgrade -r requirements.txt
	touch ".pip/.athena_lock"
	athena.info "If you want to update dependencies use --update-dependencies option..."
fi

if athena.argument.argument_exists_and_remove "--update-dependencies"; then
	athena.fs.file_exists_or_fail "requirements.txt" "Cannot update dependencies without a 'requirements.txt' being present..."
	pip install --user --upgrade -r requirements.txt
fi

.pip/bin/behave $(athena.args)
cd -
