#!/usr/bin/env bash
cd "$( dirname "${BASH_SOURCE[0]}" )"

cd slua_mac
xcodebuild
cp -r build/Release/slua.bundle ../../../Assets/Plugins/

cd -