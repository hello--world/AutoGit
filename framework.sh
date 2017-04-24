#!/bin/bash

# FRAMEWORK="FRAMEWORK.TXT"

# PATH=$1 导致命令找不到。。。
PATHIDR=$1

echo $PATHIDR

if [[ -d  ${PATHIDR} && ! -z "${PATHIDR}" ]]; then

	find ${PATHIDR} -name "*.framework"|awk 'BEGIN{ FS="/" } { print $NF }'|awk 'BEGIN{ FS="." } { print $1 }'>>${2:-frameworks_name.txt}

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