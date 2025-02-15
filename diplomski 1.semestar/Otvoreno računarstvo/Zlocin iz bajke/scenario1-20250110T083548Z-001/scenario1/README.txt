Netko je baki ukrao svu mrkvu iz vrta! Tko je sumnjivac?


CA je Certificate Authority, u potpunosti vjerujemo CA !!!

Ukoliko trebate izvući javni ključ osobe iz njenog/njegovog certifikata, korisite:

openssl x509 -pubkey -noout -in certificate_file > pubkey_file
 
