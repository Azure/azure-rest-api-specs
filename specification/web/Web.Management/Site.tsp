import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;


namespace Microsoft.CertificateRegistration;
/**
* A web app, a mobile app backend, or an API app.
*/
model Site is Azure.ResourceManager.TrackedResource<SiteProperties> {
...ResourceNameParameter<Resource = Site,KeyName = "name",SegmentName = "sites",NamePattern = "">
/**
* Managed service identity.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
"identity"?: ManagedServiceIdentity;
/**
* Extended Location.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
"extendedLocation"?: ExtendedLocation;
}



@armResourceOperations
interface SiteOps extends Azure.ResourceManager.Legacy.LegacyOperations<{...ApiVersionParameter;...SubscriptionIdParameter;...ResourceGroupParameter;...Azure.ResourceManager.Legacy.Provider}, KeysOf<ResourceNameParameter<
    Resource = Site,
    KeyName = "name",
    SegmentName = "sites",
    NamePattern = ""
  >>> {}


@armResourceOperations
interface Sites {
/**
* Description for Gets the details of a web, mobile, or API app.
*/
@operationId("WebApps_Get")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
get is SiteOps.Read<Site>;


/**
* Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
*/
@operationId("WebApps_CreateOrUpdate")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
createOrUpdate is SiteOps.CreateOrUpdateAsync<Site, Response = ArmResourceUpdatedResponse<Site> | ArmAcceptedLroResponse & { @bodyRoot
"_": Site; }, LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader>;


/**
* Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
*/
@patch(#{ implicitOptionality: false })
@operationId("WebApps_Update")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
update is SiteOps.CustomPatchSync<Site, PatchModel = SitePatchResource, Response = ArmResponse<Site> | AcceptedResponse & { @bodyRoot
"_": Site; }>;


/**
* Description for Deletes a web, mobile, or API app, or one of the deployment slots.
*/
@operationId("WebApps_Delete")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
delete is SiteOps.DeleteSync<Site, Parameters = { /**
* If true, web app metrics are also deleted.
*/
@query("deleteMetrics")
"deleteMetrics"?: boolean,
/**
* Specify false if you want to keep empty App Service plan. By default, empty App Service plan is deleted.
*/
@query("deleteEmptyServerFarm")
"deleteEmptyServerFarm"?: boolean }>;


/**
* Description for Get all apps for a subscription.
*/
@operationId("WebApps_List")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
list is SiteOps.ListBySubscription<Site, Response = ArmResponse<WebAppCollection>>;


/**
* Description for Get past recommendations for an app, optionally specified by the time range.
*/
@get
@action("recommendationHistory")
@operationId("Recommendations_ListHistoryForWebApp")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listHistoryForWebApp is SiteOps.ActionSync<Site, void, ArmResponse<RecommendationCollection>, Parameters = { /**
* Name of the app.
*/
@path
"siteName": string,
/**
* Specify <code>false</code> to return all recommendations. The default is <code>true</code>, which returns only expired recommendations.
*/
@query("expiredOnly")
"expiredOnly"?: boolean,
/**
* Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification' and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[PT1H|PT1M|P1D]
*/
@query("$filter")
"$filter"?: string }>;


/**
* Description for Get all recommendations for an app.
*/
@get
@action("recommendations")
@operationId("Recommendations_ListRecommendedRulesForWebApp")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listRecommendedRulesForWebApp is SiteOps.ActionSync<Site, void, ArmResponse<RecommendationCollection>, Parameters = { /**
* Name of the app.
*/
@path
"siteName": string,
/**
* Specify <code>true</code> to return only the most critical recommendations. The default is <code>false</code>, which returns all recommendations.
*/
@query("featured")
"featured"?: boolean,
/**
* Return only channels specified in the filter. Filter is specified by using OData syntax. Example: $filter=channel eq 'Api' or channel eq 'Notification'
*/
@query("$filter")
"$filter"?: string }>;


/**
* Description for Disable all recommendations for an app.
*/
@action("disable")
@operationId("Recommendations_DisableAllForWebApp")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
disableAllForWebApp is SiteOps.ActionSync<Site, void, NoContentResponse, Parameters = { /**
* Name of the app.
*/
@path
"siteName": string }>;


/**
* Description for Reset all recommendation opt-out settings for an app.
*/
@action("reset")
@operationId("Recommendations_ResetAllFiltersForWebApp")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
resetAllFiltersForWebApp is SiteOps.ActionSync<Site, void, NoContentResponse, Parameters = { /**
* Name of the app.
*/
@path
"siteName": string }>;


/**
* Description for Analyze a custom hostname.
*/
@get
@operationId("WebApps_AnalyzeCustomHostname")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
analyzeCustomHostname is SiteOps.ActionSync<Site, void, ArmResponse<CustomHostnameAnalysisResult>, Parameters = { /**
* Custom hostname.
*/
@query("hostName")
"hostName"?: string }>;


/**
* Description for Applies the configuration settings from the target slot onto the current slot.
*/
@action("applySlotConfig")
@operationId("WebApps_ApplySlotConfigToProduction")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
applySlotConfigToProduction is SiteOps.ActionSync<Site, CsmSlotEntity, OkResponse>;


/**
* Description for Creates a backup of an app.
*/
@operationId("WebApps_Backup")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
backup is SiteOps.ActionSync<Site, BackupRequest, ArmResponse<BackupItem>>;


/**
* Description for Replaces the application settings of an app.
*/
@put
@action("appsettings")
@operationId("WebApps_UpdateApplicationSettings")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
updateApplicationSettings is SiteOps.ActionSync<Site, StringDictionary, ArmResponse<StringDictionary>>;


/**
* Description for Gets the application settings of an app.
*/
@action("list")
@operationId("WebApps_ListApplicationSettings")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listApplicationSettings is SiteOps.ActionSync<Site, void, ArmResponse<StringDictionary>>;


/**
* Description for Updates the Authentication / Authorization settings associated with web app.
*/
@put
@action("authsettings")
@operationId("WebApps_UpdateAuthSettings")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
updateAuthSettings is SiteOps.ActionSync<Site, SiteAuthSettings, ArmResponse<SiteAuthSettings>>;


/**
* Description for Gets the Authentication/Authorization settings of an app.
*/
@action("list")
@operationId("WebApps_GetAuthSettings")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
getAuthSettings is SiteOps.ActionSync<Site, void, ArmResponse<SiteAuthSettings>>;


/**
* Description for Updates the Azure storage account configurations of an app.
*/
@put
@action("azurestorageaccounts")
@operationId("WebApps_UpdateAzureStorageAccounts")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
updateAzureStorageAccounts is SiteOps.ActionSync<Site, AzureStoragePropertyDictionaryResource, ArmResponse<AzureStoragePropertyDictionaryResource>>;


/**
* Description for Gets the Azure storage account configurations of an app.
*/
@action("list")
@operationId("WebApps_ListAzureStorageAccounts")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listAzureStorageAccounts is SiteOps.ActionSync<Site, void, ArmResponse<AzureStoragePropertyDictionaryResource>>;


/**
* Description for Updates the backup configuration of an app.
*/
@put
@action("backup")
@operationId("WebApps_UpdateBackupConfiguration")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
updateBackupConfiguration is SiteOps.ActionSync<Site, BackupRequest, ArmResponse<BackupRequest>>;


/**
* Description for Deletes the backup configuration of an app.
*/
@delete
@action("backup")
@operationId("WebApps_DeleteBackupConfiguration")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
deleteBackupConfiguration is SiteOps.ActionSync<Site, void, OkResponse>;


/**
* Description for Gets the backup configuration of an app.
*/
@action("list")
@operationId("WebApps_GetBackupConfiguration")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
getBackupConfiguration is SiteOps.ActionSync<Site, void, ArmResponse<BackupRequest>>;


/**
* Description for Replaces the connection strings of an app.
*/
@put
@action("connectionstrings")
@operationId("WebApps_UpdateConnectionStrings")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
updateConnectionStrings is SiteOps.ActionSync<Site, ConnectionStringDictionary, ArmResponse<ConnectionStringDictionary>>;


/**
* Description for Gets the connection strings of an app.
*/
@action("list")
@operationId("WebApps_ListConnectionStrings")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listConnectionStrings is SiteOps.ActionSync<Site, void, ArmResponse<ConnectionStringDictionary>>;


/**
* Description for Replaces the metadata of an app.
*/
@put
@action("metadata")
@operationId("WebApps_UpdateMetadata")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
updateMetadata is SiteOps.ActionSync<Site, StringDictionary, ArmResponse<StringDictionary>>;


/**
* Description for Gets the metadata of an app.
*/
@action("list")
@operationId("WebApps_ListMetadata")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listMetadata is SiteOps.ActionSync<Site, void, ArmResponse<StringDictionary>>;


/**
* Description for Gets the Git/FTP publishing credentials of an app.
*/
@action("list")
@operationId("WebApps_ListPublishingCredentials")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listPublishingCredentials is SiteOps.ActionAsyncBase<Site, void, ArmResponse<User>, BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Site>>;


/**
* Description for Updates the Push settings associated with web app.
*/
@put
@action("pushsettings")
@operationId("WebApps_UpdateSitePushSettings")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
updateSitePushSettings is SiteOps.ActionSync<Site, PushSettings, ArmResponse<PushSettings>>;


/**
* Description for Gets the Push settings associated with web app.
*/
@action("list")
@operationId("WebApps_ListSitePushSettings")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listSitePushSettings is SiteOps.ActionSync<Site, void, ArmResponse<PushSettings>>;


/**
* Description for Gets the last lines of docker logs for the given site
*/
@action("containerlogs")
@operationId("WebApps_GetWebSiteContainerLogs")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
getWebSiteContainerLogs is SiteOps.ActionSync<Site, void, OkResponse | NoContentResponse>;


/**
* Description for Gets the ZIP archived docker log files for the given site
*/
@action("download")
@operationId("WebApps_GetContainerLogsZip")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
getContainerLogsZip is SiteOps.ActionSync<Site, void, OkResponse | NoContentResponse>;


/**
* Description for Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.
*/
@action("discoverbackup")
@operationId("WebApps_DiscoverBackup")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
discoverBackup is SiteOps.ActionSync<Site, RestoreRequest, ArmResponse<RestoreRequest>>;


/**
* Description for Invoke onedeploy status API /api/deployments and gets the deployment status for the site
*/
@get
@action("onedeploy")
@operationId("WebApps_GetOneDeployStatus")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
getOneDeployStatus is SiteOps.ActionSync<Site, void, ArmResponse<AnyObject>>;


/**
* Description for Invoke the OneDeploy publish web app extension.
*/
@put
@action("onedeploy")
@operationId("WebApps_CreateOneDeployOperation")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
createOneDeployOperation is SiteOps.ActionSync<Site, void, ArmResponse<AnyObject>>;


/**
* Description for Fetch a short lived token that can be exchanged for a master key.
*/
@get
@action("token")
@operationId("WebApps_GetFunctionsAdminToken")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
getFunctionsAdminToken is SiteOps.ActionSync<Site, void, ArmResponse<string>>;


/**
* Description for Get host secrets for a function app.
*/
@action("listkeys")
@operationId("WebApps_ListHostKeys")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listHostKeys is SiteOps.ActionSync<Site, void, ArmResponse<HostKeys>>;


/**
* Description for This is to allow calling via powershell and ARM template.
*/
@action("listsyncstatus")
@operationId("WebApps_ListSyncStatus")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listSyncStatus is SiteOps.ActionSync<Site, void, NoContentResponse>;


/**
* Description for Syncs function trigger metadata to the management database
*/
@action("sync")
@operationId("WebApps_SyncFunctions")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
syncFunctions is SiteOps.ActionSync<Site, void, NoContentResponse>;


/**
* Description for Add or update a host level secret.
*/
@put
@action("{keyName}")
@operationId("WebApps_CreateOrUpdateHostSecret")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
createOrUpdateHostSecret is SiteOps.ActionSync<Site, KeyInfo, ArmResponse<KeyInfo> | ArmResourceCreatedSyncResponse<KeyInfo>, Parameters = { /**
* The type of host key.
*/
@path
"keyType": string,
/**
* The name of the key.
*/
@path
"keyName": string }>;


/**
* Description for Delete a host level secret.
*/
@delete
@action("{keyName}")
@operationId("WebApps_DeleteHostSecret")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
deleteHostSecret is SiteOps.ActionSync<Site, void, NoContentResponse, Parameters = { /**
* The type of host key.
*/
@path
"keyType": string,
/**
* The name of the key.
*/
@path
"keyName": string }>;


/**
* Description for Retrieves all Service Bus Hybrid Connections used by this Web App.
*/
@get
@action("hybridConnectionRelays")
@operationId("WebApps_ListHybridConnections")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listHybridConnections is SiteOps.ActionSync<Site, void, ArmResponse<HybridConnection>>;


/**
* Description for Gets hybrid connections configured for an app (or deployment slot, if specified).
*/
@get
@action("hybridconnection")
@operationId("WebApps_ListRelayServiceConnections")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listRelayServiceConnections is SiteOps.ActionSync<Site, void, ArmResponse<RelayServiceConnectionEntity>>;


/**
* Description for Shows whether an app can be cloned to another resource group or subscription.
*/
@action("iscloneable")
@operationId("WebApps_IsCloneable")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
isCloneable is SiteOps.ActionSync<Site, void, ArmResponse<SiteCloneability>>;


/**
* Description for Gets existing backups of an app.
*/
@action("listbackups")
@operationId("WebApps_ListSiteBackups")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listSiteBackups is SiteOps.ActionSync<Site, void, ArmResponse<BackupItemCollection>>;


/**
* Description for This is to allow calling via powershell and ARM template.
*/
@action("listsyncfunctiontriggerstatus")
@operationId("WebApps_ListSyncFunctionTriggers")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listSyncFunctionTriggers is SiteOps.ActionSync<Site, void, ArmResponse<FunctionSecrets>>;


/**
* Updates the machine key of an app.
*/
@action("updatemachinekey")
@operationId("WebApps_UpdateMachineKey")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
updateMachineKey is SiteOps.ActionSync<Site, void, ArmResponse<AnyObject>>;


/**
* Description for Restores a web app.
*/
@put
@action("migrate")
@operationId("WebApps_MigrateStorage")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
migrateStorage is SiteOps.ActionAsyncBase<Site, StorageMigrationOptions, ArmResponse<StorageMigrationResponse>, BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Site>, Parameters = { /**
* Azure subscription.
*/
@query("subscriptionName")
"subscriptionName": string }>;


/**
* Description for Migrates a local (in-app) MySql database to a remote MySql database.
*/
@action("migratemysql")
@operationId("WebApps_MigrateMySql")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
migrateMySql is SiteOps.ActionAsyncBase<Site, MigrateMySqlRequest, ArmResponse<Operation>, BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Site>>;


/**
* Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
*/
@get
@action("{operationId}")
@operationId("WebApps_GetNetworkTraceOperation")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
getNetworkTraceOperation is SiteOps.ActionSync<Site, void, ArmResponse<NetworkTrace[]> | AcceptedResponse & { @bodyRoot
"_": paths·vfwt7g·subscriptions-subscriptionid-resourcegroups-resourcegroupname-providers-microsoft-web-sites-name-networktrace-operationresults-operationid·get·responses·202·content·application-json·schema; }, Parameters = { /**
* GUID of the operation.
*/
@path
"operationId": string }>;


/**
* Description for Start capturing network packets for the site (To be deprecated).
*/
@action("start")
@operationId("WebApps_StartWebSiteNetworkTrace")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
startWebSiteNetworkTrace is SiteOps.ActionSync<Site, void, ArmResponse<string>, Parameters = { /**
* The duration to keep capturing in seconds.
*/
@query("durationInSeconds")
"durationInSeconds"?: int32,
/**
* The maximum frame length in bytes (Optional).
*/
@query("maxFrameLength")
"maxFrameLength"?: int32,
/**
* The Blob URL to store capture file.
*/
@query("sasUrl")
"sasUrl"?: string }>;


/**
* Description for Start capturing network packets for the site.
*/
@action("startOperation")
@operationId("WebApps_StartWebSiteNetworkTraceOperation")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
startWebSiteNetworkTraceOperation is SiteOps.ActionAsync<Site, void, ArmResponse<NetworkTrace[]>, Parameters = { /**
* The duration to keep capturing in seconds.
*/
@query("durationInSeconds")
"durationInSeconds"?: int32,
/**
* The maximum frame length in bytes (Optional).
*/
@query("maxFrameLength")
"maxFrameLength"?: int32,
/**
* The Blob URL to store capture file.
*/
@query("sasUrl")
"sasUrl"?: string }>;


/**
* Description for Stop ongoing capturing network packets for the site.
*/
@action("stop")
@operationId("WebApps_StopWebSiteNetworkTrace")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
stopWebSiteNetworkTrace is SiteOps.ActionSync<Site, void, OkResponse | NoContentResponse>;


/**
* Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
*/
@get
@action("{operationId}")
@operationId("WebApps_GetNetworkTraces")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
getNetworkTraces is SiteOps.ActionSync<Site, void, ArmResponse<NetworkTrace[]>, Parameters = { /**
* GUID of the operation.
*/
@path
"operationId": string }>;


/**
* Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
*/
@get
@action("{operationId}")
@operationId("WebApps_GetNetworkTraceOperationV2")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
getNetworkTraceOperationV2 is SiteOps.ActionSync<Site, void, ArmResponse<NetworkTrace[]> | AcceptedResponse & { @bodyRoot
"_": paths·chvwy·subscriptions-subscriptionid-resourcegroups-resourcegroupname-providers-microsoft-web-sites-name-networktraces-current-operationresults-operationid·get·responses·202·content·application-json·schema; }, Parameters = { /**
* GUID of the operation.
*/
@path
"operationId": string }>;


/**
* Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
*/
@get
@action("{operationId}")
@operationId("WebApps_GetNetworkTracesV2")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
getNetworkTracesV2 is SiteOps.ActionSync<Site, void, ArmResponse<NetworkTrace[]>, Parameters = { /**
* GUID of the operation.
*/
@path
"operationId": string }>;


/**
* Description for Generates a new publishing password for an app (or deployment slot, if specified).
*/
@action("newpassword")
@operationId("WebApps_GenerateNewSitePublishingPassword")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
generateNewSitePublishingPassword is SiteOps.ActionSync<Site, void, OkResponse | NoContentResponse>;


/**
* Description for Gets perfmon counters for web app.
*/
@get
@action("perfcounters")
@operationId("WebApps_ListPerfMonCounters")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listPerfMonCounters is SiteOps.ActionSync<Site, void, ArmResponse<PerfMonCounterCollection>, Parameters = { /**
* Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
*/
@query("$filter")
"$filter"?: string }>;


/**
* Description for Gets web app's event logs.
*/
@get
@action("phplogging")
@operationId("WebApps_GetSitePhpErrorLogFlag")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
getSitePhpErrorLogFlag is SiteOps.ActionSync<Site, void, ArmResponse<SitePhpErrorLogFlag>>;


/**
* Description for Gets the premier add-ons of an app.
*/
@get
@action("premieraddons")
@operationId("WebApps_ListPremierAddOns")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listPremierAddOns is SiteOps.ActionSync<Site, void, ArmResponse<PremierAddOn>>;


/**
* Description for Gets the private link resources
*/
@get
@action("privateLinkResources")
@operationId("WebApps_GetPrivateLinkResources")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
getPrivateLinkResources is SiteOps.ActionSync<Site, void, ArmResponse<PrivateLinkResourcesWrapper>>;


/**
* Description for Gets the publishing profile for an app (or deployment slot, if specified).
*/
@action("publishxml")
@operationId("WebApps_ListPublishingProfileXmlWithSecrets")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listPublishingProfileXmlWithSecrets is SiteOps.ActionSync<Site, CsmPublishingProfileOptions, OkResponse>;


/**
* Description for Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.
*/
@action("resetSlotConfig")
@operationId("WebApps_ResetProductionSlotConfig")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
resetProductionSlotConfig is SiteOps.ActionSync<Site, void, OkResponse>;


/**
* Description for Restarts an app (or deployment slot, if specified).
*/
@operationId("WebApps_Restart")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
restart is SiteOps.ActionSync<Site, void, OkResponse, Parameters = { /**
* Specify true to apply the configuration settings and restarts the app only if necessary. By default, the API always restarts and reprovisions the app.
*/
@query("softRestart")
"softRestart"?: boolean,
/**
* Specify true to block until the app is restarted. By default, it is set to false, and the API responds immediately (asynchronous).
*/
@query("synchronous")
"synchronous"?: boolean }>;


/**
* Description for Restores an app from a backup blob in Azure Storage.
*/
@operationId("WebApps_RestoreFromBackupBlob")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
restoreFromBackupBlob is SiteOps.ActionAsync<Site, RestoreRequest, OkResponse>;


/**
* Description for Restores a deleted web app to this web app.
*/
@operationId("WebApps_RestoreFromDeletedApp")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
restoreFromDeletedApp is SiteOps.ActionAsync<Site, DeletedAppRestoreRequest, OkResponse>;


/**
* Description for Restores a web app from a snapshot.
*/
@operationId("WebApps_RestoreSnapshot")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
restoreSnapshot is SiteOps.ActionAsync<Site, SnapshotRestoreRequest, OkResponse>;


/**
* Description for Get the difference in configuration settings between two web app slots.
*/
@action("slotsdiffs")
@operationId("WebApps_ListSlotDifferencesFromProduction")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listSlotDifferencesFromProduction is SiteOps.ActionSync<Site, CsmSlotEntity, ArmResponse<SlotDifferenceCollection>>;


/**
* Description for Swaps two deployment slots of an app.
*/
@action("slotsswap")
@operationId("WebApps_SwapSlotWithProduction")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
swapSlotWithProduction is SiteOps.ActionAsync<Site, CsmSlotEntity, OkResponse>;


/**
* Description for Returns all Snapshots to the user.
*/
@get
@action("snapshots")
@operationId("WebApps_ListSnapshots")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listSnapshots is SiteOps.ActionSync<Site, void, ArmResponse<SnapshotCollection>>;


/**
* Description for Returns all Snapshots to the user from DRSecondary endpoint.
*/
@get
@action("snapshotsdr")
@operationId("WebApps_ListSnapshotsFromDRSecondary")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listSnapshotsFromDRSecondary is SiteOps.ActionSync<Site, void, ArmResponse<SnapshotCollection>>;


/**
* Description for Starts an app (or deployment slot, if specified).
*/
@operationId("WebApps_Start")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
start is SiteOps.ActionSync<Site, void, OkResponse>;


/**
* Description for Start capturing network packets for the site.
*/
@operationId("WebApps_StartNetworkTrace")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
startNetworkTrace is SiteOps.ActionAsync<Site, void, ArmResponse<NetworkTrace[]>, Parameters = { /**
* The duration to keep capturing in seconds.
*/
@query("durationInSeconds")
"durationInSeconds"?: int32,
/**
* The maximum frame length in bytes (Optional).
*/
@query("maxFrameLength")
"maxFrameLength"?: int32,
/**
* The Blob URL to store capture file.
*/
@query("sasUrl")
"sasUrl"?: string }>;


/**
* Description for Stops an app (or deployment slot, if specified).
*/
@operationId("WebApps_Stop")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
stop is SiteOps.ActionSync<Site, void, OkResponse>;


/**
* Description for Stop ongoing capturing network packets for the site.
*/
@operationId("WebApps_StopNetworkTrace")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
stopNetworkTrace is SiteOps.ActionSync<Site, void, OkResponse | NoContentResponse>;


/**
* Description for Sync web app repository.
*/
@action("sync")
@operationId("WebApps_SyncRepository")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
syncRepository is SiteOps.ActionSync<Site, void, OkResponse>;


/**
* Description for Syncs function trigger metadata to the management database
*/
@action("syncfunctiontriggers")
@operationId("WebApps_SyncFunctionTriggers")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
syncFunctionTriggers is SiteOps.ActionSync<Site, void, NoContentResponse>;


/**
* Description for Gets the quota usage information of an app (or deployment slot, if specified).
*/
@get
@action("usages")
@operationId("WebApps_ListUsages")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listUsages is SiteOps.ActionSync<Site, void, ArmResponse<CsmUsageQuotaCollection>, Parameters = { /**
* Return only information specified in the filter (using OData syntax). For example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
*/
@query("$filter")
"$filter"?: string }>;


/**
* Description for Creates the artifacts for web site, or a deployment slot.
*/
@operationId("WebApps_DeployWorkflowArtifacts")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
deployWorkflowArtifacts is SiteOps.ActionSync<Site, {/**
* Application settings and files of the workflow.
*/
@bodyRoot
"workflowArtifacts"?: WorkflowArtifacts}, OkResponse>;


/**
* Lists logic app's connections for web site, or a deployment slot.
*/
@operationId("WebApps_ListWorkflowsConnections")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listWorkflowsConnections is SiteOps.ActionSync<Site, void, ArmResponse<WorkflowEnvelope>>;


/**
* Regenerates the callback URL access key for request triggers.
*/
@operationId("Workflows_RegenerateAccessKey")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
regenerateAccessKey is SiteOps.ActionSync<Site, RegenerateActionParameter, OkResponse, Parameters = { /**
* The workflow name.
*/
@path
"workflowName": string }>;


/**
* Validates the workflow definition.
*/
@operationId("Workflows_Validate")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
validate is SiteOps.ActionSync<Site, Workflow, OkResponse, Parameters = { /**
* The workflow name.
*/
@path
"workflowName": string }>;


}
@armResourceOperations
interface WebAppOps extends Azure.ResourceManager.Legacy.LegacyOperations<{...ApiVersionParameter;...SubscriptionIdParameter;...ResourceGroupParameter;...Azure.ResourceManager.Legacy.Provider;...KeysOf<ResourceNameParameter<
    Resource = Site,
    KeyName = "name",
    SegmentName = "sites",
    NamePattern = ""
  >>}, KeysOf<ResourceNameParameter<
    Resource = Site,
    KeyName = "slot",
    SegmentName = "slots",
    NamePattern = ""
  >>> {}


@armResourceOperations
interface WebApps {
/**
* Description for Gets the details of a web, mobile, or API app.
*/
getSlot is WebAppOps.Read<Site>;


/**
* Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
createOrUpdateSlot is WebAppOps.CreateOrUpdateAsync<Site, Response = ArmResourceUpdatedResponse<Site> | ArmAcceptedLroResponse & { @bodyRoot
"_": Site; }, LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader>;


/**
* Description for Creates a new web, mobile, or API app in an existing resource group, or updates an existing app.
*/
@patch(#{ implicitOptionality: false })
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
updateSlot is WebAppOps.CustomPatchSync<Site, PatchModel = SitePatchResource, Response = ArmResponse<Site> | AcceptedResponse & { @bodyRoot
"_": Site; }>;


/**
* Description for Deletes a web, mobile, or API app, or one of the deployment slots.
*/
deleteSlot is WebAppOps.DeleteSync<Site, Parameters = { /**
* If true, web app metrics are also deleted.
*/
@query("deleteMetrics")
"deleteMetrics"?: boolean,
/**
* Specify false if you want to keep empty App Service plan. By default, empty App Service plan is deleted.
*/
@query("deleteEmptyServerFarm")
"deleteEmptyServerFarm"?: boolean }>;


/**
* Description for Gets all web, mobile, and API apps in the specified resource group.
*/
listByResourceGroup is WebAppOps.List<Site, Parameters = { /**
* Specify <strong>true</strong> to include deployment slots in results. The default is false, which only gives you the production slot of all apps.
*/
@query("includeSlots")
"includeSlots"?: boolean }, Response = ArmResponse<WebAppCollection>>;


/**
* Description for Analyze a custom hostname.
*/
@get
@action("analyzeCustomHostname")
analyzeCustomHostnameSlot is WebAppOps.ActionSync<Site, void, ArmResponse<CustomHostnameAnalysisResult>, Parameters = { /**
* Custom hostname.
*/
@query("hostName")
"hostName"?: string }>;


/**
* Description for Applies the configuration settings from the target slot onto the current slot.
*/
@action("applySlotConfig")
applySlotConfigurationSlot is WebAppOps.ActionSync<Site, CsmSlotEntity, OkResponse>;


/**
* Description for Creates a backup of an app.
*/
@action("backup")
backupSlot is WebAppOps.ActionSync<Site, BackupRequest, ArmResponse<BackupItem>>;


/**
* Description for Replaces the application settings of an app.
*/
@put
@action("appsettings")
updateApplicationSettingsSlot is WebAppOps.ActionSync<Site, StringDictionary, ArmResponse<StringDictionary>>;


/**
* Description for Gets the application settings of an app.
*/
@action("list")
listApplicationSettingsSlot is WebAppOps.ActionSync<Site, void, ArmResponse<StringDictionary>>;


/**
* Description for Updates the Authentication / Authorization settings associated with web app.
*/
@put
@action("authsettings")
updateAuthSettingsSlot is WebAppOps.ActionSync<Site, SiteAuthSettings, ArmResponse<SiteAuthSettings>>;


/**
* Description for Gets the Authentication/Authorization settings of an app.
*/
@action("list")
getAuthSettingsSlot is WebAppOps.ActionSync<Site, void, ArmResponse<SiteAuthSettings>>;


/**
* Description for Updates the Azure storage account configurations of an app.
*/
@put
@action("azurestorageaccounts")
updateAzureStorageAccountsSlot is WebAppOps.ActionSync<Site, AzureStoragePropertyDictionaryResource, ArmResponse<AzureStoragePropertyDictionaryResource>>;


/**
* Description for Gets the Azure storage account configurations of an app.
*/
@action("list")
listAzureStorageAccountsSlot is WebAppOps.ActionSync<Site, void, ArmResponse<AzureStoragePropertyDictionaryResource>>;


/**
* Description for Updates the backup configuration of an app.
*/
@put
@action("backup")
updateBackupConfigurationSlot is WebAppOps.ActionSync<Site, BackupRequest, ArmResponse<BackupRequest>>;


/**
* Description for Deletes the backup configuration of an app.
*/
@delete
@action("backup")
deleteBackupConfigurationSlot is WebAppOps.ActionSync<Site, void, OkResponse>;


/**
* Description for Gets the backup configuration of an app.
*/
@action("list")
getBackupConfigurationSlot is WebAppOps.ActionSync<Site, void, ArmResponse<BackupRequest>>;


/**
* Description for Replaces the connection strings of an app.
*/
@put
@action("connectionstrings")
updateConnectionStringsSlot is WebAppOps.ActionSync<Site, ConnectionStringDictionary, ArmResponse<ConnectionStringDictionary>>;


/**
* Description for Gets the connection strings of an app.
*/
@action("list")
listConnectionStringsSlot is WebAppOps.ActionSync<Site, void, ArmResponse<ConnectionStringDictionary>>;


/**
* Description for Replaces the metadata of an app.
*/
@put
@action("metadata")
updateMetadataSlot is WebAppOps.ActionSync<Site, StringDictionary, ArmResponse<StringDictionary>>;


/**
* Description for Gets the metadata of an app.
*/
@action("list")
listMetadataSlot is WebAppOps.ActionSync<Site, void, ArmResponse<StringDictionary>>;


/**
* Description for Gets the Git/FTP publishing credentials of an app.
*/
@action("list")
listPublishingCredentialsSlot is WebAppOps.ActionAsyncBase<Site, void, ArmResponse<User>, BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Site>>;


/**
* Description for Updates the Push settings associated with web app.
*/
@put
@action("pushsettings")
updateSitePushSettingsSlot is WebAppOps.ActionSync<Site, PushSettings, ArmResponse<PushSettings>>;


/**
* Description for Gets the Push settings associated with web app.
*/
@action("list")
listSitePushSettingsSlot is WebAppOps.ActionSync<Site, void, ArmResponse<PushSettings>>;


/**
* Description for Gets the last lines of docker logs for the given site
*/
@action("containerlogs")
getWebSiteContainerLogsSlot is WebAppOps.ActionSync<Site, void, OkResponse | NoContentResponse>;


/**
* Description for Gets the ZIP archived docker log files for the given site
*/
@action("download")
getContainerLogsZipSlot is WebAppOps.ActionSync<Site, void, OkResponse | NoContentResponse>;


/**
* Description for Discovers an existing app backup that can be restored from a blob in Azure storage. Use this to get information about the databases stored in a backup.
*/
@action("discoverbackup")
discoverBackupSlot is WebAppOps.ActionSync<Site, RestoreRequest, ArmResponse<RestoreRequest>>;


/**
* Description for Fetch a short lived token that can be exchanged for a master key.
*/
@get
@action("token")
getFunctionsAdminTokenSlot is WebAppOps.ActionSync<Site, void, ArmResponse<string>>;


/**
* Description for Get host secrets for a function app.
*/
@action("listkeys")
listHostKeysSlot is WebAppOps.ActionSync<Site, void, ArmResponse<HostKeys>>;


/**
* Description for This is to allow calling via powershell and ARM template.
*/
@action("listsyncstatus")
listSyncStatusSlot is WebAppOps.ActionSync<Site, void, NoContentResponse>;


/**
* Description for Syncs function trigger metadata to the management database
*/
@action("sync")
syncFunctionsSlot is WebAppOps.ActionSync<Site, void, NoContentResponse>;


/**
* Description for Add or update a host level secret.
*/
@put
@action("{keyName}")
createOrUpdateHostSecretSlot is WebAppOps.ActionSync<Site, KeyInfo, ArmResponse<KeyInfo> | ArmResourceCreatedSyncResponse<KeyInfo>, Parameters = { /**
* The type of host key.
*/
@path
"keyType": string,
/**
* The name of the key.
*/
@path
"keyName": string }>;


/**
* Description for Delete a host level secret.
*/
@delete
@action("{keyName}")
deleteHostSecretSlot is WebAppOps.ActionSync<Site, void, NoContentResponse, Parameters = { /**
* The type of host key.
*/
@path
"keyType": string,
/**
* The name of the key.
*/
@path
"keyName": string }>;


/**
* Description for Retrieves all Service Bus Hybrid Connections used by this Web App.
*/
@get
@action("hybridConnectionRelays")
listHybridConnectionsSlot is WebAppOps.ActionSync<Site, void, ArmResponse<HybridConnection>>;


/**
* Description for Gets hybrid connections configured for an app (or deployment slot, if specified).
*/
@get
@action("hybridconnection")
listRelayServiceConnectionsSlot is WebAppOps.ActionSync<Site, void, ArmResponse<RelayServiceConnectionEntity>>;


/**
* Description for Shows whether an app can be cloned to another resource group or subscription.
*/
@action("iscloneable")
isCloneableSlot is WebAppOps.ActionSync<Site, void, ArmResponse<SiteCloneability>>;


/**
* Description for Gets existing backups of an app.
*/
@action("listbackups")
listSiteBackupsSlot is WebAppOps.ActionSync<Site, void, ArmResponse<BackupItemCollection>>;


/**
* Description for This is to allow calling via powershell and ARM template.
*/
@action("listsyncfunctiontriggerstatus")
listSyncFunctionTriggersSlot is WebAppOps.ActionSync<Site, void, ArmResponse<FunctionSecrets>>;


/**
* Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
*/
@get
@action("{operationId}")
getNetworkTraceOperationSlot is WebAppOps.ActionSync<Site, void, ArmResponse<NetworkTrace[]> | AcceptedResponse & { @bodyRoot
"_": paths·fho602·subscriptions-subscriptionid-resourcegroups-resourcegroupname-providers-microsoft-web-sites-name-slots-slot-networktrace-operationresults-operationid·get·responses·202·content·application-json·schema; }, Parameters = { /**
* GUID of the operation.
*/
@path
"operationId": string }>;


/**
* Description for Start capturing network packets for the site (To be deprecated).
*/
@action("start")
startWebSiteNetworkTraceSlot is WebAppOps.ActionSync<Site, void, ArmResponse<string>, Parameters = { /**
* The duration to keep capturing in seconds.
*/
@query("durationInSeconds")
"durationInSeconds"?: int32,
/**
* The maximum frame length in bytes (Optional).
*/
@query("maxFrameLength")
"maxFrameLength"?: int32,
/**
* The Blob URL to store capture file.
*/
@query("sasUrl")
"sasUrl"?: string }>;


/**
* Description for Start capturing network packets for the site.
*/
@action("startOperation")
startWebSiteNetworkTraceOperationSlot is WebAppOps.ActionAsync<Site, void, ArmResponse<NetworkTrace[]>, Parameters = { /**
* The duration to keep capturing in seconds.
*/
@query("durationInSeconds")
"durationInSeconds"?: int32,
/**
* The maximum frame length in bytes (Optional).
*/
@query("maxFrameLength")
"maxFrameLength"?: int32,
/**
* The Blob URL to store capture file.
*/
@query("sasUrl")
"sasUrl"?: string }>;


/**
* Description for Stop ongoing capturing network packets for the site.
*/
@action("stop")
stopWebSiteNetworkTraceSlot is WebAppOps.ActionSync<Site, void, OkResponse | NoContentResponse>;


/**
* Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
*/
@get
@action("{operationId}")
getNetworkTracesSlot is WebAppOps.ActionSync<Site, void, ArmResponse<NetworkTrace[]>, Parameters = { /**
* GUID of the operation.
*/
@path
"operationId": string }>;


/**
* Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
*/
@get
@action("{operationId}")
getNetworkTraceOperationSlotV2 is WebAppOps.ActionSync<Site, void, ArmResponse<NetworkTrace[]> | AcceptedResponse & { @bodyRoot
"_": paths·nokhyf·subscriptions-subscriptionid-resourcegroups-resourcegroupname-providers-microsoft-web-sites-name-slots-slot-networktraces-current-operationresults-operationid·get·responses·202·content·application-json·schema; }, Parameters = { /**
* GUID of the operation.
*/
@path
"operationId": string }>;


/**
* Description for Gets a named operation for a network trace capturing (or deployment slot, if specified).
*/
@get
@action("{operationId}")
getNetworkTracesSlotV2 is WebAppOps.ActionSync<Site, void, ArmResponse<NetworkTrace[]>, Parameters = { /**
* GUID of the operation.
*/
@path
"operationId": string }>;


/**
* Description for Generates a new publishing password for an app (or deployment slot, if specified).
*/
@action("newpassword")
generateNewSitePublishingPasswordSlot is WebAppOps.ActionSync<Site, void, OkResponse | NoContentResponse>;


/**
* Description for Gets perfmon counters for web app.
*/
@get
@action("perfcounters")
listPerfMonCountersSlot is WebAppOps.ActionSync<Site, void, ArmResponse<PerfMonCounterCollection>, Parameters = { /**
* Return only usages/metrics specified in the filter. Filter conforms to odata syntax. Example: $filter=(startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
*/
@query("$filter")
"$filter"?: string }>;


/**
* Description for Gets web app's event logs.
*/
@get
@action("phplogging")
getSitePhpErrorLogFlagSlot is WebAppOps.ActionSync<Site, void, ArmResponse<SitePhpErrorLogFlag>>;


/**
* Description for Gets the premier add-ons of an app.
*/
@get
@action("premieraddons")
listPremierAddOnsSlot is WebAppOps.ActionSync<Site, void, ArmResponse<PremierAddOn>>;


/**
* Description for Gets the private link resources
*/
@get
@action("privateLinkResources")
getPrivateLinkResourcesSlot is WebAppOps.ActionSync<Site, void, ArmResponse<PrivateLinkResourcesWrapper>>;


/**
* Description for Gets the publishing profile for an app (or deployment slot, if specified).
*/
@action("publishxml")
listPublishingProfileXmlWithSecretsSlot is WebAppOps.ActionSync<Site, CsmPublishingProfileOptions, OkResponse>;


/**
* Description for Resets the configuration settings of the current slot if they were previously modified by calling the API with POST.
*/
@action("resetSlotConfig")
resetSlotConfigurationSlot is WebAppOps.ActionSync<Site, void, OkResponse>;


/**
* Description for Restarts an app (or deployment slot, if specified).
*/
@action("restart")
restartSlot is WebAppOps.ActionSync<Site, void, OkResponse, Parameters = { /**
* Specify true to apply the configuration settings and restarts the app only if necessary. By default, the API always restarts and reprovisions the app.
*/
@query("softRestart")
"softRestart"?: boolean,
/**
* Specify true to block until the app is restarted. By default, it is set to false, and the API responds immediately (asynchronous).
*/
@query("synchronous")
"synchronous"?: boolean }>;


/**
* Description for Restores an app from a backup blob in Azure Storage.
*/
@action("restoreFromBackupBlob")
restoreFromBackupBlobSlot is WebAppOps.ActionAsync<Site, RestoreRequest, OkResponse>;


/**
* Description for Restores a deleted web app to this web app.
*/
@action("restoreFromDeletedApp")
restoreFromDeletedAppSlot is WebAppOps.ActionAsync<Site, DeletedAppRestoreRequest, OkResponse>;


/**
* Description for Restores a web app from a snapshot.
*/
@action("restoreSnapshot")
restoreSnapshotSlot is WebAppOps.ActionAsync<Site, SnapshotRestoreRequest, OkResponse>;


/**
* Description for Get the difference in configuration settings between two web app slots.
*/
@action("slotsdiffs")
listSlotDifferencesSlot is WebAppOps.ActionSync<Site, CsmSlotEntity, ArmResponse<SlotDifferenceCollection>>;


/**
* Description for Swaps two deployment slots of an app.
*/
@action("slotsswap")
swapSlotSlot is WebAppOps.ActionAsync<Site, CsmSlotEntity, OkResponse>;


/**
* Description for Returns all Snapshots to the user.
*/
@get
@action("snapshots")
listSnapshotsSlot is WebAppOps.ActionSync<Site, void, ArmResponse<SnapshotCollection>>;


/**
* Description for Returns all Snapshots to the user from DRSecondary endpoint.
*/
@get
@action("snapshotsdr")
@operationId("WebApps_ListSnapshotsFromDRSecondarySlot")
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
listSnapshotsFromDRSecondarySlot is WebAppOps.ActionSync<Site, void, ArmResponse<SnapshotCollection>>;


/**
* Description for Starts an app (or deployment slot, if specified).
*/
@action("start")
startSlot is WebAppOps.ActionSync<Site, void, OkResponse>;


/**
* Description for Start capturing network packets for the site.
*/
@action("startNetworkTrace")
startNetworkTraceSlot is WebAppOps.ActionAsync<Site, void, ArmResponse<NetworkTrace[]>, Parameters = { /**
* The duration to keep capturing in seconds.
*/
@query("durationInSeconds")
"durationInSeconds"?: int32,
/**
* The maximum frame length in bytes (Optional).
*/
@query("maxFrameLength")
"maxFrameLength"?: int32,
/**
* The Blob URL to store capture file.
*/
@query("sasUrl")
"sasUrl"?: string }>;


/**
* Description for Stops an app (or deployment slot, if specified).
*/
@action("stop")
stopSlot is WebAppOps.ActionSync<Site, void, OkResponse>;


/**
* Description for Stop ongoing capturing network packets for the site.
*/
@action("stopNetworkTrace")
stopNetworkTraceSlot is WebAppOps.ActionSync<Site, void, OkResponse | NoContentResponse>;


/**
* Description for Sync web app repository.
*/
@action("sync")
syncRepositorySlot is WebAppOps.ActionSync<Site, void, OkResponse>;


/**
* Description for Syncs function trigger metadata to the management database
*/
@action("syncfunctiontriggers")
syncFunctionTriggersSlot is WebAppOps.ActionSync<Site, void, NoContentResponse>;


/**
* Description for Gets the quota usage information of an app (or deployment slot, if specified).
*/
@get
@action("usages")
listUsagesSlot is WebAppOps.ActionSync<Site, void, ArmResponse<CsmUsageQuotaCollection>, Parameters = { /**
* Return only information specified in the filter (using OData syntax). For example: $filter=(name.value eq 'Metric1' or name.value eq 'Metric2') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration'[Hour|Minute|Day]'.
*/
@query("$filter")
"$filter"?: string }>;


/**
* Description for Creates the artifacts for web site, or a deployment slot.
*/
@action("deployWorkflowArtifacts")
deployWorkflowArtifactsSlot is WebAppOps.ActionSync<Site, {/**
* Application settings and files of the workflow.
*/
@bodyRoot
"workflowArtifacts"?: WorkflowArtifacts}, OkResponse>;


/**
* Lists logic app's connections for web site, or a deployment slot.
*/
@action("listWorkflowsConnections")
listWorkflowsConnectionsSlot is WebAppOps.ActionSync<Site, void, ArmResponse<WorkflowEnvelope>>;


}


@@doc(Site.name, "Name of the app.")
@@doc(Site.properties, "Site resource specific properties")
@@doc(Sites.`createOrUpdate`::parameters.resource, "A JSON representation of the app properties. See example.");
@@doc(Sites.`update`::parameters.properties, "A JSON representation of the app properties. See example.");
@@doc(Sites.`applySlotConfigToProduction`::parameters.body, "JSON object that contains the target slot name. See example.");
@@doc(Sites.`backup`::parameters.body, "Backup configuration. You can use the JSON response from the POST action as input here.");
@@doc(Sites.`updateApplicationSettings`::parameters.body, "Application settings of the app.");
@@doc(Sites.`updateAuthSettings`::parameters.body, "Auth settings associated with web app.");
@@doc(Sites.`updateAzureStorageAccounts`::parameters.body, "Azure storage accounts of the app.");
@@doc(Sites.`updateBackupConfiguration`::parameters.body, "Edited backup configuration.");
@@doc(Sites.`updateConnectionStrings`::parameters.body, "Connection strings of the app or deployment slot. See example.");
@@doc(Sites.`updateMetadata`::parameters.body, "Edited metadata of the app or deployment slot. See example.");
@@doc(Sites.`updateSitePushSettings`::parameters.body, "Push settings associated with web app.");
@@doc(Sites.`discoverBackup`::parameters.body, "A RestoreRequest object that includes Azure storage URL and blog name for discovery of backup.");
@@doc(Sites.`createOrUpdateHostSecret`::parameters.body, "The key to create or update");
@@doc(Sites.`migrateStorage`::parameters.body, "Migration migrationOptions.");
@@doc(Sites.`migrateMySql`::parameters.body, "MySql migration options.");
@@doc(Sites.`listPublishingProfileXmlWithSecrets`::parameters.body, "Specifies publishingProfileOptions for publishing profile. For example, use {"format": "FileZilla3"} to get a FileZilla publishing profile.");
@@doc(Sites.`restoreFromBackupBlob`::parameters.body, "Information on restore request .");
@@doc(Sites.`restoreFromDeletedApp`::parameters.body, "Deleted web app restore information.");
@@doc(Sites.`restoreSnapshot`::parameters.body, "Snapshot restore settings. Snapshot information can be obtained by calling GetDeletedSites or GetSiteSnapshots API.");
@@doc(Sites.`listSlotDifferencesFromProduction`::parameters.body, "JSON object that contains the target slot name. See example.");
@@doc(Sites.`swapSlotWithProduction`::parameters.body, "JSON object that contains the target slot name. See example.");
@@doc(Sites.`regenerateAccessKey`::parameters.body, "The access key type.");
@@doc(Sites.`validate`::parameters.body, "The workflow.");
@@doc(WebApps.`createOrUpdateSlot`::parameters.resource, "A JSON representation of the app properties. See example.");
@@doc(WebApps.`updateSlot`::parameters.properties, "A JSON representation of the app properties. See example.");
@@doc(WebApps.`applySlotConfigurationSlot`::parameters.body, "JSON object that contains the target slot name. See example.");
@@doc(WebApps.`backupSlot`::parameters.body, "Backup configuration. You can use the JSON response from the POST action as input here.");
@@doc(WebApps.`updateApplicationSettingsSlot`::parameters.body, "Application settings of the app.");
@@doc(WebApps.`updateAuthSettingsSlot`::parameters.body, "Auth settings associated with web app.");
@@doc(WebApps.`updateAzureStorageAccountsSlot`::parameters.body, "Azure storage accounts of the app.");
@@doc(WebApps.`updateBackupConfigurationSlot`::parameters.body, "Edited backup configuration.");
@@doc(WebApps.`updateConnectionStringsSlot`::parameters.body, "Connection strings of the app or deployment slot. See example.");
@@doc(WebApps.`updateMetadataSlot`::parameters.body, "Edited metadata of the app or deployment slot. See example.");
@@doc(WebApps.`updateSitePushSettingsSlot`::parameters.body, "Push settings associated with web app.");
@@doc(WebApps.`discoverBackupSlot`::parameters.body, "A RestoreRequest object that includes Azure storage URL and blog name for discovery of backup.");
@@doc(WebApps.`createOrUpdateHostSecretSlot`::parameters.body, "The key to create or update");
@@doc(WebApps.`listPublishingProfileXmlWithSecretsSlot`::parameters.body, "Specifies publishingProfileOptions for publishing profile. For example, use {"format": "FileZilla3"} to get a FileZilla publishing profile.");
@@doc(WebApps.`restoreFromBackupBlobSlot`::parameters.body, "Information on restore request .");
@@doc(WebApps.`restoreFromDeletedAppSlot`::parameters.body, "Deleted web app restore information.");
@@doc(WebApps.`restoreSnapshotSlot`::parameters.body, "Snapshot restore settings. Snapshot information can be obtained by calling GetDeletedSites or GetSiteSnapshots API.");
@@doc(WebApps.`listSlotDifferencesSlot`::parameters.body, "JSON object that contains the target slot name. See example.");
@@doc(WebApps.`swapSlotSlot`::parameters.body, "JSON object that contains the target slot name. See example.");