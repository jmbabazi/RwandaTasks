#!/bin/bash
SUBJECT="MTN MODEM STATUS ON RWINK PRODUCTION"
EMAIL="jamesmbaba@gmail.com"
EMAILMESSAGE="/home/openmrs/.scripts/.messages/MTNConnectionStatusRwinkProduction-`date +"%Y-%b-%d"`.txt"

MCHECK=`lsusb | grep ONDA`
if ! [ -n "$MCHECK" ]; then
echo "3G/GPRS modem not in use on production server. Check if the modem is unplugged...$(date)" >> $EMAILMESSAGE

# send an email using /usr/bin/mail
/usr/bin/mail -s "$SUBJECT" "$EMAIL" < $EMAILMESSAGE
exit 0
fi

NCHECK=`/sbin/ifconfig ppp`
NCHECK1=`echo $NCHECK | cut -d " " -f 1`
if [ "$NCHECK1" = "ppp0" ]; then
echo "Connection up, reconnect not required...$(date)">> $EMAILMESSAGE
exit 0
else
echo "Connection down, reconnecting...$(date)">> $EMAILMESSAGE
killall modem-manager
killall NetworkManager
/etc/init.d/network-manager restart
sleep 20
/usr/bin/mail -s "$SUBJECT" "$EMAIL" < $EMAILMESSAGE
fi
