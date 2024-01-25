import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * A web app, a mobile app backend, or an API app.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model Site extends Resource {
  /**
   * Name of the app.
   */
  @path
  @key("name")
  @segment("sites")
  @visibility("read")
  name: string;

  /**
   * Managed service identity.
   */
  identity?: ManagedServiceIdentity;

  /**
   * Extended Location.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Site resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: SiteProperties;
}

@armResourceOperations
interface Sites {
  /**
   * Description for Gets the details of a web, mobile, or API app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_Get")
  get is ArmResourceRead<Site>;

  /**
   * Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Site>;

  /**
   * Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WebApps_Update")
  update is ArmCustomPatchSync<Site, SitePatchResource>;

  /**
   * Description for Deletes a web, mobile, or API app, or one of the deployment slots.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_Delete")
  delete is ArmResourceDeleteSync<
    Site,
    {
      ...BaseParameters<Site>;

      /**
       * If true, web app metrics are also deleted.
       */
      @query("deleteMetrics")
      deleteMetrics?: boolean;

      /**
       * Specify false if you want to keep empty App Service plan. By default, empty App Service plan is deleted.
       */
      @query("deleteEmptyServerFarm")
      deleteEmptyServerFarm?: boolean;
    }
  >;

  /**
   * Description for Gets all web, mobile, and API apps in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Site,
    {
      ...BaseParameters<Site>;

      /**
       * Specify <strong>true</strong> to include deployment slots in results. The default is false, which only gives you the production slot of all apps.
       */
      @query("includeSlots")
      includeSlots?: boolean;
    }
  >;

  /**
   * Description for Get all apps for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_List")
  list is ArmListBySubscription<Site>;

  /**
   * Description for Disable all recommendations for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Recommendations_DisableAllForWebApp")
  disableAllForWebApp is ArmResourceActionNoContentSync<
    Site,
    void,
    {
      ...BaseParameters<Site>;

      /**
       * Name of the app.
       */
      @path
      siteName: string;
    }
  >;

  /**
   * Description for Reset all recommendation opt-out settings for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Recommendations_ResetAllFiltersForWebApp")
  resetAllFiltersForWebApp is ArmResourceActionNoContentSync<
    Site,
    void,
    {
      ...BaseParameters<Site>;

      /**
       * Name of the app.
       */
      @path
      siteName: string;
    }
  >;

  /**
   * Description for Applies the configuration settings from the target slot onto the current slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ApplySlotConfigToProduction")
  applySlotConfigToProduction is ArmResourceActionSync<
    Site,
    CsmSlotEntity,
    void
  >;

  /**
   * Description for Creates a backup of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_Backup")
  backup is ArmResourceActionSync<Site, BackupRequest, BackupItem>;

  /**
   * Description for Gets the application settings of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListApplicationSettings")
  listApplicationSettings is ArmResourceActionSync<
    Site,
    void,
    StringDictionary
  >;

  /**
   * Description for Gets the Authentication/Authorization settings of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetAuthSettings")
  getAuthSettings is ArmResourceActionSync<Site, void, SiteAuthSettings>;

  /**
   * Description for Gets the Azure storage account configurations of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListAzureStorageAccounts")
  listAzureStorageAccounts is ArmResourceActionSync<
    Site,
    void,
    AzureStoragePropertyDictionaryResource
  >;

  /**
   * Description for Gets the backup configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetBackupConfiguration")
  getBackupConfiguration is ArmResourceActionSync<Site, void, BackupRequest>;

  /**
   * Description for Gets the connection strings of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListConnectionStrings")
  listConnectionStrings is ArmResourceActionSync<
    Site,
    void,
    ConnectionStringDictionary
  >;

  /**
   * Description for Gets the metadata of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListMetadata")
  listMetadata is ArmResourceActionSync<Site, void, StringDictionary>;

  /**
   * Description for Gets the Git/FTP publishing credentials of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListPublishingCredentials")
  listPublishingCredentials is ArmResourceActionAsync<Site, void, User>;

  /**
   * Description for Gets the Push settings associated with web app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListSitePushSettings")
  listSitePushSettings is ArmResourceActionSync<Site, void, PushSettings>;

  /**
   * Description for Gets the last lines of docker logs for the given site
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetWebSiteContainerLogs")
  getWebSiteContainerLogs is ArmResourceActionSync<Site, void, void>;

  /**
   * Description for Gets the ZIP archived docker log files for the given site
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetContainerLogsZip")
  getContainerLogsZip is ArmResourceActionSync<Site, void, void>;

  /**
   * Description for Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_DiscoverBackup")
  discoverBackup is ArmResourceActionSync<Site, RestoreRequest, RestoreRequest>;

  /**
   * Description for Get host secrets for a function app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListHostKeys")
  listHostKeys is ArmResourceActionSync<Site, void, HostKeys>;

  /**
   * Description for This is to allow calling via powershell and ARM template.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListSyncStatus")
  listSyncStatus is ArmResourceActionNoContentSync<Site, void>;

  /**
   * Description for Syncs function trigger metadata to the management database
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_SyncFunctions")
  syncFunctions is ArmResourceActionNoContentSync<Site, void>;

  /**
   * Description for Shows whether an app can be cloned to another resource group or subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_IsCloneable")
  isCloneable is ArmResourceActionSync<Site, void, SiteCloneability>;

  /**
   * Description for Gets existing backups of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListSiteBackups")
  listSiteBackups is ArmResourceActionSync<
    Site,
    void,
    ResourceListResult<BackupItem>
  >;

  /**
   * Description for This is to allow calling via powershell and ARM template.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListSyncFunctionTriggers")
  listSyncFunctionTriggers is ArmResourceActionSync<
    Site,
    void,
    FunctionSecrets
  >;

  /**
   * Description for Migrates a local (in-app) MySql database to a remote MySql database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_MigrateMySql")
  migrateMySql is ArmResourceActionAsync<Site, MigrateMySqlRequest, Operation>;

  /**
   * Description for Start capturing network packets for the site (To be deprecated).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_StartWebSiteNetworkTrace")
  startWebSiteNetworkTrace is ArmResourceActionSync<
    Site,
    void,
    string,
    {
      ...BaseParameters<Site>;

      /**
       * The duration to keep capturing in seconds.
       */
      @query("durationInSeconds")
      durationInSeconds?: int32;

      /**
       * The maximum frame length in bytes (Optional).
       */
      @query("maxFrameLength")
      maxFrameLength?: int32;

      /**
       * The Blob URL to store capture file.
       */
      @query("sasUrl")
      sasUrl?: string;
    }
  >;

  /**
   * Description for Start capturing network packets for the site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_StartWebSiteNetworkTraceOperation")
  startWebSiteNetworkTraceOperation is ArmResourceActionAsync<
    Site,
    void,
    void,
    {
      ...BaseParameters<Site>;

      /**
       * The duration to keep capturing in seconds.
       */
      @query("durationInSeconds")
      durationInSeconds?: int32;

      /**
       * The maximum frame length in bytes (Optional).
       */
      @query("maxFrameLength")
      maxFrameLength?: int32;

      /**
       * The Blob URL to store capture file.
       */
      @query("sasUrl")
      sasUrl?: string;
    }
  >;

  /**
   * Description for Stop ongoing capturing network packets for the site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_StopWebSiteNetworkTrace")
  stopWebSiteNetworkTrace is ArmResourceActionSync<Site, void, void>;

  /**
   * Description for Generates a new publishing password for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GenerateNewSitePublishingPassword")
  generateNewSitePublishingPassword is ArmResourceActionSync<Site, void, void>;

  /**
   * Description for Gets the publishing profile for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListPublishingProfileXmlWithSecrets")
  listPublishingProfileXmlWithSecrets is ArmResourceActionSync<
    Site,
    CsmPublishingProfileOptions,
    void
  >;

  /**
   * Description for Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ResetProductionSlotConfig")
  resetProductionSlotConfig is ArmResourceActionSync<Site, void, void>;

  /**
   * Description for Restarts an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_Restart")
  restart is ArmResourceActionSync<
    Site,
    void,
    void,
    {
      ...BaseParameters<Site>;

      /**
       * Specify true to apply the configuration settings and restarts the app only if necessary. By default, the API always restarts and reprovisions the app.
       */
      @query("softRestart")
      softRestart?: boolean;

      /**
       * Specify true to block until the app is restarted. By default, it is set to false, and the API responds immediately (asynchronous).
       */
      @query("synchronous")
      synchronous?: boolean;
    }
  >;

  /**
   * Description for Restores an app from a backup blob in Azure Storage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_RestoreFromBackupBlob")
  restoreFromBackupBlob is ArmResourceActionAsync<Site, RestoreRequest, void>;

  /**
   * Description for Restores a deleted web app to this web app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_RestoreFromDeletedApp")
  restoreFromDeletedApp is ArmResourceActionAsync<
    Site,
    DeletedAppRestoreRequest,
    void
  >;

  /**
   * Description for Restores a web app from a snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_RestoreSnapshot")
  restoreSnapshot is ArmResourceActionAsync<Site, SnapshotRestoreRequest, void>;

  /**
   * Description for Get the difference in configuration settings between two web app slots.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListSlotDifferencesFromProduction")
  listSlotDifferencesFromProduction is ArmResourceActionSync<
    Site,
    CsmSlotEntity,
    SlotDifferenceCollection
  >;

  /**
   * Description for Swaps two deployment slots of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_SwapSlotWithProduction")
  swapSlotWithProduction is ArmResourceActionAsync<Site, CsmSlotEntity, void>;

  /**
   * Description for Starts an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_Start")
  start is ArmResourceActionSync<Site, void, void>;

  /**
   * Description for Start capturing network packets for the site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_StartNetworkTrace")
  startNetworkTrace is ArmResourceActionAsync<
    Site,
    void,
    void,
    {
      ...BaseParameters<Site>;

      /**
       * The duration to keep capturing in seconds.
       */
      @query("durationInSeconds")
      durationInSeconds?: int32;

      /**
       * The maximum frame length in bytes (Optional).
       */
      @query("maxFrameLength")
      maxFrameLength?: int32;

      /**
       * The Blob URL to store capture file.
       */
      @query("sasUrl")
      sasUrl?: string;
    }
  >;

  /**
   * Description for Stops an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_Stop")
  stop is ArmResourceActionSync<Site, void, void>;

  /**
   * Description for Stop ongoing capturing network packets for the site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_StopNetworkTrace")
  stopNetworkTrace is ArmResourceActionSync<Site, void, void>;

  /**
   * Description for Sync web app repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_SyncRepository")
  syncRepository is ArmResourceActionSync<Site, void, void>;

  /**
   * Description for Syncs function trigger metadata to the management database
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_SyncFunctionTriggers")
  syncFunctionTriggers is ArmResourceActionNoContentSync<Site, void>;

  /**
   * Description for Get past recommendations for an app, optionally specified by the time range.
   */
  // FIXME: Recommendations_ListHistoryForWebApp could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Recommendations_ListHistoryForWebApp")
  @summary("Get past recommendations for an app, optionally specified by the time range.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendationHistory")
  @get
  listHistoryForWebApp is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      siteName: string;

      /**
       * Specify <code>false</code> to return all recommendations. The default is <code>true</code>, which returns only expired recommendations.
       */
      @query("expiredOnly")
      expiredOnly?: boolean;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification' and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[PT1H|PT1M|P1D]
       */
      @query("$filter")
      $filter?: string;
    },
    RecommendationCollection
  >;

  /**
   * Description for Get all recommendations for an app.
   */
  // FIXME: Recommendations_ListRecommendedRulesForWebApp could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Recommendations_ListRecommendedRulesForWebApp")
  @summary("Get all recommendations for an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/recommendations")
  @get
  listRecommendedRulesForWebApp is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      siteName: string;

      /**
       * Specify <code>true</code> to return only the most critical recommendations. The default is <code>false</code>, which returns all recommendations.
       */
      @query("featured")
      featured?: boolean;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Return only channels specified in the filter. Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification'
       */
      @query("$filter")
      $filter?: string;
    },
    RecommendationCollection
  >;

  /**
   * Description for Analyze a custom hostname.
   */
  // FIXME: WebApps_AnalyzeCustomHostname could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_AnalyzeCustomHostname")
  @summary("Analyze a custom hostname.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/analyzeCustomHostname")
  @get
  analyzeCustomHostname is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Custom hostname.
       */
      @query("hostName")
      hostName?: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    CustomHostnameAnalysisResult
  >;

  /**
   * Description for List the configurations of an app
   */
  // FIXME: WebApps_ListConfigurations could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListConfigurations")
  @summary("List the configurations of an app")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config")
  @get
  listConfigurations is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<SiteConfig>
  >;

  /**
   * Description for Gets site's Authentication / Authorization settings for apps via the V2 format
   */
  // FIXME: WebApps_GetAuthSettingsV2 could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetAuthSettingsV2")
  @summary("Gets site's Authentication / Authorization settings for apps via the V2 format")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/authsettingsV2/list")
  @get
  getAuthSettingsV2 is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SiteAuthSettingsV2
  >;

  /**
   * Description for Fetch a short lived token that can be exchanged for a master key.
   */
  // FIXME: WebApps_GetFunctionsAdminToken could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetFunctionsAdminToken")
  @summary("Fetch a short lived token that can be exchanged for a master key.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/functions/admin/token")
  @get
  getFunctionsAdminToken is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Retrieves all Service Bus Hybrid Connections used by this Web App.
   */
  // FIXME: WebApps_ListHybridConnections could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListHybridConnections")
  @summary("Retrieves all Service Bus Hybrid Connections used by this Web App.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridConnectionRelays")
  @get
  listHybridConnections is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The name of the web app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    HybridConnection
  >;

  /**
   * Description for Gets hybrid connections configured for an app (or deployment slot, if specified).
   */
  // FIXME: WebApps_ListRelayServiceConnections could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListRelayServiceConnections")
  @summary("Gets hybrid connections configured for an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hybridconnection")
  @get
  listRelayServiceConnections is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    RelayServiceConnectionEntity
  >;

  /**
   * Description for Returns the status of MySql in app migration, if one is active, and whether or not MySql in app is enabled
   */
  // FIXME: WebApps_GetMigrateMySqlStatus could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetMigrateMySqlStatus")
  @summary("Returns the status of MySql in app migration, if one is active, and whether or not MySql in app is enabled")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/migratemysql/status")
  @get
  getMigrateMySqlStatus is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    MigrateMySqlStatus
  >;

  /**
   * Description for Gets all network features used by the app (or deployment slot, if specified).
   */
  // FIXME: WebApps_ListNetworkFeatures could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListNetworkFeatures")
  @summary("Gets all network features used by the app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/networkFeatures/{view}")
  @get
  listNetworkFeatures is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * The type of view. Only "summary" is supported at this time.
       */
      @path
      view: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    NetworkFeatures
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  // FIXME: WebApps_GetNetworkTraceOperation could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetNetworkTraceOperation")
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/networkTrace/operationresults/{operationId}")
  @get
  getNetworkTraceOperation is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * GUID of the operation.
       */
      @path
      operationId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  // FIXME: WebApps_GetNetworkTraces could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetNetworkTraces")
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/networkTrace/{operationId}")
  @get
  getNetworkTraces is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * GUID of the operation.
       */
      @path
      operationId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  // FIXME: WebApps_GetNetworkTraceOperationV2 could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetNetworkTraceOperationV2")
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/networkTraces/current/operationresults/{operationId}")
  @get
  getNetworkTraceOperationV2 is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * GUID of the operation.
       */
      @path
      operationId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  // FIXME: WebApps_GetNetworkTracesV2 could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetNetworkTracesV2")
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/networkTraces/{operationId}")
  @get
  getNetworkTracesV2 is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * GUID of the operation.
       */
      @path
      operationId: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Description for Gets perfmon counters for web app.
   */
  // FIXME: WebApps_ListPerfMonCounters could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListPerfMonCounters")
  @summary("Gets perfmon counters for web app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/perfcounters")
  @get
  listPerfMonCounters is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
       */
      @query("$filter")
      $filter?: string;
    },
    PerfMonCounterCollection
  >;

  /**
   * Description for Gets web app's event logs.
   */
  // FIXME: WebApps_GetSitePhpErrorLogFlag could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetSitePhpErrorLogFlag")
  @summary("Gets web app's event logs.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/phplogging")
  @get
  getSitePhpErrorLogFlag is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of web app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SitePhpErrorLogFlag
  >;

  /**
   * Description for Gets the premier add-ons of an app.
   */
  // FIXME: WebApps_ListPremierAddOns could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListPremierAddOns")
  @summary("Gets the premier add-ons of an app.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/premieraddons")
  @get
  listPremierAddOns is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    PremierAddOn
  >;

  /**
   * Description for Gets the private link resources
   */
  // FIXME: WebApps_GetPrivateLinkResources could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetPrivateLinkResources")
  @summary("Gets the private link resources")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/privateLinkResources")
  @get
  getPrivateLinkResources is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the site.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    PrivateLinkResourcesWrapper
  >;

  /**
   * Description for Returns all Snapshots to the user.
   */
  // FIXME: WebApps_ListSnapshots could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListSnapshots")
  @summary("Returns all Snapshots to the user.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/snapshots")
  @get
  listSnapshots is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Website Name.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SnapshotCollection
  >;

  /**
   * Description for Returns all Snapshots to the user from DRSecondary endpoint.
   */
  // FIXME: WebApps_ListSnapshotsFromDRSecondary could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListSnapshotsFromDRSecondary")
  @summary("Returns all Snapshots to the user from DRSecondary endpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/snapshotsdr")
  @get
  listSnapshotsFromDRSecondary is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Website Name.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SnapshotCollection
  >;

  /**
   * Description for Gets the quota usage information of an app (or deployment slot, if specified).
   */
  // FIXME: WebApps_ListUsages could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListUsages")
  @summary("Gets the quota usage information of an app (or deployment slot, if specified).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/usages")
  @get
  listUsages is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the app.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;

      /**
       * Return only information specified in the filter (using OData syntax). For example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
       */
      @query("$filter")
      $filter?: string;
    },
    CsmUsageQuotaCollection
  >;
}

