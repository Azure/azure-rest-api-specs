import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;


namespace Azure.ResourceManager.OperationalInsights;

interface Operations extends Azure.ResourceManager.Operations {} 


    enum CreatedByType {
        "User", "Application", "ManagedIdentity", "Key"
    }

    enum OperationalInsightsDataExportDestinationType {
        "StorageAccount", "EventHub"
    }

    enum DataSourceKind {
        "WindowsEvent", "WindowsPerformanceCounter", "IISLogs", "LinuxSyslog", "LinuxSyslogCollection", "LinuxPerformanceObject", "LinuxPerformanceCollection", "CustomLog", "CustomLogCollection", "AzureAuditLog", "AzureActivityLog", "GenericDataSource", "ChangeTrackingCustomPath", "ChangeTrackingPath", "ChangeTrackingServices", "ChangeTrackingDataTypeConfiguration", "ChangeTrackingDefaultRegistry", "ChangeTrackingRegistry", "ChangeTrackingLinuxPath", "LinuxChangeTrackingPath", "ChangeTrackingContentLocation", "WindowsTelemetry", "Office365", "SecurityWindowsBaselineConfiguration", "SecurityCenterSecurityWindowsBaselineConfiguration", "SecurityEventCollectionConfiguration", "SecurityInsightsSecurityEventCollectionConfiguration", "ImportComputerGroup", "NetworkMonitoring", "Itsm", "DnsAnalytics", "ApplicationInsights", "SqlDataClassification"
    }

    enum LinkedServiceEntityStatus {
        "Succeeded", "Deleting", "ProvisioningAccount", "Updating"
    }

    enum StorageInsightState {
        "OK", "ERROR"
    }

    enum SkuNameEnum {
        "Free", "Standard", "Premium", "PerNode", "PerGB2018", "Standalone", "CapacityReservation"
    }

    enum SearchSortEnum {
        "asc", "desc"
    }

    enum PurgeState {
        "pending", "completed"
    }

    enum ClusterSkuNameEnum {
        "CapacityReservation"
    }

    enum ClusterEntityStatus {
        "Creating", "Succeeded", "Failed", "Canceled", "Deleting", "ProvisioningAccount", "Updating"
    }

    enum BillingType {
        "Cluster", "Workspaces"
    }

    enum WorkspaceEntityStatus {
        "Creating", "Succeeded", "Failed", "Canceled", "Deleting", "ProvisioningAccount", "Updating"
    }

    enum WorkspaceSkuNameEnum {
        "Free", "Standard", "Premium", "PerNode", "PerGB2018", "Standalone", "CapacityReservation", "LACluster"
    }

    enum DataIngestionStatus {
        @doc("Ingestion enabled following daily cap quota reset, or subscription enablement.")"RespectQuota", @doc("Ingestion started following service setting change.")"ForceOn", @doc("Ingestion stopped following service setting change.")"ForceOff", @doc("Reached daily cap quota, ingestion stopped.")"OverQuota", @doc("Ingestion stopped following suspended subscription.")"SubscriptionSuspended", @doc("80% of daily cap quota reached.")"ApproachingQuota"
    }

    enum PublicNetworkAccessType {
        @doc("Enables connectivity to Log Analytics through public DNS.")"Enabled", @doc("Disables public connectivity to Log Analytics through public DNS.")"Disabled"
    }

    enum TablePlanEnum {
        @doc("Logs  that are adjusted to support high volume low value verbose logs.")"Basic", @doc("Logs  that allow monitoring and analytics.")"Analytics"
    }

    enum ColumnTypeEnum {
        "string", "int", "long", "real", "boolean", "dateTime", "guid", "dynamic"
    }

    enum ColumnDataTypeHintEnum {
        @doc("A string that matches the pattern of a URI, for example, scheme://username:password@host:1234/this/is/a/path?k1=v1&k2=v2#fragment")"uri", @doc("A standard 128-bit GUID following the standard shape, xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")"guid", @doc("An Azure Resource Model (ARM) path: /subscriptions/{...}/resourceGroups/{...}/providers/Microsoft.{...}/{...}/{...}/{...}...")"armPath", @doc("A standard V4/V6 ip address following the standard shape, x.x.x.x/y:y:y:y:y:y:y:y")"ip"
    }

    enum SourceEnum {
        @doc("Tables provisioned by the system, as collected via Diagnostic Settings, the Agents, or any other standard data collection means.")"microsoft", @doc("Tables created by the owner of the Workspace, and only found in this Workspace.")"customer"
    }

    enum TableTypeEnum {
        @doc("Standard data collected by Azure Monitor.")"Microsoft", @doc("Custom log table.")"CustomLog", @doc("Restored data.")"RestoredLogs", @doc("Data collected by a search job.")"SearchResults"
    }

    enum TableSubTypeEnum {
        @doc("The default subtype with which built-in tables are created.")"Any", @doc("Indicates a table created through the Data Collector API or with the custom logs feature of the MMA agent, or any table against which Custom Fields were created.")"Classic", @doc("A table eligible to have data sent into it via any of the means supported by Data Collection Rules: the Data Collection Endpoint API, ingestion-time transformations, or any other mechanism provided by Data Collection Rules")"DataCollectionRuleBased"
    }

    enum ProvisioningStateEnum {
        @doc("Table schema is still being built and updated, table is currently locked for any changes till the procedure is done.")"Updating", @doc("Table schema is stable and without changes, table data is being updated.")"InProgress", @doc("Table state is stable and without changes, table is unlocked and open for new updates.")"Succeeded", @doc("Table state is deleting.")"Deleting"
    }
