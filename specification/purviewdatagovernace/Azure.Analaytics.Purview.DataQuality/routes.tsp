import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";

using TypeSpec.Http;
using Azure.Core.Traits;

namespace PurviewDataQuality;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias DataQualityOperations = Azure.Core.ResourceOperations<ServiceTraits>;
/**
 * Create Rules for Assets
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/global-rules")
@post
op CreateRules is Azure.Core.Foundations.Operation<
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
     * Rule entity
     */
    @bodyRoot
    body: RuleEntity;
  },
  RuleEntityResponse
>;

/**
 * Get Rules for Assets
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/global-rules")
@get
op getRules is Azure.Core.Foundations.Operation<
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
  },
  RuleEntity
>;

/**
 * Update a rule
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/global-rules/{ruleId}")
@put
op updateRule is Azure.Core.Foundations.Operation<
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
     * Unique Identifier for Rule
     */
    @path
    ruleId: string;

    /**
     * Body Rule Entity
     */
    @bodyRoot
    body?: RuleEntity;
  },
  RuleEntity
>;

/**
 * Delete a rule
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/global-rules/{ruleId}")
@delete
op deleteRule is Azure.Core.Foundations.Operation<
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
     * Unique Identifier for Rule
     */
    @path
    ruleId: string;
  },
  void
>;

/**
 * Get a Rule
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/global-rules/{ruleId}")
@get
op getRule is Azure.Core.Foundations.Operation<
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
     * Unique Identifier for Rule
     */
    @path
    ruleId: string;
  },
  RuleEntity
>;

/**
 * Create Bulk Rules for Assets
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/bulk/global-rules")
@post
op createBulkRules is Azure.Core.Foundations.Operation<
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
     * Body Rule Entity
     */
    #suppress "@azure-tools/typespec-azure-core/request-body-problem"
    @bodyRoot
    body?: RuleEntity[];
  },
  RuleEntityListResponse
>;

/**
 * Create Asset Metadata Observer
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/asset-metadata")
@post
op createAssetMetaData is Azure.Core.Foundations.Operation<
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
     * Asset Meta data observer
     */
    @bodyRoot
    body?: AssetMetadataObserver;
  },
  AssetMetadataObserverResponse
>;

/**
 * Get Observer
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/asset-metadata")
@get
op getObserver is Azure.Core.Foundations.Operation<
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
  },
  AssetMetadataObserver
>;

/**
 * Update Observer
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/asset-metadata")
@put
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
    @query("$skipToken")
    $skipToken?: string;
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
@post
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
@put
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
@post
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
@route("/business-domains/{businessDomainId}/schedules/{scheduleId}/scans/{scanId}/cancel")
@post
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
@route("/business-domains/{businessDomainId}/runs/{runId}/cancel")
@post
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
  JobHistoryEntity
>;

/**
 * Do an observation
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/observations")
@post
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
