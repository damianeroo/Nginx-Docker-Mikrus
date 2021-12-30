Skryp instaluje Nginx za pomocą Dockera.
Skryp ten dedykowany użytkownika Mikrusa ale powinien zadziałać też na innych maszynach.
Skrypt sprawdza czy mamy Dockera, jeśli go nie posiadamy instaluje go za pomocą skryptu chce_dockera z https://github.com/unkn0w/noobs.


➤ Jak uruchomić

```bash
git clone https://github.com/damianeroo/Nginx-Docker-Mikrus.git
cd Nginx-Docker-Mikrus
./install.sh -a -p 12345 -n NginxTest
```

➤ Opis parametrów
```
 -a instaluje nam Portainera (gdy go nie chcemy nie podajemy tego paramaetru)
 -p port naszego Mikrusa na którym będzie dział nasz Portainer (nie wymagany gdy nie instalujemy Portainera)
 -n nazwa dla naszego kontenera z Nginx
 ```
 Po zakończeniu instalacji dostajemy ścieżke do folderu html naszego Nginx
