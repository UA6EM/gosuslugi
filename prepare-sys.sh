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


