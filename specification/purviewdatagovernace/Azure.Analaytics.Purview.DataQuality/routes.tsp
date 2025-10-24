import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace PurviewDataQuality;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias DataQualityOperation = Azure.Core.ResourceOperations<ServiceTraits>;

/** Version information */
enum Versions {
  /** API version 2025-09-01-preview */
  v2025_09_01_preview: "2025-09-01-preview"
}

@versioned(Versions)
@service(#{
  title: "Purview Data Quality API"
})
namespace PurviewDataQuality {

/**
 * Create Rules for Assets
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@put
op CreateRules is DataQualityOperation.ResourceCreateOrReplace<RuleEntities>;

/**
 * Get Rules for Assets
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@get
op getRules is DataQualityOperation.ResourceList<RuleParameters>;

/**
 * Update a rule
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@patch
op updateRule is DataQualityOperation.ResourceUpdate<RuleEntities>;

/**
 * Delete a rule
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@delete
op deleteRule is DataQualityOperation.ResourceDelete<RuleParameters>;

/**
 * Get a Rule
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@get
op getRule is DataQualityOperation.ResourceRead<RuleParameters>;

/**
 * Create Bulk Rules for Assets
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/bulk-rules")
@put
op createBulkRules is DataQualityOperation.ResourceCreateOrReplace<RuleEntities>;
//   {
//     /**
//      * Unique Identifier for Business Domain
//      */
//     @path
//     businessDomainId: string;

//     /**
//      * Unique Identifier for Data Product
//      */
//     @path
//     dataProductId: string;

//     /**
//      * Unique Identifier for Data Asset
//      */
//     @path
//     dataAssetId: string;

//     /**
//      * Body Rule Entity
//      */
//     #suppress "@azure-tools/typespec-azure-core/request-body-problem"
//     @bodyRoot
//     body?: RuleEntity[];
//   },
//   RuleEntityListResponse
// >;

/**
 * Create Asset Metadata Observer
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/asset-metadata")
@put
op createAssetMetaData is DataQualityOperation.ResourceCreateOrReplace<RuleEntities>;
//   {
//     /**
//      * Unique Identifier for Business Domain
//      */
//     @path
//     businessDomainId: string;

//     /**
//      * Unique Identifier for Data Product
//      */
//     @path
//     dataProductId: string;

//     /**
//      * Unique Identifier for Data Asset
//      */
//     @path
//     dataAssetId: string;

//     /**
//      * Asset Meta data observer
//      */
//     @bodyRoot
//     body?: AssetMetadataObserver;
//   },
//   AssetMetadataObserverResponse
// >;

/**
 * Get Observer
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/asset-metadata")
@get
op getObserver is DataQualityOperation.ResourceRead<RuleParameters>;
//   {
//     /**
//      * Unique Identifier for Business Domain
//      */
//     @path
//     businessDomainId: string;

//     /**
//      * Unique Identifier for Data Product
//      */
//     @path
//     dataProductId: string;

//     /**
//      * Unique Identifier for Data Asset
//      */
//     @path
//     dataAssetId: string;
//   },
//   AssetMetadataObserver
// >;

/**
 * Update Observer
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/asset-metadata")
@patch
op updateObserver is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique Identifier for Business Domain
     */
    @path
    businessDomainId: string;

    /**
     * Unique Identifier for Data Product
     */
    @path
    dataProductId: string;

    /**
     * Unique Identifier for Data Asset
     */
    @path
    dataAssetId: string;

    /**
     * AssetMetaDataObserver
     */
    @bodyRoot
    body?: AssetMetadataObserver;
  },
  AssetMetadataObserver
>;

/**
 * Get Schedules
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/schedules")
@get
op getSchedules is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique Identifier for Business Domain
     */
    @path
    businessDomainId: string;

    /**
     * token
     */
    @query("skipToken")
    skipToken?: string;
  },
  ScheduleEntity[]
>;

/**
 * Create Schedule
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/schedules")
@put
op createSchedule is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique Identifier for Business Domain
     */
    @path
    businessDomainId: string;

    /**
     * Schedule Entity
     */
    @bodyRoot
    body?: ScheduleEntity;
  },
  ScheduleEntityResponse
