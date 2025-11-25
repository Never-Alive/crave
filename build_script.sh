# Rom repo init

repo init -u https://github.com/LineageOS/android.git -b lineage-23.0 --git-lfs

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

git clone https://github.com/Never-Alive/device_xiaomi_haydn -b 16 device/xiaomi/haydn

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

# lunch

lunch lineage_haydn-bp2a-userdebug

echo "----------"
echo "Lunch done"
echo "----------"

# finalk command

mka bacon

echo "--------------"
echo "Rom build done"
echo "--------------"
