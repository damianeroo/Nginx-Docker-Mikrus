Skryp instaluje Nginx za pomocą Dockera.
Skryp ten dedykowany użytkownika Mikrusa ale powinien zadziałać też na innych maszynach.
Skrypt sprawdza czy mamy Dockera, jeśli go nie posiadamy instaluje go za pomocą skryptu chce_dockera z https://github.com/unkn0w/noobs.


➤ Jak uruchomić

```bash
git clone https://github.com/damianeroo/Nginx-Docker-Mikrus.git
cd Nginx-Docker-Mikrus
./install.sh -a yes -p 12345 -n NginxTest
```

➤ Opis parametrów
```
 "-a yes" instaluje nam Portainera (gdy go nie chcemy nie podajemy tego paramaetru)
 "-p 12345" port naszego Mikrusa na którym będzie dział nasz Portainer (nie wymagany gdy nie instalujemy Portainera) (np.12345)
 "-n NginxTest" nazwa dla naszego kontenera z Nginx (np. NginxTest)
 ```
 Po zakończeniu instalacji dostajemy ścieżke do folderu html naszego Nginx

Wystarczy już tylko wrzucić swoją stone do katalogu html i podpiąc domenę przez Cloudflare po IPv6 lub wybrac subdomene z panelu Mikrusa.