@Azure.Core.fixed
    enum DataSourceType {
        "CustomLogs", "AzureWatson", "Query", "Ingestion", "Alerts"
    }
@Azure.Core.fixed
    enum IdentityType {
        "SystemAssigned", "UserAssigned", "None"
    }
@Azure.Core.fixed
    enum Capacity {
        500: 500, 1000: 1000, 2000: 2000, 5000: 5000
    }
@Azure.Core.fixed
    enum CapacityReservationLevel {
        100: 100, 200: 200, 300: 300, 400: 400, 500: 500, 1000: 1000, 2000: 2000, 5000: 5000
    }



@doc("Properties that define a Log Analytics QueryPack resource.")
model LogAnalyticsQueryPackProperties {
@doc("The unique ID of your application. This field cannot be changed.")
@visibility("read")
"queryPackId"?: string;
@doc("Creation Date for the Log Analytics QueryPack, in ISO 8601 format.")
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"timeCreated"?: utcDateTime;
@doc("Last modified date of the Log Analytics QueryPack, in ISO 8601 format.")
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"timeModified"?: utcDateTime;
@doc("Current state of this QueryPack: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Succeeded, Deploying, Canceled, and Failed.")
@visibility("read")
"provisioningState"?: string;
}

@doc("An azure resource object")
model QueryPacksResource {
@doc("Azure resource Id")
@visibility("read")
"id"?: string;
@doc("Azure resource name")
@visibility("read")
"name"?: string;
@doc("Azure resource type")
@visibility("read")
"type"?: string;
@doc("Resource location")
@visibility("read", "create")
"location": string;
@doc("Resource tags")
"tags"?: Record<string>;
}

@doc("Properties that define an Log Analytics QueryPack-Query resource.")
model LogAnalyticsQueryPackQueryProperties {
@doc("The unique ID of your application. This field cannot be changed.")
@visibility("read")
"id"?: string;
@doc("Unique display name for your query within the Query Pack.")
"displayName": string;
@doc("Creation Date for the Log Analytics Query, in ISO 8601 format.")
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"timeCreated"?: utcDateTime;
@doc("Last modified date of the Log Analytics Query, in ISO 8601 format.")
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"timeModified"?: utcDateTime;
@doc("Object Id of user creating the query.")
@visibility("read")
"author"?: string;
@doc("Description of the query.")
"description"?: string;
@doc("Body of the query.")
"body": string;
@doc("The related metadata items for the function.")
"related"?: LogAnalyticsQueryPackQueryPropertiesRelated;
@doc("Tags associated with the query.")
"tags"?: Record<string[]>;
@doc("Additional properties that can be set for the query.")
"properties"?: Record<unknown>;
}

