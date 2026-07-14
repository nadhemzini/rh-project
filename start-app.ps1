# --- start-app.ps1 ---
# Script de démarrage backend + frontend Angular

$backendPath = "c:\Users\Nadhem\OneDrive - Ministere de l'Enseignement Superieur et de la Recherche Scientifique\Bureau\stage d'été\monapp\backend"
$frontendPath = "c:\Users\Nadhem\OneDrive - Ministere de l'Enseignement Superieur et de la Recherche Scientifique\Bureau\stage d'été\monapp\frontend"

Write-Output "Starting Spring Boot backend..."
Start-Process "cmd.exe" -ArgumentList "/c cd `"$backendPath`" && mvn spring-boot:run" -WindowStyle Minimized

# Attendre quelques secondes que le backend démarre
Start-Sleep -Seconds 10

Write-Output "Starting Angular frontend..."
Start-Process "cmd.exe" -ArgumentList "/c cd `"$frontendPath`" && ng serve --host 0.0.0.0 --port 4200" -WindowStyle Minimized

Write-Output "Both backend and frontend have been started successfully."
