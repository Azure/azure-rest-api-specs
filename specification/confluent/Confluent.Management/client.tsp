import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Confluent, "ConfluentManagementClient", "javascript");
// Added Java Configuration to pass specs CI check.
// Need to revisit before SDK release.
@@clientName(Microsoft.Confluent.APIKeyResourceEntity,
  "ApiKeyResourceEntity",
  "java"
);
@@clientName(Microsoft.Confluent.APIKeyOwnerEntity,
  "ApiKeyOwnerEntity",
  "java"
);
@@clientName(Microsoft.Confluent.CreateAPIKeyModel,
  "CreateApiKeyModel",
  "java"
);
@@clientName(Microsoft.Confluent.APIKeySpecEntity, "ApiKeySpecEntity", "java");
@@clientName(Microsoft.Confluent.APIKeyProperties, "ApiKeyProperties", "java");
@@clientName(Microsoft.Confluent.APIKeyRecord, "ApiKeyRecord", "java");
@@clientName(Microsoft.Confluent.OrganizationResourceAPIKeyActions.getClusterAPIKey,
  "getClusterApiKey",
  "java"
);
@@clientName(Microsoft.Confluent.OrganizationResourceAPIKeyActions.deleteClusterAPIKey,
  "deleteClusterApiKey",
  "java"
);
@@clientName(Microsoft.Confluent.SCClusterRecords.createAPIKey,
  "createApiKey",
  "java"
);
@@clientLocation(Microsoft.Confluent.OrganizationResourceAPIKeyActions.getClusterAPIKey,
  "OrganizationResourceApiKeyActions",
  "java"
);
@@clientLocation(Microsoft.Confluent.OrganizationResourceAPIKeyActions.deleteClusterAPIKey,
  "OrganizationResourceApiKeyActions",
  "java"
);
