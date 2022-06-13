#Příprava

#0/

#Vytvořte libovolným způsobem skupinu adu s GID 200.
#  groupadd -g 200 adu
#Zazálohujte si /etc/passwd a /etc/shadow
#  přes cp
#Budete-li dělat příklady s uživateli na Linuxu, vytvořte si adresář /export/home a neexistuje-li skupina apache, vytvořte ji.
  mkdir /export/home
  groupadd apache



#1/ Napište skript dejuid, který vyjde z /etc/passwd a vrátí první nepoužité UID větší než 1000 a menší než 60000.

touch dejuid.sh
chmod a+x dejuid.sh


#!/bin/bash
cut -d: -f3 /etc/passwd | sort -n | awk 'BEGIN {puid=1000;}
($0>1000 && $0<60000)
{
if ( $0==(puid+1) )
  { puid=$0; }
}
END {print puid+1;}' | tail -1



2/ Vytvořte skript, který přidá uživatele zadaného parametrem.

#!/bin/bash
if [ -z "$1"  ]; then echo "Neco zadej !!" && exit ; fi
NEWUID=$(/root/Desktop/CV02/01.sh) #volne UID nad 1000
STAFFGID=$(grep staff /etc/group | cut -d: -f3) # najde GID pro staff (solaris default 10)
mkdir -p "/export/home/$1" #home
echo "$1:x:$NEWUID:$STAFFGID::/export/home/$1:/usr/bin/bash" >> /etc/passwd
echo "$1:cmPg95i6i9icc:::::::" >> /etc/shadow  #heslo "student"
chown -R "$1:staff" /export/home/$1
chmod -R 744 /export/home/$1  # 4 = r--  7 = rwx



#5/ V systému souborů akceptujícím POSIX ACL (UFS v Solarisu nebo ext2, ext3 v Linuxu) otestujte možnost čtení pomocí ACL práv.
#Zkopírujte do nějakého adresáře soubor /etc/shadow a ověřte, že má stejná přístupová práva, jako originál.
#Vyzkoušejte, že nějaký běžný uživatel nemá právo tento soubor číst.
#Příkazem setfacl nastavte u souboru ACL práva tak, aby byl tímto uživatelem čitelný a ověřte. Vyzkoušejte funkci masky.


cp -R /etc/shadow /UFS
setfacl -m u:user1:r-- /UFS/shadow
setfacl -m m:r-- /UFS/shadow
echo "abc" > /UFC/abc
getfacl /UFS/shadow | setfacl -f - /UFS/abc
