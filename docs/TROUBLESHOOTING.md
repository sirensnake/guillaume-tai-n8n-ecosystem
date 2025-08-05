# 🔧 Guide de Dépannage - Écosystème N8N Guillaume TAI

## 🚨 Problèmes Fréquents

### 🔗 Problèmes de Connectivité

#### Webhook ne répond pas
```bash
# Symptômes
- Timeout sur curl requests
- Aucune réponse du webhook
- Erreur 404 ou 502

# Diagnostic
1. Vérifier statut N8N instance
2. Tester URL webhook dans navigateur
3. Contrôler logs N8N
4. Vérifier configuration firewall

# Solutions
- Redémarrer workflow N8N
- Vérifier path webhook correct
- Contrôler certificat SSL
- Tester avec HTTP d'abord
```

#### Google Sheets API Errors
```bash
# Erreur: "Sheets API not enabled"
Solution:
1. Google Cloud Console → APIs & Services
2. Activer Google Sheets API
3. Vérifier quotas et limites

# Erreur: "Insufficient permissions"
Solution:
1. Vérifier service account permissions
2. Partager sheet avec service account email
3. Tester OAuth2 scopes corrects

# Erreur: "Sheet not found"
Solution:
1. Vérifier Google Sheets ID correct
2. Contrôler permissions accès
3. Tester sheet accessible manuellement
```

### 🤖 Problèmes OpenAI API

#### Rate Limiting
```bash
# Symptômes
- "Rate limit exceeded" errors
- Réponses lentes ou timeout

# Solutions
1. Implémenter exponential backoff
2. Réduire fréquence requêtes
3. Upgrader plan OpenAI si nécessaire
4. Cache responses fréquentes
```

#### API Key Issues
```bash
# Erreur: "Invalid API key"
Solution:
1. Vérifier clé API correcte
2. Contrôler expiration clé
3. Regenerate new API key si nécessaire
4. Vérifier organization ID correct
```

## 🔍 Outils de Diagnostic

### Health Check Script
```bash
#!/bin/bash
# Quick health check for N8N ecosystem

echo "🌡️ HEALTH CHECK - N8N ECOSYSTEM"
echo "=============================="

# Test N8N instance
echo "Testing N8N instance..."
curl -I https://srv780568.hstgr.cloud/ | head -1

# Test Master Coordinator
echo "Testing Master Coordinator..."
curl -X POST https://srv780568.hstgr.cloud/webhook/master-coordinator \
  -H "Content-Type: application/json" \
  -d '{"message": "health check"}' \
  --max-time 10

# Test RAG Enhanced
echo "Testing RAG Enhanced..."
curl -X POST https://srv780568.hstgr.cloud/webhook/rag-enhanced \
  -H "Content-Type: application/json" \
  -d '{"question": "test"}' \
  --max-time 10

echo "✅ Health check complete"
```

### Debug Mode Activation
```bash
# Dans N8N
1. Workflow Settings → Error Handling
2. "Continue on fail" = ON
3. "Save execution progress" = ON
4. Niveau logs = DEBUG

# Dans Google Sheets
1. Ajouter colonnes debug dans sheets
2. Logger toutes les requêtes/réponses
3. Timestamps précis pour tracing
```

## 🚑 Procédures de Récupération

### Workflow Crash Recovery
```bash
1. Identifier workflow défaillant
2. Désactiver workflow (switch OFF)
3. Analyser logs d'exécution
4. Corriger configuration/code
5. Tester en mode debug
6. Réactiver workflow (switch ON)
7. Monitorer performance 24h
```

### Database Recovery
```bash
# Si corruption PostgreSQL
1. Stopper N8N instance
2. Backup base actuelle
3. Vérifier intégrité backup précédent
4. Restore depuis backup valide
5. Redémarrer N8N
6. Valider fonctionnement workflows
```

### Rollback Version
```bash
# Retour version précédente workflow
1. Accès GitHub repository
2. Identifier commit stable précédent
3. Télécharger JSON workflow
4. Import dans N8N (remplacer actuel)
5. Reconfigurer credentials si nécessaire
6. Tester fonctionnement
```

## 📊 Monitoring et Alertes

### KPIs à Surveiller
```yaml
Performance:
  - Temps réponse moyen < 5s
  - Taux d'erreur < 1%
  - Uptime > 99%
  - Mémoire N8N < 80%

Security:
  - Tentatives connexion suspectes
  - API calls anormales
  - Modifications config non autorisées
  - Accès sheets externes

Business:
  - Nombre de requêtes/jour
  - Agents les plus utilisés
  - Satisfaction utilisateur
  - ROI en temps économisé
```

### Alertes Automatiques
```bash
# Configuration email alerts
1. SMTP server configuration
2. Alert triggers definition
3. Escalation procedures
4. On-call rotation (si équipe)

# Slack integration (optionnel)
1. Webhook Slack configuration
2. Channel dédié monitoring
3. Bot alerts formatting
4. Thread responses pour troubleshooting
```

## 📞 Contacts Support

### Support Technique
- **Principal** : Guillaume TAI (creeper3144@gmail.com)
- **N8N Community** : community.n8n.io
- **GitHub Issues** : github.com/sirensnake/guillaume-tai-n8n-ecosystem/issues

### Documentation Officielle
- **N8N Docs** : docs.n8n.io
- **OpenAI API** : platform.openai.com/docs
- **Google APIs** : developers.google.com

---

*Guide maintenu par Guillaume TAI - Dernière mise à jour : 2025-08-05*