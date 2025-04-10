// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationsOperationGroup {
  /**
   * Operation to return the list of available operations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Returns the list of available operations.")
  @operationId("Operations_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/operations")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<OperationsDiscoveryCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationAppliancesOperationGroup {
  /**
   * Gets the list of Azure Site Recovery appliances for the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of appliances.")
  @operationId("ReplicationAppliances_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationAppliances")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,
  ): ArmResponse<ApplianceCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationNetworksOperationGroup {
  /**
   * Lists the networks available in a vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of networks. View-only API.")
  @operationId("ReplicationNetworks_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationNetworks")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<NetworkCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationNetworkMappingsOperationGroup {
  /**
   * Lists all ASR network mappings in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets all the network mappings under a vault.")
  @operationId("ReplicationNetworkMappings_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationNetworkMappings")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<NetworkMappingCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationProtectionContainersOperationGroup {
  /**
   * Lists the protection containers in a vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of all protection containers in a vault.")
  @operationId("ReplicationProtectionContainers_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationProtectionContainers")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<ProtectionContainerCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationMigrationItemsOperationGroup {
  /**
   * Gets the list of migration items in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of migration items in the vault.")
  @operationId("ReplicationMigrationItems_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationMigrationItems")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,

    /**
     * The pagination token.
     */
    @query("skipToken")
    skipToken?: string,

    /**
     * The page size.
     */
    @query("takeToken")
    takeToken?: string,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,
  ): ArmResponse<MigrationItemCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationProtectedItemsOperationGroup {
  /**
   * Gets the list of ASR replication protected items in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of replication protected items.")
  @operationId("ReplicationProtectedItems_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationProtectedItems")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,

    /**
     * The pagination token. Possible values: "FabricId" or "FabricId_CloudId" or null.
     */
    @query("skipToken")
    skipToken?: string,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,
  ): ArmResponse<ReplicationProtectedItemCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationProtectionClustersOperationGroup {
  /**
   * Gets the list of ASR replication protected clusters in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of Replication protection clusters in vault.")
  @operationId("ReplicationProtectionClusters_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationProtectionClusters")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    @path
    resourceName: string,

    ...SubscriptionIdParameter,

    /**
     * The pagination token. Possible values: "FabricId" or "FabricId_CloudId" or null.
     */
    @query("skipToken")
    skipToken?: string,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,
  ): ArmResponse<ReplicationProtectionClusterCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationProtectionContainerMappingsOperationGroup {
  /**
   * Lists the protection container mappings in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of all protection container mappings in a vault.")
  @operationId("ReplicationProtectionContainerMappings_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationProtectionContainerMappings")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<ProtectionContainerMappingCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationRecoveryServicesProvidersOperationGroup {
  /**
   * Lists the registered recovery services providers in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of registered recovery services providers in the vault. This is a view only api.")
  @operationId("ReplicationRecoveryServicesProviders_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationRecoveryServicesProviders")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<RecoveryServicesProviderCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationStorageClassificationsOperationGroup {
  /**
   * Lists the storage classifications in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of storage classification objects under a vault.")
  @operationId("ReplicationStorageClassifications_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationStorageClassifications")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<StorageClassificationCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationStorageClassificationMappingsOperationGroup {
  /**
   * Lists the storage classification mappings in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of storage classification mappings objects under a vault.")
  @operationId("ReplicationStorageClassificationMappings_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationStorageClassificationMappings")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<StorageClassificationMappingCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationvCentersOperationGroup {
  /**
   * Lists the vCenter servers registered in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of vCenter registered under the vault.")
  @operationId("ReplicationvCenters_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationvCenters")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<VCenterCollection> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationJobsOperationGroup {
  /**
   * The operation to export the details of the Azure Site Recovery jobs of the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Exports the details of the Azure Site Recovery jobs of the vault.")
  @operationId("ReplicationJobs_Export")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationJobs/export")
  @post
  export(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,

    /**
     * job query filter.
     */
    @bodyRoot
    jobQueryParameter: JobQueryParameter,
  ): ArmResponse<Job> | ArmAcceptedResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SupportedOperatingSystemsOperationGroup {
  /**
   * Gets the data of supported operating systems by SRS.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the data of supported operating systems by SRS.")
  @operationId("SupportedOperatingSystems_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationSupportedOperatingSystems")
  @get
  get(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,

    /**
     * The instance type.
     */
    @query("instanceType")
    instanceType?: string,
  ): ArmResponse<SupportedOperatingSystems> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReplicationVaultHealthOperationGroup {
  /**
   * Gets the health details of the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the health summary for the vault.")
  @operationId("ReplicationVaultHealth_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationVaultHealth")
  @get
  get(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<VaultHealthDetails> | ErrorResponse;

  /**
   * Refreshes health summary of the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Refreshes health summary of the vault.")
  @operationId("ReplicationVaultHealth_Refresh")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationVaultHealth/default/refresh")
  @post
  refresh(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    resourceName: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<VaultHealthDetails> | ArmAcceptedResponse | ErrorResponse;
}
