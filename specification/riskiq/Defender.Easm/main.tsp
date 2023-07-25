import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(OAuth2Auth<[ImplicitFlow]>)
@versioned(Easm.Versions)
@service({
    title: "Defender EASM",
})
@server(
    "{endpoint}/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/workspaces/{workspaceName}",
    "",
    {
        @doc("The endpoint hosting the requested resource. For example, https://{region}.easm.defender.microsoft.com")
        endpoint: string,

        @doc("The ID of the target subscription.")
        subscriptionId: string,

        @doc("The name of the Resource Group.")
        resourceGroupName: string,

        @doc("The name of the Workspace.")
        workspaceName: string,
    }
)
@doc("Defender EASM discovers and maps your digital attack surface to provide an \"outside-in\" perspective using probes to discover assets. The assets are provided with detailed metadata associated, including vulnerabilities, configurations and web components, allowing customers to view and prioritize external risk. The EASM REST API enables you to develop clients that integrate with your application.")
namespace Easm {
    @doc("The Easm service version.")
    enum Versions {
        @doc("Version 2023-03-01-preview")
        @useDependency(Azure.Core.Versions.v1_0_Preview_2)
        v2023_03_01_preview: "2023-03-01-preview",
    }

    @tag("Assets")
    @doc("Provides access to inventory assets.")
    interface Assets {
        @route("/assets")
        @doc("Retrieve a list of assets for the provided search parameters.")
        @get
        op Assets_List(
            ...FilterParameter,
            ...OrderByParameter,
            ...SkipParameter,
            ...MaxPageSizeParameter,
            ...MarkParameter,
            ...ApiVersionParameter,
        ): AssetPageResponse | ErrorResponse;

        @route("/assets")
        @doc("Update labels on assets matching the provided filter.")
        @post
        op Assets_Update(
            ...RequiredFilterParameter,
            ...ApiVersionParameter,
            @body assetUpdateRequest: AssetUpdateRequest,
        ): TaskResponse | ErrorResponse;

        @route("/assets/{assetId}")
        @doc("Retrieve an asset by assetId.")
        @get
        op Assets_Get(
            ...AssetIdParameter,
            ...ApiVersionParameter,
        ): AssetResponse | ErrorResponse;
    }

    @tag("Data Connections")
    @doc("Provides access to data connection resources.")
    interface DataConnections {
        @route("/dataConnections")
        @doc("Retrieve a list of data connections.")
        @get
        op DataConnections_List(
            ...SkipParameter,
            ...MaxPageSizeParameter,
            ...ApiVersionParameter,
        ): DataConnectionPageResponse | ErrorResponse;

        @route("/dataConnections:validate")
        @doc("Validate a data connection with a given dataConnectionName.")
        @post
        op DataConnections_Validate(
            ...ApiVersionParameter,
            @body dataConnectionRequest: DataConnectionRequest,
        ): ValidateResponse | ErrorResponse;

        @route("/dataConnections/{dataConnectionName}")
        @doc("Retrieve a data connection with a given dataConnectionName.")
        @get
        op DataConnections_Get(
            ...DataConnectionNameParameter,
            ...ApiVersionParameter,
        ): DataConnectionResponse | ErrorResponse;

        @route("/dataConnections/{dataConnectionName}")
        @doc("Create or update a data connection with a given dataConnectionName.")
        @put
        op DataConnections_Put(
            ...DataConnectionNameParameter,
            ...ApiVersionParameter,
            @body dataConnectionRequest: DataConnectionRequest,
        ): DataConnectionResponse | ErrorResponse;

        @route("/dataConnections/{dataConnectionName}")
        @doc("Delete a data connection with a given dataConnectionName.")
        @delete
        op DataConnections_Delete(
            ...DataConnectionNameParameter,
            ...ApiVersionParameter,
        ): NoContentResponse | ErrorResponse;
    }

    @tag("Discovery Groups")
    @doc("Provides access to discovery resources.")
    interface DiscoveryGroups {
        @route("/discoGroups")
        @doc("Retrieve a list of discovery group for the provided search parameters.")
        @get
        op DiscoveryGroups_List(
            ...FilterParameter,
            ...SkipParameter,
            ...MaxPageSizeParameter,
            ...ApiVersionParameter,
        ): DiscoGroupPageResponse | ErrorResponse;

        @route("/discoGroups:validate")
        @doc("Validate a discovery group with a given groupName.")
        @post
        op DiscoveryGroups_Validate(
            ...ApiVersionParameter,
            ...DiscoGroupNameParameter,
            @body discoGroupRequest: DiscoGroupRequest,
        ): ValidateResponse | ErrorResponse;

        @route("/discoGroups/{groupName}")
        @doc("Retrieve a discovery group with a given groupName.")
        @get
        op DiscoveryGroups_Get(
            ...DiscoGroupNameParameter,
            ...ApiVersionParameter,
        ): DiscoGroupResponse | ErrorResponse;

        @route("/discoGroups/{groupName}")
        @doc("Create a discovery group with a given groupName.")
        @put
        op DiscoveryGroups_Put(
            ...DiscoGroupNameParameter,
            ...ApiVersionParameter,
            @body discoGroupRequest: DiscoGroupRequest,
        ): DiscoGroupResponse | ErrorResponse;

        @route("/discoGroups/{groupName}:run")
        @doc("Run a discovery group with a given groupName.")
        @post
        op DiscoveryGroups_Run(
            ...DiscoGroupNameParameter,
            ...ApiVersionParameter,
        ): NoContentResponse | ErrorResponse;

        @route("/discoGroups/{groupName}/runs")
        @doc("Retrieve a collection of discovery run results for a discovery group with a given groupName.")
        @get
        op DiscoveryGroups_ListRuns(
            ...DiscoGroupNameParameter,
            ...FilterParameter,
            ...SkipParameter,
            ...MaxPageSizeParameter,
            ...ApiVersionParameter,
        ): DiscoRunPageResponse | ErrorResponse;
    }

    @tag("Discovery Templates")
    @doc("Provides access to disco template resources.")
    interface DiscoveryTemplates {
        @route("/discoTemplates")
        @doc("Retrieve a list of disco templates for the provided search parameters.")
        @get
        op DiscoveryTemplates_List(
            ...FilterParameter,
            ...SkipParameter,
            ...MaxPageSizeParameter,
            ...ApiVersionParameter,
        ): DiscoTemplatePageResponse | ErrorResponse;