@doc("The related metadata items for the function.")
model LogAnalyticsQueryPackQueryPropertiesRelated {
@doc("The related categories for the function.")
"categories"?: string[];
@doc("The related resource types for the function.")
"resourceTypes"?: string[];
@doc("The related Log Analytics solutions for the function.")
"solutions"?: string[];
}

@doc("An Azure resource QueryPack-Query object")
model AzureResourceProperties {
@doc("Azure resource Id")
@visibility("read")
"id"?: string;
@doc("Azure resource name")
@visibility("read")
"name"?: string;
@doc("Azure resource type")
@visibility("read")
"type"?: string;
@doc("Read only system data")
@visibility("read")
"systemData"?: SystemData;
}

@doc("Properties that define an Log Analytics QueryPack-Query search properties.")
model LogAnalyticsQueryPackQuerySearchProperties {
@doc("The related metadata items for the function.")
"related"?: LogAnalyticsQueryPackQuerySearchPropertiesRelated;
@doc("Tags associated with the query.")
"tags"?: Record<string[]>;
}

@doc("The related metadata items for the function.")
model LogAnalyticsQueryPackQuerySearchPropertiesRelated {
@doc("The related categories for the function.")
"categories"?: string[];
@doc("The related resource types for the function.")
"resourceTypes"?: string[];
@doc("The related Log Analytics solutions for the function.")
"solutions"?: string[];
}

@doc("Data Export properties.")
model DataExportProperties {
@doc("The data export rule ID.")
"dataExportId"?: string;
@doc("An array of tables to export, for example: [“Heartbeat, SecurityEvent”].")
"tableNames": string[];
@doc("destination properties.")
"destination"?: Destination;
@doc("Active when enabled.")
"enable"?: boolean;
@doc("The latest data export rule modification time.")
"createdDate"?: string;
@doc("Date and time when the export was last modified.")
"lastModifiedDate"?: string;
}

@doc("Destination properties.")
model Destination {
@doc("The destination resource ID. This can be copied from the Properties entry of the destination resource in Azure.")
"resourceId": string;
@doc("The type of the destination resource")
@visibility("read")
@projectedName("json", "type")
"destinationType"?: OperationalInsightsDataExportDestinationType;
@doc("destination meta data.")
"metaData"?: DestinationMetaData;
}

@doc("Destination meta data.")
model DestinationMetaData {
@doc("Optional. Allows to define an Event Hub name. Not applicable when destination is Storage Account.")
"eventHubName"?: string;
}

@doc("Intelligence Pack containing a string name and boolean indicating if it's enabled.")
model IntelligencePack {
@doc("The name of the intelligence pack.")
"name"?: string;
@doc("The enabled boolean for the intelligence pack.")
"enabled"?: boolean;
@doc("The display name of the intelligence pack.")
"displayName"?: string;
}

@doc("Linked service properties.")
model LinkedServiceProperties {
@doc("The resource id of the resource that will be linked to the workspace. This should be used for linking resources which require read access")
"resourceId"?: string;
@doc("The resource id of the resource that will be linked to the workspace. This should be used for linking resources which require write access")
"writeAccessResourceId"?: string;
@doc("The provisioning state of the linked service.")
"provisioningState"?: LinkedServiceEntityStatus;
}

@doc("Linked storage accounts properties.")
model LinkedStorageAccountsProperties {
@doc("Linked storage accounts type.")
@visibility("read")
"dataSourceType"?: DataSourceType;
@doc("Linked storage accounts resources ids.")
"storageAccountIds"?: string[];
}

@doc("The list workspace management groups operation response.")
@pagedResult
model WorkspaceListManagementGroupsResult {
@doc("Gets or sets a list of management groups attached to the workspace.")
@items
"value"?: ManagementGroup[];
}

@doc("A management group that is connected to a workspace")
model ManagementGroup {
@doc("The properties of the management group.")
"properties"?: ManagementGroupProperties;
}

