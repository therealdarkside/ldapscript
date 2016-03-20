#!/bin/bash

guardado(){
echo "dn: uid=$uid,ou=$ou,dc=$dc,dc=$dc2" >> $fi.ldif
echo "objectClass: top" >> $fi.ldif
echo "objectClass: account" >> $fi.ldif
echo "objectClass: posixAccount" >> $fi.ldif
echo "objectClass: shadowAccount" >> $fi.ldif
echo "cn: $uid" >> $fi.ldif
echo "homeDirectory: /home/$uid" >> $fi.ldif
echo "loginShell: /bin/bash" >> $fi.ldif
echo "userPassword: $(sudo cat /etc/shadow |grep $uid| cut -d':' -f2)" >> $fi.ldif
echo "shadowLastChange: 0" >> $fi.ldif
echo "shadowMax: 0" >> $fi.ldif
echo "shadowWarning: 0" >> $fi.ldif
}

clear
echo "-----------------------------------------"
echo "- INTERFAZ DE CONFIGURACIÓN DE OPENLDAP -"
echo "-----------------------------------------
"
echo "Introduce el nombre del fichero que quieres crear:"
read fi
ls|grep $fi
if [ $? -ne 0 ]
then
	touch $fi.ldif
else
	echo "El fichero ya existe"
	exit 0
fi

echo "Introduce el uid (User ID):"
read uid
echo "Introduce la ou (Unidad Organizativa):"
read ou
echo "Introduce el dc: (Domain Component):"
read dc
echo "Introduce otro dc: (Domain Component). Por ejemplo com de .com:"
read dc2
guardado
