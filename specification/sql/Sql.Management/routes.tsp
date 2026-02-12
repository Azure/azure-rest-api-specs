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

namespace Microsoft.Sql;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DeletedServersOperationGroup {
  /**
   * Gets a list of all deleted servers in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeletedServers_List")
  @autoRoute
  @get
  @action("deletedServers")
  list is ArmProviderActionSync<
    Response = ResourceListResult<DeletedServer>,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CapabilitiesOperationGroup {
  /**
   * Gets the subscription capabilities available for the specified location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Capabilities_ListByLocation")
  @autoRoute
  @get
  @action("capabilities")
  listByLocation is ArmProviderActionSync<
    Response = LocationCapabilities,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The location name whose capabilities are retrieved.
       */
      @path
      @segment("locations")
      locationName: string;

      /**
       * If specified, restricts the response to only include the selected item.
       */
      @query("include")
      include?: CapabilityGroup;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LongTermRetentionBackupsOperationGroup {
  /**
   * Lists the long term retention backups for a given location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_ListByLocation")
  @autoRoute
  @get
  @action("longTermRetentionBackups")
  listByLocation is ArmProviderActionSync<
    Response = ResourceListResult<LongTermRetentionBackup>,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The location of the database
       */
      @path
      @segment("locations")
      locationName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;
    }
  >;
  /**
   * Lists the long term retention backups for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_ListByServer")
  @autoRoute
  @get
  @action("longTermRetentionBackups")
  listByServer is ArmProviderActionSync<
    Response = ResourceListResult<LongTermRetentionBackup>,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The location of the database
       */
      @path
      @segment("locations")
      locationName: string;

      /**
       * The name of the server
       */
      @path
      @segment("longTermRetentionServers")
      longTermRetentionServerName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;
    }
  >;
  /**
   * Lists the long term retention backups for a given location based on resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_ListByResourceGroupLocation")
  @autoRoute
  @get
  @action("longTermRetentionBackups")
  listByResourceGroupLocation is ArmProviderActionSync<
    Response = ResourceListResult<LongTermRetentionBackup>,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The location of the database
       */
      @path
      @segment("locations")
      locationName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;
    }
  >;
  /**
   * Lists the long term retention backups for a given server based on resource groups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_ListByResourceGroupServer")
  @autoRoute
  @get
  @action("longTermRetentionBackups")
  listByResourceGroupServer is ArmProviderActionSync<
    Response = ResourceListResult<LongTermRetentionBackup>,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The location of the database
       */
      @path
      @segment("locations")
      locationName: string;

      /**
       * The name of the server
       */
      @path
      @segment("longTermRetentionServers")
      longTermRetentionServerName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LongTermRetentionManagedInstanceBackupsOperationGroup {
  /**
   * Lists the long term retention backups for managed databases in a given location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionManagedInstanceBackups_ListByLocation")
  @autoRoute
  @get
  @action("longTermRetentionManagedInstanceBackups")
  listByLocation is ArmProviderActionSync<
    Response = ResourceListResult<ManagedInstanceLongTermRetentionBackup>,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The location of the database.
       */
      @path
      @segment("locations")
      locationName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int64;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
  /**
   * Lists the long term retention backups for a given managed instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionManagedInstanceBackups_ListByInstance")
  @autoRoute
  @get
  @action("longTermRetentionManagedInstanceBackups")
  listByInstance is ArmProviderActionSync<
    Response = ResourceListResult<ManagedInstanceLongTermRetentionBackup>,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The location of the database
       */
      @path
      @segment("locations")
      locationName: string;

      /**
       * The name of the managed instance.
       */
      @path
      @segment("longTermRetentionManagedInstances")
      managedInstanceName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;
    }
  >;
  /**
   * Lists the long term retention backups for managed databases in a given location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionManagedInstanceBackups_ListByResourceGroupLocation")
  @autoRoute
  @get
  @action("longTermRetentionManagedInstanceBackups")
  listByResourceGroupLocation is ArmProviderActionSync<
    Response = ResourceListResult<ManagedInstanceLongTermRetentionBackup>,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The location of the database.
       */
      @path
      @segment("locations")
      locationName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int64;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
  /**
   * Lists the long term retention backups for a given managed instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionManagedInstanceBackups_ListByResourceGroupInstance")
  @autoRoute
  @get
  @action("longTermRetentionManagedInstanceBackups")
  listByResourceGroupInstance is ArmProviderActionSync<
    Response = ResourceListResult<ManagedInstanceLongTermRetentionBackup>,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The location of the database.
       */
      @path
      @segment("locations")
      locationName: string;

      /**
       * The name of the managed instance.
       */
      @path
      @segment("longTermRetentionManagedInstances")
      managedInstanceName: string;

      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ServersOperationGroup {
  /**
   * Determines whether a resource can be created with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Servers_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityRequest,
    Response = CheckNameAvailabilityResponse,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SyncGroupsOperationGroup {
  /**
   * Gets a collection of sync database ids.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SyncGroups_ListSyncDatabaseIds")
  @autoRoute
  @get
  @action("syncDatabaseIds")
  listSyncDatabaseIds is ArmProviderActionSync<
    Response = SyncDatabaseIdListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The name of the region where the resource is located.
       */
      @path
      @segment("locations")
      locationName: string;
    }
  >;
}