@doc("Management group properties.")
model ManagementGroupProperties {
@doc("The number of servers connected to the management group.")
"serverCount"?: int32;
@doc("Gets or sets a value indicating whether the management group is a gateway.")
"isGateway"?: boolean;
@doc("The name of the management group.")
"name"?: string;
@doc("The unique ID of the management group.")
"id"?: string;
@doc("The datetime that the management group was created.")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"created"?: utcDateTime;
@doc("The last datetime that the management group received data.")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"dataReceived"?: utcDateTime;
@doc("The version of System Center that is managing the management group.")
"version"?: string;
@doc("The SKU of System Center that is managing the management group.")
"sku"?: string;
}

@doc("The shared keys for a workspace.")
model SharedKeys {
@doc("The primary shared key of a workspace.")
"primarySharedKey"?: string;
@doc("The secondary shared key of a workspace.")
"secondarySharedKey"?: string;
}

@doc("The list workspace usages operation response.")
@pagedResult
model WorkspaceListUsagesResult {
@doc("Gets or sets a list of usage metrics for a workspace.")
@items
"value"?: UsageMetric[];
}

@doc("A metric describing the usage of a resource.")
model UsageMetric {
@doc("The name of the metric.")
"name"?: MetricName;
@doc("The units used for the metric.")
"unit"?: string;
@doc("The current value of the metric.")
"currentValue"?: float32;
@doc("The quota limit for the metric.")
"limit"?: float32;
@doc("The time that the metric's value will reset.")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"nextResetTime"?: utcDateTime;
@doc("The quota period that determines the length of time between value resets.")
"quotaPeriod"?: string;
}

@doc("The name of a metric.")
model MetricName {
@doc("The system name of the metric.")
"value"?: string;
@doc("The localized name of the metric.")
"localizedValue"?: string;
}

@doc("Storage insight properties.")
model StorageInsightProperties {
@doc("The names of the blob containers that the workspace should read")
"containers"?: string[];
@doc("The names of the Azure tables that the workspace should read")
"tables"?: string[];
@doc("The storage account connection details")
"storageAccount": StorageAccount;
@doc("The status of the storage insight")
@visibility("read")
"status"?: StorageInsightStatus;
}

@doc("Describes a storage account connection.")
model StorageAccount {
@doc("The Azure Resource Manager ID of the storage account resource.")
"id": string;
@doc("The storage account key.")
"key": string;
}

@doc("The status of the storage insight.")
model StorageInsightStatus {
@doc("The state of the storage insight connection to the workspace")
"state": StorageInsightState;
@doc("Description of the state of the storage insight.")
"description"?: string;
}

@doc("Value object for saved search results.")
model SavedSearchProperties {
@doc("The category of the saved search. This helps the user to find a saved search faster. ")
"category": string;
@doc("Saved search display name.")
"displayName": string;
@doc("The query expression for the saved search.")
"query": string;
@doc("The function alias if query serves as a function.")
"functionAlias"?: string;
@doc("The optional function parameters if query serves as a function. Value should be in the following format: 'param-name1:type1 = default_value1, param-name2:type2 = default_value2'. For more examples and proper syntax please refer to https://docs.microsoft.com/en-us/azure/kusto/query/functions/user-defined-functions.")
"functionParameters"?: string;
@doc("The version number of the query language. The current version is 2 and is the default.")
"version"?: int32;
@doc("The tags attached to the saved search.")
"tags"?: Tag[];
}

@doc("A tag of a saved search.")
model Tag {
@doc("The tag name.")
"name": string;
@doc("The tag value.")
"value": string;
}

@doc("Service Tier details.")
model AvailableServiceTier {
@doc("The name of the Service Tier.")
@visibility("read")
"serviceTier"?: SkuNameEnum;
@doc("True if the Service Tier is enabled for the workspace.")
@visibility("read")
"enabled"?: boolean;
@doc("The minimum retention for the Service Tier, in days.")
@visibility("read")
"minimumRetention"?: int32;
@doc("The maximum retention for the Service Tier, in days.")
@visibility("read")
"maximumRetention"?: int32;
@doc("The default retention for the Service Tier, in days.")
@visibility("read")
"defaultRetention"?: int32;
@doc("The capacity reservation level in GB per day. Returned for the Capacity Reservation Service Tier.")
@visibility("read")
"capacityReservationLevel"?: int32;
@doc("Time when the sku was last updated for the workspace. Returned for the Capacity Reservation Service Tier.")
@visibility("read")
"lastSkuUpdate"?: string;
}

