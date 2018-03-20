# Toimialueen työasemiin asennettujen ohjelmien inventointi

Tehtävänäsi on inventoida toimialueen palvelimiin ja työasemiin asennetut
ohjelmat. Luo harjoitusta varten uusi työasema WS44 ja liitä se toimialueeseen.
Asenna koneeseen Imaget-kansiosta Microsoft Visio, Excel ja Word.

## Tarvittavat toimenpiteet

1. Luetaan toimialueen konetilitiedot hakemistopalvelimelta (AD).
2. Muodostetaan silmukassa yhteys jokaiseen koneeseen.
3. Luetaan koneeseen asennetut ohjelmat
4. Muodostetaan uusi objekti, jonka ominaisuuksiksi annetaan koneen nimi,
ohelman nimi ja versio.
5. Tallenetaan luotu objekti vektoriin.
6. Putkitetaan vektori CSV-tiedostoon.
7. Luetaan CSV-tiedosto Exceliin.

:bulb: Vastaava rutiini löytyy Powershell-esimerkeistä nimellä `DokumentoiToimialueenBiosit.ps1`
Powershell-esimerkeistä löydät myös skriptin `DokumentoiAsennetutOhjelmat.ps1`,
jolla luetaan yhden koneen asennettujen ohjelmien tiedot.

:warning: Muista sallia WMI-etäyhtetdet työasemien palomuureissa. Muuten
skriptisi ei tomi. 
