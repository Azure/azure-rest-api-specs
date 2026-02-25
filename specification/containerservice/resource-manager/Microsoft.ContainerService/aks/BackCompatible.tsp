import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerService;

// =============================================================================
// Property flattening for SDK backward compatibility
// These must remain as augment decorators since 'properties' is inherited from
// ARM resource templates (TrackedResource<T>, ProxyResource<T>)
// =============================================================================

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedClusterAccessProfile.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AgentPoolAvailableVersions.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RunCommandResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedCluster.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedClusterUpgradeProfile.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MaintenanceConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AgentPool.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AgentPoolUpgradeProfile.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Snapshot.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedClusterSnapshot.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TrustedAccessRoleBinding.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(LoadBalancer.properties);

// =============================================================================
// Operation parameter renaming
// These must remain as augment decorators since parameters are defined in
// template operations (ArmResourceCreateOrReplaceAsync, etc.)
// =============================================================================

@@clientName(ManagedClusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(ManagedClusters.updateTags::parameters.properties, "parameters");
@@clientName(ManagedClusters.resetServicePrincipalProfile::parameters.body,
  "parameters"
);
@@clientName(ManagedClusters.resetAADProfile::parameters.body, "parameters");
@@clientName(ManagedClusters.runCommand::parameters.body, "requestPayload");
@@clientName(ManagedClusters.rebalanceLoadBalancers::parameters.body,
  "parameters"
);
@@clientLocation(ManagedClusters.getAvailableAgentPoolVersions,
  AgentPools,
  "!csharp"
);
@@clientLocation(ManagedClusters.privateLinkResourcesList,
  "PrivateLinkResources",
  "!csharp"
);
@@clientName(ManagedClusters.privateLinkResourcesList, "List");
@@clientLocation(ManagedClusters.post,
  "ResolvePrivateLinkServiceId",
  "!csharp"
);
@@clientName(ManagedClusters.post, "POST");
@@clientName(ManagedClusters.post::parameters.body, "parameters");
@@clientLocation(ManagedClusters.operationStatusResultList,
  "OperationStatusResult",
  "!csharp"
);
@@clientName(ManagedClusters.operationStatusResultList, "List");
@@clientLocation(ManagedClusters.operationStatusResultGet,
  "OperationStatusResult",
  "!csharp"
);
@@clientName(ManagedClusters.operationStatusResultGet, "Get");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedCluster.properties);

@@clientLocation(ManagedClusterUpgradeProfiles.getUpgradeProfile,
  ManagedClusters,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedClusterUpgradeProfile.properties);

@@clientName(ManagedClusters.privateLinkResourcesList, "List", "!csharp");
@@clientName(ManagedClusters.post, "POST", "!csharp");
@@clientName(ManagedClusters.post::parameters.body, "parameters", "!csharp");
@@clientName(ManagedClusters.operationStatusResultList, "List", "!csharp");
@@clientName(ManagedClusters.operationStatusResultGet, "Get", "!csharp");

@@clientName(MaintenanceConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(ManagedNamespaces.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ManagedNamespaces.update::parameters.properties, "parameters");

@@clientName(AgentPools.createOrUpdate::parameters.resource, "parameters");
@@clientName(AgentPools.deleteMachines::parameters.body, "machines");
@@clientLocation(AgentPools.getByAgentPool, "OperationStatusResult", "!csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AgentPool.properties);

@@clientLocation(AgentPoolUpgradeProfiles.getUpgradeProfile,
  AgentPools,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AgentPoolUpgradeProfile.properties);

@@clientName(Machines.createOrUpdate::parameters.resource, "parameters");

@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "parameters"
);

@@clientName(Snapshots.createOrUpdate::parameters.resource, "parameters");
@@clientName(Snapshots.updateTags::parameters.properties, "parameters");

@@clientName(ManagedClusterSnapshots.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ManagedClusterSnapshots.updateTags::parameters.properties,
  "parameters"
);

@@clientName(TrustedAccessRoleBindings.createOrUpdate::parameters.resource,
  "trustedAccessRoleBinding"
);

@@clientName(LoadBalancers.createOrUpdate::parameters.resource, "parameters");

@@clientName(IdentityBindings.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(JWTAuthenticators.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(MeshMemberships.createOrUpdate::parameters.resource, "parameters");

// =============================================================================
// Operation location reorganization
// These reorganize where operations appear in generated SDK clients
// =============================================================================

@@clientLocation(ManagedClusters.getAvailableAgentPoolVersions, AgentPools);
@@clientLocation(ManagedClusters.privateLinkResourcesList,
  "PrivateLinkResources"
);
@@clientLocation(ManagedClusters.post, "ResolvePrivateLinkServiceId");
@@clientLocation(ManagedClusters.operationStatusResultList,
  "OperationStatusResult"
);
@@clientLocation(ManagedClusters.operationStatusResultGet,
  "OperationStatusResult"
);

@@clientLocation(ManagedClusterUpgradeProfiles.getUpgradeProfile,
  ManagedClusters
);

@@clientLocation(AgentPools.getByAgentPool, "OperationStatusResult");

@@clientLocation(AgentPoolUpgradeProfiles.getUpgradeProfile, AgentPools);

@@clientLocation(GuardrailsAvailableVersions.getGuardrailsVersions,
  ManagedClusters,
  "!csharp"
);
@@clientLocation(GuardrailsAvailableVersions.listGuardrailsVersions,
  ManagedClusters,
  "!csharp"
);

@@clientLocation(SafeguardsAvailableVersions.getSafeguardsVersions,
  ManagedClusters,
  "!csharp"
);
@@clientLocation(SafeguardsAvailableVersions.listSafeguardsVersions,
  ManagedClusters,
  "!csharp"
);

@@clientLocation(MeshRevisionProfiles.getMeshRevisionProfile,
  ManagedClusters,
  "!csharp"
);
@@clientLocation(MeshRevisionProfiles.listMeshRevisionProfiles,
  ManagedClusters,
  "!csharp"
);

@@clientLocation(MeshUpgradeProfiles.getMeshUpgradeProfile,
  ManagedClusters,
  "!csharp"
);
@@clientLocation(MeshUpgradeProfiles.listMeshUpgradeProfiles,
  ManagedClusters,
  "!csharp"
);

@@clientLocation(ManagedClustersOperationGroup.listKubernetesVersions,
  ManagedClusters,
  "!csharp"
);

@@clientLocation(ContainerServiceOperationGroup.listNodeImageVersions,
  "ContainerService",
  "!csharp"
);

@@clientLocation(TrustedAccessRolesOperationGroup.list,
  "TrustedAccessRoles",
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OperationValue.display);
@@clientLocation(TrustedAccessRolesOperationGroup.list,
  "TrustedAccessRoles",
  "!csharp"
);
