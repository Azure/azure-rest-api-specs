import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HybridNetwork;

@@clientName(ResourceElementTemplate.type, "ResourceElementType");

@@clientName(ConfigurationGroupSchemas.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ConfigurationGroupSchemas.update::parameters.properties,
  "parameters"
);
@@clientName(ConfigurationGroupSchemas.updateState, "updateState");
@@clientName(ConfigurationGroupSchemas.updateState::parameters.body,
  "parameters"
);

@@clientName(ConfigurationGroupValues.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ConfigurationGroupValues.updateTags::parameters.properties,
  "parameters"
);

@@clientName(NetworkFunctions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NetworkFunctions.updateTags::parameters.properties, "parameters");
@@clientName(NetworkFunctions.executeRequest::parameters.body, "parameters");

@@clientName(NetworkFunctionDefinitionGroups.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NetworkFunctionDefinitionGroups.update::parameters.properties,
  "parameters"
);

@@clientName(NetworkFunctionDefinitionVersions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NetworkFunctionDefinitionVersions.update::parameters.properties,
  "parameters"
);
@@clientName(NetworkFunctionDefinitionVersions.updateState, "updateState");
@@clientName(NetworkFunctionDefinitionVersions.updateState::parameters.body,
  "parameters"
);

@@clientName(NetworkServiceDesignGroups.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NetworkServiceDesignGroups.update::parameters.properties,
  "parameters"
);

@@clientName(NetworkServiceDesignVersions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NetworkServiceDesignVersions.update::parameters.properties,
  "parameters"
);
@@clientName(NetworkServiceDesignVersions.updateState, "updateState");
@@clientName(NetworkServiceDesignVersions.updateState::parameters.body,
  "parameters"
);

@@clientName(Publishers.createOrUpdate::parameters.resource, "parameters");
@@clientName(Publishers.update::parameters.properties, "parameters");

@@clientName(ArtifactStores.createOrUpdate::parameters.resource, "parameters");
@@clientName(ArtifactStores.update::parameters.properties, "parameters");
@@clientName(ArtifactStores.addNetworkFabricControllerEndPoints::parameters.body,
  "parameters"
);
@@clientName(ArtifactStores.deleteNetworkFabricControllerEndPoints::parameters.body,
  "parameters"
);
@@clientName(ArtifactStores.approvePrivateEndPoints::parameters.body,
  "parameters"
);
@@clientName(ArtifactStores.removePrivateEndPoints::parameters.body,
  "parameters"
);
@@clientName(ProxyArtifact.proxyArtifactGet, "Get");
@@clientName(ProxyArtifact.updateState::parameters.body, "parameters");

@@clientName(ArtifactManifests.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ArtifactManifests.update::parameters.properties, "parameters");
@@clientName(ArtifactManifests.updateState::parameters.body, "parameters");

@@clientName(Sites.createOrUpdate::parameters.resource, "parameters");
@@clientName(Sites.updateTags::parameters.properties, "parameters");

@@clientName(SiteNetworkServices.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SiteNetworkServices.updateTags::parameters.properties,
  "parameters"
);

@@clientLocation(SiteNetworkServicesOperationGroup.cancelOperation,
  SiteNetworkServices
);

@@clientName(SiteNetworkServicesOperationGroup.cancelOperation::parameters.body,
  "parameters"
);

@@doc(ArtifactManifestPropertiesFormat.provisioningState,
  "The provisioning state of the ArtifactManifest resource."
);
@@doc(ArtifactStorePropertiesFormat.provisioningState,
  "The provisioning state of the application groups resource."
);
@@doc(ArtifactStorePropertiesFormat.backingResourcePublicNetworkAccess,
  "The artifact store backing resource network access type"
);
@@doc(ConfigurationGroupSchemaPropertiesFormat.provisioningState,
  "The provisioning state of the Configuration group schema resource."
);
@@doc(NetworkFunction.identity,
  "The managed identity of the network function."
);
@@doc(NetworkFunctionDefinitionGroupPropertiesFormat.provisioningState,
  "The provisioning state of the network function definition groups resource."
);
@@doc(NetworkFunctionDefinitionVersionPropertiesFormat.provisioningState,
  "The provisioning state of the network function definition version resource."
);
@@doc(NetworkFunctionDefinitionVersionPropertiesFormat.versionState,
  "The network function definition version state."
);
@@doc(NetworkFunctionDefinitionVersionUpdateState.versionState,
  "The network function definition version state."
);
@@doc(NetworkFunctionPropertiesFormat.provisioningState,
  "The provisioning state of the network function resource."
);
@@doc(NetworkFunctionPropertiesFormat.publisherScope,
  "The scope of the publisher."
);
@@doc(NetworkFunctionPropertiesFormat.nfviType,
  "The nfvi type for the network function."
);
@@doc(NetworkServiceDesignGroupPropertiesFormat.provisioningState,
  "The provisioning state of the network service design groups resource."
);
@@doc(NetworkServiceDesignVersionUpdateState.versionState,
  "The network service design version state."
);
@@doc(Publisher.identity,
  "The managed identity of the publisher, if configured."
);
@@doc(PublisherPropertiesFormat.provisioningState,
  "The provisioning state of the publisher resource."
);
@@doc(PublisherPropertiesFormat.scope, "The publisher scope.");
@@doc(SiteNetworkService.identity,
  "The managed identity of the Site network service, if configured."
);
@@doc(SiteNetworkServicePropertiesFormat.provisioningState,
  "The provisioning state of the site network service resource."
);
@@doc(SiteNetworkServicePropertiesFormat.publisherScope,
  "The scope of the publisher."
);
@@doc(SitePropertiesFormat.provisioningState,
  "The provisioning state of the site resource. **TODO**: Confirm if this is needed."
);
@@doc(configurationGroupValue.properties,
  "Hybrid configuration group value properties."
);
@@doc(configurationGroupValuePropertiesFormat.provisioningState,
  "The provisioning state of the site resource."
);
@@doc(configurationGroupValuePropertiesFormat.publisherScope,
  "The scope of the publisher."
);
@@doc(networkServiceDesignVersionPropertiesFormat.provisioningState,
  "The provisioning state of the network service design version resource."
);
@@doc(networkServiceDesignVersionPropertiesFormat.versionState,
  "The network service design version state."
);
@@doc(AzureContainerRegistryScopedTokenCredential.repositories,
  "The repositories that could be accessed using the current credential."
);
@@doc(AzureStorageAccountCredential.containerCredentials,
  "The containers that could be accessed using the current credential."
);
@@doc(NetworkFunction.etag,
  "A unique read-only string that changes whenever the resource is updated."
);
