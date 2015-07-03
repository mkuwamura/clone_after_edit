#!/bin/bash
#auther mkuwamura
#ver. 0.91
#date 2015/07/01
IFCONFIG_DIR=/etc/sysconfig/network-scripts
ZABCONFIG_DIR=/etc/zabbix
ZABCONFIG_FILE=zabbix_agentd.conf

function usage(){
echo -e "Usage: $0 [-0] eth0_IPaddr_change
                      [-1] eth1_IPaddr_change
                      [-2] eth2_IPaddr_change
                      [-c] file check
                      [-s] RHEL register show
                      [-r] RHEL register
                      [-z] zabicom_agent_edit \e[32mcomming soon!!\e[m
                      [-h|Unknown Option] This message
                      [no option] No Action"
}

while [ $# -gt 0 ]
do
case "$1" in
-0) ETH0_IP_EDIT=TRUE
shift ;;
-1) ETH1_IP_EDIT=TRUE
shift ;;
-2) ETH2_IP_EDIT=TRUE
shift ;;
#-s) STATIC_ROUTE=TRUE
#shift ;;
#-n) HOST_NAME=TRUE
#shift ;;
-s) RSHOW=TRUE
shift ;;
-r) REGIST=TRUE
shift ;;
-c) CHK=TRUE
shift ;;
-z) ZABI_EDIT=TRUE
shift ;;
-?) usage 1>&2
exit 1 ;;
*) exit 1 ;;
esac
done

echo ETH0 $ETH0_IP_EDIT
echo ETH1 $ETH1_IP_EDIT
echo ETH2 $ETH2_IP_EDIT
echo RSHOW $RSHOW
echo CHK $CHK
#echo $SERVERSPEC_RECIPE
#echo $SERVERSPEC_ACTION

if [  "$ETH0_IP_EDIT" = "TRUE" ]; then
  ETH_NOMBER=0
  EDIT_TIME=`date '+%Y%m%d'`
  if [ -e $IFCONFIG_DIR/_ifcfg-eth"$ETH_NOMBER"_"$EDIT_TIME"01 ] ;then
    echo ""$IFCONFIG_DIR/_ifcfg-eth"$ETH_NOMBER"_"$EDIT_TIME"01" "is exist" "
    exit 1
  else
    echo -n -e "\e[32meth0  IP ADDR Please!!:\e[m"
    while read IP_ADDR
    do
      cp -p $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER" $IFCONFIG_DIR/_ifcfg-eth"$ETH_NOMBER"_"$EDIT_TIME"01
      sed -i -e "s/^ONBOOT=no/ONBOOT=yes/g" $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
      sed -i -e "s/^#BOOTPROTO/BOOTPROTO/g" $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
      sed -i -e "s/^#IPADDR=10.208eth0/IPADDR=$IP_ADDR/g" $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
      MAC=`cat /sys/class/net/eth0/address | tr -d '\n'`
      sed -i -e "s/^#HWADDR=/HWADDR="$MAC"/g" $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
      diff $IFCONFIG_DIR/_ifcfg-eth"$ETH_NOMBER"_"$EDIT_TIME"01 $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
    break
    done
  fi
fi

if [ "$ETH1_IP_EDIT" = "TRUE" ]; then
  ETH_NOMBER=1
  EDIT_TIME=`date '+%Y%m%d'`
  if [ -e $IFCONFIG_DIR/_ifcfg-eth"$ETH_NOMBER"_"$EDIT_TIME"01 ] ;then
     echo ""$IFCONFIG_DIR/_ifcfg-eth"$ETH_NOMBER"_"$EDIT_TIME"01" "is exist" "
     exit 1
  else
    echo -n -e "\e[32meth"1" IP ADDR Please!!:\e[m"
    while read IP_ADDR
    do
      cp -p $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER" $IFCONFIG_DIR/_ifcfg-eth"$ETH_NOMBER"_"$EDIT_TIME"01
      sed -i -e "s/^ONBOOT=no/ONBOOT=yes/g" $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
      sed -i -e "s/^#BOOTPROTO/BOOTPROTO/g" $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
      sed -i -e "s/^#IPADDR=10.208eth1/IPADDR=$IP_ADDR/g" $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
      MAC=`cat /sys/class/net/eth1/address | tr -d '\n'`
      sed -i -e "s/^#HWADDR=/HWADDR="$MAC"/g" $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
      diff $IFCONFIG_DIR/_ifcfg-eth"$ETH_NOMBER"_"$EDIT_TIME"01 $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
    break
    done
  fi
fi

