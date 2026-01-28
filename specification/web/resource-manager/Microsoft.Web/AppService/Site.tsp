import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * A web app, a mobile app backend, or an API app.
 */
model Site is Azure.ResourceManager.TrackedResource<SiteProperties> {
  ...ResourceNameParameter<
    Resource = Site,
    KeyName = "name",
    SegmentName = "sites",
    NamePattern = ""
  >;

  /**
   * Managed service identity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;

  /**
   * Extended Location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /** Kind of resource. If the resource is an app, you can refer to https://github.com/Azure/app-service-linux-docs/blob/master/Things_You_Should_Know/kind_property.md#app-service-resource-kind-reference for details supported values for kind. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface SiteOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      }
    > {}

@armResourceOperations
interface WorkflowRegenerateAccessKeyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** undefined */
        @path
        @segment("hostruntime")
        @key
        runtime: "runtime",

        /** undefined */
        @path
        @segment("webhooks")
        @key
        workflow: "workflow",

        /** undefined */
        @path
        @segment("api")
        @key
        management: "management",
      },
      {
        /** The workflow name. */
        @path
        @segment("workflows")
        @key
        workflowName: string,
      }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true })
interface Sites {
  /**
   * Description for Gets the details of a web, mobile, or API app.
   */
  @summary("Gets the details of a web, mobile, or API app.")
  get is SiteOps.Read<
    Site,
    Response = ArmResponse<Site> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
  createOrUpdate is SiteOps.CreateOrUpdateAsync<
    Site,
    Response = ArmResourceUpdatedResponse<Site> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Site>> & {
      @bodyRoot
      _: Site;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
  update is SiteOps.CustomPatchSync<
    Site,
    PatchModel = SitePatchResource,
    Response = ArmResponse<Site> | (AcceptedResponse & {
      @bodyRoot
      _: Site;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a web, mobile, or API app, or one of the deployment slots.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a web, mobile, or API app, or one of the deployment slots.")
  delete is SiteOps.DeleteSync<
    Site,
    Parameters = {
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
    },
    Response = {
      @body body: void;
    } | NoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get all apps for a subscription.
   */
  @summary("Get all apps for a subscription.")
  list is Azure.ResourceManager.Extension.ListByTarget<
    Extension.Subscription,
    Site,
    Response = ArmResponse<WebAppCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get past recommendations for an app, optionally specified by the time range.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get past recommendations for an app, optionally specified by the time range.")
  @Azure.ResourceManager.Legacy.renamePathParameter("name", "siteName")
  @get
  @list
  @action("recommendationHistory")
  listHistoryForWebApp is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<RecommendationCollection>,
    Parameters = {
      /**
       * Specify <code>false</code> to return all recommendations. The default is <code>true</code>, which returns only expired recommendations.
       */
      @query("expiredOnly")
      expiredOnly?: boolean;

      /**
       * Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification' and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[PT1H|PT1M|P1D]
       */
      @query("$filter")
      $filter?: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get all recommendations for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get all recommendations for an app.")
  @Azure.ResourceManager.Legacy.renamePathParameter("name", "siteName")
  @get
  @list
  @action("recommendations")
  listRecommendedRulesForWebApp is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<RecommendationCollection>,
    Parameters = {
      /**
       * Specify <code>true</code> to return only the most critical recommendations. The default is <code>false</code>, which returns all recommendations.
       */
      @query("featured")
      featured?: boolean;

      /**
       * Return only channels specified in the filter. Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification'
       */
      @query("$filter")
      $filter?: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Disable all recommendations for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Disable all recommendations for an app.")
  @post
  @action("recommendations/disable")
  @Azure.ResourceManager.Legacy.renamePathParameter("name", "siteName")
  disableAllForWebApp is ArmResourceActionSync<
    Site,
    Request = void,
    Response = NoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Reset all recommendation opt-out settings for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @post
  @summary("Reset all recommendation opt-out settings for an app.")
  @action("recommendations/reset")
  @Azure.ResourceManager.Legacy.renamePathParameter("name", "siteName")
  resetAllFiltersForWebApp is ArmResourceActionSync<
    Site,
    Request = void,
    Response = NoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Analyze a custom hostname.
   */
  @summary("Analyze a custom hostname.")
  @get
  analyzeCustomHostname is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<CustomHostnameAnalysisResult>,
    Parameters = {
      /**
       * Custom hostname.
       */
      @query("hostName")
      hostName?: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Applies the configuration settings from the target slot onto the current slot.
   */
  @summary("Applies the configuration settings from the target slot onto the current slot.")
  @action("applySlotConfig")
  applySlotConfigToProduction is SiteOps.ActionSync<
    Site,
    CsmSlotEntity,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a backup of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a backup of an app.")
  backup is SiteOps.ActionSync<
    Site,
    BackupRequest,
    ArmResponse<BackupItem>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Replaces the application settings of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Replaces the application settings of an app.")
  @put
  @action("config/appsettings")
  updateApplicationSettings is SiteOps.ActionSync<
    Site,
    StringDictionary,
    ArmResponse<StringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the application settings of an app.
   */
  @summary("Gets the application settings of an app.")
  @action("config/appsettings/list")
  listApplicationSettings is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<StringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates the Authentication / Authorization settings associated with web app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates the Authentication / Authorization settings associated with web app.")
  @put
  @action("config/authsettings")
  updateAuthSettings is SiteOps.ActionSync<
    Site,
    SiteAuthSettings,
    ArmResponse<SiteAuthSettings>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the Authentication/Authorization settings of an app.
   */
  @summary("Gets the Authentication/Authorization settings of an app.")
  @action("config/authsettings/list")
  getAuthSettings is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<SiteAuthSettings>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates the Azure storage account configurations of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates the Azure storage account configurations of an app.")
  @put
  @action("config/azurestorageaccounts")
  updateAzureStorageAccounts is SiteOps.ActionSync<
    Site,
    AzureStoragePropertyDictionaryResource,
    ArmResponse<AzureStoragePropertyDictionaryResource>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the Azure storage account configurations of an app.
   */
  @summary("Gets the Azure storage account configurations of an app.")
  @action("config/azurestorageaccounts/list")
  listAzureStorageAccounts is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<AzureStoragePropertyDictionaryResource>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates the backup configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates the backup configuration of an app.")
  @put
  @action("config/backup")
  updateBackupConfiguration is SiteOps.ActionSync<
    Site,
    BackupRequest,
    ArmResponse<BackupRequest>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes the backup configuration of an app.
   */
  @summary("Deletes the backup configuration of an app.")
  @delete
  @action("config/backup")
  deleteBackupConfiguration is SiteOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the backup configuration of an app.
   */
  @summary("Gets the backup configuration of an app.")
  @action("config/backup/list")
  getBackupConfiguration is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<BackupRequest>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Replaces the connection strings of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Replaces the connection strings of an app.")
  @put
  @action("config/connectionstrings")
  updateConnectionStrings is SiteOps.ActionSync<
    Site,
    ConnectionStringDictionary,
    ArmResponse<ConnectionStringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the connection strings of an app.
   */
  @summary("Gets the connection strings of an app.")
  @action("config/connectionstrings/list")
  listConnectionStrings is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<ConnectionStringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Replaces the metadata of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Replaces the metadata of an app.")
  @put
  @action("config/metadata")
  updateMetadata is SiteOps.ActionSync<
    Site,
    StringDictionary,
    ArmResponse<StringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the metadata of an app.
   */
  @summary("Gets the metadata of an app.")
  @action("config/metadata/list")
  listMetadata is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<StringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the Git/FTP publishing credentials of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the Git/FTP publishing credentials of an app.")
  @action("config/publishingcredentials/list")
  listPublishingCredentials is Azure.ResourceManager.ArmResourceActionAsyncBase<
    Site,
    Request = void,
    Response = ArmResponse<User> & ArmLroLocationHeader<FinalResult = User>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Site>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Updates the Push settings associated with web app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates the Push settings associated with web app.")
  @put
  @action("config/pushsettings")
  updateSitePushSettings is SiteOps.ActionSync<
    Site,
    PushSettings,
    ArmResponse<PushSettings>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the Push settings associated with web app.
   */
  @summary("Gets the Push settings associated with web app.")
  @action("config/pushsettings/list")
  listSitePushSettings is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<PushSettings>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the last lines of docker logs for the given site
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the last lines of docker logs for the given site")
  @action("containerlogs")
  getWebSiteContainerLogs is SiteOps.ActionSync<
    Site,
    void,
    {
      @header("Content-Type")
      contentType: "application/octet-stream";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    } | NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the ZIP archived docker log files for the given site
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the ZIP archived docker log files for the given site")
  @action("containerlogs/zip/download")
  getContainerLogsZip is SiteOps.ActionSync<
    Site,
    void,
    {
      @header("Content-Type")
      contentType: "application/zip";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    } | NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.
   */
  @summary("Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.")
  @action("discoverbackup")
  discoverBackup is SiteOps.ActionSync<
    Site,
    RestoreRequest,
    ArmResponse<RestoreRequest>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Invoke onedeploy status API /api/deployments and gets the deployment status for the site
   */
  @summary("Invoke onedeploy status API /api/deployments and gets the deployment status for the site")
  @get
  @action("extensions/onedeploy")
  getOneDeployStatus is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<unknown>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Invoke the OneDeploy publish web app extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Invoke the OneDeploy publish web app extension.")
  @put
  @action("extensions/onedeploy")
  createOneDeployOperation is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<unknown>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Fetch a short lived token that can be exchanged for a master key.
   */
  @summary("Fetch a short lived token that can be exchanged for a master key.")
  @get
  @action("functions/admin/token")
  getFunctionsAdminToken is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<stringApplicationJson>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get host secrets for a function app.
   */
  @summary("Get host secrets for a function app.")
  @action("host/default/listkeys")
  listHostKeys is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<HostKeys>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for This is to allow calling via powershell and ARM template.
   */
  @summary("This is to allow calling via powershell and ARM template.")
  @action("host/default/listsyncstatus")
  listSyncStatus is SiteOps.ActionSync<
    Site,
    void,
    NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Syncs function trigger metadata to the management database
   */
  @summary("Syncs function trigger metadata to the management database")
  @action("host/default/sync")
  syncFunctions is SiteOps.ActionSync<
    Site,
    void,
    NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Add or update a host level secret.
   */
  @summary("Add or update a host level secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/host/default/{keyType}/{keyName}")
  @put
  createOrUpdateHostSecret is ActionParameterSiteWebAppOps.ActionSync<
    Site,
    KeyInfo,
    Parameters = {
      /**
       * The type of host key.
       */
      @path
      keyType: string;

      /**
       * The name of the key.
       */
      @path
      keyName: string;
    },
    Response = ArmResponse<KeyInfo> | ArmResourceCreatedSyncResponse<KeyInfo>,
    OverrideErrorType = DefaultErrorResponse
  >;
  /**
   * Description for Delete a host level secret.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a host level secret.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/host/default/{keyType}/{keyName}")
  @delete
  deleteHostSecret is ActionParameterSiteWebAppOps.ActionSync<
    Site,
    void,
    Parameters = {
      /**
       * The type of host key.
       */
      @path
      keyType: string;

      /**
       * The name of the key.
       */
      @path
      keyName: string;
    },
    Response = NoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Retrieves all Service Bus Hybrid Connections used by this Web App.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Retrieves all Service Bus Hybrid Connections used by this Web App.")
  @get
  @action("hybridConnectionRelays")
  listHybridConnections is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<HybridConnection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets hybrid connections configured for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets hybrid connections configured for an app (or deployment slot, if specified).")
  @get
  @action("hybridconnection")
  listRelayServiceConnections is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<RelayServiceConnectionEntity>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Shows whether an app can be cloned to another resource group or subscription.
   */
  @summary("Shows whether an app can be cloned to another resource group or subscription.")
  @action("iscloneable")
  isCloneable is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<SiteCloneability>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets existing backups of an app.
   */
  @summary("Gets existing backups of an app.")
  @action("listbackups")
  @list
  listSiteBackups is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<BackupItemCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for This is to allow calling via powershell and ARM template.
   */
  @summary("This is to allow calling via powershell and ARM template.")
  @action("listsyncfunctiontriggerstatus")
  listSyncFunctionTriggers is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<FunctionSecrets>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Updates the machine key of an app.
   */
  @summary("Updates the machine key of an app.")
  @action("updatemachinekey")
  updateMachineKey is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<unknown>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Restores a web app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Restores a web app.")
  @put
  @action("migrate")
  migrateStorage is Azure.ResourceManager.ArmResourceActionAsyncBase<
    Site,
    StorageMigrationOptions,
    ArmResponse<StorageMigrationResponse> &
      ArmLroLocationHeader<FinalResult = StorageMigrationResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Site>,
    Parameters = {
      /**
       * Azure subscription
       */
      @query("subscriptionName")
      subscriptionName: string;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Migrates a local (in-app) MySql database to a remote MySql database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Migrates a local (in-app) MySql database to a remote MySql database.")
  @action("migratemysql")
  migrateMySql is Azure.ResourceManager.ArmResourceActionAsyncBase<
    Site,
    MigrateMySqlRequest,
    ArmResponse<Operation> & ArmLroLocationHeader<FinalResult = Operation>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Site>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/networkTrace/operationresults/{operationId}")
  getNetworkTraceOperation is ActionParameterSiteWebAppOps.ActionSync<
    Site,
    void,
    Response = ArmResponse<NetworkTrace[]> | (AcceptedResponse & {
      @identifiers(#[])
      @bodyRoot
      _: NetworkTrace[];
    }),
    Parameters = {
      /**
       * GUID of the operation.
       */
      @path
      operationId: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Start capturing network packets for the site (To be deprecated).
   */
  @summary("Start capturing network packets for the site (To be deprecated).")
  @action("networkTrace/start")
  startWebSiteNetworkTrace is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<stringApplicationJson>,
    Parameters = {
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Start capturing network packets for the site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Start capturing network packets for the site.")
  @action("networkTrace/startOperation")
  startWebSiteNetworkTraceOperation is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<NetworkTrace[]> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NetworkTrace[]>> & {
      @bodyRoot
      @identifiers(#[])
      _?: NetworkTrace[];
    }),
    Parameters = {
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Stop ongoing capturing network packets for the site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Stop ongoing capturing network packets for the site.")
  @action("networkTrace/stop")
  stopWebSiteNetworkTrace is SiteOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    } | NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/networkTrace/{operationId}")
  getNetworkTraces is ActionParameterSiteWebAppOps.ActionSync<
    Site,
    void,
    Parameters = {
      /**
       * GUID of the operation.
       */
      @path
      operationId: string;
    },
    Response = ArmResponse<NetworkTrace[]>,
    OverrideErrorType = DefaultErrorResponse
  >;
  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/networkTraces/current/operationresults/{operationId}")
  getNetworkTraceOperationV2 is ActionParameterSiteWebAppOps.ActionSync<
    Site,
    void,
    Response = ArmResponse<NetworkTrace[]> | (AcceptedResponse & {
      @identifiers(#[])
      @bodyRoot
      _: NetworkTrace[];
    }),
    Parameters = {
      /**
       * GUID of the operation.
       */
      @path
      operationId: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/networkTraces/{operationId}")
  getNetworkTracesV2 is ActionParameterSiteWebAppOps.ActionSync<
    Site,
    void,
    Parameters = {
      /**
       * GUID of the operation.
       */
      @path
      operationId: string;
    },
    Response = ArmResponse<NetworkTrace[]>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Generates a new publishing password for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Generates a new publishing password for an app (or deployment slot, if specified).")
  @action("newpassword")
  generateNewSitePublishingPassword is SiteOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    } | NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets perfmon counters for web app.
   */
  @summary("Gets perfmon counters for web app.")
  @get
  @action("perfcounters")
  @list
  listPerfMonCounters is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<PerfMonCounterCollection>,
    Parameters = {
      /**
       * Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
       */
      @query("$filter")
      $filter?: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets web app's event logs.
   */
  @summary("Gets web app's event logs.")
  @get
  @action("phplogging")
  getSitePhpErrorLogFlag is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<SitePhpErrorLogFlag>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the premier add-ons of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the premier add-ons of an app.")
  @get
  @action("premieraddons")
  listPremierAddOns is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<PremierAddOn>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the private link resources
   */
  @summary("Gets the private link resources")
  @get
  @action("privateLinkResources")
  getPrivateLinkResources is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<PrivateLinkResourcesWrapper>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the publishing profile for an app (or deployment slot, if specified).
   */
  @summary("Gets the publishing profile for an app (or deployment slot, if specified).")
  @action("publishxml")
  listPublishingProfileXmlWithSecrets is SiteOps.ActionSync<
    Site,
    CsmPublishingProfileOptions,
    {
      @header("Content-Type")
      contentType: "application/xml";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.
   */
  @summary("Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.")
  @action("resetSlotConfig")
  resetProductionSlotConfig is SiteOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Restarts an app (or deployment slot, if specified).
   */
  @summary("Restarts an app (or deployment slot, if specified).")
  restart is SiteOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    Parameters = {
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Restores an app from a backup blob in Azure Storage.
   */
  @summary("Restores an app from a backup blob in Azure Storage.")
  restoreFromBackupBlob is SiteOps.ActionAsync<
    Site,
    RestoreRequest,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Description for Restores a deleted web app to this web app.
   */
  @summary("Restores a deleted web app to this web app.")
  restoreFromDeletedApp is SiteOps.ActionAsync<
    Site,
    DeletedAppRestoreRequest,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Description for Restores a web app from a snapshot.
   */
  @summary("Restores a web app from a snapshot.")
  restoreSnapshot is SiteOps.ActionAsync<
    Site,
    SnapshotRestoreRequest,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Description for Get the difference in configuration settings between two web app slots.
   */
  @summary("Get the difference in configuration settings between two web app slots.")
  @action("slotsdiffs")
  @list
  listSlotDifferencesFromProduction is SiteOps.ActionSync<
    Site,
    CsmSlotEntity,
    ArmResponse<SlotDifferenceCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Swaps two deployment slots of an app.
   */
  @summary("Swaps two deployment slots of an app.")
  @action("slotsswap")
  swapSlotWithProduction is SiteOps.ActionAsync<
    Site,
    CsmSlotEntity,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Description for Returns all Snapshots to the user.
   */
  @summary("Returns all Snapshots to the user.")
  @get
  @action("snapshots")
  @list
  listSnapshots is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<SnapshotCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Returns all Snapshots to the user from DRSecondary endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Returns all Snapshots to the user from DRSecondary endpoint.")
  @get
  @list
  @action("snapshotsdr")
  listSnapshotsFromDRSecondary is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<SnapshotCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Starts an app (or deployment slot, if specified).
   */
  @summary("Starts an app (or deployment slot, if specified).")
  start is ArmResourceActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Start capturing network packets for the site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Start capturing network packets for the site.")
  @operationId("WebApps_StartNetworkTrace")
  startNetworkTrace is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<NetworkTrace[]> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NetworkTrace[]> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      @identifiers(#[])
      _?: NetworkTrace[];
    }),
    Parameters = {
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Stops an app (or deployment slot, if specified).
   */
  @summary("Stops an app (or deployment slot, if specified).")
  @action("stop")
  stop is SiteOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Stop ongoing capturing network packets for the site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Stop ongoing capturing network packets for the site.")
  stopNetworkTrace is SiteOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    } | NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Sync web app repository.
   */
  @summary("Sync web app repository.")
  @action("sync")
  syncRepository is SiteOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Syncs function trigger metadata to the management database
   */
  @summary("Syncs function trigger metadata to the management database")
  @action("syncfunctiontriggers")
  syncFunctionTriggers is SiteOps.ActionSync<
    Site,
    void,
    NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the quota usage information of an app (or deployment slot, if specified).
   */
  @summary("Gets the quota usage information of an app (or deployment slot, if specified).")
  @get
  @action("usages")
  @list
  listUsages is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<CsmUsageQuotaCollection>,
    Parameters = {
      /**
       * Return only information specified in the filter (using OData syntax). For example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
       */
      @query("$filter")
      $filter?: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates the artifacts for web site, or a deployment slot.
   */
  @summary("Creates the artifacts for web site, or a deployment slot.")
  deployWorkflowArtifacts is SiteOps.ActionSync<
    Site,
    WorkflowArtifacts,
    {
      @body body: void;
    },
    OptionalRequestBody = true,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Lists logic app's connections for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Lists logic app's connections for web site, or a deployment slot.")
  listWorkflowsConnections is SiteOps.ActionSync<
    Site,
    void,
    ArmResponse<WorkflowEnvelope>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Regenerates the callback URL access key for request triggers.
   */
  regenerateAccessKey is WorkflowRegenerateAccessKeyOps.ActionSync<
    Site,
    RegenerateActionParameter,
    {
      @body body: void;
    },
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Validates the workflow definition.
   */
  validate is WorkflowRegenerateAccessKeyOps.ActionSync<
    Site,
    Workflow,
    {
      @body body: void;
    },
    OverrideErrorType = ErrorResponse
  >;
}

@armResourceOperations
interface WebAppOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Name of the deployment slot. By default, this API returns the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      }
    > {}

alias ActionParameterSlotWebAppOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** Name of the app. */
    @path
    @segment("sites")
    @key
    name: string;
  },
  {
    /** Name of the deployment slot. By default, this API returns the production slot. */
    @path
    @segment("slots")
    @key
    slot: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/slots",
  }
>;

alias ActionParameterSiteWebAppOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** Name of the app. */
    @path
    @segment("sites")
    @key
    name: string;
  },
  {},
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface WebApps {
  @summary("Gets an app's deployment slots.")
  @doc("Description for Gets an app's deployment slots.")
  listSlots is WebAppOps.List<
    Site,
    Response = ArmResponse<WebAppCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the details of a web, mobile, or API app.
   */
  @summary("Gets the details of a web, mobile, or API app.")
  getSlot is WebAppOps.Read<
    Site,
    Response = ArmResponse<Site> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
  createOrUpdateSlot is WebAppOps.CreateOrUpdateAsync<
    Site,
    Response = ArmResourceUpdatedResponse<Site> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Site>> & {
      @bodyRoot
      _: Site;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.")
  @patch(#{ implicitOptionality: false })
  updateSlot is WebAppOps.CustomPatchSync<
    Site,
    PatchModel = SitePatchResource,
    Response = ArmResponse<Site> | (AcceptedResponse & {
      @bodyRoot
      _: Site;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a web, mobile, or API app, or one of the deployment slots.
   */
  @summary("Deletes a web, mobile, or API app, or one of the deployment slots.")
  deleteSlot is WebAppOps.DeleteSync<
    Site,
    Parameters = {
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
    },
    Response = {
      @body body: void;
    } | NoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets all web, mobile, and API apps in the specified resource group.
   */
  @summary("Gets all web, mobile, and API apps in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Site,
    Parameters = {
      /**
       * Specify <strong>true</strong> to include deployment slots in results. The default is false, which only gives you the production slot of all apps.
       */
      @query("includeSlots")
      includeSlots?: boolean;
    },
    Response = ArmResponse<WebAppCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Analyze a custom hostname.
   */
  @summary("Analyze a custom hostname.")
  @get
  @action("analyzeCustomHostname")
  analyzeCustomHostnameSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<CustomHostnameAnalysisResult>,
    Parameters = {
      /**
       * Custom hostname.
       */
      @query("hostName")
      hostName?: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Applies the configuration settings from the target slot onto the current slot.
   */
  @summary("Applies the configuration settings from the target slot onto the current slot.")
  @action("applySlotConfig")
  applySlotConfigurationSlot is WebAppOps.ActionSync<
    Site,
    CsmSlotEntity,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a backup of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a backup of an app.")
  @action("backup")
  backupSlot is WebAppOps.ActionSync<
    Site,
    BackupRequest,
    ArmResponse<BackupItem>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Replaces the application settings of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Replaces the application settings of an app.")
  @put
  @action("config/appsettings")
  updateApplicationSettingsSlot is WebAppOps.ActionSync<
    Site,
    StringDictionary,
    ArmResponse<StringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the application settings of an app.
   */
  @summary("Gets the application settings of an app.")
  @action("config/appsettings/list")
  listApplicationSettingsSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<StringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates the Authentication / Authorization settings associated with web app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates the Authentication / Authorization settings associated with web app.")
  @put
  @action("config/authsettings")
  updateAuthSettingsSlot is WebAppOps.ActionSync<
    Site,
    SiteAuthSettings,
    ArmResponse<SiteAuthSettings>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the Authentication/Authorization settings of an app.
   */
  @summary("Gets the Authentication/Authorization settings of an app.")
  @action("config/authsettings/list")
  getAuthSettingsSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<SiteAuthSettings>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates the Azure storage account configurations of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates the Azure storage account configurations of an app.")
  @put
  @action("config/azurestorageaccounts")
  updateAzureStorageAccountsSlot is WebAppOps.ActionSync<
    Site,
    AzureStoragePropertyDictionaryResource,
    ArmResponse<AzureStoragePropertyDictionaryResource>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the Azure storage account configurations of an app.
   */
  @summary("Gets the Azure storage account configurations of an app.")
  @action("config/azurestorageaccounts/list")
  listAzureStorageAccountsSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<AzureStoragePropertyDictionaryResource>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates the backup configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates the backup configuration of an app.")
  @put
  @action("config/backup")
  updateBackupConfigurationSlot is WebAppOps.ActionSync<
    Site,
    BackupRequest,
    ArmResponse<BackupRequest>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes the backup configuration of an app.
   */
  @summary("Deletes the backup configuration of an app.")
  @delete
  @action("config/backup")
  deleteBackupConfigurationSlot is WebAppOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the backup configuration of an app.
   */
  @summary("Gets the backup configuration of an app.")
  @action("config/backup/list")
  getBackupConfigurationSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<BackupRequest>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Replaces the connection strings of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Replaces the connection strings of an app.")
  @put
  @action("config/connectionstrings")
  updateConnectionStringsSlot is WebAppOps.ActionSync<
    Site,
    ConnectionStringDictionary,
    ArmResponse<ConnectionStringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the connection strings of an app.
   */
  @summary("Gets the connection strings of an app.")
  @action("config/connectionstrings/list")
  listConnectionStringsSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<ConnectionStringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Replaces the metadata of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Replaces the metadata of an app.")
  @put
  @action("config/metadata")
  updateMetadataSlot is WebAppOps.ActionSync<
    Site,
    StringDictionary,
    ArmResponse<StringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the metadata of an app.
   */
  @summary("Gets the metadata of an app.")
  @action("config/metadata/list")
  listMetadataSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<StringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the Git/FTP publishing credentials of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the Git/FTP publishing credentials of an app.")
  @action("config/publishingcredentials/list")
  listPublishingCredentialsSlot is Azure.ResourceManager.ArmResourceActionAsyncBase<
    Site,
    void,
    ArmResponse<User> & ArmLroLocationHeader<FinalResult = User>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Site>,
    Parameters = {
      /**
       * If true, the password is included in the response. The default is false.
       */
      @segment("slots")
      @path
      slot: string;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Updates the Push settings associated with web app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates the Push settings associated with web app.")
  @put
  @action("config/pushsettings")
  updateSitePushSettingsSlot is WebAppOps.ActionSync<
    Site,
    PushSettings,
    ArmResponse<PushSettings>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the Push settings associated with web app.
   */
  @summary("Gets the Push settings associated with web app.")
  @action("config/pushsettings/list")
  listSitePushSettingsSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<PushSettings>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the last lines of docker logs for the given site
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the last lines of docker logs for the given site")
  @action("containerlogs")
  getWebSiteContainerLogsSlot is WebAppOps.ActionSync<
    Site,
    void,
    {
      @header("Content-Type")
      contentType: "application/octet-stream";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    } | NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the ZIP archived docker log files for the given site
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the ZIP archived docker log files for the given site")
  @action("containerlogs/zip/download")
  getContainerLogsZipSlot is WebAppOps.ActionSync<
    Site,
    void,
    {
      @header("Content-Type")
      contentType: "application/zip";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    } | NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.
   */
  @summary("Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.")
  @action("discoverbackup")
  discoverBackupSlot is WebAppOps.ActionSync<
    Site,
    RestoreRequest,
    ArmResponse<RestoreRequest>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Fetch a short lived token that can be exchanged for a master key.
   */
  @summary("Fetch a short lived token that can be exchanged for a master key.")
  @get
  @action("functions/admin/token")
  getFunctionsAdminTokenSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<stringApplicationJson>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get host secrets for a function app.
   */
  @summary("Get host secrets for a function app.")
  @action("host/default/listkeys")
  listHostKeysSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<HostKeys>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for This is to allow calling via powershell and ARM template.
   */
  @summary("This is to allow calling via powershell and ARM template.")
  @action("host/default/listsyncstatus")
  listSyncStatusSlot is WebAppOps.ActionSync<
    Site,
    void,
    NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Syncs function trigger metadata to the management database
   */
  @summary("Syncs function trigger metadata to the management database")
  @action("host/default/sync")
  syncFunctionsSlot is WebAppOps.ActionSync<
    Site,
    void,
    NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Add or update a host level secret.
   */
  @summary("Add or update a host level secret.")
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/slots/{slot}/host/default/{keyType}/{keyName}")
  createOrUpdateHostSecretSlot is ActionParameterSlotWebAppOps.ActionSync<
    Site,
    KeyInfo,
    Parameters = {
      /**
       * The type of host key.
       */
      @path
      keyType: string;

      /**
       * The name of the key.
       */
      @path
      keyName: string;
    },
    Response = ArmResponse<KeyInfo> | ArmResourceCreatedSyncResponse<KeyInfo> | DefaultErrorResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a host level secret.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a host level secret.")
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/slots/{slot}/host/default/{keyType}/{keyName}")
  deleteHostSecretSlot is ActionParameterSlotWebAppOps.ActionSync<
    Site,
    void,
    Parameters = {
      /**
       * The type of host key.
       */
      @path
      keyType: string;

      /**
       * The name of the key.
       */
      @path
      keyName: string;
    },
    Response = NoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Retrieves all Service Bus Hybrid Connections used by this Web App.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Retrieves all Service Bus Hybrid Connections used by this Web App.")
  @get
  @action("hybridConnectionRelays")
  listHybridConnectionsSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<HybridConnection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets hybrid connections configured for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets hybrid connections configured for an app (or deployment slot, if specified).")
  @get
  @action("hybridconnection")
  listRelayServiceConnectionsSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<RelayServiceConnectionEntity>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Shows whether an app can be cloned to another resource group or subscription.
   */
  @summary("Shows whether an app can be cloned to another resource group or subscription.")
  @action("iscloneable")
  isCloneableSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<SiteCloneability>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets existing backups of an app.
   */
  @summary("Gets existing backups of an app.")
  @list
  @action("listbackups")
  listSiteBackupsSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<BackupItemCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for This is to allow calling via powershell and ARM template.
   */
  @summary("This is to allow calling via powershell and ARM template.")
  @action("listsyncfunctiontriggerstatus")
  listSyncFunctionTriggersSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<FunctionSecrets>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/slots/{slot}/networkTrace/operationresults/{operationId}")
  getNetworkTraceOperationSlot is ActionParameterSlotWebAppOps.ActionSync<
    Site,
    Request = void,
    Response = ArmResponse<NetworkTrace[]> | (AcceptedResponse & {
      @identifiers(#[])
      @bodyRoot
      _: NetworkTrace[];
    }),
    Parameters = {
      /**
       * GUID of the operation.
       */
      @path
      operationId: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Start capturing network packets for the site (To be deprecated).
   */
  @summary("Start capturing network packets for the site (To be deprecated).")
  @action("networkTrace/start")
  startWebSiteNetworkTraceSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<stringApplicationJson>,
    Parameters = {
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Start capturing network packets for the site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Start capturing network packets for the site.")
  @action("networkTrace/startOperation")
  startWebSiteNetworkTraceOperationSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<NetworkTrace[]> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NetworkTrace[]>> & {
      @bodyRoot
      @identifiers(#[])
      _?: NetworkTrace[];
    }),
    Parameters = {
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Stop ongoing capturing network packets for the site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Stop ongoing capturing network packets for the site.")
  @action("networkTrace/stop")
  stopWebSiteNetworkTraceSlot is WebAppOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    } | NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/slots/{slot}/networkTrace/{operationId}")
  getNetworkTracesSlot is ActionParameterSlotWebAppOps.ActionSync<
    Site,
    Request = void,
    Response = ArmResponse<NetworkTrace[]>,
    Parameters = {
      /** GUID of the operation. */
      @path
      operationId: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/slots/{slot}/networkTraces/current/operationresults/{operationId}")
  getNetworkTraceOperationSlotV2 is ActionParameterSlotWebAppOps.ActionSync<
    Site,
    Request = void,
    Response = ArmResponse<NetworkTrace[]> | (AcceptedResponse & {
      @identifiers(#[])
      @bodyRoot
      _: NetworkTrace[];
    }),
    Parameters = {
      /**
       * GUID of the operation.
       */
      @path
      operationId: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
   */
  @summary("Gets a named operation for a network trace capturing (or deployment slot, if specified).")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/sites/{name}/slots/{slot}/networkTraces/{operationId}")
  getNetworkTracesSlotV2 is ActionParameterSlotWebAppOps.ActionSync<
    Site,
    Request = void,
    Response = ArmResponse<NetworkTrace[]>,
    Parameters = {
      /** GUID of the operation. */
      @path
      operationId: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Generates a new publishing password for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Generates a new publishing password for an app (or deployment slot, if specified).")
  @action("newpassword")
  generateNewSitePublishingPasswordSlot is WebAppOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    } | NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets perfmon counters for web app.
   */
  @summary("Gets perfmon counters for web app.")
  @get
  @action("perfcounters")
  @list
  listPerfMonCountersSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<PerfMonCounterCollection>,
    Parameters = {
      /**
       * Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
       */
      @query("$filter")
      $filter?: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets web app's event logs.
   */
  @summary("Gets web app's event logs.")
  @get
  @action("phplogging")
  getSitePhpErrorLogFlagSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<SitePhpErrorLogFlag>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the premier add-ons of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the premier add-ons of an app.")
  @get
  @action("premieraddons")
  listPremierAddOnsSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<PremierAddOn>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the private link resources
   */
  @summary("Gets the private link resources")
  @get
  @action("privateLinkResources")
  getPrivateLinkResourcesSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<PrivateLinkResourcesWrapper>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the publishing profile for an app (or deployment slot, if specified).
   */
  @summary("Gets the publishing profile for an app (or deployment slot, if specified).")
  @action("publishxml")
  listPublishingProfileXmlWithSecretsSlot is WebAppOps.ActionSync<
    Site,
    CsmPublishingProfileOptions,
    {
      @header("Content-Type")
      contentType: "application/xml";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.
   */
  @summary("Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.")
  @action("resetSlotConfig")
  resetSlotConfigurationSlot is WebAppOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Restarts an app (or deployment slot, if specified).
   */
  @summary("Restarts an app (or deployment slot, if specified).")
  @action("restart")
  restartSlot is WebAppOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    Parameters = {
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Restores an app from a backup blob in Azure Storage.
   */
  @summary("Restores an app from a backup blob in Azure Storage.")
  @action("restoreFromBackupBlob")
  restoreFromBackupBlobSlot is WebAppOps.ActionAsync<
    Site,
    RestoreRequest,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Description for Restores a deleted web app to this web app.
   */
  @summary("Restores a deleted web app to this web app.")
  @action("restoreFromDeletedApp")
  restoreFromDeletedAppSlot is WebAppOps.ActionAsync<
    Site,
    DeletedAppRestoreRequest,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Description for Restores a web app from a snapshot.
   */
  @summary("Restores a web app from a snapshot.")
  @action("restoreSnapshot")
  restoreSnapshotSlot is WebAppOps.ActionAsync<
    Site,
    SnapshotRestoreRequest,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Description for Get the difference in configuration settings between two web app slots.
   */
  @summary("Get the difference in configuration settings between two web app slots.")
  @action("slotsdiffs")
  @list
  listSlotDifferencesSlot is WebAppOps.ActionSync<
    Site,
    CsmSlotEntity,
    ArmResponse<SlotDifferenceCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Swaps two deployment slots of an app.
   */
  @summary("Swaps two deployment slots of an app.")
  @action("slotsswap")
  swapSlotSlot is WebAppOps.ActionAsync<
    Site,
    CsmSlotEntity,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Description for Returns all Snapshots to the user.
   */
  @summary("Returns all Snapshots to the user.")
  @get
  @action("snapshots")
  @list
  listSnapshotsSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<SnapshotCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Returns all Snapshots to the user from DRSecondary endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Returns all Snapshots to the user from DRSecondary endpoint.")
  @get
  @list
  @action("snapshotsdr")
  listSnapshotsFromDRSecondarySlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<SnapshotCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Starts an app (or deployment slot, if specified).
   */
  @summary("Starts an app (or deployment slot, if specified).")
  @action("start")
  startSlot is WebAppOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Start capturing network packets for the site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Start capturing network packets for the site.")
  @action("startNetworkTrace")
  startNetworkTraceSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<NetworkTrace[]> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NetworkTrace[]> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      @identifiers(#[])
      _?: NetworkTrace[];
    }),
    Parameters = {
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Stops an app (or deployment slot, if specified).
   */
  @summary("Stops an app (or deployment slot, if specified).")
  @action("stop")
  stopSlot is WebAppOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Stop ongoing capturing network packets for the site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Stop ongoing capturing network packets for the site.")
  @action("stopNetworkTrace")
  stopNetworkTraceSlot is WebAppOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    } | NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Sync web app repository.
   */
  @summary("Sync web app repository.")
  @action("sync")
  syncRepositorySlot is WebAppOps.ActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Syncs function trigger metadata to the management database
   */
  @summary("Syncs function trigger metadata to the management database")
  @action("syncfunctiontriggers")
  syncFunctionTriggersSlot is WebAppOps.ActionSync<
    Site,
    void,
    NoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the quota usage information of an app (or deployment slot, if specified).
   */
  @summary("Gets the quota usage information of an app (or deployment slot, if specified).")
  @get
  @action("usages")
  @list
  listUsagesSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<CsmUsageQuotaCollection>,
    Parameters = {
      /**
       * Return only information specified in the filter (using OData syntax). For example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
       */
      @query("$filter")
      $filter?: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates the artifacts for web site, or a deployment slot.
   */
  @summary("Creates the artifacts for web site, or a deployment slot.")
  @action("deployWorkflowArtifacts")
  deployWorkflowArtifactsSlot is WebAppOps.ActionSync<
    Site,
    WorkflowArtifacts,
    {
      @body body: void;
    },
    OptionalRequestBody = true,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Lists logic app's connections for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Lists logic app's connections for web site, or a deployment slot.")
  @action("listWorkflowsConnections")
  listWorkflowsConnectionsSlot is WebAppOps.ActionSync<
    Site,
    void,
    ArmResponse<WorkflowEnvelope>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(Site.name, "Name of the app.");
@@doc(Site.properties, "Site resource specific properties");
@@doc(Sites.createOrUpdate::parameters.resource,
  "A JSON representation of the app properties. See example."
);
@@doc(Sites.update::parameters.properties,
  "A JSON representation of the app properties. See example."
);
@@doc(Sites.applySlotConfigToProduction::parameters.body,
  "JSON object that contains the target slot name. See example."
);
@@doc(Sites.backup::parameters.body,
  "Backup configuration. You can use the JSON response from the POST action as input here."
);
@@doc(Sites.updateApplicationSettings::parameters.body,
  "Application settings of the app."
);
@@doc(Sites.updateAuthSettings::parameters.body,
  "Auth settings associated with web app."
);
@@doc(Sites.updateAzureStorageAccounts::parameters.body,
  "Azure storage accounts of the app."
);
@@doc(Sites.updateBackupConfiguration::parameters.body,
  "Edited backup configuration."
);
@@doc(Sites.updateConnectionStrings::parameters.body,
  "Connection strings of the app or deployment slot. See example."
);
@@doc(Sites.updateMetadata::parameters.body,
  "Edited metadata of the app or deployment slot. See example."
);
@@doc(Sites.updateSitePushSettings::parameters.body,
  "Push settings associated with web app."
);
@@doc(Sites.discoverBackup::parameters.body,
  "A RestoreRequest object that includes Azure storage URL and blog name for discovery of backup."
);
@@doc(Sites.createOrUpdateHostSecret::parameters.body,
  "The key to create or update"
);
@@doc(Sites.migrateStorage::parameters.body, "Migration migrationOptions.");
@@doc(Sites.migrateMySql::parameters.body, "MySql migration options.");
@@doc(Sites.listPublishingProfileXmlWithSecrets::parameters.body,
  "Specifies publishingProfileOptions for publishing profile. For example, use {\" format\": \"FileZilla3\"} to get a FileZilla publishing profile."
);
@@doc(Sites.restoreFromBackupBlob::parameters.body,
  "Information on restore request ."
);
@@doc(Sites.restoreFromDeletedApp::parameters.body,
  "Deleted web app restore information."
);
@@doc(Sites.restoreSnapshot::parameters.body,
  "Snapshot restore settings. Snapshot information can be obtained by calling GetDeletedSites or GetSiteSnapshots API."
);
@@doc(Sites.listSlotDifferencesFromProduction::parameters.body,
  "JSON object that contains the target slot name. See example."
);
@@doc(Sites.swapSlotWithProduction::parameters.body,
  "JSON object that contains the target slot name. See example."
);
@@doc(Sites.deployWorkflowArtifacts::parameters.body,
  "Application settings and files of the workflow."
);
@@doc(Sites.regenerateAccessKey::parameters.body, "The access key type.");
@@doc(Sites.validate::parameters.body, "The workflow.");
@@doc(WebApps.createOrUpdateSlot::parameters.resource,
  "A JSON representation of the app properties. See example."
);
@@doc(WebApps.updateSlot::parameters.properties,
  "A JSON representation of the app properties. See example."
);
@@doc(WebApps.applySlotConfigurationSlot::parameters.body,
  "JSON object that contains the target slot name. See example."
);
@@doc(WebApps.backupSlot::parameters.body,
  "Backup configuration. You can use the JSON response from the POST action as input here."
);
@@doc(WebApps.updateApplicationSettingsSlot::parameters.body,
  "Application settings of the app."
);
@@doc(WebApps.updateAuthSettingsSlot::parameters.body,
  "Auth settings associated with web app."
);
@@doc(WebApps.updateAzureStorageAccountsSlot::parameters.body,
  "Azure storage accounts of the app."
);
@@doc(WebApps.updateBackupConfigurationSlot::parameters.body,
  "Edited backup configuration."
);
@@doc(WebApps.updateConnectionStringsSlot::parameters.body,
  "Connection strings of the app or deployment slot. See example."
);
@@doc(WebApps.updateMetadataSlot::parameters.body,
  "Edited metadata of the app or deployment slot. See example."
);
@@doc(WebApps.updateSitePushSettingsSlot::parameters.body,
  "Push settings associated with web app."
);
@@doc(WebApps.discoverBackupSlot::parameters.body,
  "A RestoreRequest object that includes Azure storage URL and blog name for discovery of backup."
);
@@doc(WebApps.createOrUpdateHostSecretSlot::parameters.body,
  "The key to create or update"
);
@@doc(WebApps.listPublishingProfileXmlWithSecretsSlot::parameters.body,
  "Specifies publishingProfileOptions for publishing profile. For example, use {\" format\": \"FileZilla3\"} to get a FileZilla publishing profile."
);
@@doc(WebApps.restoreFromBackupBlobSlot::parameters.body,
  "Information on restore request ."
);
@@doc(WebApps.restoreFromDeletedAppSlot::parameters.body,
  "Deleted web app restore information."
);
@@doc(WebApps.restoreSnapshotSlot::parameters.body,
  "Snapshot restore settings. Snapshot information can be obtained by calling GetDeletedSites or GetSiteSnapshots API."
);
@@doc(WebApps.listSlotDifferencesSlot::parameters.body,
  "JSON object that contains the target slot name. See example."
);
@@doc(WebApps.swapSlotSlot::parameters.body,
  "JSON object that contains the target slot name. See example."
);
@@doc(WebApps.deployWorkflowArtifactsSlot::parameters.body,
  "Application settings and files of the workflow."
);
