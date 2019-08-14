# gosuslugi
Установщик программ для доступа к сайтам Госуслуг (для пакета Крипто-Про)

Используется пакет программ Крипто-Про 4.0
Кратко о компонентах  КриптоПро для Linux:

cprocsp-curl - Библиотека libcurl с реализацией шифрования по ГОСТ
lsb-cprocsp-base - Основной пакет КриптоПро CSP
lsb-cprocsp-capilite - Интерфейс CAPILite и утилиты
lsb-cprocsp-kc1 - Провайдер криптографической службы KC1
lsb-cprocsp-rdr - Поддержка ридеров и RNG
cprocsp-rdr-gui-gtk - Графический интерфейс для диалоговых операций
cprocsp-rdr-rutoken - Поддержка карт Рутокен
cprocsp-rdr-jacarta - Поддержка карт JaCarta
cprocsp-rdr-pcsc - Компоненты PC/SC для ридеров КриптоПро CSP
lsb-cprocsp-pkcs11 - Поддержка PKCS11

Если установка КриптоПро будет запущена не в графическом режиме или при установке выбраны не все компоненты, то следует в обязательном порядке установить следующие пакеты (найти их можно в папке установки КриптоПро с файлом install_gui.sh):

cprocsp-rdr-pcsc-64_4.0.0-4_amd64.deb
cprocsp-rdr-rutoken-64_4.0.0-4_amd64.deb
ifd-rutokens_1.0.1_amd64.deb
cprocsp-rdr-gui-gtk-64_4.0.0-4_amd64.deb


Rutoken Lite не требует установки дополнительных драйверов. Для установки других типов Рутокена потребуется посетить официальный сайт и установить необходимые драйвера.
Однако для полноценной работы Рутокена потребуется установить дополнительные библиотеки при помощи команды в Терминале:
sudo apt-get install libccid pcscd libpcsclite1 pcsc-tools opensc

Для Rutoken S, JaCarta PKI потребуется установка дополнительных драйверов.

Перезапуск службы pcscd
Перезапустить указанную службу легко при помощи команды
sudo service pcscd restart

Проверка работоспособности Рутокена при помощи фирменных средств производителя
Выполнив команду pcsc_scan в терминале, можно проверить работоспособность подключенного Рутокена.
Проверка работоспособности Рутокена при помощи встроенных средств КриптоПро
Средства КриптоПро также позволяют сразу же проверить работоспособность присоединенных носителей. Команда в терминале
/opt/cprocsp/bin/amd64/csptest -card -enum -v -v

Просмотр и Импорт в Личное хранилище сертификатов с Рутокена
Для просмотра личных сертификатов, имеющихся на подключенных контейнерах, выполняем команду в Терминале
/opt/cprocsp/bin/amd64/csptest -keyset -enum_cont -fqcn -verifyc

Для импорта всех личных сертификатов со всех подключенных носителей выполняем команду в Терминале
/opt/cprocsp/bin/amd64/csptestf -absorb -cert

Просмотр личных сертификатов в хранилище
Убедиться в успешном импорте сертификатов с Рутокена в Личное хранилище сертификатов можно при помощи команды в терминале
/opt/cprocsp/bin/amd64/certmgr -list -store uMy
Для удаления сертификата из личного хранилища сертификатов следует выполнить команду в Терминале:
/opt/cprocsp/bin/amd64/certmgr -delete -store umy
Далее терминал предложит указать номер удаляемого сертификата.

Импорт коренвых сертификатов в хранилище доверенных корневых сертификатов
Вначале скопируем кореные сертификаты в отдельную папку. Затем в контекстном меню, перейдя в эту папку, выполним команду Открыть в терминале. Далее произведем установку командой в Теримнале:

sudo /opt/cprocsp/bin/amd64/certmgr -inst -store uroot -file "uc_tensor_44-2017.cer"
sudo /opt/cprocsp/bin/amd64/certmgr -inst -store uroot -file "uc_tensor-2018_gost2012.cer"
sudo /opt/cprocsp/bin/amd64/certmgr -inst -store uroot -file "uc_tensor-2017.cer"

Установка КриптоПро ЭЦП Browser plug-in
Для установки КриптоПро ЭЦП Browser plug-in потребуется утилита alien. Установим ее командой:
sudo apt install alien

Далее скачиваем установочный пакет КриптоПро ЭЦП Browser plug-in с официального сайта КриптоПро.
Распаковываем архив cades_linux_amd64.zip и переходим перейти в каталог с распакованными файлами, выполним команду Открыть в терминале и далее выполним команды для преобразования rpm-пакетов в deb-пакеты:
alien -dc cprocsp-pki-2.0.0-amd64-cades.rpm
alien -dc cprocsp-pki-2.0.0-amd64-plugin.rpm

Далее устанавливаем deb-пакеты:
sudo alien -kci cprocsp-pki-cades_2.0.0-2_amd64.deb
sudo alien -kci cprocsp-pki-plugin_2.0.0-2_amd64.deb

Установка расширения браузера КриптоПро ЭЦП Browser plug-in
Далее необходимо в используемом вами браузере установить расширение КриптоПро ЭЦП Browser plug-in. Cсылка на расширение для Google Chrome
https://chrome.google.com/webstore/detail/cryptopro-extension-for-c/iifchhfnnmpdbibifmljnfjhpififfog




Использовались материалы сайтов
1. https://multiblog67.ru/raznoe/29-ubuntu/201-ustanovka-i-nastrojka-kriptopro-v-ubuntu-linux-18-04.html
2. https://forum.ubuntu.ru/index.php?topic=300549.0
3. 