@doc("The get schema operation response.")
model SearchGetSchemaResponse {
@doc("The metadata from search results.")
"metadata"?: SearchMetadata;
@doc("The array of result values.")
"value"?: SearchSchemaValue[];
}

@doc("Metadata for search results.")
model SearchMetadata {
@doc("The request id of the search.")
@projectedName("json", "requestId")
"searchId"?: string;
@doc("The search result type.")
"resultType"?: string;
@doc("The total number of search results.")
"total"?: int32;
@doc("The number of top search results.")
"top"?: int32;
@doc("The id of the search results request.")
"id"?: string;
@doc("The core summaries.")
"coreSummaries"?: CoreSummary[];
@doc("The status of the search results.")
"status"?: string;
@doc("The start time for the search.")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startTime"?: utcDateTime;
@doc("The time of last update.")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastUpdated"?: utcDateTime;
@doc("The ETag of the search results.")
"eTag"?: string;
@doc("How the results are sorted.")
"sort"?: SearchSort[];
@doc("The request time.")
"requestTime"?: int32;
@doc("The aggregated value field.")
"aggregatedValueField"?: string;
@doc("The aggregated grouping fields.")
"aggregatedGroupingFields"?: string;
@doc("The sum of all aggregates returned in the result set.")
"sum"?: int32;
@doc("The max of all aggregates returned in the result set.")
"max"?: int32;
@doc("The schema.")
"schema"?: SearchMetadataSchema;
}

@doc("The core summary of a search.")
model CoreSummary {
@doc("The status of a core summary.")
"status"?: string;
@doc("The number of documents of a core summary.")
"numberOfDocuments": int32;
}

@doc("The sort parameters for search.")
model SearchSort {
@doc("The name of the field the search query is sorted on.")
"name"?: string;
@doc("The sort order of the search.")
"order"?: SearchSortEnum;
}

@doc("Schema metadata for search.")
model SearchMetadataSchema {
@doc("The name of the metadata schema.")
"name"?: string;
@doc("The version of the metadata schema.")
"version"?: int32;
}

@doc("Value object for schema results.")
model SearchSchemaValue {
@doc("The name of the schema.")
"name"?: string;
@doc("The display name of the schema.")
"displayName"?: string;
@doc("The type.")
"type"?: string;
@doc("The boolean that indicates the field is searchable as free text.")
"indexed": boolean;
@doc("The boolean that indicates whether or not the field is stored.")
"stored": boolean;
@doc("The boolean that indicates whether or not the field is a facet.")
"facet": boolean;
@doc("The array of workflows containing the field.")
"ownerType"?: string[];
}

@doc("Describes the body of a purge request for an App Insights Workspace")
model WorkspacePurgeBody {
@doc("Table from which to purge data.")
"table": string;
@doc("The set of columns and filters (queries) to run over them to purge the resulting data.")
"filters": WorkspacePurgeBodyFilters[];
}

@doc("User-defined filters to return data which will be purged from the table.")
model WorkspacePurgeBodyFilters {
@doc("The column of the table over which the given query should run")
"column"?: string;
@doc("A query operator to evaluate over the provided column and value(s). Supported operators are ==, =~, in, in~, >, >=, <, <=, between, and have the same behavior as they would in a KQL query.")
"operator"?: string;
@doc("the value for the operator to function over. This can be a number (e.g., > 100), a string (timestamp >= '2017-09-01') or array of values.")
"value"?: unknown;
@doc("When filtering over custom dimensions, this key will be used as the name of the custom dimension.")
"key"?: string;
}

@doc("Response containing operationId for a specific purge action.")
model WorkspacePurgeResponse {
@doc("Id to use when querying for status for a particular purge operation.")
"operationId": string;
}

