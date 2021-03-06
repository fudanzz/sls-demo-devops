#!/bin/bash
set -e
set -o pipefail

instruction()
{
  echo "usage: ./build.sh deploy <env>"
  echo ""
  echo "env: eg. dev, staging, prod, ..."
  echo ""
  echo "for example: ./build.sh deploy dev"
}

if [ $# -eq 0 ]; then
  instruction
  exit 1
elif [ "$1" = "int-test" ] && [ $# -eq 1 ]; then
  npm --registry https://registry.npm.taobao.org install

  npm run integration-test
elif [ "$1" = "acceptance-test" ] && [ $# -eq 1 ]; then
  npm --registry https://registry.npm.taobao.org install

  npm run acceptance-test
elif [ "$1" = "deploy" ] && [ $# -eq 2 ]; then
  STAGE=$2

  npm --registry https://registry.npm.taobao.org install
  'node_modules/.bin/sls' deploy -s $STAGE
else
  instruction
  exit 1
fi