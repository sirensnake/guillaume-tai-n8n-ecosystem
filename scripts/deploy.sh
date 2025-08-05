#!/bin/bash
# Script de déploiement automatisé - N8N Ecosystem Guillaume TAI

set -e

echo "🚀 DÉPLOIEMENT ÉCOSYSTÈME N8N GUILLAUME TAI"
echo "=========================================="

# Vérification prérequis
check_prerequisites() {
    echo "🔍 Vérification des prérequis..."
    
    # Vérifier fichier .env
    if [ ! -f "config/.env" ]; then
        echo "❌ Fichier config/.env manquant"
        echo "💡 Copier config/credentials_template.env vers config/.env et configurer"
        exit 1
    fi
    
    # Source des variables
    source config/.env
    
    # Vérifier variables critiques
    if [ -z "$OPENAI_API_KEY" ]; then
        echo "❌ OPENAI_API_KEY non configuré"
        exit 1
    fi
    
    if [ -z "$N8N_WEBHOOK_BASE_URL" ]; then
        echo "❌ N8N_WEBHOOK_BASE_URL non configuré"
        exit 1
    fi
    
    echo "✅ Prérequis validés"
}

# Import des workflows
import_workflows() {
    echo "📥 Import des workflows N8N..."
    
    echo "⚠️  Import manuel requis dans interface N8N:"
    echo "   1. workflows/master_coordinator_v2.0.json"
    echo "   2. workflows/rag_enhanced_hybrid_v3.0.json"
    echo "   3. workflows/productivity_agent_v1.5.json"
    echo "   4. workflows/learning_agent_v1.8.json"
    echo "   5. workflows/content_agent_v1.2.json"
}

# Configuration Google Sheets
setup_sheets() {
    echo "📊 Configuration Google Sheets..."
    
    echo "⚠️  Configuration manuelle requise:"
    echo "   1. Créer Google Sheet avec ID: $GOOGLE_SHEETS_ID"
    echo "   2. Ajouter onglets: chat_logs, rag_knowledge, productivity_metrics"
    echo "   3. Configurer permissions service account N8N"
    echo "   4. Tester connectivité depuis workflows"
}

# Tests de validation
run_tests() {
    echo "🧪 Exécution des tests de validation..."
    
    # Test connectivité webhook
    if command -v curl &> /dev/null; then
        echo "Test webhook Master Coordinator..."
        curl -X POST "$N8N_WEBHOOK_BASE_URL/webhook/master-coordinator" \
             -H "Content-Type: application/json" \
             -d '{"message": "Test déploiement", "user": "Guillaume"}' \
             --max-time 30 || echo "⚠️  Test webhook échoué - Vérifier configuration"
    else
        echo "⚠️  curl non disponible - Tests manuels requis"
    fi
}

# Exécution principale
main() {
    check_prerequisites
    import_workflows
    setup_sheets
    run_tests
    
    echo ""
    echo "✅ DÉPLOIEMENT TERMINÉ !"
    echo "======================="
    echo ""
    echo "📋 PROCHAINES ÉTAPES:"
    echo "1. Importer les workflows JSON dans N8N interface"
    echo "2. Configurer les credentials dans N8N"
    echo "3. Créer et configurer les Google Sheets"
    echo "4. Tester chaque workflow individuellement"
    echo "5. Activer les workflows en production"
    echo ""
    echo "📖 Documentation complète: docs/DEPLOYMENT_GUIDE.md"
    echo "🐛 En cas de problème: docs/TROUBLESHOOTING.md"
    echo ""
    echo "🎉 Bon déploiement Guillaume ! 🚀"
}

main "$@"