>;

/**
 * Get Schedule
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/schedules/{scheduleId}")
@get
op getSchedule is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique Identifier for Business Domain
     */
    @path
    businessDomainId: string;

    /**
     * Unique Identifier for Schedule
     */
    @path
    scheduleId: string;
  },
  ScheduleEntity
>;

/**
 * Update Schedule
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/schedules/{scheduleId}")
@patch
op updateSchedule is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique Identifier for Business Domain
     */
    @path
    businessDomainId: string;

    /**
     * Unique Identifier for Schedule
     */
    @path
    scheduleId: string;

    /**
     * Body for Schedule Entity
     */
    @bodyRoot
    body?: ScheduleEntity;
  },
  ScheduleEntity
>;

/**
 * Delete Schedule
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/schedules/{scheduleId}")
@delete
op deleteSchedule is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique Identifier for Business Domain
     */
    @path
    businessDomainId: string;

    /**
     * Unique identifier for Schedule
     */
    @path
    scheduleId: string;
  },
  void
>;

/**
 * Create Scan
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/schedules/{scheduleId}/scans")
@pollingOperation(createScan)
@put
op createScan is Azure.Core.Foundations.Operation<
  {
    /**
     * Get business domain id
     */
    @path
    businessDomainId: string;

    /**
     * Get schedule id
     */
    @path
    scheduleId: string;

    /**
     * Get scanDTO
     */
    @bodyRoot
    body?: ScanDTO;
  },
  ScanDTOResponse
>;

/**
 * Cancel Scan
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
#suppress "LroExtension" "This operation returns 202"
@route("/business-domains/{businessDomainId}/schedules/{scheduleId}/scans/{scanId}:cancel")
@pollingOperation(cancelScan)
@put
op cancelScan is Azure.Core.Foundations.Operation<
  {
    /**
     * Get business domain id
     */
    @path
    businessDomainId: string;

    /**
     * Get schedule id
     */
    @path
    scheduleId: string;

    /**
     * Get scan id
     */
    @path
    scanId: string;
  },
  ScanDTOResponse
>;

/**
 * Get Scan by ScanId
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/schedules/{scheduleId}/scans/{scanId}")
@get
op scanByScanId is Azure.Core.Foundations.Operation<
  {
    /**
     * Get business domain id
     */
    @path
    businessDomainId: string;

    /**
     * Get schedule id
     */
    @path
    scheduleId: string;

    /**
     * Get scan id
     */
    @path
    scanId: string;
  },
  ScheduleScanMonitoringEntity
>;

/**
 * Get the run status by run id
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/runs/{runId}")
@get
op getRunStatus is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business domain id
     */
    @path
    businessDomainId: string;

    /**
     * Get run id
     */
    @path
    runId: string;
  },
  JobMetadataEntity
>;

/**
 * Cancel Scan
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/runs/{runId}:cancel")
@pollingOperation(cancelScanByRunId)
@put
op cancelScanByRunId is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business domain id
     */
    @path
    businessDomainId: string;

    /**
     * Get run id
     */
    @path
    runId: string;
  },
  ScanDTOResponse
>;

/**
 * Get runs for asset
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/runs")
@get
op getRunsForAsset is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business domain id
     */
    @path
    businessDomainId: string;

    /**
     * Get data product id
     */
    @path
    dataProductId: string;

    /**
     * Get data asset id
     */
    @path
    dataAssetId: string;

    /**
     * Get run type
     */
    @query("runType")
    runType: string;
  },
  JobHistoryEntity[]
>;

/**
 * Do an observation
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/observations")
@pollingOperation(observe)
@put
op observe is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get Data Product Id
     */
    @path
    dataProductId: string;

    /**
     * Get Data Asset Id
     */
    @path
    dataAssetId: string;

    /**
     * Body Job Config DTO
     */
    @bodyRoot
    body: JobConfigDTO;
  },
  JobConfigDTOResponse
>;

/**
 * Deletes a specific observation.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/observations/{observationId}")
@delete
op `Delete Observation` is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get Data Product Id
     */
    @path
    dataProductId: string;

    /**
     * Get Data Asset Id
     */
    @path
    dataAssetId: string;

    /**
     * Get Observation Id
     */
    @path
    observationId: string;
  },
  void