@doc("Response containing status for a specific purge operation.")
model WorkspacePurgeStatusResponse {
@doc("Status of the operation represented by the requested Id.")
"status": PurgeState;
}

@doc("Identity for the resource.")
model Identity {
@doc("The principal ID of resource identity.")
@visibility("read")
"principalId"?: string;
@doc("The tenant ID of resource.")
@visibility("read")
"tenantId"?: string;
@doc("Type of managed service identity.")
"type": IdentityType;
@doc("The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.")
"userAssignedIdentities"?: Record<UserIdentityProperties>;
}

@doc("User assigned identity properties.")
model UserIdentityProperties {
@doc("The principal id of user assigned identity.")
@visibility("read")
"principalId"?: string;
@doc("The client id of user assigned identity.")
@visibility("read")
"clientId"?: string;
}

@doc("The cluster sku definition.")
model ClusterSku {
@doc("The capacity value")
"capacity"?: Capacity;
@doc("The name of the SKU.")
"name"?: ClusterSkuNameEnum;
}

@doc("Cluster properties.")
model ClusterProperties {
@doc("The ID associated with the cluster.")
@visibility("read")
"clusterId"?: string;
@doc("The provisioning state of the cluster.")
@visibility("read")
"provisioningState"?: ClusterEntityStatus;
@doc("Configures whether cluster will use double encryption. This Property can not be modified after cluster creation. Default value is 'true'")
@visibility("create")
"isDoubleEncryptionEnabled"?: boolean;
@doc("Sets whether the cluster will support availability zones. This can be set as true only in regions where Azure Data Explorer support Availability Zones. This Property can not be modified after cluster creation. Default value is 'true' if region supports Availability Zones.")
"isAvailabilityZonesEnabled"?: boolean;
@doc("The cluster's billing type.")
"billingType"?: BillingType;
@doc("The associated key properties.")
"keyVaultProperties"?: KeyVaultProperties;
@doc("The last time the cluster was updated.")
@visibility("read")
"lastModifiedDate"?: string;
@doc("The cluster creation time")
@visibility("read")
"createdDate"?: string;
@doc("The list of Log Analytics workspaces associated with the cluster")
"associatedWorkspaces"?: AssociatedWorkspace[];
@doc("Additional properties for capacity reservation")
"capacityReservationProperties"?: CapacityReservationProperties;
}

@doc("The key vault properties.")
model KeyVaultProperties {
@doc("The Key Vault uri which holds they key associated with the Log Analytics cluster.")
"keyVaultUri"?: string;
@doc("The name of the key associated with the Log Analytics cluster.")
"keyName"?: string;
@doc("The version of the key associated with the Log Analytics cluster.")
"keyVersion"?: string;
@doc("Selected key minimum required size.")
"keyRsaSize"?: int32;
}

@doc("The list of Log Analytics workspaces associated with the cluster.")
model AssociatedWorkspace {
@doc("The id of the assigned workspace.")
@visibility("read")
"workspaceId"?: string;
@doc("The name id the assigned workspace.")
@visibility("read")
"workspaceName"?: string;
@doc("The ResourceId id the assigned workspace.")
@visibility("read")
"resourceId"?: string;
@doc("The time of workspace association.")
@visibility("read")
"associateDate"?: string;
}

@doc("The Capacity Reservation properties.")
model CapacityReservationProperties {
@doc("The last time Sku was updated.")
@visibility("read")
"lastSkuUpdate"?: string;
@doc("Minimum CapacityReservation value in GB.")
@visibility("read")
"minCapacity"?: int32;
}

