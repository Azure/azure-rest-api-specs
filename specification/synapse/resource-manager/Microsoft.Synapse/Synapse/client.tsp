import "@azure-tools/typespec-client-generator-core";

import "./Workspaces/main.tsp";
import "./SqlPools/main.tsp";
import "./BigDataPools/main.tsp";
import "./IntegrationRuntimes/main.tsp";
import "./KustoPools/main.tsp";

using Azure.ClientGenerator.Core;

/**
 * Azure Synapse Analytics management client. Combines the Synapse resource-manager
 * TypeSpec projects (each with its own API version) into the single SDK client
 * released from the `package-composite-v2` tag.
 */
@client({
  name: "SynapseManagementClient",
  service: [
    Workspaces,
    SqlPools,
    BigDataPools,
    IntegrationRuntimes,
    KustoPools
  ],
  autoMergeService: true,
})
namespace Microsoft.Synapse;

// --- C# names (csharp scope only; wire contract and other languages unchanged) ---
// Shipped names come from the GA Azure.ResourceManager.Synapse public API or its
// autorest.md rename-mapping. The full GA naming port is done at the SDK step.

// Kusto check-name request bodies (GA public API).
@@clientName(
  KustoPools.KustoPoolCheckNameRequest,
  "KustoPoolNameAvailabilityContent",
  "csharp"
);
@@clientName(
  KustoPools.DatabaseCheckNameRequest,
  "KustoPoolChildResourceNameAvailabilityContent",
  "csharp"
);
@@clientName(
  KustoPools.DataConnectionCheckNameRequest,
  "KustoPoolDataConnectionNameAvailabilityContent",
  "csharp"
);
@@clientName(
  KustoPools.ClusterPrincipalAssignmentCheckNameRequest,
  "KustoPoolPrincipalAssignmentNameAvailabilityContent",
  "csharp"
);
@@clientName(
  KustoPools.DatabasePrincipalAssignmentCheckNameRequest,
  "KustoPoolDatabasePrincipalAssignmentNameAvailabilityContent",
  "csharp"
);

// Integration runtimes (GA public API).
@@clientName(
  IntegrationRuntimes.UpdateIntegrationRuntimeRequest,
  "SynapseIntegrationRuntimePatch",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.UpdateIntegrationRuntimeNodeRequest,
  "UpdateIntegrationRuntimeNodeContent",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.GetSsisObjectMetadataRequest,
  "SynapseGetSsisObjectMetadataContent",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeStatusResponse,
  "SynapseIntegrationRuntimeStatusResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SsisObjectMetadataStatusResponse,
  "SynapseSsisObjectMetadataStatusResult",
  "csharp"
);

// Integration runtime list results (GA autorest.md rename-mapping; internal in .NET).
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeListResponse,
  "SynapseIntegrationRuntimeListResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.SsisObjectMetadataListResponse,
  "SynapseSsisObjectMetadataListResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimes.IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse,
  "SynapseIntegrationRuntimeOutboundNetworkDependenciesCategoryEndpointListResult",
  "csharp"
);

// Big data pools list results (GA autorest.md rename-mapping; internal in .NET).
@@clientName(
  BigDataPools.LibraryListResponse,
  "BigDataPoolLibraryListResult",
  "csharp"
);
@@clientName(
  BigDataPools.SparkConfigurationListResponse,
  "SynapseSparkConfigurationListResult",
  "csharp"
);

// Workspaces (GA public API / rename-mapping).
@@clientName(
  Workspaces.ReplaceAllIpFirewallRulesRequest,
  "ReplaceAllIPFirewallRulesContent",
  "csharp"
);
@@clientName(
  Workspaces.ReplaceAllFirewallRulesOperationResponse,
  "ReplaceAllFirewallRulesOperationResult",
  "csharp"
);
@@clientName(
  Workspaces.PrivateEndpointConnectionForPrivateLinkHub_ResourceCollectionResponse,
  "SynapsePrivateEndpointConnectionForPrivateLinkHubListResult",
  "csharp"
);
@@clientName(
  Workspaces.DataLakeStorageAccountDetails.accountUrl,
  "AccountUri",
  "csharp"
);
@@clientName(
  Workspaces.WorkspaceKeyDetails.keyVaultUrl,
  "KeyVaultUri",
  "csharp"
);
@@clientName(Workspaces.KeyProperties.keyVaultUrl, "KeyVaultUri", "csharp");

// Workspaces check-name (no shipped .NET name; follows the GA KustoPool*NameAvailability* pattern).
@@clientName(
  Workspaces.CheckNameAvailabilityRequest,
  "SynapseNameAvailabilityContent",
  "csharp"
);
@@clientName(
  Workspaces.CheckNameAvailabilityResponse,
  "SynapseNameAvailabilityResult",
  "csharp"
);

// SQL pools.
@@clientName(
  SqlPools.MaintenanceWindowOptions,
  "SynapseMaintenanceWindowOption",
  "csharp"
); // GA: SynapseMaintenanceWindowOptionData
@@clientName(
  SqlPools.SqlPoolNotFoundResponse,
  "SqlPoolNotFoundResult",
  "csharp"
); // no shipped name (404 error response)
@@clientName(
  SqlPools.SqlPoolAcceptedResponse,
  "SqlPoolAcceptedResult",
  "csharp"
); // no shipped name (pause/resume 202 envelope)

// --- Python names (python scope only) ---
// Merged-client name clashes. Shipped names stay on the released types: KustoPools.ResourceProvisioningState
// and the workspace-level SqlPools.BlobAuditingPolicyName are both classes in azure-mgmt-synapse 2.1.0b7.
@@clientName(
  Azure.ResourceManager.ResourceProvisioningState,
  "ArmResourceProvisioningState",
  "python"
);

// Single-value path parameters shipped as fixed constants (Literal) in azure-mgmt-synapse 2.1.0b7.
@@alternateType(SqlPools.DataMaskingPolicyName, "Default", "python");
@@alternateType(
  SqlPools.SqlPoolLevel.BlobAuditingPolicyName,
  "default",
  "python"
);
@@alternateType(SqlPools.WritableSensitivityLabelSource, "current", "python");
@@alternateType(
  SqlPools.RecommendedSensitivityLabelSource,
  "recommended",
  "python"
);

// Operations that were not pageable in azure-mgmt-synapse 2.1.0b7 (they returned the list model).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restores the released Python non-pageable signature"
@@Azure.ClientGenerator.Core.Legacy.disablePageable(
  KustoPools.KustoPools.listByWorkspace,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restores the released Python non-pageable signature"
@@Azure.ClientGenerator.Core.Legacy.disablePageable(
  IntegrationRuntimes.IntegrationRuntimeResources.listOutboundNetworkDependenciesEndpoints,
  "python"
);
