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

@armResourceOperations
@tag("Operations")
interface OperationsOperationGroup {
  /**
   * Operation to return the list of available operations.
   */
  @summary("Returns the list of available operations.")
  @autoRoute
  @get
  @list
  @action("operations")
  list is ArmProviderActionSync<
    Response = OperationsDiscoveryCollection,
    Scope = Extension.ResourceGroup,
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationAppliances")
interface ReplicationAppliancesOperationGroup {
  /**
   * Gets the list of Azure Site Recovery appliances for the vault.
   */
  @summary("Gets the list of appliances.")
  @autoRoute
  @get
  @list
  @action("replicationAppliances")
  list is ArmProviderActionSync<
    Response = ApplianceCollection,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;

      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationNetworks")
interface ReplicationNetworksOperationGroup {
  /**
   * Lists the networks available in a vault.
   */
  @summary("Gets the list of networks. View-only API.")
  @autoRoute
  @get
  @list
  @action("replicationNetworks")
  list is ArmProviderActionSync<
    Response = NetworkCollection,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationNetworkMappings")
interface ReplicationNetworkMappingsOperationGroup {
  /**
   * Lists all ASR network mappings in the vault.
   */
  @summary("Gets all the network mappings under a vault.")
  @autoRoute
  @get
  @list
  @action("replicationNetworkMappings")
  list is ArmProviderActionSync<
    Response = NetworkMappingCollection,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationProtectionContainers")
interface ReplicationProtectionContainersOperationGroup {
  /**
   * Lists the protection containers in a vault.
   */
  @summary("Gets the list of all protection containers in a vault.")
  @autoRoute
  @get
  @list
  @action("replicationProtectionContainers")
  list is ArmProviderActionSync<
    Response = ProtectionContainerCollection,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationMigrationItems")
interface ReplicationMigrationItemsOperationGroup {
  /**
   * Gets the list of migration items in the vault.
   */
  @summary("Gets the list of migration items in the vault.")
  @autoRoute
  @get
  @list
  @action("replicationMigrationItems")
  list is ArmProviderActionSync<
    Response = MigrationItemCollection,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;

      /**
       * The pagination token.
       */
      @query("skipToken")
      skipToken?: string;

      /**
       * The page size.
       */
      @query("takeToken")
      takeToken?: string;

      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationProtectedItems")
interface ReplicationProtectedItemsOperationGroup {
  /**
   * Gets the list of ASR replication protected items in the vault.
   */
  @summary("Gets the list of replication protected items.")
  @autoRoute
  @get
  @list
  @action("replicationProtectedItems")
  list is ArmProviderActionSync<
    Response = ReplicationProtectedItemCollection,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;

      /**
       * The pagination token. Possible values: "FabricId" or "FabricId_CloudId" or null.
       */
      @query("skipToken")
      skipToken?: string;

      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationProtectionClusters")
interface ReplicationProtectionClustersOperationGroup {
  /**
   * Gets the list of ASR replication protected clusters in the vault.
   */
  @summary("Gets the list of Replication protection clusters in vault.")
  @autoRoute
  @get
  @list
  @action("replicationProtectionClusters")
  list is ArmProviderActionSync<
    Response = ReplicationProtectionClusterCollection,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
      @path
      @segment("vaults")
      resourceName: string;

      /**
       * The pagination token. Possible values: "FabricId" or "FabricId_CloudId" or null.
       */
      @query("skipToken")
      skipToken?: string;

      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@armResourceOperations
@tag("ReplicationProtectionContainerMappings")
interface ReplicationProtectionContainerMappingsOperationGroup {
  /**
   * Lists the protection container mappings in the vault.
   */
  @summary("Gets the list of all protection container mappings in a vault.")
  @autoRoute
  @get
  @list
  @action("replicationProtectionContainerMappings")
  list is ArmProviderActionSync<
    Response = ProtectionContainerMappingCollection,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationRecoveryServicesProviders")
interface ReplicationRecoveryServicesProvidersOperationGroup {
  /**
   * Lists the registered recovery services providers in the vault.
   */
  @summary("Gets the list of registered recovery services providers in the vault. This is a view only api.")
  @autoRoute
  @get
  @list
  @action("replicationRecoveryServicesProviders")
  list is ArmProviderActionSync<
    Response = RecoveryServicesProviderCollection,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationStorageClassifications")
interface ReplicationStorageClassificationsOperationGroup {
  /**
   * Lists the storage classifications in the vault.
   */
  @summary("Gets the list of storage classification objects under a vault.")
  @autoRoute
  @get
  @list
  @action("replicationStorageClassifications")
  list is ArmProviderActionSync<
    Response = StorageClassificationCollection,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationStorageClassificationMappings")
interface ReplicationStorageClassificationMappingsOperationGroup {
  /**
   * Lists the storage classification mappings in the vault.
   */
  @summary("Gets the list of storage classification mappings objects under a vault.")
  @autoRoute
  @get
  @list
  @action("replicationStorageClassificationMappings")
  list is ArmProviderActionSync<
    Response = StorageClassificationMappingCollection,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationvCenters")
interface ReplicationvCentersOperationGroup {
  /**
   * Lists the vCenter servers registered in the vault.
   */
  @summary("Gets the list of vCenter registered under the vault.")
  @autoRoute
  @get
  @list
  @action("replicationvCenters")
  list is ArmProviderActionSync<
    Response = VCenterCollection,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationJobs")
interface ReplicationJobsOperationGroup {
  /**
   * The operation to export the details of the Azure Site Recovery jobs of the vault.
   */
  @summary("Exports the details of the Azure Site Recovery jobs of the vault.")
  @autoRoute
  @action("replicationJobs/export")
  export is ArmProviderActionAsync<
    Request = JobQueryParameter,
    Response = Job,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("SupportedOperatingSystems")
interface SupportedOperatingSystemsOperationGroup {
  /**
   * Gets the data of supported operating systems by SRS.
   */
  @summary("Gets the data of supported operating systems by SRS.")
  @autoRoute
  @get
  @action("replicationSupportedOperatingSystems")
  get is ArmProviderActionSync<
    Response = SupportedOperatingSystems,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;

      /**
       * The instance type.
       */
      @query("instanceType")
      instanceType?: string;
    },
    Error = never
  >;
}

@armResourceOperations
@tag("ReplicationVaultHealth")
interface ReplicationVaultHealthOperationGroup {
  /**
   * Gets the health details of the vault.
   */
  @summary("Gets the health summary for the vault.")
  @autoRoute
  @get
  @action("replicationVaultHealth")
  get is ArmProviderActionSync<
    Response = VaultHealthDetails,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;
    },
    Error = never
  >;
  /**
   * Refreshes health summary of the vault.
   */
  @summary("Refreshes health summary of the vault.")
  @autoRoute
  @action("replicationVaultHealth/default/refresh")
  refresh is ArmProviderActionAsync<
    Response = VaultHealthDetails,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      resourceName: string;
    },
    Error = never
  >;
}