@doc("Workspace properties.")
model WorkspaceProperties {
@doc("The provisioning state of the workspace.")
@visibility("read")
"provisioningState"?: WorkspaceEntityStatus;
@doc("This is a read-only property. Represents the ID associated with the workspace.")
@visibility("read")
"customerId"?: string;
@doc("The SKU of the workspace.")
"sku"?: WorkspaceSku;
@doc("The workspace data retention in days. Allowed values are per pricing plan. See pricing tiers documentation for details.")
"retentionInDays"?: int32;
@doc("The daily volume cap for ingestion.")
"workspaceCapping"?: WorkspaceCapping;
@doc("Workspace creation date.")
@visibility("read")
"createdDate"?: string;
@doc("Workspace modification date.")
@visibility("read")
"modifiedDate"?: string;
@doc("The network access type for accessing Log Analytics ingestion.")
"publicNetworkAccessForIngestion"?: PublicNetworkAccessType;
@doc("The network access type for accessing Log Analytics query.")
"publicNetworkAccessForQuery"?: PublicNetworkAccessType;
@doc("Indicates whether customer managed storage is mandatory for query management.")
"forceCmkForQuery"?: boolean;
@doc("List of linked private link scope resources.")
@visibility("read")
"privateLinkScopedResources"?: PrivateLinkScopedResource[];
@doc("Workspace features.")
"features"?: WorkspaceFeatures;
@doc("The resource ID of the default Data Collection Rule to use for this workspace. Expected format is - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/dataCollectionRules/{dcrName}.")
"defaultDataCollectionRuleResourceId"?: string;
}

@doc("The SKU (tier) of a workspace.")
model WorkspaceSku {
@doc("The name of the SKU.")
"name": WorkspaceSkuNameEnum;
@doc("The capacity reservation level in GB for this workspace, when CapacityReservation sku is selected.")
"capacityReservationLevel"?: CapacityReservationLevel;
@doc("The last time when the sku was updated.")
@visibility("read")
"lastSkuUpdate"?: string;
}

@doc("The daily volume cap for ingestion.")
model WorkspaceCapping {
@doc("The workspace daily quota for ingestion.")
"dailyQuotaGb"?: float32;
@doc("The time when the quota will be rest.")
@visibility("read")
"quotaNextResetTime"?: string;
@doc("The status of data ingestion for this workspace.")
@visibility("read")
"dataIngestionStatus"?: DataIngestionStatus;
}

@doc("The private link scope resource reference.")
model PrivateLinkScopedResource {
@doc("The full resource Id of the private link scope resource.")
"resourceId"?: string;
@doc("The private link scope unique Identifier.")
"scopeId"?: string;
}

@doc("Workspace features.")
model WorkspaceFeatures {
...Record<unknown>;
@doc("Flag that indicate if data should be exported.")
"enableDataExport"?: boolean;
@doc("Flag that describes if we want to remove the data after 30 days.")
"immediatePurgeDataOn30Days"?: boolean;
@doc("Flag that indicate which permission to use - resource or workspace or both.")
"enableLogAccessUsingOnlyResourcePermissions"?: boolean;
@doc("Dedicated LA cluster resourceId that is linked to the workspaces.")
"clusterResourceId"?: string;
@doc("Disable Non-AAD based Auth.")
"disableLocalAuth"?: boolean;
}

@doc("The resource model definition for an Azure Resource Manager resource with an etag.")
model AzureEntityResource {
...Resource;
@doc("Resource Etag.")
@visibility("read")
"etag"?: string;
}

@doc("Table properties.")
model TableProperties {
@doc("The table retention in days, between 4 and 730. Setting this property to -1 will default to the workspace retention.")
"retentionInDays"?: int32;
@doc("The table total retention in days, between 4 and 2556. Setting this property to -1 will default to table retention.")
"totalRetentionInDays"?: int32;
@doc("The table data archive retention in days. Calculated as (totalRetentionInDays-retentionInDays)")
@visibility("read")
"archiveRetentionInDays"?: int32;
@doc("Parameters of the search job that initiated this table.")
"searchResults"?: SearchResults;
@doc("Parameters of the restore operation that initiated this table.")
"restoredLogs"?: RestoredLogs;
@doc("Search job execution statistics.")
@visibility("read")
"resultStatistics"?: ResultStatistics;
@doc("Instruct the system how to handle and charge the logs ingested to this table.")
"plan"?: TablePlanEnum;
@doc("The timestamp that table plan was last modified (UTC).")
@visibility("read")
"lastPlanModifiedDate"?: string;
@doc("Table schema.")
"schema"?: Schema;
@doc("Table's current provisioning state. If set to 'updating', indicates a resource lock due to ongoing operation, forbidding any update to the table until the ongoing operation is concluded.")
@visibility("read")
"provisioningState"?: ProvisioningStateEnum;
@doc("True - Value originates from workspace retention in days, False - Customer specific.")
@visibility("read")
"retentionInDaysAsDefault"?: boolean;
@doc("True - Value originates from retention in days, False - Customer specific.")
@visibility("read")
"totalRetentionInDaysAsDefault"?: boolean;
}

