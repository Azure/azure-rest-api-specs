import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("A web app, a mobile app backend, or an API app.")
model Site is TrackedResource<SiteProperties> {
  @doc("Name of the app.")
  @path
  @key("name")
  @segment("sites")
  name: string;

  @doc("Extended Location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Gets the details of a web, mobile, or API app.")
  get is ArmResourceRead<Site>;
  @doc("Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Site>;
  @doc("Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
  update is ArmResourcePatchSync<Site, SiteProperties>;
  @doc("Description for Deletes a web, mobile, or API app, or one of the deployment slots.")
  delete is ArmResourceDeleteSync<
    Site,
    {
      ...BaseParameters<Site>;

      @doc("If true, web app metrics are also deleted.")
      @query("deleteMetrics")
      deleteMetrics?: boolean;

      @doc("Specify false if you want to keep empty App Service plan. By default, empty App Service plan is deleted.")
      @query("deleteEmptyServerFarm")
      deleteEmptyServerFarm?: boolean;
    }
  >;
  @doc("Description for Gets all web, mobile, and API apps in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Site,
    {
      ...BaseParameters<Site>;

      @doc("Specify <strong>true</strong> to include deployment slots in results. The default is false, which only gives you the production slot of all apps.")
      @query("includeSlots")
      includeSlots?: boolean;
    }
  >;
  @doc("Description for Get all apps for a subscription.")
  list is ArmListBySubscription<Site>;
  @doc("Description for Applies the configuration settings from the target slot onto the current slot.")
  applySlotConfigToProduction is ArmResourceActionSync<
    Site,
    CsmSlotEntity,
    void
  >;
  @doc("Description for Creates a backup of an app.")
  backup is ArmResourceActionSync<Site, BackupRequest, BackupItem>;
  @doc("Description for Gets the application settings of an app.")
  listApplicationSettings is ArmResourceActionSync<
    Site,
    void,
    StringDictionary
  >;
  @doc("Description for Gets the Authentication/Authorization settings of an app.")
  getAuthSettings is ArmResourceActionSync<Site, void, SiteAuthSettings>;
  @doc("Description for Gets the Azure storage account configurations of an app.")
  listAzureStorageAccounts is ArmResourceActionSync<
    Site,
    void,
    AzureStoragePropertyDictionaryResource
  >;
  @doc("Description for Gets the backup configuration of an app.")
  getBackupConfiguration is ArmResourceActionSync<Site, void, BackupRequest>;
  @doc("Description for Gets the connection strings of an app.")
  listConnectionStrings is ArmResourceActionSync<
    Site,
    void,
    ConnectionStringDictionary
  >;
  @doc("Description for Gets the metadata of an app.")
  listMetadata is ArmResourceActionSync<Site, void, StringDictionary>;
  @doc("Description for Gets the Git/FTP publishing credentials of an app.")
  listPublishingCredentials is ArmResourceActionAsync<Site, void, User>;
  @doc("Description for Gets the Push settings associated with web app.")
  listSitePushSettings is ArmResourceActionSync<Site, void, PushSettings>;
  @doc("Description for Gets the last lines of docker logs for the given site")
  getWebSiteContainerLogs is ArmResourceActionSync<Site, void, void>;
  @doc("Description for Gets the ZIP archived docker log files for the given site")
  getContainerLogsZip is ArmResourceActionSync<Site, void, void>;
  @doc("Description for Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.")
  discoverBackup is ArmResourceActionSync<Site, RestoreRequest, RestoreRequest>;
  @doc("Description for Get host secrets for a function app.")
  listHostKeys is ArmResourceActionSync<Site, void, HostKeys>;
  @doc("Description for This is to allow calling via powershell and ARM template.")
  listSyncStatus is ArmResourceActionNoContentSync<Site, void>;
  @doc("Description for Syncs function trigger metadata to the management database")
  syncFunctions is ArmResourceActionNoContentSync<Site, void>;
  @doc("Description for Shows whether an app can be cloned to another resource group or subscription.")
  isCloneable is ArmResourceActionSync<Site, void, SiteCloneability>;
  @doc("Description for Gets existing backups of an app.")
  listSiteBackups is ArmResourceActionSync<
    Site,
    void,
    ResourceListResult<BackupItem>
  >;
  @doc("Description for This is to allow calling via powershell and ARM template.")
  listSyncFunctionTriggers is ArmResourceActionSync<
    Site,
    void,
    FunctionSecrets
  >;
  @doc("Description for Migrates a local (in-app) MySql database to a remote MySql database.")
  migrateMySql is ArmResourceActionAsync<Site, MigrateMySqlRequest, Operation>;
  @doc("Description for Start capturing network packets for the site (To be deprecated).")
  startWebSiteNetworkTrace is ArmResourceActionSync<
    Site,
    void,
    string,
    {
      ...BaseParameters<Site>;

      @doc("The duration to keep capturing in seconds.")
      @query("durationInSeconds")
      durationInSeconds?: int32;

      @doc("The maximum frame length in bytes (Optional).")
      @query("maxFrameLength")
      maxFrameLength?: int32;

      @doc("The Blob URL to store capture file.")
      @query("sasUrl")
      sasUrl?: string;
    }
  >;
  @doc("Description for Start capturing network packets for the site.")
  startWebSiteNetworkTraceOperation is ArmResourceActionAsync<
    Site,
    void,
    void,
    {
      ...BaseParameters<Site>;

      @doc("The duration to keep capturing in seconds.")
      @query("durationInSeconds")
      durationInSeconds?: int32;

      @doc("The maximum frame length in bytes (Optional).")
      @query("maxFrameLength")
      maxFrameLength?: int32;

      @doc("The Blob URL to store capture file.")
      @query("sasUrl")
      sasUrl?: string;
    }
  >;
  @doc("Description for Stop ongoing capturing network packets for the site.")
  stopWebSiteNetworkTrace is ArmResourceActionSync<Site, void, void>;
  @doc("Description for Generates a new publishing password for an app (or deployment slot, if specified).")
  generateNewSitePublishingPassword is ArmResourceActionSync<Site, void, void>;
  @doc("Description for Gets the publishing profile for an app (or deployment slot, if specified).")
  listPublishingProfileXmlWithSecrets is ArmResourceActionSync<
    Site,
    CsmPublishingProfileOptions,
    void
  >;
  @doc("Description for Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.")
  resetProductionSlotConfig is ArmResourceActionSync<Site, void, void>;
  @doc("Description for Restarts an app (or deployment slot, if specified).")
  restart is ArmResourceActionSync<
    Site,
    void,
    void,
    {
      ...BaseParameters<Site>;

      @doc("Specify true to apply the configuration settings and restarts the app only if necessary. By default, the API always restarts and reprovisions the app.")
      @query("softRestart")
      softRestart?: boolean;

      @doc("Specify true to block until the app is restarted. By default, it is set to false, and the API responds immediately (asynchronous).")
      @query("synchronous")
      synchronous?: boolean;
    }
  >;
  @doc("Description for Restores an app from a backup blob in Azure Storage.")
  restoreFromBackupBlob is ArmResourceActionAsync<Site, RestoreRequest, void>;
  @doc("Description for Restores a deleted web app to this web app.")
  restoreFromDeletedApp is ArmResourceActionAsync<
    Site,
    DeletedAppRestoreRequest,
    void
  >;
  @doc("Description for Restores a web app from a snapshot.")
  restoreSnapshot is ArmResourceActionAsync<Site, SnapshotRestoreRequest, void>;
  @doc("Description for Get the difference in configuration settings between two web app slots.")
  listSlotDifferencesFromProduction is ArmResourceActionSync<
    Site,
    CsmSlotEntity,
    SlotDifferenceCollection
  >;
  @doc("Description for Swaps two deployment slots of an app.")
  swapSlotWithProduction is ArmResourceActionAsync<Site, CsmSlotEntity, void>;
  @doc("Description for Starts an app (or deployment slot, if specified).")
  start is ArmResourceActionSync<Site, void, void>;
  @doc("Description for Start capturing network packets for the site.")
  startNetworkTrace is ArmResourceActionAsync<
    Site,
    void,
    void,
    {
      ...BaseParameters<Site>;

      @doc("The duration to keep capturing in seconds.")
      @query("durationInSeconds")
      durationInSeconds?: int32;

      @doc("The maximum frame length in bytes (Optional).")
      @query("maxFrameLength")
      maxFrameLength?: int32;

      @doc("The Blob URL to store capture file.")
      @query("sasUrl")
      sasUrl?: string;
    }
  >;
  @doc("Description for Stops an app (or deployment slot, if specified).")
  stop is ArmResourceActionSync<Site, void, void>;
  @doc("Description for Stop ongoing capturing network packets for the site.")
  stopNetworkTrace is ArmResourceActionSync<Site, void, void>;
  @doc("Description for Sync web app repository.")
  syncRepository is ArmResourceActionSync<Site, void, void>;
  @doc("Description for Syncs function trigger metadata to the management database")
  syncFunctionTriggers is ArmResourceActionNoContentSync<Site, void>;
  @summary("Analyze a custom hostname.")
  @doc("Description for Analyze a custom hostname.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/analyzeCustomHostname")
  @get
  AnalyzeCustomHostname is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Custom hostname.")
      @query("hostName")
      hostName?: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    CustomHostnameAnalysisResult
  >;

  @summary("List the configurations of an app")
  @doc("Description for List the configurations of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config")
  @get
  ListConfigurations is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteConfigResourceCollection
  >;

  @summary("Gets site's Authentication / Authorization settings for apps via the V2 format")
  @doc("Description for Gets site's Authentication / Authorization settings for apps via the V2 format")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/authsettingsV2/list")
  @get
  GetAuthSettingsV2 is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteAuthSettingsV2
  >;

  @summary("Fetch a short lived token that can be exchanged for a master key.")
  @doc("Description for Fetch a short lived token that can be exchanged for a master key.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/functions/admin/token")
  @get
  GetFunctionsAdminToken is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Retrieves all Service Bus Hybrid Connections used by this Web App.")
  @doc("Description for Retrieves all Service Bus Hybrid Connections used by this Web App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionRelays")
  @get
  ListHybridConnections is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The name of the web app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    HybridConnection
  >;

  @summary("Gets hybrid connections configured for an app (or deployment slot, if specified).")
  @doc("Description for Gets hybrid connections configured for an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridconnection")
  @get
  ListRelayServiceConnections is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    RelayServiceConnectionEntity
  >;

  @summary("Returns the status of MySql in app migration, if one is active, and whether or not MySql in app is enabled")
  @doc("Description for Returns the status of MySql in app migration, if one is active, and whether or not MySql in app is enabled")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/migratemysql/status")
  @get
  GetMigrateMySqlStatus is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    MigrateMySqlStatus
  >;

  @summary("Gets all network features used by the app (or deployment slot, if specified).")
  @doc("Description for Gets all network features used by the app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/networkFeatures/{view}")
  @get
  ListNetworkFeatures is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("The type of view. Only \"summary\" is supported at this time.")
      @path
      view: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    NetworkFeatures
  >;

  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @doc("Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/networkTrace/operationresults/{operationId}")
  @get
  GetNetworkTraceOperation is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("GUID of the operation.")
      @path
      operationId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @doc("Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/networkTrace/{operationId}")
  @get
  GetNetworkTraces is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("GUID of the operation.")
      @path
      operationId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @doc("Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/networkTraces/current/operationresults/{operationId}")
  @get
  GetNetworkTraceOperationV2 is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("GUID of the operation.")
      @path
      operationId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @doc("Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/networkTraces/{operationId}")
  @get
  GetNetworkTracesV2 is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("GUID of the operation.")
      @path
      operationId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("Gets perfmon counters for web app.")
  @doc("Description for Gets perfmon counters for web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/perfcounters")
  @get
  ListPerfMonCounters is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.")
      @query("$filter")
      $filter?: string;
    },
    PerfMonCounterCollection
  >;

  @summary("Gets web app's event logs.")
  @doc("Description for Gets web app's event logs.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/phplogging")
  @get
  GetSitePhpErrorLogFlag is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SitePhpErrorLogFlag
  >;

  @summary("Gets the premier add-ons of an app.")
  @doc("Description for Gets the premier add-ons of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/premieraddons")
  @get
  ListPremierAddOns is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PremierAddOn
  >;

  @summary("Gets the private link resources")
  @doc("Description for Gets the private link resources")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateLinkResources")
  @get
  GetPrivateLinkResources is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the site.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    PrivateLinkResourcesWrapper
  >;

  @summary("Returns all Snapshots to the user.")
  @doc("Description for Returns all Snapshots to the user.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/snapshots")
  @get
  ListSnapshots is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Website Name.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SnapshotCollection
  >;

  @summary("Returns all Snapshots to the user from DRSecondary endpoint.")
  @doc("Description for Returns all Snapshots to the user from DRSecondary endpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/snapshotsdr")
  @get
  ListSnapshotsFromDRSecondary is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Website Name.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SnapshotCollection
  >;

  @summary("Gets the quota usage information of an app (or deployment slot, if specified).")
  @doc("Description for Gets the quota usage information of an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/usages")
  @get
  ListUsages is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Return only information specified in the filter (using OData syntax). For example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.")
      @query("$filter")
      $filter?: string;
    },
    CsmUsageQuotaCollection
  >;
}

@armResourceOperations
interface Recommendations {
  @doc("Description for Disable all recommendations for an app.")
  disableAllForWebApp is ArmResourceActionNoContentSync<
    Site,
    void,
    {
      ...BaseParameters<Site>;

      @doc("Name of the app.")
      @path
      siteName: string;
    }
  >;
  @doc("Description for Reset all recommendation opt-out settings for an app.")
  resetAllFiltersForWebApp is ArmResourceActionNoContentSync<
    Site,
    void,
    {
      ...BaseParameters<Site>;

      @doc("Name of the app.")
      @path
      siteName: string;
    }
  >;
  @summary("Get past recommendations for an app, optionally specified by the time range.")
  @doc("Description for Get past recommendations for an app, optionally specified by the time range.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendationHistory")
  @get
  ListHistoryForWebApp is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      siteName: string;

      @doc("Specify <code>false</code> to return all recommendations. The default is <code>true</code>, which returns only expired recommendations.")
      @query("expiredOnly")
      expiredOnly?: boolean;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification' and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[PT1H|PT1M|P1D]")
      @query("$filter")
      $filter?: string;
    },
    RecommendationCollection
  >;

  @summary("Get all recommendations for an app.")
  @doc("Description for Get all recommendations for an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendations")
  @get
  ListRecommendedRulesForWebApp is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      siteName: string;

      @doc("Specify <code>true</code> to return only the most critical recommendations. The default is <code>false</code>, which returns all recommendations.")
      @query("featured")
      featured?: boolean;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;

      @doc("Return only channels specified in the filter. Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification'")
      @query("$filter")
      $filter?: string;
    },
    RecommendationCollection
  >;
}
