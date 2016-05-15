#!/usr/bin/env bash
cd "$( dirname "${BASH_SOURCE[0]}" )"

cd skynet/slua
xcodebuild
cp -r build/Release/slua.bundle ../../../Assets/Plugins/

cd -