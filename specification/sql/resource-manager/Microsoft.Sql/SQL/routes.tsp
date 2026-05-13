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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface DeletedServersOperationGroup {
  /**
   * Gets a list of all deleted servers in a subscription.
   */
  @tag("DeletedServers")
  @autoRoute
  @get
  @action("deletedServers")
  @list
  list is ArmProviderActionSync<
    Response = ResourceListResult<DeletedServer>,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface CapabilitiesOperationGroup {
  /**
   * Gets the subscription capabilities available for the specified location.
   */
  @tag("LocationCapabilities")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface LongTermRetentionBackupsOperationGroup {
  /**
   * Lists the long term retention backups for a given location.
   */
  @tag("LongTermRetentionBackups")
  @autoRoute
  @get
  @action("longTermRetentionBackups")
  @list
  listByLocation is ArmProviderActionSync<
    Response = LongTermRetentionBackupListResult,
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
  @tag("LongTermRetentionBackups")
  @autoRoute
  @get
  @action("longTermRetentionBackups")
  @list
  listByServer is ArmProviderActionSync<
    Response = LongTermRetentionBackupListResult,
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
  @tag("LongTermRetentionBackups")
  @autoRoute
  @get
  @action("longTermRetentionBackups")
  @list
  listByResourceGroupLocation is ArmProviderActionSync<
    Response = LongTermRetentionBackupListResult,
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
  @tag("LongTermRetentionBackups")
  @autoRoute
  @get
  @action("longTermRetentionBackups")
  @list
  listByResourceGroupServer is ArmProviderActionSync<
    Response = LongTermRetentionBackupListResult,
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface LongTermRetentionManagedInstanceBackupsOperationGroup {
  /**
   * Lists the long term retention backups for managed databases in a given location.
   */
  @tag("LongTermRetentionManagedInstanceBackups")
  @autoRoute
  @get
  @action("longTermRetentionManagedInstanceBackups")
  @list
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
  @tag("LongTermRetentionManagedInstanceBackups")
  @autoRoute
  @get
  @action("longTermRetentionManagedInstanceBackups")
  @list
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
  @tag("LongTermRetentionManagedInstanceBackups")
  @autoRoute
  @get
  @action("longTermRetentionManagedInstanceBackups")
  @list
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
  @tag("LongTermRetentionManagedInstanceBackups")
  @autoRoute
  @get
  @action("longTermRetentionManagedInstanceBackups")
  @list
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface ServersOperationGroup {
  /**
   * Determines whether a resource can be created with the specified name.
   */
  @tag("Servers")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityRequest,
    Response = CheckNameAvailabilityResponse,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface SyncGroupsOperationGroup {
  /**
   * Gets a collection of sync database ids.
   */
  @tag("SyncGroups")
  @autoRoute
  @get
  @action("syncDatabaseIds")
  @list
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
