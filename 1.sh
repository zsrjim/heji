#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


 #0一键更新系统
update(){
	apt update -y && apt install -y curl && apt install -y socat
}
 #1一键DD debian11
debian(){
	curl -fLO https://raw.githubusercontent.com/bohanyang/debi/master/debi.sh && chmod a+rx debi.sh && ./debi.sh --install 'curl wget neofetch htop net-tools git' --hostname liu --bbr --timezone Asia/Shanghai --cloud-kernel --user root --password xxxxxx && shutdown -r now
}
#2流媒体测试
check(){
	bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
}
#3一键安装XUI
xui(){
	bash <(curl -Ls https://raw.githubusercontent.com/FranzKafkaYu/x-ui/master/install.sh)
}
#4一键安装Acme
Acme (){
	curl https://get.acme.sh | sh
}

echo && echo -e " 
  
+-------------------------------------------------------------+
|                          vip专用                             | 
|                          使用教程                             |                   
+-------------------------------------------------------------+
 ${Green_font_prefix}0.${Font_color_suffix}  更新系统插件
 ${Green_font_prefix}1.${Font_color_suffix}  DD最新的diban11系统默认密码xxxxxx
 ${Green_font_prefix}2.${Font_color_suffix}  流媒体测试
 ${Green_font_prefix}3.${Font_color_suffix}  安装XUI
 ${Green_font_prefix}4.${Font_color_suffix}  安装Acme
 " && echo
echo
read -e -p " 请输入数字 [0-1]:" num
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
	*)
	echo "请输入正确数字 [0-4]"
	;;
 esac
