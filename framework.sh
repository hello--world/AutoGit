#!/bin/bash

# 将framework的名字和头文件名字提取出来，导出文件
# FRAMEWORK="FRAMEWORK.TXT"

# PATH=$1 导致命令找不到。。。
#1、shell遇到”>”操作符，会判断右边文件是否存在，如果存在就先删除，并且创建新文件。不存在直接创建。 无论左边命令执行是否成功。右边文件都会变为空。

#2、“>>”操作符，判断右边文件，如果不存在，先创建。以添加方式打开文件，会分配一个文件描述符[不特别指定，默认为1,2]然后，与左边的标准输出（1）或错误输出（2） 绑定。

PATHIDR=$1

echo $PATHIDR

if [[ -d ${PATHIDR} && ! -z "${PATHIDR}" ]]; then
	frameworks_name=${2:-frameworks_name.txt}

	# 查找路径，将内容使用awk命令进行处理 FS="/" 分隔符  $NF 最后一个  $1第一个
	find ${PATHIDR} -name "*.framework"|awk 'BEGIN{ FS="/" } { print $NF }'|awk 'BEGIN{ FS="." } { print $1 }'>${frameworks_name}
	frameworksdir="frameworkstxt.bundle"
	if [[ -d "${frameworksdir}" ]]; then
		rm -rf ${frameworksdir}/*
	else
		mkdir ${frameworksdir}
	fi 
	while read line; do
		# echo $line
		# frameworkpath="${PATHIDR}/${line}/.framework"
		
		ls ${PATHIDR}/${line}.framework|awk 'BEGIN{ FS="." } {print $1}'>${frameworksdir}/${line}.txt
	done<${frameworks_name}
else
	echo "参数输入错误，请输入framework路径，eg:./framework.sh /xxx/xxx"
fi

	# echo `awk 'BEGIN{ FS="/" } { print $NF }' name.tmp`>>111.txt
				# for i in `awk 'BEGIN{ FS="." } { print $1 }' 111.txt`; do
				# 	#statements
				# done
								# echo `awk 'BEGIN{ FS="." } { print $1 }' 111.txt`>>222.txt
# 打算用sed做，没做出来
# for path in `find ${PATHIDR} -name "*.framework"`; do
	# 	if [ -d ${path} ]; then
	# 		# echo "path-->${path}"

	# 		# find ${path} -name "*.h">>tmp.txt
	# 		# echo "${path}">>name.tmp

	# 		# sed '/^${PATHIDR}/d' name.tmp

	# 		# sed -i "" 's/^\/Users\/hefengyang\/git\/iOS-Runtime-Headers\/Frameworks//g' name.tmp

	# 		# sed -i "" 's/^"${PATHIDR}"//g' name.tmp

	# 		# echo `sed  's/^"${PATHIDR}"//g' <${path}`>>tmp

	# 		# `${path}`
	# 		# ls ${path}>>tmp.txt
	# 		# cat tmp.txt
	# 		# sed '/^${PATHIDR}/'d tmp.txt
	# 		# sed '/^$/Users/hefengyang/git/iOS-Runtime-Headers/Frameworks/'d /Users/hefengyang/git/iOS-Runtime-Headers/Frameworks/WebKit.framework
	# 		# cat tmp.txt
	# 		:
	# 	fi
	# done