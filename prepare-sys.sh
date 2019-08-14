# 1. Устанавливаем пакет браузера Хромиум-Гост

wget -O https://github.com/deemru/chromium-gost/releases/download/76.0.3809.100/chromium-gost-76.0.3809.100-linux-amd64.deb
sudo dpkg -i chromium-gost-76.0.3809.100-linux-amd64.deb

# Весь нужный софт был собран с сети и находился в свободном доступе. Всё объединил в один архив: ubuntu_crypto.zip
# https://drive.google.com/uc?id=1FhQQK00z2x8tBEOjG_ge6C0TRLpJaAwt&export=download

# 2. Устанавливаем CryptoPro:
# 2.1 Добавляем поддержку LSB и alien - понадобится для установки ЭЦП браузер плагин (CadesPlugin).
sudo apt install lsb lsb-core alien

# 2.2 Заходим в папку linux-amd64_deb и устанавливаем криптопровайдер.
sudo ./install.sh

# 2.3.Устанавливаем доп. пакеты для работы с ЭЦП:
sudo dpkg -i cprocsp-rdr-gui-64_4.0.9944-5_amd64.deb
sudo dpkg -i cprocsp-rdr-gui-gtk-64_4.0.9944-5_amd64.deb
#Поддержка алгоритмов класса1 и 2
sudo dpkg -i lsb-cprocsp-kc1-64_4.0.9944-5_amd64.deb
sudo dpkg -i lsb-cprocsp-kc2-64_4.0.9944-5_amd64.deb
#Обязательно установить библиотеки pkcs11
sudo dpkg -i lsb-cprocsp-pkcs11-64_4.0.9944-5_amd64.deb 

#  2.4. Далее если используем rutoken s. устанавливаем:
sudo dpkg -i cprocsp-rsa-64_4.0.9944-5_amd64.deb
sudo dpkg -i cprocsp-rdr-pcsc-64_4.0.9944-5_amd64.deb
sudo dpkg -i cprocsp-rdr-rutoken-64_4.0.9944-5_amd64.deb
sudo dpkg -i ifd-rutokens_1.0.1_amd64.deb

# 3. Устанавливаем CadesPlugin с помощью alien.
sudo alien -kci cprocsp-pki-2.0.0-amd64-cades.rpm
sudo alien -kci cprocsp-pki-2.0.0-amd64-plugin.rpm
# С первого раза не все файлы копируются, например не копируется /opt/cprocsp/lib/amd64/libnpcades.so
sudo alien -kci cprocsp-pki-2.0.0-amd64-plugin.rpm

# Делаем ссылку на установленный плагин
sudo ln -s  /opt/cprocsp/lib/amd64/libnpcades.so /usr/lib/firefox-addons/plugins/libnpcades.so

# 4. Устанавливем IFCPlugin для работы с порталами с ЕСИА(Госуслуги).
sudo dpkg -i IFCPlugin-x86_64.deb

# 4.1 После успешной установки заменяем дефолтный файл /etc/ifc.cfg на файл ifc.cfg из архива.

# 4.2 Обязательно делаем символьную ссылку на библиотеку pkcs11 из пакета CryptoPro для использования IFCPlugin
sudo ln -s /opt/cprocsp/lib/amd64/libcppkcs11.so.4.0.4 /usr/lib/mozilla/plugins/lib/libcppkcs11.so

# 4.3 Если мы хотим работать на Госуслугах через chromium-gost, необходимо ему подсунуть ссылку на плагин, 
# так как разрабы этого плагина, почему-то забыли про существования chromium и в deb пакете с плагином присутствуют
# конфиги только для Firefox и google-chrome.
udo ln -s /etc/opt/chrome/native-messaging-hosts/ru.rtlabs.ifcplugin.json /etc/chromium/native-messaging-hosts

# Установку завершили. Осталось теперь при первом входе на порталы установить расширения для CadeslPlugin и (Firefox
# сам предложит его установить при первом входе на портал где он используется) и установить Расширение для плагина
# Госуслуг в chromium-gost

# Далее, для работы необходимо установить в CryptoPro по порядку: корневой сертификат, промежуточные сертификаты, 
# и личный с ссылкой на контейнер с закрытым ключём:

 # 1. Нужно убедиться что CryptoPro видит наш контейнер с закрытым ключём, обратите внимание что контейнер должен быть 
 # доступен обычному пользователю, под которым вы работаете в системе:
 /opt/cprocsp/bin/amd64/csptest -keyset -enum_cont -verifycontext -fqcn
 
# CSP (Type:80) v4.0.9017 KC2 Release Ver:4.0.9944 OS:Linux CPU:AMD64 FastCode:READY:AVX.
# AcquireContext: OK. HCRYPTPROV: 12104259
# \\.\HDIMAGE\xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
# \\.\Aktiv Co. Rutoken S 00 00\xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
# OK.
# Total: SYS: 0,000 sec USR: 0,000 sec UTC: 0,320 sec
# [ErrorCode: 0x00000000]











