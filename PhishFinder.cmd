echo off
REM Informacion del script
echo Nombre del script: PhishFinder.cmd
echo Version: 1.0
echo Autor: Arturo Mata - j0k3r
echo Email: arturo.mata@gmail.com
echo.
cls
echo -----------------------------------------------------------------------------
echo  PhishFinder - Busqueda OSINT de sitios web reportados por phishing by j0k3r 
echo -----------------------------------------------------------------------------
@echo off
set /p url="Ingresa la URL o URI del posible sitio malicioso de phishing: "

REM Descarga el archivo de bloqueo de Phishing.Army
powershell -Command "Invoke-WebRequest -Uri 'https://phishing.army/download/phishing_army_blocklist_extended.txt' -OutFile 'phishing_army_blocklist_extended.txt'"

REM Descarga el archivo de OpenPhish
powershell -Command "Invoke-WebRequest -Uri 'https://openphish.com/feed.txt' -OutFile 'openphish_feed.txt'"

REM Descarga el archivo de CERT.PL
powershell -Command "Invoke-WebRequest -Uri 'https://hole.cert.pl/domains/domains_hosts.txt' -OutFile 'cert_pl_domains.txt'"

REM Descarga el archivo de Phishunt.io
powershell -Command "Invoke-WebRequest -Uri 'https://phishunt.io/feed.txt' -OutFile 'phishunt_feed.txt'"

REM Verifica si la URL está registrada en el archivo de Phishing.Army
powershell -Command "$malicious = Get-Content 'phishing_army_blocklist_extended.txt' | Where-Object { $_ -ne '' } | Select-String -Pattern '%url%' -Quiet; if ($malicious) { Write-Host 'La pagina es maliciosa por ataques de phishing. Fuente: Phishing.Army' }"

REM Verifica si la URL está registrada en el archivo de OpenPhish
powershell -Command "$malicious = Get-Content 'openphish_feed.txt' | Where-Object { $_ -ne '' } | Select-String -Pattern '%url%' -Quiet; if ($malicious) { Write-Host 'La pagina es maliciosa por ataques de phishing. Fuente: OpenPhish' } else { Write-Host 'La pagina no es maliciosa por ataques de phishing. Fuente: OpenPhish' }"

REM Verifica si la URL está registrada en el archivo de CERT.PL
powershell -Command "$malicious = Get-Content 'cert_pl_domains.txt' | Where-Object { $_ -ne '' } | Select-String -Pattern '%url%' -Quiet; if ($malicious) { Write-Host 'La pagina es maliciosa por ataques de phishing. Fuente: CERT.PL' } else { Write-Host 'La pagina no es maliciosa por ataques de phishing. Fuente: CERT.PL' }"

REM Verifica si la URL está registrada en el archivo de Phishunt.io
powershell -Command "$malicious = Get-Content 'phishunt_feed.txt' | Where-Object { $_ -ne '' } | Select-String -Pattern '%url%' -Quiet; if ($malicious) { Write-Host 'La pagina es maliciosa por ataques de phishing. Fuente: Phishunt.io' } else { Write-Host 'La pagina no es maliciosa por ataques de phishing. Fuente: Phishunt.io' }"

REM Espera 5 segundos antes de borrar los archivos
timeout /t 120 > nul

REM Borra los archivos
del "phishing_army_blocklist_extended.txt"
del "openphish_feed.txt"
del "cert_pl_domains.txt"
del "phishunt_feed.txt"

pause
