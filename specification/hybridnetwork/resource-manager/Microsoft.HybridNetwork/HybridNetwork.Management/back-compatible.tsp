import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HybridNetwork;

@@clientName(ResourceElementTemplate.type, "ResourceElementType");
@@clientName(NetworkFunctionDefinitionResourceElementTemplateDetails.type,
  "ResourceElementType",
  "go, javascript"
);
@@clientName(ArmResourceDefinitionResourceElementTemplateDetails.type,
  "ResourceElementType",
  "go, javascript"
);

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
