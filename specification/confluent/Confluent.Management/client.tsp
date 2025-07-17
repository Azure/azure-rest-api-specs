import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Confluent;

@@clientName(Microsoft.Confluent, "ConfluentManagementClient", "javascript");
// Added Java Configuration to pass specs CI check.
// Need to revisit before SDK release.
@@clientName(APIKeyResourceEntity, "ApiKeyResourceEntity", "java");
@@clientName(APIKeyOwnerEntity, "ApiKeyOwnerEntity", "java");
@@clientName(CreateAPIKeyModel, "CreateApiKeyModel", "java");
@@clientName(APIKeySpecEntity, "ApiKeySpecEntity", "java");
@@clientName(APIKeyProperties, "ApiKeyProperties", "java");
@@clientName(APIKeyRecord, "ApiKeyRecord", "java");
@@clientName(OrganizationResourceAPIKeyActions.getClusterAPIKey,
  "getClusterApiKey",
  "java"
);
@@clientName(OrganizationResourceAPIKeyActions.deleteClusterAPIKey,
  "deleteClusterApiKey",
  "java"
);
@@clientName(SCClusterRecords.createAPIKey, "createApiKey", "java");
@@clientLocation(OrganizationResourceAPIKeyActions.getClusterAPIKey,
  "OrganizationResourceApiKeyActions",
  "java"
);
@@clientLocation(OrganizationResourceAPIKeyActions.deleteClusterAPIKey,
  "OrganizationResourceApiKeyActions",
  "java"
);

@@clientName(ProvisionState, "ConfluentProvisionState", "csharp");
@@clientName(UserDetail, "ConfluentUserDetail", "csharp");
@@clientName(OfferDetail, "ConfluentOfferDetail", "csharp");
@@clientName(SaaSOfferStatus, "ConfluentSaaSOfferStatus", "csharp");
@@clientName(APIKeyRecord, "ConfluentAPIKeyRecord", "csharp");