if [  "$ETH2_IP_EDIT" = "TRUE" ]; then
  ETH_NOMBER=2
  EDIT_TIME=`date '+%Y%m%d'`
  if [ -e $IFCONFIG_DIR/_ifcfg-eth"$ETH_NOMBER"_"$EDIT_TIME"01 ] ;then
    echo ""$IFCONFIG_DIR/_ifcfg-eth"$ETH_NOMBER"_"$EDIT_TIME"01" "is exist" "
    exit 1
  else
    echo -n -e "\e[32meth"2" IP  ADDR Please!!:\e[m"
    while read IP_ADDR
    do
      cp -p $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER" $IFCONFIG_DIR/_ifcfg-eth"$ETH_NOMBER"_"$EDIT_TIME"01
      sed -i -e "s/^ONBOOT=no/ONBOOT=yes/g" $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
      sed -i -e "s/^#BOOTPROTO/BOOTPROTO/g" $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
      sed -i -e "s/^#IPADDR=10.208eth2/IPADDR=$IP_ADDR/g" $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
      MAC=`cat /sys/class/net/eth2/address | tr -d '\n'`
      sed -i -e "s/^#HWADDR=/HWADDR="$MAC"/g" $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
      diff $IFCONFIG_DIR/_ifcfg-eth"$ETH_NOMBER"_"$EDIT_TIME"01 $IFCONFIG_DIR/ifcfg-eth"$ETH_NOMBER"
    break
    done
  fi
fi

if [  "$RSHOW" = "TRUE" ]; then
  subscription-manager list --available
  date
fi

if [  "$REGIST" = "TRUE" ]; then
  echo -e subscription-manager register --autosubscribe --username="\e[31myour account!!!\e[m" --password="\e[31myour password!!!!\e[m"
fi

if [ "$STATIC_ROUTE" = "TRUE" ]; then
  echo -n -e "\e[32mstatic route Please!!:\e[m"
  STATIC_EDIT_TIME=`date '+%Y%m%d'`
  while read LINE
  do
    if [ "$LINE" -eq "end_line" ]; then
    echo -e "\e[31m受付を終了します...\e[m"
    else
    echo $LINE >>$STATIC_FILE
    echo -e "\e[31maccepted\e[m"
    fi
  break
  done
fi

if [  "$ZABI_EDIT" = "TRUE" ]; then
  EDIT_TIME=`date '+%Y%m%d'`
  if [ -e $ZABCONFIG_DIR/_"$ZABCONFIG_FILE"_"$EDIT_TIME"01 ] ;then
    echo ""$ZABCONFIG_DIR/_"$ZABCONFIG_FILE"_"$EDIT_TIME"01" "is exist" "
    exit 1
  else
    echo -n -e "\e[32mHostCode Please!!:\e[m"
    while read HOST_CODE
    do
      EDIT_TIME=`date '+%Y%m%d'`
      cp -pi $ZABCONFIG_DIR/$ZABCONFIG_FILE $ZABCONFIG_DIR/_"$ZABCONFIG_FILE"_"$EDIT_TIME"01
      sed -i -e "s/^Hostname=/Hostname="$HOST_CODE"/g" $ZABCONFIG_DIR/"$ZABCONFIG_FILE"
      diff $ZABCONFIG_DIR/_"$ZABCONFIG_FILE"_"$EDIT_TIME"01 $ZABCONFIG_DIR/$ZABCONFIG_FILE
    break
    done
  fi
fi

if [  "$CHK" = "TRUE" ]; then
  echo  -e "\e[32m#######################################\e[m"
  echo  -e "\e[32mifcfg-eth\e[m"
  more /etc/sysconfig/network-scripts/ifcfg-eth*
  echo  -e "\e[32m#######################################\e[m"
  echo  -e "\e[32m70\e[m"
  more /etc/udev/rules.d/70-persistent-net.rules*
  echo  -e "\e[32m#######################################\e[m"
  echo  -e "\e[32mifcfg-eth\e[m"
  more /etc/sysconfig/network-scripts/ifcfg-eth*
  echo  -e "\e[32m#######################################\e[m"
  echo  -e "\e[32mifcfg-route\e[m"
  more /etc/sysconfig/network-scripts/route-eth*
  echo  -e "\e[32m#######################################\e[m"
  echo  -e "\e[32mntp.conf\e[m"
  cat /etc/ntp.conf
  echo  -e "\e[32m#######################################\e[m"
  echo  -e "\e[32msyscon_network\e[m"
  cat /etc/sysconfig/network
  echo  -e "\e[32m#######################################\e[m"
fi
