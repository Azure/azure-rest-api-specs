#!/bin/bash
# Compile check for Phase 1.c services
# Run from repo root: bash eng/scripts/check-client-tsp-compile.sh

SERVICES=(
  "specification/ai-foundry/data-plane/Foundry/src/sdk-agents"
  "specification/app/resource-manager/Microsoft.App/ContainerApps"
  "specification/edge/Microsoft.Edge.DisconnectedOperations.Management"
  "specification/frontdoor/resource-manager/Microsoft.Network/FrontDoor"
  "specification/migrate/resource-manager/Microsoft.Migrate/Waves"
  "specification/relationships/Relationships.Management"
  "specification/resources/resource-manager/Microsoft.Authorization/policy"
  "specification/resources/resource-manager/Microsoft.Resources/deploymentStacks"
  "specification/search/data-plane/Search"
  "specification/web/resource-manager/Microsoft.Web/AppService"
)

for svc in "${SERVICES[@]}"; do
  echo "=== $svc ==="
  npx tsp compile "$svc/main.tsp"
  echo ""
done
