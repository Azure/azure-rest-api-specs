import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerRegistry;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ArchiveUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CacheRuleUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConnectedRegistryUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CredentialSetUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationDefinition.properties);

@@clientName(IPRule.value, "IPAddressOrRange");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RegistryUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReplicationUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScopeMapUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TokenUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WebhookCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WebhookUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AgentPoolUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TaskRunUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TaskUpdateParameters.properties);

@@clientName(Archives.create::parameters.resource, "archiveCreateParameters");
@@clientName(Archives.update::parameters.properties, "archiveUpdateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Archive.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ArchiveVersion.properties);

@@clientName(CacheRules.create::parameters.resource,
  "cacheRuleCreateParameters"
);
@@clientName(CacheRules.update::parameters.properties,
  "cacheRuleUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CacheRule.properties);

@@clientName(ConnectedRegistries.create::parameters.resource,
  "connectedRegistryCreateParameters"
);
@@clientName(ConnectedRegistries.update::parameters.properties,
  "connectedRegistryUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConnectedRegistry.properties);

@@clientName(CredentialSets.create::parameters.resource,
  "credentialSetCreateParameters"
);
@@clientName(CredentialSets.update::parameters.properties,
  "credentialSetUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CredentialSet.properties);

@@clientName(ExportPipelines.create::parameters.resource,
  "exportPipelineCreateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ExportPipeline.properties);

@@clientName(ImportPipelines.create::parameters.resource,
  "importPipelineCreateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ImportPipeline.properties);

@@clientName(PipelineRuns.create::parameters.resource,
  "pipelineRunCreateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PipelineRun.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "privateEndpointConnection"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(Registries.create::parameters.resource, "registry");
@@clientName(Registries.update::parameters.properties,
  "registryUpdateParameters"
);
@@clientName(Registries.importImage::parameters.body, "parameters");
@@clientName(Registries.regenerateCredential::parameters.body,
  "regenerateCredentialParameters"
);
@@clientName(Registries.generateCredentials::parameters.body,
  "generateCredentialsParameters"
);
@@clientName(Registries.scheduleRun::parameters.body, "runRequest");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Registry.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(Replications.create::parameters.resource, "replication");
@@clientName(Replications.update::parameters.properties,
  "replicationUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Replication.properties);

@@clientName(ScopeMaps.create::parameters.resource, "scopeMapCreateParameters");
@@clientName(ScopeMaps.update::parameters.properties,
  "scopeMapUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScopeMap.properties);

@@clientName(Tokens.create::parameters.resource, "tokenCreateParameters");
@@clientName(Tokens.update::parameters.properties, "tokenUpdateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Token.properties);

@@clientName(Webhooks.create::parameters.resource, "webhookCreateParameters");
@@clientName(Webhooks.update::parameters.properties, "webhookUpdateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Webhook.properties);

@@clientName(AgentPools.create::parameters.resource, "agentPool");
@@clientName(AgentPools.update::parameters.properties, "updateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AgentPool.properties);

@@clientName(Runs.update::parameters.properties, "runUpdateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Run.properties);

@@clientName(TaskRuns.create::parameters.resource, "taskRun");
@@clientName(TaskRuns.update::parameters.properties, "updateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TaskRun.properties);

@@clientName(Tasks.create::parameters.resource, "taskCreateParameters");
@@clientName(Tasks.update::parameters.properties, "taskUpdateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Task.properties);
