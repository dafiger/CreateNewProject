#!/bin/bash
# chmod 755 CreateNewModule.sh

# 定义颜色
HighLightColor='\033[0;36m'
DefaultColor='\033[0;m'

# 工程名
ProjectName=''
# 组织名
OrganizationName=''
# 模板工程clone地址
DemoClonePath='https://github.com/dafiger/OCProjectDemo.git'
# 模板工程名
DemoName='OCProjectDemo'

# 作者
Author='dafiger'
# 作者和组织一样
# Author="${OrganizationName}"

# Spec仓库名称
SpecName='DFSpec'
# Spec仓库主页地址
SpecHomePage='https://github.com/dafiger/DFSpec.git'

# 确认状态
ConfirmStatus='N'

# 输入项目名
InputProjectName() {
    echo -e "\n"
	read -p 'Please input your Project name: ' ProjectName
    if 
    	test -z ${ProjectName};
    then
    	InputProjectName
    fi
}

# 输入组织名
InputOrganizationName() {
    echo -e "\n"
    read -p 'Please input your Organization name: ' OrganizationName
    if 
    	test -z ${OrganizationName};
    then
    	InputOrganizationName
    fi
    # 作者和组织一样
    Author="${OrganizationName}"
}

# 审查输入内容
CheckInfomation() {
    InputProjectName
    InputOrganizationName

    echo -e "\n================================================"
    echo -e "  Project Name        :  ${HighLightColor}${ProjectName}${DefaultColor}"
    echo -e "  Organization Name   :  ${HighLightColor}${OrganizationName}${DefaultColor}"
    echo -e "  Author              :  ${HighLightColor}${Author}${DefaultColor}"
    echo -e "  Spec Name           :  ${HighLightColor}${SpecName}${DefaultColor}"
    echo -e "  Spec HomePage       :  ${HighLightColor}${SpecHomePage}${DefaultColor}"
    echo -e "================================================\n"
}

# 循环检查
while [ ${ConfirmStatus} != 'y' -a ${ConfirmStatus} != 'Y' ]
do
    if 
        [ ${ConfirmStatus} == 'n' -o ${ConfirmStatus} == 'N' ]; 
    then
        CheckInfomation
    fi
    read -p 'Are you sure? (y/n):' ConfirmStatus
done

# 返回桌面
cd
cd Desktop/

# 桌面新建文件夹
# mkdir ${ProjectName}
# date_now=`date +%Y%m%d`
date_now=`date +%Y%m%d%H%M%S`
mkdir -p ${ProjectName}/${date_now}
cd ${ProjectName}/${date_now}

# 下载模板工程
git clone ${DemoClonePath}
# ls

# 复制主工程
# 递归拷贝
# cp -r "${DemoName}" "${ProjectName}"
# 直接拷贝不需要询问
# cp -f "${DemoName}" "${ProjectName}"
# 主工程重新命名
mv "${DemoName}" "${ProjectName}"
# 打开工程
cd ${ProjectName}
mv "${DemoName}" "${ProjectName}"
mv "${DemoName}.xcodeproj" "${ProjectName}.xcodeproj"

# 文件路径
license_Path="./LICENSE"
gitignore_Path="./.gitignore"
readme_Path="./README.md"
podfile_Path="./Podfile"
upload_Path="./UPLOAD.sh"

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















