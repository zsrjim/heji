#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 检查 wget 或 curl 是否可用
check_dependencies() {
    if command -v wget >/dev/null 2>&1; then
        echo "使用 wget"
        DOWNLOAD_CMD="wget -qO"
    elif command -v curl >/dev/null 2>&1; then
        echo "使用 curl"
        DOWNLOAD_CMD="curl -sLo"
    else
        echo "错误：没有找到 wget 或 curl，无法下载文件。请安装其中一个。"
        exit 1
    fi
}

# 0. 一键更新系统
update() {
    echo "正在更新系统..."
    apt-get update -y && apt-get upgrade -y && apt-get install wget sudo curl socat -y || { echo "更新或安装失败！"; exit 1; }
}

# 1. 一键DD Debian11
debian() {
    check_dependencies
    $DOWNLOAD_CMD debi.sh https://js.danshui.tk/proxy/https://raw.githubusercontent.com/bohanyang/debi/master/debi.sh
    chmod a+rx debi.sh && ./debi.sh --install 'curl wget neofetch htop net-tools git' --hostname liu --bbr --ustc --timezone Asia/Shanghai --cloud-kernel --user root --password xxxxxx && shutdown -r now
}

# 2. 流媒体测试
check() {
    check_dependencies
    bash <($DOWNLOAD_CMD -L -s https://js.danshui.tk/proxy/https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
}

# 3. 一键安装XUI
xui() {
    check_dependencies
    bash <($DOWNLOAD_CMD -Ls https://js.danshui.tk/proxy/https://raw.githubusercontent.com/FranzKafkaYu/x-ui/master/install.sh)
}

# 4. 一键安装Acme
Acme() {
    check_dependencies
    $DOWNLOAD_CMD acme.sh https://get.acme.sh | sh
    read -e -p "请输入邮箱：" str
    # 80 端口空闲的证书申请方式
    ~/.acme.sh/acme.sh --register-account -m $str --server letsencrypt
    read -e -p "请输入域名：" str
    ~/.acme.sh/acme.sh --issue -d $str --server letsencrypt --standalone

    # 安装证书到指定文件夹
    ~/.acme.sh/acme.sh --installcert -d $str --key-file /root/private.key --fullchain-file /root/cert.crt
}

# 5. 一键测速
superspeed() {
    check_dependencies
    bash <($DOWNLOAD_CMD -Lso- https://git.io/superspeed_uxh)
}

# 6. 一键安装docker
docker() {
    check_dependencies
    curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
}

# 7. 一键安装docker-compose
docker-compose() {
    check_dependencies
    $DOWNLOAD_CMD "https://js.danshui.tk/proxy/https://github.com/docker/compose/releases/download/v2.10.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose && ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
}

# 8. 安装Tg专用代理（Go版）
mtproxy() {
    check_dependencies
    bash <($DOWNLOAD_CMD -s -L https://js.danshui.tk/proxy/https://raw.githubusercontent.com/shidahuilang/SS-SSR-TG-iptables-bt/main/sh/mtproxy_go.sh)
}

# 9. 安装sing-box全家桶
sing-box() {
    check_dependencies
    bash <($DOWNLOAD_CMD -qO- https://js.danshui.tk/proxy/https://raw.githubusercontent.com/fscarmen/sing-box/main/sing-box.sh)
}

# 10. 一键添加虚拟交换分区（别乱用）
swap() {
    check_dependencies
    bash -c  "$(curl -fsSL https://js.danshui.tk/proxy/https://raw.githubusercontent.com/shidahuilang/pve/main/swap.sh)"
}

# 菜单
echo && echo -e " 
+-------------------------------------------------------------+
|                          vip专用                             | 
|                          使用教程                            |                   
+-------------------------------------------------------------+
 ${Green_font_prefix}0.${Font_color_suffix}  更新系统插件
 ${Green_font_prefix}1.${Font_color_suffix}  DD最新的Debian11系统默认密码xxxxxx
 ${Green_font_prefix}2.${Font_color_suffix}  流媒体测试
 ${Green_font_prefix}3.${Font_color_suffix}  安装XUI
 ${Green_font_prefix}4.${Font_color_suffix}  安装Acme
 ${Green_font_prefix}5.${Font_color_suffix}  VPS测速
 ${Green_font_prefix}6.${Font_color_suffix}  安装docker
 ${Green_font_prefix}7.${Font_color_suffix}  安装docker-compose
 ${Green_font_prefix}8.${Font_color_suffix}  安装Tg专用代理（Go版）
 ${Green_font_prefix}9.${Font_color_suffix}  安装sing-box
 ${Green_font_prefix}10.${Font_color_suffix} 更改swap分区
" && echo

# 读取用户输入的选择
echo
read -e -p " 请输入数字 [0-10]:" num

# 执行相应的操作
case "$num" in
    0)
        update
        ;;
    1)
        debian
        ;;
    2)
        check
        ;;
    3)
        xui 
        ;;
    4)
        Acme 
        ;;
    5)
        superspeed 
        ;;
    6)
        docker 
        ;;
    7)
        docker-compose 
        ;;
    8)
        mtproxy 
        ;;
    9)
        sing-box 
        ;;
    10)
        swap 
        ;;
    *)
        echo "请输入正确数字 [0-10]"
        ;;
esac
