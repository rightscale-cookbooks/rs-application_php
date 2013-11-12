#!/usr/bin/env bats

@test 'basic html serving succeeds' {
  curl --silent --location localhost:8080 | grep 'Basic html serving succeeded'
}

@test 'application configuration succeeds' {
  curl --silent --location localhost:8080/appserver | grep 'PHP configuration=succeeded'
}
