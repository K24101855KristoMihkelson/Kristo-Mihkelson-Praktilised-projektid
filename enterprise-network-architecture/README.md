# enterprise-network-architecture
See projekt kujutab endast kahe geograafilise asukohaga (Tartu peakontor ja Elva harukontor) ettevõtte turvalise, skaleeritava ja tsentraalselt monitooritud arvutivõrgu disaini ning teostust. Projekt loodi eesmärgiga tagada ettevõtte ärikriitiliste andmete turvalisus, võrguliikluse loogiline segmenteerimine ja proaktiivne seire.

## 🛠️ Kasutatud tehnoloogiad ja seadmed

* **Tulemüür ja marsruutimine:** pfSense (Default Deny poliitikad, NAT)
* **Võrguseadmed:** Cisco lülitid (VLANide ja Trunk portide seadistus)
* **Turvalisus:** IPsec Site-to-Site VPN, SNMPv3
* **Monitooring:** Checkmk (tsentraalne reaalajas seire)
* **Infrastruktuur:** Proxmox VE (virtuaalkeskkonna haldus), Linux/Windows serverid

## 🚀 Projekti peamised funktsionaalsused

### 1. Võrgu loogiline segmenteerimine (VLAN)
Võrk on jaotatud turvalisteks segmentideks, et piirata ligipääsu ja tõsta üldist turvataset:
* **VLAN 10 (WS):** Tööjaamad (ligipääs internetti ja spetsiifilistele serveritele).
* **VLAN 20 (ADM):** Administraatorid (täielik ligipääs seadmete halduseks).
* **VLAN 30 (GUEST):** Külaliste võrk (isoleeritud sisevõrgust, ainult internetiühendus).
* **VLAN 40 (DMZ):** Demilitariseeritud tsoon avalikele teenustele (nt veebiserverid).

### 2. Turvaline andmeside (IPsec VPN)
Kahe kontori (Tartu ja Elva) vahele on seadistatud **IPsec Site-to-Site VPN** tunnel. See tagab krüpteeritud ja turvalise andmevahetuse harukontori ja peakontori vahel, kasutades tugevaid krüptoalgoritme.

### 3. Tsentraalne monitooring (Checkmk)
Kogu infrastruktuuri tervist jälgitakse reaalajas Checkmk seiresüsteemiga, kasutades turvalist **SNMPv3** protokolli.
* Seadmete protsessori (CPU) ja mälu (RAM) koormuse jälgimine.
* Võrguliideste staatuse ja ribalaiuse monitooring.
* Automaatsed teavitused (Alerting) kriitiliste kõrvalekallete korral.

### 4. Tulemüüri poliitikad (pfSense)
Rakendatud on range **"Default Deny"** lähenemine. Lubatud on ainult spetsiifiline, äriprotsessideks vajalik liiklus (näiteks administraatorite ligipääs seadmete haldusliidestele pordil 443 või 22).

## 📊 Võrgutopoloogia ja seadistused

Võrguskeem
<img width="1123" height="1112" alt="image" src="https://github.com/user-attachments/assets/a4515a39-7f3b-4035-a5f5-e20434cce78a" />



Checkmk töölaud
<img width="1123" height="1112" alt="image" src="https://github.com/user-attachments/assets/a96ef789-8be6-41e2-b052-c5d302cd69bf" />
<img width="1123" height="1112" alt="image" src="https://github.com/user-attachments/assets/b50224fa-3c62-4d98-92fb-c06460497f1e" />



## 💡 Õpiväljundid
Projekti käigus sai praktiliselt rakendatud suurettevõtte võrgu planeerimise parimaid praktikaid, turvapoliitikate loomist ning reaalajas monitooringu tähtsust süsteemide stabiilsuse tagamisel.
