#!/bin/bash
read -p "Enter version number: " version
find . -type d -exec rm .DS_Store \;
xcodebuild -project iFap.xcodeproj -scheme iFap -sdk iphoneos -configuration Release CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO -derivedDataPath build

ldid -SiFap/iFap.entitlements build/Build/Products/Release-iphoneos/iFap.app

mkdir one.keycap.ifap_${version}_iphoneos-arm
mkdir one.keycap.ifap_${version}_iphoneos-arm/DEBIAN
mkdir one.keycap.ifap_${version}_iphoneos-arm/Applications
cp -r build/Build/Products/Release-iphoneos/iFap.app one.keycap.ifap_${version}_iphoneos-arm/Applications/
echo -e "Package: one.keycap.ifap\nName: iFap\nIcon: https://repo.keycap.one/icons/iFap.png\nDepends: firmware (>= 15.0)\nArchitecture: iphoneos-arm\nDescription: An all-in-one app that has multiple sources of R-rated material\nMaintainer: SingleKeycap\nAuthor: SingleKeycap\nSection: Applications\nVersion: ${version}\nInstalled-Size: $(du -ks one.keycap.ifap_${version}_iphoneos-arm/Applications|cut -f 1)\nSileoDepiction: https://repo.keycap.one/depictions/one.keycap.ifap.json\n" > one.keycap.ifap_${version}_iphoneos-arm/DEBIAN/control
chmod -R 0755 one.keycap.ifap_${version}_iphoneos-arm/DEBIAN
dpkg-deb --build one.keycap.ifap_${version}_iphoneos-arm

mkdir one.keycap.ifap_${version}_iphoneos-arm64
mkdir one.keycap.ifap_${version}_iphoneos-arm64/DEBIAN
mkdir one.keycap.ifap_${version}_iphoneos-arm64/var
mkdir one.keycap.ifap_${version}_iphoneos-arm64/var/jb
mkdir one.keycap.ifap_${version}_iphoneos-arm64/var/jb/Applications
cp -r build/Build/Products/Release-iphoneos/iFap.app one.keycap.ifap_${version}_iphoneos-arm64/var/jb/Applications/
echo -e "Package: one.keycap.ifap\nName: iFap\nIcon: https://repo.keycap.one/icons/iFap.png\nDepends: firmware (>= 15.0)\nArchitecture: iphoneos-arm64\nDescription: An all-in-one app that has multiple sources of R-rated material\nMaintainer: SingleKeycap\nAuthor: SingleKeycap\nSection: Applications\nVersion: ${version}\nInstalled-Size: $(du -ks one.keycap.ifap_${version}_iphoneos-arm64/var|cut -f 1)\nSileoDepiction: https://repo.keycap.one/depictions/one.keycap.ifap.json\n" > one.keycap.ifap_${version}_iphoneos-arm64/DEBIAN/control
chmod -R 0755 one.keycap.ifap_${version}_iphoneos-arm64/DEBIAN
dpkg-deb --build one.keycap.ifap_${version}_iphoneos-arm64

mkdir Payload
cp -r build/Build/Products/Release-iphoneos/iFap.app Payload/
zip -r iFap_${version}.ipa Payload

rm -rf build Payload one.keycap.ifap_${version}_iphoneos-arm one.keycap.ifap_${version}_iphoneos-arm64