@doc("Parameters of the search job that initiated this table.")
model SearchResults {
@doc("Search job query.")
"query"?: string;
@doc("Search job Description.")
"description"?: string;
@doc("Limit the search job to return up to specified number of rows.")
"limit"?: int32;
@doc("The timestamp to start the search from (UTC)")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startSearchTime"?: utcDateTime;
@doc("The timestamp to end the search by (UTC)")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endSearchTime"?: utcDateTime;
@doc("The table used in the search job.")
@visibility("read")
"sourceTable"?: string;
@doc("Search results table async operation id.")
@visibility("read")
"azureAsyncOperationId"?: string;
}

@doc("Restore parameters.")
model RestoredLogs {
@doc("The timestamp to start the restore from (UTC).")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startRestoreTime"?: utcDateTime;
@doc("The timestamp to end the restore by (UTC).")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"endRestoreTime"?: utcDateTime;
@doc("The table to restore data from.")
"sourceTable"?: string;
@doc("Search results table async operation id.")
@visibility("read")
"azureAsyncOperationId"?: string;
}

@doc("Search job execution statistics.")
model ResultStatistics {
@doc("Search job completion percentage.")
@visibility("read")
"progress"?: float32;
@doc("The number of rows that were returned by the search job.")
@visibility("read")
"ingestedRecords"?: int32;
@doc("Search job: Amount of scanned data.")
@visibility("read")
"scannedGb"?: float32;
}

@doc("Table's schema.")
model Schema {
@doc("Table name.")
"name"?: string;
@doc("Table display name.")
"displayName"?: string;
@doc("Table description.")
"description"?: string;
@doc("A list of table custom columns.")
"columns"?: Column[];
@doc("A list of table standard columns.")
@visibility("read")
"standardColumns"?: Column[];
@doc("Table category.")
@visibility("read")
"categories"?: string[];
@doc("Table labels.")
@visibility("read")
"labels"?: string[];
@doc("Table's creator.")
@visibility("read")
"source"?: SourceEnum;
@doc("Table's creator.")
@visibility("read")
"tableType"?: TableTypeEnum;
@doc("The subtype describes what APIs can be used to interact with the table, and what features are available against it.")
@visibility("read")
"tableSubType"?: TableSubTypeEnum;
@doc("List of solutions the table is affiliated with")
@visibility("read")
"solutions"?: string[];
}

@doc("Table column.")
model Column {
@doc("Column name.")
"name"?: string;
@doc("Column data type.")
@projectedName("json", "type")
"columnType"?: ColumnTypeEnum;
@doc("Column data type logical hint.")
"dataTypeHint"?: ColumnDataTypeHintEnum;
@doc("Column display name.")
"displayName"?: string;
@doc("Column description.")
"description"?: string;
@doc("Is displayed by default.")
@visibility("read")
"isDefaultDisplay"?: boolean;
@doc("Is column hidden.")
@visibility("read")
"isHidden"?: boolean;
}

@doc("DataSource filter. Right now, only filter by kind is supported.")
model DataSourceFilter {
@doc("The kind of the DataSource.")
"kind"?: DataSourceKind;
}

@doc("The status of operation.")
model OperationStatus {
@doc("The operation Id.")
"id"?: string;
@doc("The operation name.")
"name"?: string;
@doc("The start time of the operation.")
"startTime"?: string;
@doc("The end time of the operation.")
"endTime"?: string;
@doc("The status of the operation.")
"status"?: string;
@doc("The error detail of the operation if any.")
"error"?: ErrorResponse;
}