        @route("/discoTemplates/{templateId}")
        @doc("Retrieve a disco template with a given templateId.")
        @get
        op DiscoveryTemplates_Get(
            ...DiscoTemplateIdParameter,
            ...ApiVersionParameter,
        ): DiscoTemplateResponse | ErrorResponse;
    }

    @tag("Reports")
    @doc("Provides access to reporting data.")
    interface Reports {
        @route("/reports/assets:getBillable")
        @doc("Get billable assets summary for the workspace.")
        @post
        op Reports_Billable(
            ...ApiVersionParameter,
        ): ReportBillableAssetSummaryResponse | ErrorResponse;

        @route("/reports/assets:getSnapshot")
        @doc("Get the most recent snapshot of asset summary values for the snapshot request.")
        @post
        op Reports_Snapshot(
            ...ApiVersionParameter,
            @body reportAssetSnapshotRequest: ReportAssetSnapshotRequest,
        ): ReportAssetSnapshotResponse | ErrorResponse;

        @route("/reports/assets:getSummary")
        @doc("Get asset summary details for the summary request.")
        @post
        op Reports_Summary(
            ...ApiVersionParameter,
            @body reportAssetSummaryRequest: ReportAssetSummaryRequest,
        ): ReportAssetSummaryResponse | ErrorResponse;
    }

    @tag("Saved Filters")
    @doc("Provides access to saved filter resources.")
    interface SavedFilters {
        @route("/savedFilters")
        @doc("Retrieve a list of saved filters for the provided search parameters.")
        @get
        op SavedFilters_List(
            ...FilterParameter,
            ...SkipParameter,
            ...MaxPageSizeParameter,
            ...ApiVersionParameter,
        ): SavedFilterPageResponse | ErrorResponse;

        @route("/savedFilters/{filterName}")
        @doc("Retrieve a saved filter by filterName.")
        @get
        op SavedFilters_Get(
            ...SavedFilterNameParameter,
            ...ApiVersionParameter,
        ): SavedFilterResponse | ErrorResponse;

        @route("/savedFilters/{filterName}")
        @doc("Create or update a saved filter with a given filterName.")
        @put
        op SavedFilters_Put(
            ...SavedFilterNameParameter,
            ...ApiVersionParameter,
            @body savedFilterRequest: SavedFilterRequest,
        ): SavedFilterResponse | ErrorResponse;

        @route("/savedFilters/{filterName}")
        @doc("Delete a saved filter with a given filterName.")
        @delete
        op SavedFilters_Delete(
            ...SavedFilterNameParameter,
            ...ApiVersionParameter,
        ): NoContentResponse | ErrorResponse;
    }

    @tag("Tasks")
    @doc("Provides access to task resources.")
    interface Tasks {
        @route("/tasks")
        @doc("Retrieve a list of tasks for the provided search parameters.")
        @get
        op Tasks_List(
            ...FilterParameter,
            ...OrderByParameter,
            ...SkipParameter,
            ...MaxPageSizeParameter,
            ...ApiVersionParameter,
        ): TaskPageResponse | ErrorResponse;

        @route("/tasks/{taskId}")
        @doc("Retrieve a task by taskId.")
        @get
        op Tasks_Get(
            ...TaskIdParameter,
            ...ApiVersionParameter,
        ): TaskResponse | ErrorResponse;

        @route("/tasks/{taskId}:cancel")
        @doc("Cancel a task by taskId.")
        @post
        op Tasks_Cancel(
            ...TaskIdParameter,
            ...ApiVersionParameter,
        ): TaskResponse | ErrorResponse;
    }

    @doc("AlexaInfo")
    model AlexaInfo {
        alexaRank?: int64;
        category?: string;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        recent?: boolean;
    }

