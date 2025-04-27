#!/bin/bash

# 📦 Lancer un Docker Registry Local sur le port 5000
echo "Démarrage du Docker Registry local sur localhost:5000..."

docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  registry:2

echo "✅ Registry lancé sur http://localhost:5000"
