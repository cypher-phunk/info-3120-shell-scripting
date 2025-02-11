echo '# Sample test_passwd file for testing
root:x:0:0:Superuser:/root:/bin/bash
bin:x:1:1:Binaries:/bin:/sbin/nologin
daemon:x:2:2:Daemons:/sbin:/sbin/nologin
testuser:x:1000:1000:Test User:/home/testuser:/bin/bash
guest:x:1001:1001:Guest Account:/home/guest:/bin/bash
mysql:x:27:27:MariaDB Server:/var/lib/mysql:/sbin/nologin
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
backup:x:999:999:Backup System:/var/backups:/bin/sh' > test_passwd

# echo "Testing Command 1"
# cut -d: -f7 | sort -u < test_passwd
echo "Testing Command 2"
cut -d: -f1 < test_passwd
echo "Testing Command 3"
cut -d: -f7 test_passwd | sort -u
echo "Testing Command 4"
ls | paste - - - -
echo "Testing Command 5"
cut -d: -f1,5 test_passwd
echo "Testing Command 6"
vi `grep -l foobar *.c`
echo "Testing Command 7"
grep -v '^mr' test_passwd