    @doc("AsAsset")
    model AsAsset extends InventoryAsset {
        asn?: int64;
        asNames?: ObservedString[];
        orgNames?: ObservedString[];
        orgIds?: ObservedString[];
        countries?: ObservedString[];
        registries?: ObservedString[];
        sources?: Source[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        registrarCreatedAt?: ObservedLong[];
        registrarUpdatedAt?: ObservedLong[];
        registrantContacts?: ObservedString[];
        adminContacts?: ObservedString[];
        technicalContacts?: ObservedString[];
        registrarNames?: ObservedString[];
        registrantNames?: ObservedString[];
        adminNames?: ObservedString[];
        technicalNames?: ObservedString[];
        adminOrgs?: ObservedString[];
        technicalOrgs?: ObservedString[];
        registrantPhones?: ObservedString[];
        adminPhones?: ObservedString[];
        technicalPhones?: ObservedString[];
        detailedFromWhoisAt?: utcDateTime;
    }

    @doc("AssetPageResponse")
    model AssetPageResponse {
        @statusCode statusCode: 200;

        @doc("The total number of items available in the full result set.")
        totalElements?: int64;

        @doc("The cursor mark to be used on the next request.  Not set if using paging.")
        mark?: string;

        @doc("The link to access the next page of results.  Not set if at the end of the result set.")
        nextLink?: string;

        @doc("The items in the current page of results.")
        value?: AssetResponse[];
    }

    @discriminator("kind")
    @doc("AssetResponse")
    model AssetResponse {
        @statusCode statusCode: 200;

        @doc("The system generated unique id for the resource.")
        id?: string;

        @doc("The caller provided unique name for the resource.")
        name?: string;

        @doc("The name that can be used for display purposes.")
        displayName?: string;

        @doc("Global UUID for the asset.")
        uuid?: uuid;

        @doc("The date this asset was first added to this workspace.")
        createdDate?: utcDateTime;

        @doc("The date this asset was last updated for this workspace.")
        updatedDate?: utcDateTime;
        state?: AssetState;

        @doc("An optional customer provided identifier for this asset.")
        externalId?: string;

        @doc("Customer labels assigned to this asset.")
        labels?: string[];

        @doc("An indicator of whether this asset represents a wildcard rollup of assets on this domain.")
        wildcard?: boolean;

        @doc("The name of the DiscoveryGroup that brought added this asset to the workspace.")
        discoGroupName?: string;

        @doc("The history of how this asset was pulled into the workspace through the discovery process.")
        auditTrail?: AuditTrailItem[];
        reason?: string;
    }

    @doc("AssetSecurityPolicy")
    model AssetSecurityPolicy {
        policyName?: string;
        isAffected?: boolean;
        description?: string;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        recent?: boolean;
        sources?: Source[];
    }

    @doc("AssetSummaryResponse")
    model AssetSummaryResponse {
        @doc("The name of the summary response.  Depending on the request time this will either be the asset filter, risk category, or risk metric.")
        displayName?: string;

        @doc("The description of the summary response.  Filters don't have a description.")
        description?: string;

        @doc("The last time risk categories or risk metrics were captured. Set to the current time for asset filter requests, which always pull the live asset data.")
        updatedAt?: utcDateTime;

        @doc("If the request is for a metric category, this will contain the requested unique category name.")
        metricCategory?: string;

        @doc("If the request is for a metric, this will contain the requested unique metric name.")
        metric?: string;

        @doc("If the request is for an asset filter, this will contain the corresponding filter.")
        filter?: string;

        @doc("An optional label used to filter requests results.")
        labelName?: string;

        @doc("The count of assets matching the request parameters.")
        count?: int64;

        @doc("The link to the corresponding asset details.")
        link?: string;

        @doc("The corresponding child entities.  For metric categories this will contain metrics.  For filters with groupBy and segmentBy this will contain facets.")
        children?: AssetSummaryResponse[];
    }

    @doc("AssetUpdateRequest")
    model AssetUpdateRequest {
        @doc("The state to update the asset to.")
        state?: AssetUpdateState;

        @doc("A string which can be used to identify the asset in external systems.")
        externalId?: string;

        @doc("Any Labels to update the asset with.")
        labels?: Record<boolean>;

        @doc("A list of asset types to cascade the updates to.")
        transfers?: AssetUpdateTransfers;
    }

    @doc("Attribute")
    model Attribute {
        attributeType?: string;
        attributeValue?: string;
        sources?: Source[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        recent?: boolean;
    }

    @doc("AuditTrailItem")
    model AuditTrailItem {
        @doc("The system generated unique id for the resource.")
        id?: string;

        @doc("The caller provided unique name for the resource.")
        name?: string;

        @doc("The name that can be used for display purposes.")
        displayName?: string;

        @doc("The kind of asset.")
        kind?: AuditTrailItemKind;

        @doc("An explanation of why this audit trail node was discovered from the previous node.")
        reason?: string;
    }

    @doc("AzureDataExplorerDataConnectionProperties")
    model AzureDataExplorerDataConnectionProperties
        extends DataConnectionProperties {
        @doc("The azure data explorer cluster name")
        clusterName?: string;

        @doc("The azure data explorer region")
        region?: string;

        @doc("The azure data explorer database name")
        databaseName?: string;
    }

    @doc("Banner")
    model Banner {
        port?: int32;

        @projectedName("csharp", "BannerProperty")
        banner?: string;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        scanType?: string;
        bannerMetadata?: string;
        recent?: boolean;
        sha256?: string;
        sources?: Source[];
    }

    @doc("CVSS3Summary")
    model CVSS3Summary {
        version?: string;
        vectorString?: string;
        attackVector?: string;
        attackComplexity?: string;
        privilegesRequired?: string;
        userInteraction?: string;
        scope?: string;
        confidentialityImpact?: string;
        integrityImpact?: string;
        availabilityImpact?: string;
        baseScore?: float32;
        baseSeverity?: string;
        exploitCodeMaturity?: string;
        remediationLevel?: string;
        reportConfidence?: string;
        exploitabilityScore?: float32;
        impactScore?: float32;
    }

    @doc("ContactAsset")
    model ContactAsset extends InventoryAsset {
        email?: string;
        names?: ObservedString[];
        organizations?: ObservedString[];
        sources?: Source[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
    }

    @doc("Cookie")
    model Cookie {
        cookieName?: string;
        cookieDomain?: string;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        recent?: boolean;
        cookieExpiryDate?: utcDateTime;
    }

    @doc("Cve")
    model Cve {
        name?: string;
        cweId?: string;
        cvssScore?: float32;
        cvss3Summary?: CVSS3Summary;
    }

    @doc("DataConnectionPageResponse")
    model DataConnectionPageResponse {
        @statusCode statusCode: 200;

        @doc("The total number of items available in the full result set.")
        totalElements?: int64;

        @doc("The link to access the next page of results.  Not set if at the end of the result set.")
        nextLink?: string;

        @doc("The items in the current page of results.")
        value?: DataConnectionResponse[];
    }

    @doc("DataConnectionProperties")
    model DataConnectionProperties {}

    @discriminator("kind")
    @doc("DataConnectionRequest")
    model DataConnectionRequest {
        @doc("The name of data connection")
        name?: string;

        @doc("The type of data the data connection will transfer.")
        content?: DataConnectionContent;

        @doc("The rate at which the data connection will receive updates.")
        frequency?: DataConnectionFrequency;

        @doc("The day to update the data connection on. (1-7 for weekly, 1-31 for monthly)")
        frequencyOffset?: int32;
    }

    @discriminator("kind")
    @doc("DataConnectionResponse")
    model DataConnectionResponse {
        @statusCode statusCode: 200;

        @doc("The system generated unique id for the resource.")
        id?: string;

        @doc("The caller provided unique name for the resource.")
        name?: string;

        @doc("The name that can be used for display purposes.")
        displayName?: string;

        @doc("The type of data the data connection will transfer")
        content?: DataConnectionContent;

        @doc("The date the data connection was created.")
        createdDate?: utcDateTime;

        @doc("The rate at which the data connection will receive updates.")
        frequency?: DataConnectionFrequency;

        @doc("The day to update the data connection on.")
        frequencyOffset?: int32;

        @doc("The date the data connection was last updated.")
        updatedDate?: utcDateTime;

        @doc("The date the data connection was last updated by user.")
        userUpdatedAt?: utcDateTime;

        @doc("An indicator of whether the data connection is active.")
        active?: boolean;

        @doc("A message that specifies details about data connection if inactive.")
        inactiveMessage?: string;
    }

    @doc("DependentResource")
    model DependentResource {
        md5?: string;
        responseBodySize?: int64;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        firstSeenCrawlGuid?: string;
        firstSeenPageGuid?: string;
        firstSeenResourceGuid?: string;
        lastSeenCrawlGuid?: string;
        lastSeenPageGuid?: string;
        lastSeenResourceGuid?: string;
        responseBodyMinhash?: int32[];
        contentType?: string;
        sha256?: string;
        sha384?: string;
        sha512?: string;
        url?: string;
        cached?: boolean;
        sriChecks?: SubResourceIntegrityCheck[];
        host?: string;
        lastObservedViolation?: utcDateTime;
        lastObservedValidation?: utcDateTime;
        lastObservedActualSriHash?: string;
        lastObservedExpectedSriHash?: string;
    }

    @doc("DiscoGroupPageResponse")
    model DiscoGroupPageResponse {
        @statusCode statusCode: 200;

        @doc("The total number of items available in the full result set.")
        totalElements?: int64;

        @doc("The link to access the next page of results.  Not set if at the end of the result set.")
        nextLink?: string;

        @doc("The items in the current page of results.")
        value?: DiscoGroupResponse[];
    }

    @doc("DiscoGroupRequest")
    model DiscoGroupRequest {
        @doc("The name for a disco group.")
        name?: string;

        @doc("The description for a disco group.")
        description?: string;

        @doc("The tier for the disco group which will affect the algorithm used for the disco runs in this group.")
        tier?: string;

        @doc("The frequency at which the disco group is supposed to be rerun in milliseconds.")
        frequencyMilliseconds?: int64;

        @doc("The list of seeds used for the disco group runs.")
        seeds?: DiscoSource[];

        @doc("The list of names used for the disco group runs.")
        names?: string[];

        @doc("The list of excludes used for the disco group runs, aka assets to exclude from the discovery algorithm.")
        excludes?: DiscoSource[];

        @doc("The unique identifier for the disco template used for the disco group creation.")
        templateId?: string;
    }

    @doc("DiscoGroupResponse")
    model DiscoGroupResponse {
        @statusCode statusCode: 200;

        @doc("The system generated unique id for the resource.")
        id?: string;

        @doc("The caller provided unique name for the resource.")
        name?: string;

        @doc("The name that can be used for display purposes.")
        displayName?: string;

        @doc("The description for a disco group.")
        description?: string;

        @doc("The tier for the disco group which will affect the algorithm used for the disco runs in this group.")
        tier?: string;

        @doc("The frequency at which the disco group is supposed to be rerun in milliseconds.")
        frequencyMilliseconds?: int64;

        @doc("The list of seeds used for the disco group runs.")
        seeds?: DiscoSource[];

        @doc("The list of names used for the disco group runs.")
        names?: string[];

        @doc("The list of excludes used for the disco group runs, aka assets to exclude from the discovery algorithm.")
        excludes?: DiscoSource[];
        latestRun?: DiscoRunResponse;

        @doc("The date for the disco group was created.")
        createdDate?: utcDateTime;

        @doc("The unique identifier for the disco template used for the disco group creation.")
        templateId?: string;
    }

    @doc("DiscoRunPageResponse")
    model DiscoRunPageResponse {
        @statusCode statusCode: 200;

        @doc("The total number of items available in the full result set.")
        totalElements?: int64;

        @doc("The link to access the next page of results.  Not set if at the end of the result set.")
        nextLink?: string;

        @doc("The items in the current page of results.")
        value?: DiscoRunResponse[];
    }

    @doc("DiscoRunResponse")
    model DiscoRunResponse {
        @doc("The date for when the disco run was created in the system.")
        submittedDate?: utcDateTime;

        @doc("The date for when the disco run was actually started by the system.")
        startedDate?: utcDateTime;

        @doc("The date for when the disco run was completed by the system.")
        completedDate?: utcDateTime;

        @doc("The tier which will affect the algorithm used for the disco run.")
        tier?: string;

        @doc("The State of the disco run.")
        state?: DiscoRunState;

        @doc("The total count of assets that were found this disco run.")
        totalAssetsFoundCount?: int64;

        @doc("The list of seeds used for the disco run.")
        seeds?: DiscoSource[];

        @doc("The list of excludes used for the disco run, aka assets to exclude from the discovery algorithm.")
        excludes?: DiscoSource[];

        @doc("The list of names used for the disco run.")
        names?: string[];
    }

    @doc("DiscoSource")
    model DiscoSource {
        @doc("The kind of disco source.")
        kind?: DiscoSourceKind;

        @doc("The name for the disco source.")
        name?: string;
    }

    @doc("DiscoTemplatePageResponse")
    model DiscoTemplatePageResponse {
        @statusCode statusCode: 200;

        @doc("The total number of items available in the full result set.")
        totalElements?: int64;

        @doc("The link to access the next page of results.  Not set if at the end of the result set.")
        nextLink?: string;

        @doc("The items in the current page of results.")
        value?: DiscoTemplateResponse[];
    }

    @doc("DiscoTemplateResponse")
    model DiscoTemplateResponse {
        @statusCode statusCode: 200;

        @doc("The system generated unique id for the resource.")
        id?: string;

        @doc("The caller provided unique name for the resource.")
        name?: string;

        @doc("The name that can be used for display purposes.")
        displayName?: string;

        @doc("The name of the industry.")
        industry?: string;

        @doc("The name of the region.")
        region?: string;

        @doc("The country code.")
        countryCode?: string;

        @doc("The state code.")
        stateCode?: string;

        @doc("The name of the city.")
        city?: string;

        @doc("The list of disco template seeds.")
        seeds?: DiscoSource[];

        @doc("The list of disco template names.")
        names?: string[];
    }

    @doc("DomainAsset")
    model DomainAsset extends InventoryAsset {
        domain?: string;
        whoisId?: int64;
        registrarIanaIds?: ObservedInteger[];
        registrantContacts?: ObservedString[];
        registrantOrgs?: ObservedString[];
        adminContacts?: ObservedString[];
        technicalContacts?: ObservedString[];
        alexaInfos?: AlexaInfo[];
        nameServers?: ObservedString[];
        mailServers?: ObservedString[];
        whoisServers?: ObservedString[];
        domainStatuses?: ObservedString[];
        registrarCreatedAt?: ObservedLong[];
        registrarUpdatedAt?: ObservedLong[];
        registrarExpiresAt?: ObservedLong[];
        soaRecords?: SoaRecord[];
        detailedFromWhoisAt?: utcDateTime;
        registrarNames?: ObservedString[];
        sources?: Source[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        parkedDomain?: ObservedBoolean[];
        registrantNames?: ObservedString[];
        adminNames?: ObservedString[];
        technicalNames?: ObservedString[];
        adminOrgs?: ObservedString[];
        technicalOrgs?: ObservedString[];
        registrantPhones?: ObservedString[];
        adminPhones?: ObservedString[];
        technicalPhones?: ObservedString[];
    }

    @doc("ErrorDetail")
    model ErrorDetail {
        @doc("This is one of a server-defined set of error codes.")
        code: string;

        @doc("This is a human-readable representation of the error.")
        message: string;

        @doc("This is the error target.")
        target?: string;

        @doc("This is an array of details about specific errors that led to this reported error.")
        details?: ErrorDetail[];
        innererror?: InnerError;
    }

    @error
    @doc("ErrorResponse")
    model ErrorResponse {
        @header("x-ms-error-code")
        errorCode: string;
        error: ErrorDetail;
    }

    @doc("GuidPair")
    model GuidPair {
        pageGuid?: string;
        crawlStateGuid?: string;
        loadDate?: utcDateTime;
        recent?: boolean;
    }

    @doc("HostAsset")
    model HostAsset extends InventoryAsset {
        host?: string;
        domain?: string;
        ipAddresses?: ObservedString[];
        webComponents?: WebComponent[];
        headers?: ObservedHeader[];
        attributes?: Attribute[];
        cookies?: Cookie[];
        sslCerts?: SslCertAsset[];
        parentHosts?: ObservedString[];
        childHosts?: ObservedString[];
        hostCore?: HostCore;
        services?: Service[];
        cnames?: ObservedString[];
        sources?: Source[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        resourceUrls?: ResourceUrl[];
        scanMetadata?: ScanMetadata[];
        asns?: ObservedLong[];
        ipBlocks?: IpBlock[];
        responseBodies?: ObservedString[];
        domainAsset?: DomainAsset;
        nsRecord?: ObservedBoolean[];
        mxRecord?: ObservedBoolean[];
        webserver?: ObservedBoolean[];
        location?: ObservedLocation[];
        nxdomain?: ObservedBoolean[];
        sslServerConfig?: SslServerConfig[];
        isWildcard?: ObservedBoolean[];
        banners?: Banner[];
        ipv4?: ObservedBoolean[];
        ipv6?: ObservedBoolean[];
    }

    @doc("HostCore")
    model HostCore {
        host?: string;
        domain?: string;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        blacklistCauseFirstSeen?: utcDateTime;
        blacklistCauseLastSeen?: utcDateTime;
        blacklistCauseCount?: int64;
        blacklistResourceFirstSeen?: utcDateTime;
        blacklistResourceLastSeen?: utcDateTime;
        blacklistResourceCount?: int64;
        blacklistSequenceFirstSeen?: utcDateTime;
        blacklistSequenceLastSeen?: utcDateTime;
        blacklistSequenceCount?: int64;
        phishCauseCount?: int64;
        malwareCauseCount?: int64;
        spamCauseCount?: int64;
        scamCauseCount?: int64;
        phishResourceCount?: int64;
        malwareResourceCount?: int64;
        spamResourceCount?: int64;
        scamResourceCount?: int64;
        phishSequenceCount?: int64;
        malwareSequenceCount?: int64;
        spamSequenceCount?: int64;
        scamSequenceCount?: int64;
        alexaRank?: int32;
        hostReputationScore?: int32;
        hostPhishReputationScore?: int32;
        hostMalwareReputationScore?: int32;
        hostSpamReputationScore?: int32;
        hostScamReputationScore?: int32;
        domainReputationScore?: int32;
        domainPhishReputationScore?: int32;
        domainMalwareReputationScore?: int32;
        domainSpamReputationScore?: int32;
        domainScamReputationScore?: int32;
        uuid?: string;
    }

    @doc("InnerError")
    model InnerError {
        @doc("This is a more specific error code than was provided by the containing error.")
        code?: string;

        @doc("This is an additional field representing the value that caused the error to help with debugging.")
        value?: unknown;
    }

    @doc("InventoryAsset")
    model InventoryAsset {}

    @doc("IpAddressAsset")
    model IpAddressAsset extends InventoryAsset {
        ipAddress?: string;
        asns?: ObservedLong[];
        reputations?: Reputation[];
        webComponents?: WebComponent[];
        netRanges?: ObservedString[];
        headers?: ObservedHeader[];
        attributes?: Attribute[];
        cookies?: Cookie[];
        sslCerts?: SslCertAsset[];
        services?: Service[];
        ipBlocks?: IpBlock[];
        sources?: Source[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        banners?: Banner[];
        scanMetadata?: ScanMetadata[];
        nsRecord?: ObservedBoolean[];
        mxRecord?: ObservedBoolean[];
        location?: ObservedLocation[];
        hosts?: ObservedString[];
        nxdomain?: ObservedBoolean[];
        sslServerConfig?: SslServerConfig[];
        ipv4?: boolean;
        ipv6?: boolean;
    }

    @doc("IpBlock")
    model IpBlock {
        @projectedName("csharp", "IpBlockProperty")
        ipBlock?: string;
        sources?: Source[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        recent?: boolean;
    }

    @doc("IpBlockAsset")
    model IpBlockAsset extends InventoryAsset {
        ipBlock?: string;
        asns?: ObservedLong[];
        bgpPrefixes?: ObservedString[];
        netNames?: ObservedString[];
        registrantContacts?: ObservedString[];
        registrantOrgs?: ObservedString[];
        adminContacts?: ObservedString[];
        technicalContacts?: ObservedString[];
        registrarCreatedAt?: ObservedLong[];
        registrarUpdatedAt?: ObservedLong[];
        netRanges?: ObservedString[];
        startIp?: string;
        endIp?: string;
        reputations?: Reputation[];
        detailedFromWhoisAt?: utcDateTime;
        sources?: Source[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        location?: ObservedLocation[];
        registrarExpiresAt?: ObservedLong[];
        registrantNames?: ObservedString[];
        adminNames?: ObservedString[];
        technicalNames?: ObservedString[];
        adminOrgs?: ObservedString[];
        technicalOrgs?: ObservedString[];
        registrantPhones?: ObservedString[];
        adminPhones?: ObservedString[];
        technicalPhones?: ObservedString[];
        ipv4?: boolean;
        ipv6?: boolean;
    }

    @doc("Location")
    model Location {
        countryCode?: string;
        countryName?: string;
        region?: string;
        regionName?: string;
        city?: string;
        areaCode?: int32;
        postalCode?: string;
        latitude?: float32;
        longitude?: float32;
        dmaCode?: int32;
        metroCodeId?: int32;
    }

    @doc("LogAnalyticsDataConnectionProperties")
    model LogAnalyticsDataConnectionProperties
        extends DataConnectionProperties {
        @doc("log analytics api key")
        apiKey?: string;

        @doc("log analytics workspace id")
        workspaceId?: string;
    }

    @doc("ObservationResponse")
    model ObservationResponse {
        name?: string;
        type?: string[];
        priority?: ObservationPriority;
        cvssScoreV2?: float32;
        cvssScoreV3?: float32;
    }

    @doc("ObservedBoolean")
    model ObservedBoolean {
        value?: boolean;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        sources?: Source[];
        recent?: boolean;
    }

    @doc("ObservedHeader")
    model ObservedHeader {
        headerName?: string;
        headerValue?: string;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        recent?: boolean;
    }

    @doc("ObservedInteger")
    model ObservedInteger {
        value?: int32;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        sources?: Source[];
        recent?: boolean;
    }

    @doc("ObservedIntegers")
    model ObservedIntegers {
        values?: int32[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        sources?: Source[];
        recent?: boolean;
    }

    @doc("ObservedLocation")
    model ObservedLocation {
        value?: Location;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        recent?: boolean;
        sources?: Source[];
    }

    @doc("ObservedLong")
    model ObservedLong {
        value?: int64;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        sources?: Source[];
        recent?: boolean;
    }

    @doc("ObservedPortState")
    model ObservedPortState {
        value?: ObservedPortStateValue;
        port?: int32;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        recent?: boolean;
    }

    @doc("ObservedString")
    model ObservedString {
        value?: string;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        sources?: Source[];
        recent?: boolean;
    }

    @doc("PageAsset")
    model PageAsset extends InventoryAsset {
        url?: string;
        httpMethod?: string;
        service?: string;
        ipAddresses?: ObservedString[];
        successful?: ObservedBoolean[];
        httpResponseCodes?: ObservedInteger[];
        httpResponseMessages?: ObservedString[];
        responseTimes?: ObservedLong[];
        frames?: ObservedBoolean[];
        windows?: ObservedBoolean[];
        nonHtmlFrames?: ObservedBoolean[];
        undirectedContent?: ObservedBoolean[];
        contentTypes?: ObservedString[];
        contentLengths?: ObservedLong[];
        windowNames?: ObservedString[];
        charsets?: ObservedString[];
        titles?: ObservedString[];
        languages?: ObservedString[];
        responseHeaders?: ObservedHeader[];
        cookies?: Cookie[];
        webComponents?: WebComponent[];
        attributes?: Attribute[];
        assetSecurityPolicies?: AssetSecurityPolicy[];
        responseBodyMinhashSignatures?: ObservedIntegers[];
        fullDomMinhashSignatures?: ObservedIntegers[];
        responseBodyHashSignatures?: ObservedString[];
        errors?: ObservedString[];
        sslCerts?: SslCertAsset[];
        sources?: Source[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        cause?: PageCause;
        referrer?: string;
        redirectUrls?: ObservedString[];
        redirectType?: PageAssetRedirectType;
        finalUrls?: ObservedString[];
        finalResponseCodes?: ObservedInteger[];
        parkedPage?: ObservedBoolean[];
        resourceUrls?: ResourceUrl[];
        guids?: GuidPair[];
        finalIpAddresses?: ObservedString[];
        asns?: ObservedLong[];
        ipBlocks?: IpBlock[];
        finalAsns?: ObservedLong[];
        finalIpBlocks?: IpBlock[];
        responseBodies?: ObservedString[];
        domainAsset?: DomainAsset;
        rootUrl?: ObservedBoolean;
        isRootUrl?: boolean;
        location?: ObservedLocation[];
        services?: Service[];
        siteStatus?: string;
        cnames?: ObservedString[];
        cdns?: ObservedString[];
        host?: string;
        domain?: string;
        sslServerConfig?: SslServerConfig[];
        gdprAssetSecurityPolicies?: AssetSecurityPolicy[];
        ipv4?: ObservedBoolean[];
        ipv6?: ObservedBoolean[];
    }

    @doc("PageCause")
    model PageCause {
        cause?: string;
        causeElementXPath?: string;
        location?: string;
        possibleMatches?: int32;
        loopDetected?: boolean;
        version?: int32;
        domChangeIndex?: int32;
    }

    @doc("Port")
    model Port {
        @projectedName("csharp", "PortProperty")
        port?: int32;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
    }

    @doc("ReportAssetSnapshotExportRequest")
    model ReportAssetSnapshotExportRequest {
        @doc("The metric to retrieve a snapshot for.")
        metric?: string;

        @doc("The filename of the exported file.")
        fileName?: string;

        @doc("The columns to include in the export")
        columns?: string[];
    }

    @doc("ReportAssetSnapshotRequest")
    model ReportAssetSnapshotRequest {
        @doc("The metric to retrieve a snapshot for.")
        metric?: string;

        @doc("The name of the label to retrieve a snapshot for.")
        labelName?: string;

        @doc("The number of assets per page.")
        size?: int32;

        @doc("The page to retrieve.")
        page?: int32;
    }

    @doc("ReportAssetSnapshotResponse")
    model ReportAssetSnapshotResponse {
        @statusCode statusCode: 200;

        @doc("The name of the metric.")
        displayName?: string;

        @doc("The unique metric name.")
        metric?: string;

        @doc("The customer label that was filtered on, if one was provided.")
        labelName?: string;

        @doc("The last time this asset data was updated on this metric.")
        updatedAt?: utcDateTime;

        @doc("A description of what the metric represents.")
        description?: string;
        assets?: AssetPageResponse;
    }

    @doc("ReportAssetSummaryRequest")
    model ReportAssetSummaryRequest {
        @doc("Categories to retrieve risk reporting data for.")
        metricCategories?: string[];

        @doc("Metrics to retrieve risk reporting data for.")
        metrics?: string[];

        @doc("Query filters to apply to the asset summary.")
        filters?: string[];

        @doc("A parameter to group the assets by (first level facet field), only used when the chosen summary identifier is filters.")
        groupBy?: string;

        @doc("A parameter to segment the assets by (second level facet field), only used when the chosen summary identifier is filters.")
        segmentBy?: string;

        @doc("Currently unused.")
        labelName?: string;
    }

    @doc("ReportAssetSummaryResponse")
    model ReportAssetSummaryResponse {
        @statusCode statusCode: 200;

        @doc("The collection of asset summaries.")
        assetSummaries?: AssetSummaryResponse[];
    }

    @doc("ReportBillableAssetBreakdown")
    model ReportBillableAssetBreakdown {
        @doc("The kind of billable asset.")
        kind?: ReportBillableAssetBreakdownKind;

        @doc("The number of assets of this type.")
        count?: int64;
    }

    @doc("ReportBillableAssetSnapshotResponse")
    model ReportBillableAssetSnapshotResponse {
        @doc("The date these assets were billed on.")
        date?: plainDate;

        @doc("The total number of billable assets for this date.")
        total?: int64;

        @doc("The breakdown of billable asset counts for each asset type.")
        assetBreakdown?: ReportBillableAssetBreakdown[];
    }

    @doc("ReportBillableAssetSummaryResponse")
    model ReportBillableAssetSummaryResponse {
        @statusCode statusCode: 200;
        assetSummaries?: ReportBillableAssetSnapshotResponse[];
    }

    @doc("Reputation")
    model Reputation {
        listName?: string;
        threatType?: string;
        trusted?: boolean;
        cidr?: string;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        listUpdatedAt?: utcDateTime;
        recent?: boolean;
    }

    @doc("ResourceUrl")
    model ResourceUrl {
        url?: string;
        resources?: DependentResource[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        recent?: boolean;
    }

    @doc("SavedFilterPageResponse")
    model SavedFilterPageResponse {
        @statusCode statusCode: 200;

        @doc("The total number of items available in the full result set.")
        totalElements?: int64;

        @doc("The link to access the next page of results.  Not set if at the end of the result set.")
        nextLink?: string;

        @doc("The items in the current page of results.")
        value?: SavedFilterResponse[];
    }

    @doc("SavedFilterRequest")
    model SavedFilterRequest {
        @doc("An expression on the resource type that selects the resources to be returned.")
        filter: string;

        @doc("A human readable description of the saved filter.")
        description: string;
    }

    @doc("SavedFilterResponse")
    model SavedFilterResponse {
        @statusCode statusCode: 200;

        @doc("The system generated unique id for the resource.")
        id?: string;

        @doc("The caller provided unique name for the resource.")
        name?: string;

        @doc("The name that can be used for display purposes.")
        displayName?: string;
        filter?: string;
        description?: string;
    }

    @doc("ScanMetadata")
    model ScanMetadata {
        port?: int32;
        bannerMetadata?: string;
        startScan?: utcDateTime;
        endScan?: utcDateTime;
    }

    @doc("Service")
    model Service {
        scheme?: string;
        port?: int32;
        webComponents?: WebComponent[];
        sslCerts?: SslCertAsset[];
        exceptions?: ObservedString[];
        sources?: Source[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        recent?: boolean;
        portStates?: ObservedPortState[];
    }

    @doc("SoaRecord")
    model SoaRecord {
        nameServer?: string;
        email?: string;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        serialNumber?: int64;
        recent?: boolean;
    }

    @doc("Source")
    model Source {
        @projectedName("csharp", "SourceProperty")
        source?: string;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        reason?: string;
    }

    @doc("SslCertAsset")
    model SslCertAsset extends InventoryAsset {
        sha1?: string;
        subjectCommonNames?: string[];
        organizations?: string[];
        organizationalUnits?: string[];
        issuerCommonNames?: string[];
        sigAlgName?: string;
        invalidAfter?: utcDateTime;
        serialNumber?: string;
        subjectAlternativeNames?: string[];
        issuerAlternativeNames?: string[];
        sources?: Source[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        invalidBefore?: utcDateTime;
        keySize?: int32;
        keyAlgorithm?: string;
        subjectLocality?: string[];
        subjectState?: string[];
        subjectCountry?: string[];
        issuerLocality?: string[];
        issuerState?: string[];
        issuerCountry?: string[];
        subjectOrganizations?: string[];
        subjectOrganizationalUnits?: string[];
        issuerOrganizations?: string[];
        issuerOrganizationalUnits?: string[];
        version?: int32;
        certificateAuthority?: boolean;
        selfSigned?: boolean;
        sigAlgOid?: string;
        recent?: boolean;
        validationType?: SslCertAssetValidationType;
    }

    @doc("SslServerConfig")
    model SslServerConfig {
        tlsVersions?: string[];
        cipherSuites?: string[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        sources?: Source[];
    }

    @doc("SubResourceIntegrityCheck")
    model SubResourceIntegrityCheck {
        violation?: boolean;
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        causePageUrl?: string;
        crawlGuid?: string;
        pageGuid?: string;
        resourceGuid?: string;
        expectedHash?: string;
    }

    @doc("TaskPageResponse")
    model TaskPageResponse {
        @statusCode statusCode: 200;

        @doc("The total number of items available in the full result set.")
        totalElements?: int64;

        @doc("The link to access the next page of results.  Not set if at the end of the result set.")
        nextLink?: string;

        @doc("The items in the current page of results.")
        value?: TaskResponse[];
    }

    @doc("TaskResponse")
    model TaskResponse {
        @statusCode statusCode: 200;

        @doc("The unique identifier of the task.")
        id?: string;

        @doc("The time the task started.")
        startedAt?: utcDateTime;

        @doc("The time the task completed.")
        completedAt?: utcDateTime;

        @doc("The last time the status of the task was updated.")
        lastPolledAt?: utcDateTime;

        @doc("The state the task is in.")
        state?: TaskState;

        @doc("The phase the task is in.")
        phase?: TaskPhase;

        @doc("The reason the task was moved into its current state, if the task wasn't completed.")
        reason?: string;

        @doc("Attributes unique to the task.  This differs by task type.")
        metadata?: unknown;
    }

    @doc("ValidateResponse")
    model ValidateResponse {
        @statusCode statusCode: 200;
        error?: ErrorDetail;
    }

    @doc("WebComponent")
    model WebComponent {
        name?: string;
        type?: string;
        version?: string;
        ruleId?: string[];
        firstSeen?: utcDateTime;
        lastSeen?: utcDateTime;
        count?: int64;
        cve?: Cve[];
        endOfLife?: int64;
        recent?: boolean;
        ports?: Port[];
        sources?: Source[];
        service?: string;
    }

    scalar uuid extends string;

    enum AssetUpdateTransfers {
        as,
        contact,
        domain,
        host,
        ipAddress,
        ipBlock,
        page,
        sslCert,
    }

    enum ReportBillableAssetBreakdownKind {
        domain,
        host,
        ipAddress,
    }

    enum ObservationPriority {
        high,
        medium,
        low,
        none,
    }

    enum TaskState {
        pending,
        running,
        paused,
        complete,
        incomplete,
        failed,
        warning,
    }

    enum TaskPhase {
        running,
        polling,
        complete,
    }

    enum DataConnectionKind {
        logAnalytics,
        azureDataExplorer,
    }

    enum DataConnectionFrequency {
        daily,
        weekly,
        monthly,
    }

    enum AssetKind {
        as,
        contact,
        domain,
        host,
        ipAddress,
        ipBlock,
        page,
        sslCert,
    }

    enum DiscoRunState {
        pending,
        running,
        completed,
        failed,
    }

    enum DataConnectionContent {
        assets,
        attackSurfaceInsights,
    }

    enum DiscoSourceKind {
        as,
        attribute,
        contact,
        domain,
        host,
        ipBlock,
    }

    enum ObservedPortStateValue {
        open,
        closed,
        filtered,
    }

    enum AssetUpdateState {
        candidate,
        confirmed,
        dismissed,
        candidateInvestigate,
        associatedPartner,
        associatedThirdparty,
    }

    enum AssetState {
        candidate,
        confirmed,
        dismissed,
        candidateInvestigate,
        associatedPartner,
        associatedThirdparty,
        archived,
    }

    enum AuditTrailItemKind {
        as,
        contact,
        domain,
        host,
        ipAddress,
        ipBlock,
        page,
        sslCert,
    }

    enum PageAssetRedirectType {
        httpHeader,
        metaRefresh,
        javascript,
        final,
    }

    enum SslCertAssetValidationType {
        domainValidation,
        organizationValidation,
        extendedValidation,
    }

    model LogAnalyticsDataConnectionRequest extends DataConnectionRequest {
        kind: "logAnalytics";
        properties: LogAnalyticsDataConnectionProperties;
    }

    model AzureDataExplorerDataConnectionRequest extends DataConnectionRequest {
        kind: "azureDataExplorer";
        properties: AzureDataExplorerDataConnectionProperties;
    }

    model AsAssetResponse extends AssetResponse {
        kind: "as";
        asset: AsAsset;
    }

    model ContactAssetResponse extends AssetResponse {
        kind: "contact";
        asset: ContactAsset;
    }

    model DomainAssetResponse extends AssetResponse {
        kind: "domain";
        asset: DomainAsset;
    }

    model HostAssetResponse extends AssetResponse {
        kind: "host";
        asset: HostAsset;
    }

    model IpAddressAssetResponse extends AssetResponse {
        kind: "ipAddress";
        asset: IpAddressAsset;
    }

    model IpBlockAssetResponse extends AssetResponse {
        kind: "ipBlock";
        asset: IpBlockAsset;
    }

    model PageAssetResponse extends AssetResponse {
        kind: "page";
        asset: PageAsset;
    }

    model SslCertAssetResponse extends AssetResponse {
        kind: "sslCert";
        asset: SslCertAsset;
    }

    model LogAnalyticsDataConnectionResponse extends DataConnectionResponse {
        kind: "logAnalytics";
        properties: LogAnalyticsDataConnectionProperties;
    }

    model AzureDataExplorerDataConnectionResponse
        extends DataConnectionResponse {
        kind: "azureDataExplorer";
        properties: AzureDataExplorerDataConnectionProperties;
    }

    @doc("SubscriptionIdParameter")
    model SubscriptionIdParameter {
        @path("subscriptionId") subscriptionId: string;
    }

    @doc("ResourceGroupNameParameter")
    model ResourceGroupNameParameter {
        @path("resourceGroupName") resourceGroupName: string;
    }

    @doc("WorkspaceNameParameter")
    model WorkspaceNameParameter {
        @path("workspaceName") workspaceName: string;
    }

    @doc("ApiVersionParameter")
    model ApiVersionParameter {
        @query("api-version") apiversion: string;
    }

    @doc("SavedFilterNameParameter")
    model SavedFilterNameParameter {
        @path("filterName") filterName: string;
    }

    @doc("DiscoGroupNameParameter")
    model DiscoGroupNameParameter {
        @path("groupName") groupName: string;
    }

    @doc("DataConnectionNameParameter")
    model DataConnectionNameParameter {
        @path("dataConnectionName") dataConnectionName: string;
    }

    @doc("TaskIdParameter")
    model TaskIdParameter {
        @path("taskId") taskId: string;
    }

    @doc("FilterParameter")
    model FilterParameter {
        @query("filter") filter?: string;
    }

    @doc("OrderByParameter")
    model OrderByParameter {
        @query("orderby") orderby?: string;
    }

    @doc("SkipParameter")
    model SkipParameter {
        @query("skip") skip?: int32;
    }

    @doc("MaxPageSizeParameter")
    model MaxPageSizeParameter {
        @query("maxpagesize") maxpagesize?: int32;
    }

    @doc("MarkParameter")
    model MarkParameter {
        @query("mark") mark?: string;
    }

    @doc("RequiredFilterParameter")
    model RequiredFilterParameter {
        @query("filter") filter: string;
    }

    @doc("DiscoTemplateIdParameter")
    model DiscoTemplateIdParameter {
        @path("templateId") templateId: string;
    }

    @doc("AssetIdParameter")
    model AssetIdParameter {
        @path("assetId") assetId: string;
    }

    @doc("Implicit Flow")
    model ImplicitFlow {
        @doc("implicit flow")
        type: OAuth2FlowType.implicit;

        @doc("the authorization URL")
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";

        @doc("list of scopes for the credential")
        scopes: ["https://easm.defender.microsoft.com/.default"];
    }
}
