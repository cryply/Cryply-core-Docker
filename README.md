# Cryply-core-Docker
Alpine based docker for Cryply core

1. Install docker-compose
2. run 'docker-compose up -d'
3. check logs with 'docker-compose exec cryplyd tail -f /data/debug.log'

Your blockchain survives since we mount it on separate named volume. Use 'docker volume ls' to check its physical location.

