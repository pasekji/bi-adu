BI-ADU

1. cvičení

Vytvořte nového uživatele user1 s UID 1001 s domovským adresářem /export/home/user1 s přihlašovacím shellem bash a nastavte mu heslo.


useradd -u 1001 -m -d /export/home/user1 -s /bin/bash -p heslo user1

Analogicky vytvořte uživatele user2

useradd -u 1001 -d /export/home/user2 -s BASH -p heslo user2

Vytvořte novou skupinu adu s GID 101 a nastavte ji uživateli user1 jako primární a uživateli user2 jako sekundární.

groupadd -g 101 adu

usermod -g adu user1

usermod s-G adu user2

Prohlédněte si změny v souborech /etc/passwd, /etc/shadow a /etc/group

Analyzujte soubor /etc/profile a zařiďte, aby se každému(!) uživateli při přihlášení nastavila taková maska, že on bude jediný, kdo bude moci se svými soubory a adresáři dělat vše a nikdo jiný nic.

maska, kterou chci nastavit, je 077 je asi tak maska nevim  - umask 077

7a/ Změna hashovacího algoritmu hesel

Nastavte jiný algoritmus hashování uživatelských hesel, než je nastavený implicitně.

v /etc/shadow mají uživatelé hashe svých hesel

https://redhatlinux.guru/2016/06/09/configuring-solaris-10-for-sha512-password-hashing/

7b/ Změna pravidel pro vytváření hesel

Nastavte jiná pravidla pro tvorbu hesel, než jsou implicitní, včetně zákazu opakování hesel.
Ověřte na uživatelích, vytvořených v předchozím příkladu.

https://www.networkworld.com/article/2726564/how-to-enforce-password-complexity-on-solaris.html

8/ Ověřte, že vlastníkem procesu passwd nemusí být ten, kdo si heslo mění

ssh student@localhost
ps -ef | grep passwd
