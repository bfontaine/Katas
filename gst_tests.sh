#! /bin/bash

kata=KataSecretSantas
pkg=$(cat <<EOP
<package>
    <name>$kata</name>
    <namespace>$kata</namespace>
    <test>
        <sunit>${kata}.${kata}TestCase*</sunit>
        <filein>${kata}_tests.st</filein>
    </test>
    <filein>${kata}.st</filein>
</package>
EOP
)

mkdir -p $kata
cp ${kata}*st $kata/
echo $pkg >> $kata/package.xml
echo -n "building package… "
gst-package -t ~/.st $kata/package.xml > /dev/null && echo "ok."
echo "running tests…"
gst-sunit -p $kata && rm -Rf ${kata}

