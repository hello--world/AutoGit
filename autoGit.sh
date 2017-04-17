#!/bin/bash
# 脚本学习

# 按顺序执行，函数需要调用才执行

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
    git_user="user.name"
    username="`git config --git $git_user`"
    if [[ -n $username ]]; then
        #statements
        echo "?"
    else
        echo $username
    fi

    username="autoShell"
    git config user.name $username
    echo "设置用户为$username"
    useremail="hellohfy@gmail.com"
    # 暂时用这个，后面改为取参数
    git config user.email $useremail
}

git_commit() {

    echo "."
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
    echo "-->$hfy--?"
    echo `git add .`
    message="`date +%Y年%m月%d日%H:%M:%S脚本自动提交`"
    echo $message
    echo `git commit -m ${message}`

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
    echo `git init`
    git_config
    echo `git checkout -b master`
    echo `git add .`
    echo `git commit -m "脚本初始化git并提交项目"`
    fi
#    echo $input
#    done

fi


