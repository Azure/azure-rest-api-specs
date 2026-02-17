import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerRegistry;

// Flatten properties for backward compatibility
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Archive.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ArchiveVersion.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CacheRule.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConnectedRegistry.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CredentialSet.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExportPipeline.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImportPipeline.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PipelineRun.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Registry.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Replication.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScopeMap.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Token.properties,
  "autorest,javascript,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Webhook.properties,
  "autorest,javascript,java,python"
);

@@clientName(IPRule.value, "IPAddressOrRange");

@@clientName(Archives.create::parameters.resource, "archiveCreateParameters");
@@clientName(Archives.update::parameters.properties, "archiveUpdateParameters");

@@clientName(CacheRules.create::parameters.resource,
  "cacheRuleCreateParameters"
);
@@clientName(CacheRules.update::parameters.properties,
  "cacheRuleUpdateParameters"
);

@@clientName(ConnectedRegistries.create::parameters.resource,
  "connectedRegistryCreateParameters"
);
@@clientName(ConnectedRegistries.update::parameters.properties,
  "connectedRegistryUpdateParameters"
);

@@clientName(CredentialSets.create::parameters.resource,
  "credentialSetCreateParameters"
);
@@clientName(CredentialSets.update::parameters.properties,
  "credentialSetUpdateParameters"
);

@@clientName(ExportPipelines.create::parameters.resource,
  "exportPipelineCreateParameters"
);

@@clientName(ImportPipelines.create::parameters.resource,
  "importPipelineCreateParameters"
);

@@clientName(PipelineRuns.create::parameters.resource,
  "pipelineRunCreateParameters"
);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "privateEndpointConnection"
);

@@clientName(Registries.create::parameters.resource, "registry");
@@clientName(Registries.update::parameters.properties,
  "registryUpdateParameters"
);
@@clientName(Registries.importImage::parameters.body, "parameters");
@@clientName(Registries.checkNameAvailability::parameters.body,
  "registryNameCheckRequest"
);
@@clientName(Registries.regenerateCredential::parameters.body,
  "regenerateCredentialParameters"
);
@@clientName(Registries.generateCredentials::parameters.body,
  "generateCredentialsParameters"
);

@@clientLocation(PrivateLinkResources.getPrivateLinkResource, Registries);
@@clientLocation(PrivateLinkResources.listPrivateLinkResources, Registries);

@@clientName(Replications.create::parameters.resource, "replication");
@@clientName(Replications.update::parameters.properties,
  "replicationUpdateParameters"
);

@@clientName(ScopeMaps.create::parameters.resource, "scopeMapCreateParameters");
@@clientName(ScopeMaps.update::parameters.properties,
  "scopeMapUpdateParameters"
);

@@clientName(Tokens.create::parameters.resource, "tokenCreateParameters");
@@clientName(Tokens.update::parameters.properties, "tokenUpdateParameters");

@@clientName(Webhooks.create::parameters.resource, "webhookCreateParameters");
@@clientName(Webhooks.update::parameters.properties, "webhookUpdateParameters");
