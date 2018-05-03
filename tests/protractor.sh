#!/bin/bash
set -e # http://stackoverflow.com/a/3474556/1123955

E2E_TESTING_DIR="/tmp/brolog-angular-demo.$$"
GIT_URL="https://github.com/zixia/brolog-angular-demo.git"

npm link

// https://github.com/angular/webdriver-manager/issues/307#issuecomment-377684918
webdriver-manager update --gecko=false

git clone "$GIT_URL" "$E2E_TESTING_DIR"

cd "$E2E_TESTING_DIR"
npm install
npm link brolog
npm start
cd -

# http://stackoverflow.com/a/3474556/1123955
ts-node ./node_modules/.bin/protractor tests/protractor.conf.ts

cd "$E2E_TESTING_DIR"
npm stop
cd -

rm -fr "$E2E_TESTING_DIR"
