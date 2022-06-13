0/ Vytvořte v Solarisu jakýmkoli způsobem alespoň 3 běžné uživatele, včetně nastavení hesla.

useradd user1
useradd user2
useradd user3

passwd user1
passwd user2
passwd user3

1/ Uveďte systém (Solaris 11) do implicitního stavu, kdy se root nemůže přihlašovat přímo, ale jen prostřednictvim běžného uživatele (zde student) pomocí su -

Prohlédněte si soubor /etc/user_attr a pokuste se z něj pochopit, jak byl systém „downgradován“, že se root může přihlásit přímo.
Zaarchivujte si stávající /etc/user_attr.
Uveďte systém do původního bezpečného stavu.
Ověřte přes ssh uživatel@localhost možnost přihlášení uživatelů root, student a nějaký jiný uživatel a jejich možnost stát se rootem.
Zařiďte, aby se něterý z vámi vytvořených uživatelů mohl stát rootem.


cd /etc/
useradd -m -d /export/home/user4 -s /bin/pfksh user4
passwd user4
tar cvf archiv.tar user_attr
mv user_attr.orig_S11 user_attr
ssh root@localhost
usermod -K type=role root
grep root /etc/user_attr
# root::::type=role;auths=solaris.*,solaris.grant;profiles=..
usermod -R root user4



2/ Vytvořte profil super_reader, který umožní přečíst příkazem more jakýkoli soubor a přiřaďte tento profil nějakému běžnému uživateli. Sledujte průběžně změny v souboru /etc/user_attr !


echo "super_reader::::" >> /etc/security/prof_attr
echo "super_reader:suser:cmd:::/usr/bin/more:euid=0" >> /etc/security/exec_attr
usermod -P super_reader user1


3/ Vytvořte roli ctenar s tímto profilem, přiřaďte ji dalšímu uživateli a otestujte v rámci role stejnými příkazy jako v příkladu 2/.


roleadd -m -d /export/home/ctenar -P super_reader -s /bin/pfksh ctenar
passwd ctenar
usermod -R ctenar user1


4/ Vytvořte pod tímto (neprivilegovaným) uživatelem skript cat_shadow, který příkazem cat vypíše soubor /etc/shadow. Skript vytvořte v adresáři /var/tmp a nastavte mu práva 755. (Skript samozřejmě fungovat nebude. Proč?)

su super_reader

echo "#!/bin/pfksh
cat /etc/shadow" >> /var/tmp/cat_shadow
chmod u=rwx,go=rx /var/tmp/cat_shadow


5/ Vyměňte v profilu přímé spouštění /usr/bin/more za tento skript. Proč je (nebo neni?) a v čem toto řešení bezpečnější?

# V souboru /etc/security/exec_attr zmenit posledni radku na:
super_reader:suser:cmd:::/var/tmp/cat_shadow:euid=0
