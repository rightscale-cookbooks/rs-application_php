#!/usr/bin/env bats

@test 'database configuration file is created' {
  test -L /usr/local/www/sites/example/current/config/db.php
  test -f /usr/local/www/sites/example/shared/db.php
}

@test 'mysql service is running' {
  pgrep mysqld
}

@test 'php application connects to the database' {
  curl --silent --location localhost:8080/dbread | grep --only-matching 'I am in the db' | wc --lines | grep 3
}