>;

/**
 * Get all Data Sources for a given Business Domain
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-sources")
@get
op getDataSources is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * token
     */
    @query("skipToken")
    skipToken?: string;

    /**
     * name
     */
    @query("name")
    name?: string;
  },
  DataSourceEntity[]
>;

/**
 * Get Data Source for a given data source id
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-sources/{dataSourceId}")
@get
op getDataSource is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get Data Source Id
     */
    @path
    dataSourceId: string;
  },
  DataSourceEntity
>;

/**
 * Delete data source
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-sources/{dataSourceId}")
@delete
op deleteDataSource is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get Data Source Id
     */
    @path
    dataSourceId: string;
  },
  void
>;

/**
 * Update data source
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-sources/{dataSourceId}")
@patch
op updateDataSource is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get Data Source Id
     */
    @path
    dataSourceId: string;

    /**
     * Data Source Entity
     */
    @bodyRoot
    body: DataSourceEntity;
  },
  DataSourceEntity
>;

/**
 * Update data source
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-sources")
@put
op createDataSource is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Data Source Entity
     */
    @bodyRoot
    body: DataSourceEntity;
  },
  DataSourceEntityResponse
>;

/**
 * Delete scoped asset meta data
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/scoped-asset-metadata")
@delete
op deleteScopedAssetMetaData is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get data product Id
     */
    @path
    dataProductId: string;

    /**
     * Get data asset Id
     */
    @path
    dataAssetId: string;
  },
  void
>;

/**
 * Get scoped asset meta data
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/scoped-asset-metadata")
@get
op getScopedAssetMetaData is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get data product Id
     */
    @path
    dataProductId: string;

    /**
     * Get data asset Id
     */
    @path
    dataAssetId: string;
  },
  DataSourceEntity
>;

/**
 * Update scoped asset meta data
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/scoped-asset-metadata")
@patch
op updateScopedAssetMetaData is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get data product Id
     */
    @path
    dataProductId: string;

    /**
     * Get data asset Id
     */
    @path
    dataAssetId: string;

    /**
     * Scoped asset meta data body
     */
    @bodyRoot
    body: DataSourceEntity;
  },
  DataSourceEntity
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/scoped-asset-metadata")
@put
op createScopedAssetMetaData is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get data product Id
     */
    @path
    dataProductId: string;

    /**
     * Get data asset Id
     */
    @path
    dataAssetId: string;

    /**
     * Scoped asset meta data body
     */
    @bodyRoot
    body: DataSourceEntity;
  },
  DataSourceEntityResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/profiles")
@pollingOperation(Profile)
@put
op Profile is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get data product Id
     */
    @path
    dataProductId: string;

    /**
     * Get data asset Id
     */
    @path
    dataAssetId: string;

    /**
     * Scoped asset meta data body
     */
    @bodyRoot
    profiles: ProfileEntity;
  },
  ProfileEntityResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/profiles/{profileRunId}")
@delete
op `Delete Profile` is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get data product Id
     */
    @path
    dataProductId: string;

    /**
     * Get data asset Id
     */
    @path
    dataAssetId: string;

    /**
     * Get Profile Run Id
     */
    @path
    profileRunId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/schedules/{scheduleId}/scans/{scanId}/runs")
@get
op GetRuns is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get schedule Id
     */
    @path
    scheduleId: string;

    /**
     * Get scan id
     */
    @path
    scanId: string;

    /**
     * Get offset
     */
    @query("offset")
    offset: int64;
  },
  ScheduleScanMonitoringEntity[]
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/report/snapshots/dataquality/latest")
@get
op GetLatestSnapshot is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;
  },
  EmptyResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/rule-opinions/{ruleId}")
@get
op OpinionTrend is Azure.Core.Foundations.Operation<
  {
    /**
     * Get Business Domain Id
     */
    @path
    businessDomainId: string;

    /**
     * Get data product Id
     */
    @path
    dataProductId: string;

    /**
     * Get data asset Id
     */
    @path
    dataAssetId: string;

    /**
     * Get Rule Id
     */
    @path
    ruleId: string;
  },
  OpinionEntity
>;
