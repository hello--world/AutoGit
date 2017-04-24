#!/bin/bash
# 脚本学习，复习git使用

# 按顺序执行，函数需要调用才执行
# 测试查找大文件，删除历史

# 变量替换
#${var} 变量本来的值
#${var:-word}    如果变量 var 为空或已被删除(unset)，那么返回 word，但不改变 var 的值。
#${var:=word}    如果变量 var 为空或已被删除(unset)，那么返回 word，并将 var 的值设置为 word。
#${var:?message} 如果变量 var 为空或已被删除(unset)，那么将消息 message 送到标准错误输出，可以用来检测变量 var 是否可以被正常赋值。
#若此替换出现在Shell脚本中，那么脚本将停止运行。
#${var:+word}    如果变量 var 被定义，那么返回 word，但不改变 var 的值。

 # -z 判断字符串是否为空
    # if [ -z "branch" ]; then
    #     branch="master"
    # fi

#
set -e
# set -x # 显示执行过程

# 只读属性
readonly VERSION="1.0"

readonly COMMITDATE=`date +%Y_%m_%d_%H_%M_%S`

# readonly DEBUG=false
readonly DEBUG=true

# delrubbishfile ()
echo "测试啊\n"

# 删除垃圾文件
delrubbishfile () { 
    # .DS_Store
    for filePath in `find . -name .DS_Store`; do
        echo "删除文件-->${filePath}"
        rm -rf ${filePath}
    done
}

# 写在delrubbishfile () { } 的后面
delrubbishfile

# 状态
git_status () {
    # echo `git status`
    status="`git status`"
    echo $status
    # 函数只能返回数字
    # if [[ $status != "" ]]; then
    #     return "ss"
    # fi
    # return "d"
    echo "我叫什么名？"

}
# 配置
git_config() {

    username="`git config --get user.name`"
    # 判断字符串是否为空
    # 判断有无用户名
    if [ ! -n "$username" ]; then
        echo "没有用户名"
        username="autoShell"
        git config user.name $username
        echo "设置用户为$username"
    else
        : #占位
    fi
    echo "用户名--->$username"
  
    useremail="`git config --get user.email`"
# 判断有无用户名
    if [ ! -n "$useremail" ]; then
        echo "没有设置email"
        useremail="hellohfy@gmail.com"
        git config user.email $useremail 
        echo "设置email为$useremail"
    else
        : #占位
    fi
    echo "email--->$useremail"

}
# 提交
git_commit() {
    message="$1"
    if [ ! -n "$message" ]; then
        message="${COMMITDATE}脚本自动提交"
    fi
    echo `git commit -m ${message}`
    :
}
# 推送
git_push() {
    if ${DEBUG}; then 
        # 判断是否设置url
        if [ -z "`git config remote.origin.url`" ]; then
        git remote add origin git@github.com:hello--world/AutoGit.git
        fi
        branch=${COMMITDATE}
        git_checkout ${branch}
        echo `git push -u origin ${branch}`

    fi
}
# 添加
git_add() {
    git add .
}
# 初始化
git_init() {
    git init
}
# 检出
git_checkout() {
    git checkout -b ${1:-master}
}

find_file () {

    filesPath="${HOME}/Desktop/files.txt"
    echo "filesPath-->${filesPath}"
    if [ -f ${filesPath} ]; then
        rm ${filesPath}
    fi
    find . -type f -size +1k>>${filesPath} # 查找当前大于

}

# git_status
# echo "文件名--->$0"
# echo "参数1--->$1"
# 如果没有输入参数
if [[ -d "$1" ]]; then
    echo "目录存在"
# 如果存在.git目录
elif [[ -d "`pwd`/.git" ]]; then
    find_file

    git_config
    echo "当前目录--->`pwd`"
#    echo `git log`
    # git_status
    hfy=$(git_status)
    echo "状态：-->$hfy--?"
    git_add
    git_commit
    git_push


else
# echo "参数输入错误~~~~"
    echo "---->请输入git目录或者将脚本复制到git目录<----"
    echo "当前目录--->`pwd`"
#    PS3="是否需要初始化git?Y?"
#    select y in "y" "Y"
#    do
#    echo "$y"
#    break
#    done
    read -p "是否需要初始化git?y?" input
# -eq 能判断数字，不嗯判断字符
    if [ "$input" = "y" ]
    then
#result=`git init`
    git_config
    git_init
    git_checkout
    git_add
    git_commit "${COMMITDATE}脚本初始化git并提交项目"
   
    fi
#    echo $input
#    done

fi