@@projectedName(Sites.createOrUpdate::parameters.resource,
  "json",
  "siteEnvelope"
);
@@extension(Sites.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "siteEnvelope"
);
@@doc(Sites.createOrUpdate::parameters.resource,
  "A JSON representation of the app properties. See example."
);
@@projectedName(Sites.update::parameters.properties, "json", "siteEnvelope");
@@extension(Sites.update::parameters.properties,
  "x-ms-client-name",
  "siteEnvelope"
);
@@doc(Sites.update::parameters.properties,
  "A JSON representation of the app properties. See example."
);
@@projectedName(Sites.applySlotConfigToProduction::parameters.body,
  "json",
  "slotSwapEntity"
);
@@extension(Sites.applySlotConfigToProduction::parameters.body,
  "x-ms-client-name",
  "slotSwapEntity"
);
@@doc(Sites.applySlotConfigToProduction::parameters.body,
  "JSON object that contains the target slot name. See example."
);
@@projectedName(Sites.backup::parameters.body, "json", "request");
@@extension(Sites.backup::parameters.body, "x-ms-client-name", "request");
@@doc(Sites.backup::parameters.body,
  "Backup configuration. You can use the JSON response from the POST action as input here."
);
@@projectedName(Sites.discoverBackup::parameters.body, "json", "request");
@@extension(Sites.discoverBackup::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(Sites.discoverBackup::parameters.body,
  "A RestoreRequest object that includes Azure storage URL and blog name for discovery of backup."
);
@@projectedName(Sites.migrateMySql::parameters.body,
  "json",
  "migrationRequestEnvelope"
);
@@extension(Sites.migrateMySql::parameters.body,
  "x-ms-client-name",
  "migrationRequestEnvelope"
);
@@doc(Sites.migrateMySql::parameters.body, "MySql migration options.");
@@projectedName(Sites.listPublishingProfileXmlWithSecrets::parameters.body,
  "json",
  "publishingProfileOptions"
);
@@extension(Sites.listPublishingProfileXmlWithSecrets::parameters.body,
  "x-ms-client-name",
  "publishingProfileOptions"
);
@@doc(Sites.listPublishingProfileXmlWithSecrets::parameters.body,
  "Specifies publishingProfileOptions for publishing profile. For example, use {",
  format,
  ": ",
  FileZilla3,
  "} to get a FileZilla publishing profile."
);
@@projectedName(Sites.restoreFromBackupBlob::parameters.body,
  "json",
  "request"
);
@@extension(Sites.restoreFromBackupBlob::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(Sites.restoreFromBackupBlob::parameters.body,
  "Information on restore request ."
);
@@projectedName(Sites.restoreFromDeletedApp::parameters.body,
  "json",
  "restoreRequest"
);
@@extension(Sites.restoreFromDeletedApp::parameters.body,
  "x-ms-client-name",
  "restoreRequest"
);
@@doc(Sites.restoreFromDeletedApp::parameters.body,
  "Deleted web app restore information."
);
@@projectedName(Sites.restoreSnapshot::parameters.body,
  "json",
  "restoreRequest"
);
@@extension(Sites.restoreSnapshot::parameters.body,
  "x-ms-client-name",
  "restoreRequest"
);
@@doc(Sites.restoreSnapshot::parameters.body,
  "Snapshot restore settings. Snapshot information can be obtained by calling GetDeletedSites or GetSiteSnapshots API."
);
@@projectedName(Sites.listSlotDifferencesFromProduction::parameters.body,
  "json",
  "slotSwapEntity"
);
@@extension(Sites.listSlotDifferencesFromProduction::parameters.body,
  "x-ms-client-name",
  "slotSwapEntity"
);
@@doc(Sites.listSlotDifferencesFromProduction::parameters.body,
  "JSON object that contains the target slot name. See example."
);
@@projectedName(Sites.swapSlotWithProduction::parameters.body,
  "json",
  "slotSwapEntity"
);
@@extension(Sites.swapSlotWithProduction::parameters.body,
  "x-ms-client-name",
  "slotSwapEntity"
);
@@doc(Sites.swapSlotWithProduction::parameters.body,
  "JSON object that contains the target slot name. See example."
);
