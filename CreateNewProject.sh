#!/bin/bash

# 编码处理
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# 颜色
RedColor='\033[31m'
GreenColor='\033[32m'
YellowColor='\033[33m'
DefaultColor='\033[0m'


# demo名
DemoName='OCProjectDemo'
# demo地址
DemoClonePath='https://github.com/dafiger/OCProjectDemo.git'


# 工程名
ProjectName=''
# 组织名
OrganizationName=''
# 作者
Author=''
# 确认状态
ConfirmStatus='N'


# 输入项目名
InputProjectName() {
    read -p "请输入新建项目名称: " ProjectName
    # 字符串长度为0
    if test -z ${ProjectName}
    then
        InputProjectName
    fi
}

# 输入组织名
InputOrganizationName() {
    read -p "请输入新建项目组织名称: " OrganizationName
    # 字符串长度为0
    if test -z ${OrganizationName}
    then
        InputOrganizationName
    fi
    # 组织名和作者一样
    Author=${OrganizationName}
}

# 检验输入内容
CheckInfomation() {
    InputProjectName
    InputOrganizationName

    echo -e "\n${DefaultColor}================================================"
    echo -e "  新建项目名称：${RedColor}${ProjectName}${DefaultColor}"
    echo -e "  新建项目组织名称：${RedColor}${OrganizationName}${DefaultColor}"
    echo -e "  新建项目作者：${RedColor}${OrganizationName}${DefaultColor}"
    echo -e "================================================\n"
}

# 循环检验
while [ ${ConfirmStatus} != "y" -a ${ConfirmStatus} != "Y" ] 
do
    if [ ${ConfirmStatus} == "n" -o ${ConfirmStatus} == "N" ]
    then 
        CheckInfomation
    fi
    read -p "确定? (y/n):" ConfirmStatus
done

# 桌面新建文件夹
cd ~/Desktop
ProjectPath="Demo$(date +%y%m%d%H%M%S)"
mkdir -p ${ProjectPath}
cd ${ProjectPath}

# 下载demo
git clone ${DemoClonePath}

# 项目重命名
mv ${DemoName} ${ProjectName}

# 打开工程
cd ${ProjectName}
mv ${DemoName} ${ProjectName}
mv ${DemoName}.xcodeproj ${ProjectName}.xcodeproj

# 遍历文件
function listfile() {
    for file_name in $(ls $1); do
        if [ -d "$1/${file_name}" ]; then
            read_dir "$1/${file_name}"
        else
            echo -e "$1/${file_name}"
        fi
    done
}

# function read_dir(){
#     for file in `ls $1`
#     do
#         if [ -d $1"/"$file ]  #注意此处之间一定要加上空格，否则会报错
#         then
#             read_dir $1"/"$file
#         else
#             echo $1"/"$file
#         fi
#     done
# }

# path=`pwd`
cd ../
listfile ${ProjectName}

exit 0

# 相关文件路径
ignore_path="./.gitignore"
license_path="./LICENSE"
podfile_path="./Podfile"
readme_path="./README.md"
upload_path="./UPLOAD.sh"

pbxproj_Path="./${ProjectName}.xcodeproj/project.pbxproj"
xcworkspacedata_Path="./${ProjectName}.xcodeproj/project.xcworkspace/contents.xcworkspacedata"
infoplist_Path="./${ProjectName}/Info.plist"

# 修改文件内容
echo "Start editing..."

sed -i "" "s%_Author_%${Author}%g"              "${license_Path}"
sed -i "" "s%_ProjectName_%${ProjectName}%g"    "${gitignore_Path}"

sed -i "" "s%_ProjectName_%${ProjectName}%g"    "${readme_Path}"
sed -i "" "s%_date_time_%${date_now}%g"         "${readme_Path}"

sed -i "" "s%_ProjectName_%${ProjectName}%g"       "${podfile_Path}"
sed -i "" "s%_SpecHomePage_%${SpecHomePage}%g"     "${podfile_Path}"

sed -i "" "s%_ProjectName_%${ProjectName}%g"  "${upload_Path}"

# 组织名修改
sed -i "" "s%dafiger%${OrganizationName}%g"   "${pbxproj_Path}"
# BundleId修改
# sed -i "" "s%OCProjectDemo%${ProjectName}%g"  "${pbxproj_Path}"
# 工程相关的命名修改
sed -i "" "s%${DemoName}%${ProjectName}%g"    "${pbxproj_Path}"
sed -i "" "s%${DemoName}%${ProjectName}%g"    "${xcworkspacedata_Path}"
sed -i "" "s%${DemoName}%${ProjectName}%g"    "${infoplist_Path}"

echo "Edit finished"

echo "Start cleaning..."

rm -rf .git
rm -rf .DS_Store
rm -rf ${ProjectName}.xcodeproj/xcuserdata/
rm -rf ${ProjectName}.xcodeproj/project.xcworkspace/xcuserdata/
rm -rf ${ProjectName}.xcodeproj/project.xcworkspace/xcshareddata/

echo "Clean finished"

# 添加spec本地库
# pod repo add ${SpecName} ${SpecHomePage}

# pod install
# pod update --no-repo-update

echo "Good luck for you!"















