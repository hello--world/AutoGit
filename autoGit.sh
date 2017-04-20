#!/bin/bash
# 脚本学习，复习git使用

# 按顺序执行，函数需要调用才执行
# 测试查找大文件，删除历史

set -e
# set -x # 显示执行过程

# 只读属性
readonly VERSION="1.0"

readonly COMMITDATE=`date +%Y_%m_%d_%H_%M_%S`

# readonly DEBUG=false
readonly DEBUG=true

echo "测试啊\n"

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
    echo `git add .`
}
# 初始化
git_init() {
    echo `git init`
}
# 检出
git_checkout() {
    branch=$1
    # -z 判断字符串是否为空
    if [ -z "branch" ]; then
        branch="master"
    fi
    echo `git checkout -b ${branch}` 
}

find_file () {
    files="files.txt"
    if [ -f ${files} ]; then
        rm ${files}
    fi
    echo `find . -type f -size +1k>>${files}`

}

# git_status
# echo "文件名--->$0"
# echo "参数1--->$1"
# 如果没有输入参数
if [[ -d "$1" ]]; then
    echo "目录存在"
# 如果存在.git目录
elif [[ -d "`pwd`/.git" ]]; then

    git_config
    echo "当前目录--->`pwd`"
#    echo `git log`
    # git_status
    hfy=$(git_status)
    echo "状态：-->$hfy--?"
    git_add
    git_commit
    git_push

    find_file

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


