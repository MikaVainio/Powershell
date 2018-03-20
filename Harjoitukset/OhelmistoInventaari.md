# Toimialueen työasemiin asennettujen ohjelmien inventointi

Tehtävänäsi on inventoida toimialueen palvelimiin ja työasemiin asennetut
ohjelmat. Luo harjoitusta varten uusi työasema WS44 ja liitä se toimialueeseen.
Asenna koneeseen Imaget-kansiosta Microsoft Visio, Excel ja Word.

## Tarvittavat toimenpiteet

1. Luetaan toimialueen konetilitiedot hakemistopalvelimelta (AD).
2. Muodostetaan silmukassa yhteys jokaiseen koneeseen.
3. Luetaan koneeseen asennetut ohjelmat
4. Muodostetaan toisessa simukassa uusi objekti, jonka ominaisuuksiksi annetaan koneen nimi, ohelman nimi ja versio.
5. Tallenetaan luotu objekti vektoriin.
6. Putkitetaan vektori CSV-tiedostoon.
7. Luetaan CSV-tiedosto Exceliin.

Koska koneessa on monta asennettua ohjelmaa, kustakin koneesta saadaan monta
objektia. Tarvitset silloin toisen silmukan, jossa objekti lopullisesti
muodostetaan. Voit katsoa mallia tunnilla tehdystä harjoituksesta, jossa
dokumentoimme kaikki ryhmät ja niiden jäsenten tiedot. Vastaava esimerkki löytyy
skriptistä `DokumentoiKaikkiRyhmätJaJäsenet.ps1`

> :bulb: Koneiden läpikäytiin tarvittava rutiini löytyy Powershell-esimerkeistä nimellä `DokumentoiToimialueenBiosit.ps1`.
Powershell-esimerkeistä löydät myös skriptin `DokumentoiAsennetutOhjelmat.ps1`,
jolla luetaan yhden koneen asennettujen ohjelmien tiedot. CSV-tiedostoon
tallennuksessa voit hyödyntää `Export-Csv`-komentosovelmaa.

`DokumentoiToimialueenBiosit.ps1`-skriptissä on käytetty tunneilla tehtyjä
harjoituksia edistyneenpää ohjelmointitapaa. Skriptissä on varauduttu
virhetilanteisiin. Kaikki koneet eivät kenties olekaan päällä, jolloin syntyy
poikkeus (virhe). Virheiden käsittelyyn on käytetty Try-Catch-Finally-rakennetta.
Käytä sitä myös omassa ohjelmassasi. Älä kopioi esimerkkiä suoraan, vaan sovella
sitä tähän tehtävään.

> :warning: Muista sallia WMI-etäyhtetdet työasemien palomuureissa. Muuten
skriptisi ei tomi. Voit sallia yhteydet myös komentoriviltä. Ohje löytyy täältä https://support.microsoft.com/en-us/help/3192130/remote-wmi-relies-on-windows-firewall-settings-incorrectly-even-if-a-t
