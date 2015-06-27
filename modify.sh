#!/bin/bash
#auther mkuwamura
#ver. 0.88
IFCONFIG_DIR=/tmp
ZABCONFIG_DIR=/tmp
ZABCONFIG_FILE=zabbix_agent.conf


function usage(){
echo "Usage: $0 [-0] eth0_IPaddr_change [-1] eth1_IPaddr_change [-2] eth2_IPaddr_change [-z] zabicom_agent_edit [-h|Unknown Option] This message [no option} No Action"

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
-s) STATIC_ROUTE=TRUE
shift ;;
-n) HOST_NAME=TRUE
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
echo $SERVERSPEC_RECIPE
echo $SERVERSPEC_ACTION

if [ "$ETH0_IP_EDIT" = "TRUE" ]; then
ETH_NOMBER=eth0
EDIT_TIME=`date '+%Y%m%d'`
if [ -e $IFCONFIG_DIR/_ifcfg-"$ETH_NOMBER"_"$EDIT_TIME"01 ] ;then
echo ""$IFCONFIG_DIR/_ifcfg-"$ETH_NOMBER"_"$EDIT_TIME"01" "is exist" "
exit 1
else
echo -n -e "\e[32meth0 IP ADDR Please!!:\e[m"
while read IP_ADDR
do
cp -p $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER" $IFCONFIG_DIR/_ifcfg-"$ETH_NOMBER"_"$EDIT_TIME"01
sed -i -e "s/^ONBOOT=no/ONBOOT=yes/g" $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER"
sed -i -e "s/^#BOOTPROTO/BOOTPROTO/g" $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER"
sed -i -e "s/^#IPADDR=10.208/IPADDR=$IP_ADDR/g" $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER"
diff $IFCONFIG_DIR/_ifcfg-"$ETH_NOMBER"_"$EDIT_TIME"01 $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER"
break
done
fi
fi

if [ "$ETH1_IP_EDIT" = "TRUE" ]; then
ETH_NOMBER=eth1
EDIT_TIME=`date '+%Y%m%d'`
if [ -e $IFCONFIG_DIR/_ifcfg-"$ETH_NOMBER"_"$EDIT_TIME"01 ] ;then
echo ""$IFCONFIG_DIR/_ifcfg-"$ETH_NOMBER"_"$EDIT_TIME"01" "is exist" "
exit 1
else
echo -n -e "\e[32meth"1" IP ADDR Please!!:\e[m"
while read IP_ADDR
do
cp -p $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER" $IFCONFIG_DIR/_ifcfg-"$ETH_NOMBER"_"$EDIT_TIME"01
sed -i -e "s/^ONBOOT=no/ONBOOT=yes/g" $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER"
sed -i -e "s/^#BOOTPROTO/BOOTPROTO/g" $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER"
sed -i -e "s/^#IPADDR=10.208/IPADDR=$IP_ADDR/g" $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER"
diff $IFCONFIG_DIR/_ifcfg-"$ETH_NOMBER"_"$EDIT_TIME"01 $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER"
break
done
fi
fi

if [ "$ETH2_IP_EDIT" = "TRUE" ]; then
ETH_NOMBER=eth2
EDIT_TIME=`date '+%Y%m%d'`
if [ -e $IFCONFIG_DIR/_ifcfg-"$ETH_NOMBER"_"$EDIT_TIME"01 ] ;then
echo ""$IFCONFIG_DIR/_ifcfg-"$ETH_NOMBER"_"$EDIT_TIME"01" "is exist" "
exit 1
else
echo -n -e "\e[32meth"2" IP ADDR Please!!:\e[m"
while read IP_ADDR
do
cp -p $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER" $IFCONFIG_DIR/_ifcfg-"$ETH_NOMBER"_"$EDIT_TIME"01
sed -i -e "s/^ONBOOT=no/ONBOOT=yes/g" $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER"
sed -i -e "s/^#BOOTPROTO/BOOTPROTO/g" $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER"
sed -i -e "s/^#IPADDR=10.208/IPADDR=$IP_ADDR/g" $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER"
diff $IFCONFIG_DIR/_ifcfg-"$ETH_NOMBER"_"$EDIT_TIME"01 $IFCONFIG_DIR/ifcfg-"$ETH_NOMBER"
break
done
fi
fi

if [ "$STATIC_ROUTE" = "TRUE" ]; then
echo -n -e "\e[32mstatic route Please!!:\e[m"
STATIC_EDIT_TIME=`date '+%Y%m%d'`
#cp -pi $IFCONFIG_DIR/ifcfg-eth0 $IFCONFIG_DIR/_ifcfg-eth1_"$ETH1_EDIT_TIME"01
while read LINE
do
if [ "$LINE" -eq "end_line" ]; then
echo -e "\e[31mŽó•t‚ðI—¹‚µ‚Ü‚·...\e[m"
else
echo $LINE >>$STATIC_FILE
echo -e "\e[31maccepted\e[m"
fi
break
done
fi


if [ "$ZABI_EDIT" = "TRUE" ]; then
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
sed -i -e "s/^Server=127.0.0.1/Server="$HOST_CODE"/g" $ZABCONFIG_DIR/"$ZABCONFIG_FILE"
diff $ZABCONFIG_DIR/_"$ZABCONFIG_FILE"_"$EDIT_TIME"01 $ZABCONFIG_DIR/$ZABCONFIG_FILE
break
done
fi
fi