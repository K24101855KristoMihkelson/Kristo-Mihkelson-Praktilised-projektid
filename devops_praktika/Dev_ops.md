### Dockeriseeritud Infrastruktuur: Linux SQL Server ja Nginx

Käesolev repositoorium sisaldab dokumentatsiooni ja konfiguratsioonifaile mitme konteineriga serverikeskkonna püstipanekuks Ubuntu Linux operatsioonisüsteemil. Projekt demonstreerib kaasaegset infrastruktuuri haldamist (Infrastructure as Code) kasutades Docker Compose'i. 

Süsteem sisaldab täielikult funktsionaalset Microsoft SQL Serverit (Linuxi baasil) andmebaaside haldamiseks ja Nginx veebiserverit esitluskihi teenindamiseks.

---

### 🏗 Süsteemi Arhitektuur ja Tehnoloogiad

* **Operatsioonisüsteem:** Ubuntu Linux (Server)
* **Konteineriseerimine:** Docker Engine
* **Orkestreerimine:** Docker Compose
* **Andmebaas:** Microsoft SQL Server 2022 (Linux image)
* **Veebiserver:** Nginx

[ Ubuntu Server (Host) ]
       │
       ├──► [ Docker Network ]
                 │
                 ├──► (Port 1433) ── [ SQL Server Konteiner ] ──► Püsiv andmemaht (Volume)
                 │
                 └──► (Port 80/443) ─ [ Nginx Konteiner ]     ──► Staatilised failid / Proxy

---

### 🚀 Samm-Sammuline Paigaldus- ja Seadistusprotsess

### Samm 1: Ubuntu serveri ettevalmistamine
Kõigepealt uuendati serveri paketihaldus ja paigaldati Docker ning Docker Compose.

    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install docker.io docker-compose -y
    sudo systemctl enable docker
    sudo systemctl start docker

### Samm 2: Docker Compose faili (docker-compose.yml) struktureerimine
Loodi konfiguratsioonifail, mis defineerib mõlemad teenused, nende pordid, keskkonnamuutujad ja andmemahud (volumes), et tagada andmete säilimine ka konteineri taaskäivitamisel.

    version: '3.8'

    services:
      sql-server:
        image: mcr.microsoft.com/mssql/server:2022-latest
        container_name: linux_sql_server
        environment:
          - ACCEPT_EULA=Y
          - MSSQL_SA_PASSWORD=${SA_PASSWORD}
        ports:
          - "1433:1433"
        volumes:
          - sql_data:/var/opt/mssql
        restart: unless-stopped

      nginx-web:
        image: nginx:latest
        container_name: nginx_server
        ports:
          - "80:80"
        volumes:
          - ./html:/usr/share/nginx/html
        restart: unless-stopped

    volumes:
      sql_data:

### Samm 3: Turvalisus ja keskkonnamuutujad
Selle asemel, et kirjutada andmebaasi parool otse konfiguratsioonifaili, kasutati .env faili. See välistab tundlike andmete lekkimise versioonihaldusesse (GitHub).

* Loodi .env fail: SA_PASSWORD=SinuTugevParool123!
* Fail lisati .gitignore nimekirja.

### Samm 4: Infrastruktuuri käivitamine ja monitooring
Konteinerite keskkond käivitati taustaprotsessina (detached mode). Seejärel kontrolliti teenuste tervislikku seisundit ja ühenduvust.

    # Keskkonna käivitamine
    sudo docker-compose up -d

    # Konteinerite staatuse kontroll
    sudo docker ps

    # SQL Serveri logide kontrollimine tõrkeotsinguks
    sudo docker logs linux_sql_server

---

### 🛠 Tõrkeotsing (Troubleshooting) ja lahendatud probleemid

Projekti käigus lahendati mitmeid spetsiifilisi infrastruktuuri väljakutseid:

* **Pordi konfliktid:** Tagati, et Ubuntu host masinas ei töötaks teisi teenuseid, mis hõivaksid pordi 80 (Nginx) või 1433 (SQL).
* **Andmete püsivus (Data Persistence):** Lahendati andmekadu konteineri seiskumisel, linkides SQL Serveri andmekataloogi (/var/opt/mssql) lokaalse Docker volume'iga (sql_data).
* **Konteinerite omavaheline suhtlus:** Kuigi Nginx ja SQL Server on eraldatud, pandi nad samasse Dockeri võrku, mis võimaldab tulevikus lisada vahekihi (nt Pythoni API), mis suhtleb turvaliselt andmebaasiga sisevõrgus.

---

### 📈 Projekti tulem
See projekt tõestab praktilist oskust hallata kaasaegseid Linux-põhiseid serverikeskkondi. See näitab võimekust liikuda manuaalsest installeerimisest üle standardiseeritud ja automatiseeritud konteinerlahendustele, mis on kriitiline oskus süsteemiadministraatori ja noorem-DevOps inseneri rollis.
