# Rom repo init

repo init -u https://github.com/crdroidandroid/android.git -b 16.0 --git-lfs --no-clone-bundle

echo "-----------------------------"
echo "Repo init cloned successfully"
echo "-----------------------------"

# rm -rf to prevent prebuilt errors
rm -rf prebuilts/clang/host/linux-x86

# sycning

echo "-----------------------"
echo "Starting to sync source"
echo "-----------------------"

/opt/crave/resync.sh

/opt/crave/resync.sh

/opt/crave/resync.sh

echo "------------------------"
echo "Source syncing comppeted"
echo "------------------------"


# Dt

git clone https://github.com/Never-Alive/device_xiaomi_haydn -b crdroid device/xiaomi/haydn

echo "---------------------"
echo "Tress clone completed"
echo "---------------------"

# build env

. b*/e*

echo "---------------------------"
echo "Build/envsetup.sh completed"
echo "---------------------------"

# cloning hardware/lineage/conpat
rm -rf hardware/lineage/compat

git clone https://github.com/Never-Alive/android_hardware_lineage_compat -b 23 hardware/lineage/compat

echo "-----------------------------"
echo "hardware/lineage/conpat is cloned with fix"
echo "-----------------------------"

. b*/e*

# signing script

curl -sSf https://raw.githubusercontent.com/Trijal08/crDroid-build-signed-script-auto/main/create-signed-env.sh | bash

echo "----------------------------"
echo "Rom signed with private keys"
echo "----------------------------"

# brunch

brunch haydn

echo "--------------"
echo "Rom build done"
echo "--------------"
