import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias DataQualityOperation = Azure.Core.ResourceOperations<ServiceTraits>;

namespace PurviewDataQuality {
  /**
   * Create Rules for Assets
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/rules")
  @put
  @tag("Rules")
  @doc("Creates rules for a specific data asset within a data product and business domain.")
  op CreateRules is RpcOperation<
    {
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      @doc("Unique identifier for the data product containing the data asset")
      @path
      dataProductId: string;

      @doc("Unique identifier for the data asset")
      @path
      dataAssetId: string;

      @doc("Rule creation request")
      @body
      request: RuleEntities;
    },
    RuleEntityResponse
  >;

  /**
   * Get Rules for Assets
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @get
  @tag("Rules")
  @doc("Retrieves all rules associated with data assets.")
  op getRules is DataQualityOperation.ResourceList<RuleParameters>;

  /**
   * Update a rule
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @patch(#{ implicitOptionality: true })
  @tag("Rules")
  @doc("Updates an existing rule associated with a data asset.")
  op updateRule is DataQualityOperation.ResourceUpdate<RuleEntities>;

  /**
   * Delete a rule
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @delete
  @tag("Rules")
  @doc("Deletes a specific rule associated with a data asset.")
  op deleteRule is DataQualityOperation.ResourceDelete<RuleParameters>;

  /**
   * Get a Rule
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @get
  @tag("Rules")
  @doc("Retrieves a specific rule associated with a data asset.")
  op getRule is DataQualityOperation.ResourceRead<RuleParameters>;

  /**
   * Create Bulk Rules for Assets
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/bulk-rules")
  @put
  @tag("Rules")
  @doc("Creates bulk rules for a specific data asset within a data product and business domain.")
  op createBulkRules is RpcOperation<
    {
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      @doc("Unique identifier for the data product containing the data asset")
      @path
      dataProductId: string;

      @doc("Unique identifier for the data asset for the bulk rules operation")
      @path
      dataAssetId: string;

      @doc("Bulk rules creation request")
      @body
      request: BulkRulesRequest;
    },
    BulkRulesResponse
  >;

  /**
   * Get Observer
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @get
  @tag("AssetMetadata")
  @doc("Retrieves the asset metadata associated with a Data Asset.")
  @route("/data-assets/{dataAssetId}/asset-metadata")
  op getObserver is RpcOperation<
    {
      /**
       * The unique identifier for the data asset whose metadata observer is being retrieved.
       * Data assets represent individual datasets, tables, or data sources that can be
       * monitored for quality, profiling, and observability within a data product.
       */
      @doc("Unique identifier for the data asset whose metadata observer is being retrieved")
      @path
      dataAssetId: string;
    },
    AssetMetadata
  >;

  /**
   * Update Asset Metadata Observer
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  @route("/data-assets/{dataAssetId}/asset-metadata")
  @patch(#{ implicitOptionality: true })
  @tag("AssetMetadata")
  @doc("Updates the asset metadata  associated with a Data Asset.")
  op updateObserver is RpcOperation<
    {
      @doc("Unique identifier for the data asset whose metadata observer is being updated")
      @path
      dataAssetId: string;

      @doc("Asset metadata update request")
      @body
      request: AssetMetadata;
    },
    AssetMetadataObserverResponse
  >;

  /**
   * Get all schedules for a business domain.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @tag("Schedules")
  @doc("Retrieves all scheduled jobs defined under a given business domain, optionally supporting pagination with `skipToken`.")
  @get
  op getSchedules is DataQualityOperation.ResourceList<
    ScheduleEntity,
    {
      @query("skipToken")
      @doc("Continuation token for pagination of results.")
      skipToken?: string;
    }
  >;

  /**
   * Create a new schedule under a specific Business Domain.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("Schedules")
  @doc("Creates a new scheduled job under a business domain for selected data assets.")
  @route("/business-domains/{businessDomainId}/schedules/{scheduleId}")
  @put
  op createSchedule is RpcOperation<
    {
      /**
       * The unique identifier for the business domain that contains the data product.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      /**
       * The unique identifier for the scan within the business domain.
       * Scans define automated execution patterns for data quality operations,
       * and monitoring activities within the context of a business domain.
       */
      @doc("Unique identifier for the scheduled job within the business domain")
      @path
      scheduleId: string;

      @doc("The payload for creating scheduled job")
      @bodyRoot
      request: ScheduleEntity;
    },
    ScheduleEntityResponse
  >;

  /**
   * Get Schedule
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @tag("Schedules")
  @doc("Retrieves a specific scheduled job by its unique identifier under a business domain.")
  @get
  op getSchedule is DataQualityOperation.ResourceRead<ScheduleEntity>;

  /**
   * Update Schedule
   */
  /**
   * Update Schedule
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  @tag("Schedules")
  @doc("Updates the details of an existing schedule under a specific business domain.")
  @patch(#{ implicitOptionality: true })
  @route("/business-domains/{businessDomainId}/schedules/{scheduleId}")
  op updateSchedule is RpcOperation<
    {
      /**
       * The unique identifier for the business domain that contains the data product.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      /**
       * The unique identifier for the schedule within the business domain.
       * Schedules define automated execution patterns for data quality operations,
       * scans, and monitoring activities within the context of a business domain.
       */
      @doc("Unique identifier for the schedule within the business domain")
      @path
      scheduleId: string;

      #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Should use unknown to model Object"
      @doc("The payload for creating schedule")
      @bodyRoot
      request: ScheduleEntity;
    },
    ScheduleEntityResponse
  >;

  /**
   * Delete Schedule
   */
  /**
   * Delete Schedule
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @tag("Schedules")
  @doc("Deletes a specific schedule under a given business domain.")
  @delete
  op deleteSchedule is DataQualityOperation.ResourceDelete<ScheduleEntity>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @tag("ScheduleScan")
  @pollingOperation(scans)
  @doc("Creates a scan under a specific business domain and schedule.")
  @post
  op scans is DataQualityOperation.ResourceAction<
    ScheduleEntity,
    ScanDTO,
    ScanDTOResponse
  >;

  /**
   * Cancel Scan
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  @post
  @tag("ScheduleScan")
  @doc("Cancels a specific scan under a given schedule within a business domain.")
  @route("/business-domains/{businessDomainId}/schedules/{scheduleId}/scans/{scanId}:cancel")
  op cancelScan is RpcOperation<
    {
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      @doc("Unique identifier for the scheduled job within the business domain")
      @path
      scheduleId: string;

      @doc("Unique identifier for the scan within the scheduled job")
      @path
      scanId: string;
    },
    {
      @statusCode
      statusCode: 202;

      @doc("Scan cancellation response")
      @body
      response: ScanDTOResponse;
    }
  >;

  /**
   * Get Scan by ScanId
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("ScheduleScan")
  @doc("Retrieves details of a specific scan under a given schedule within a business domain.")
  @route("/business-domains/{businessDomainId}/schedules/{scheduleId}/scans/{scanId}")
  @get
  op scanByScanId is RpcOperation<
    {
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      @doc("Unique identifier for the scheduled job within the business domain")
      @path
      scheduleId: string;

      @doc("Unique identifier for the scan within the scheduled job")
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
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("JobRunMonitoring")
  @doc("Retrieves execution metadata and status for a specific schedule run within a business domain.")
  @route("/business-domains/{businessDomainId}/runs/{runId}")
  @get
  op getRunStatus is RpcOperation<
    {
      @doc("Unique identifier for the business domain containing the data product")
      businessDomainId: string;

      @doc("Unique identifier for the run within the business domain")
      @path
      runId: string;
    },
    JobMetadataEntity
  >;
  /**
   * Cancel Scan Run
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  @route("/business-domains/{businessDomainId}/runs/{runId}:cancel")
  @post
  @tag("JobRunMonitoring")
  @doc("Cancels a specific scan run within a business domain.")
  op cancelScanByRunId is RpcOperation<
    {
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      @doc("Unique identifier for the run within the business domain")
      @path
      runId: string;
    },
    {
      @statusCode
      statusCode: 202;

      @doc("Scan run cancellation response")
      @body
      response: ScanDTOResponse;
    }
  >;
  /**
   * Get runs for asset
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("JobRunMonitoring")
  @doc("Retrieves all runs associated with a specific data asset, optionally filtered by run type.")
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/runs")
  @get
  op getRunsForAsset is RpcOperation<
    {
      @doc("The unique identifier for the business domain.")
      @path
      businessDomainId: string;

      @doc("The unique identifier for the data product.")
      @path
      dataProductId: string;

      @doc("The unique identifier for the data asset.")
      @path
      dataAssetId: string;

      @query("runType")
      @doc("Specifies the type of run to filter results by (e.g., 'Scan' or 'Validation').")
      runType: string;
    },
    JobHistoryResponse
  >;

  /**
   * Do an observation
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @tag("DQ Assessment Observations")
  @doc("Triggers a long-running observation job for a specific data asset.")
  @post
  @pollingOperation(observations)
  op observations is DataQualityOperation.ResourceAction<
    DataAsset,  // Resource context (businessDomainId, dataProductId, dataAssetId)
    JobConfigDTO,  // Request body (job configuration)
    JobConfigDTOResponse // Response body
  >;

  /**
   * Deletes a specific observation.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @delete
  @tag("DQ Assessment Observations")
  @doc("Deletes a specific observation associated with a data asset.")
  op deleteObservation is DataQualityOperation.ResourceDelete<ObservationAssetMetadata>;

  /**
   * Get all Data Sources for a given Business Domain
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("DataSources")
  @doc("Retrieves all data sources connections for a given business domain, with optional name filtering and pagination.")
  @route("/business-domains/{businessDomainId}/data-sources")
  @get
  op getDataSources is RpcOperation<
    {
      /**
       * The unique identifier for the business domain containing the data sources.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain containing the data sources")
      @path
      businessDomainId: string;

      @query("skipToken")
      @doc("Continuation token for paginated results.")
      skipToken?: string;

      @query("name")
      @doc("Optional name filter for data sources.")
      name?: string;
    },
    DataSourceEntityListResponse
  >;
  /**
   * Get Data Source for a given data source id
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  @tag("DataSources")
  @doc("Retrieves a specific data source connection by its ID within a given business domain, with optional query parameters.")
  @route("/business-domains/{businessDomainId}/data-sources/{dataSourceId}")
  @get
  op getDataSource is RpcOperation<
    {
      /**
       * The unique identifier for the business domain containing the data source.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain containing the data source")
      @path
      businessDomainId: string;

      /**
       * The unique identifier for the data source within the business domain.
       * Data sources represent connections to external systems or databases
       * that provide data for quality monitoring and governance activities.
       */
      @doc("Unique identifier for the data source connection within the business domain")
      @path
      dataSourceId: string;

      @query("skipToken")
      @doc("Continuation token for paginated results.")
      skipToken?: string;

      @query("name")
      @doc("Optional name filter for data sources.")
      name?: string;
    },
    DataSourceEntity
  >;

  /**
   * Delete data source
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @tag("DataSources")
  @doc("Deletes a specific data source connection within a given business domain.")
  @delete
  op deleteDataSource is DataQualityOperation.ResourceDelete<DataSource>;

  /**
   * Update data source
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  @tag("DataSources")
  @doc("Updates an existing data source within a given business domain.")
  @route("/business-domains/{businessDomainId}/data-sources/{dataSourceId}")
  @patch(#{ implicitOptionality: true })
  op updateDataSource is RpcOperation<
    {
      /**
       * The unique identifier for the business domain containing the data source.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain containing the data source")
      @path
      businessDomainId: string;

      /**
       * The unique identifier for the data source within the business domain.
       * Data sources represent connections to external systems or databases
       * that provide data for quality monitoring and governance activities.
       */
      @doc("Unique identifier for the data source connection to be updated")
      @path
      dataSourceId: string;

      /**
       * The updated data source entity containing the modifications to be applied.
       */
      @doc("Updated data source entity with partial modifications")
      @bodyRoot
      request: DataSourceEntity;
    },
    DataSourceEntity
  >;

  /**
   * Create data source
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("DataSources")
  @doc("Creates a new data source connection under a given business domain.")
  @route("/business-domains/{businessDomainId}/data-sources/{dataSourceId}")
  @put
  op createDataSource is RpcOperation<
    {
      /**
       * The unique identifier for the business domain that will contain the new data source.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain that will contain the new data source")
      @path
      businessDomainId: string;

      /**
       * The unique identifier for the data source within the business domain.
       * Data sources represent connections to external systems or databases
       * that provide data for quality monitoring and governance activities.
       */
      @doc("Unique identifier for the data source connection to be created")
      @path
      dataSourceId: string;

      /**
       * The data source entity containing the configuration and properties for the new data source.
       */
      @doc("Data source entity with configuration for the new data source")
      @bodyRoot
      request: DataSourceEntity;
    },
    DataSourceEntityResponse
  >;

  /**
   * Deletes the scoped asset metadata for a specific data asset.
   *
   * Example:
   * ```
   * DELETE /business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/scoped-asset-metadata
   * ```
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("Scoped Asset Metadata")
  @doc("Deletes the scoped asset metadata for a given data asset within a business domain.")
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/scoped-asset-metadata")
  @delete
  op deleteScopedAssetMetaData is RpcOperation<
    {
      /**
       * The unique identifier for the business domain that contains the data product.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      /**
       * The unique identifier for the data product that contains the data asset.
       * Data products are collections of related data assets that serve specific
       * business purposes or analytical use cases within a business domain.
       */
      @doc("Unique identifier for the data product containing the data asset")
      @path
      dataProductId: string;

      /**
       * The unique identifier for the data asset whose scoped metadata is being deleted.
       * Data assets represent individual datasets, tables, or data sources that can be
       * monitored for quality, profiling, and observability within a data product.
       */
      @doc("Unique identifier for the data asset whose scoped metadata is being deleted")
      @path
      dataAssetId: string;
    },
    EmptyResponse
  >;

  /**
   * Get scoped asset meta data
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("Scoped Asset Metadata")
  @doc("Retrieves the scoped asset metadata for a given data asset within a business domain.")
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/scoped-asset-metadata")
  @get
  op getScopedAssetMetaData is RpcOperation<
    {
      /**
       * The unique identifier for the business domain that contains the data product.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      /**
       * The unique identifier for the data product that contains the data asset.
       * Data products are collections of related data assets that serve specific
       * business purposes or analytical use cases within a business domain.
       */
      @doc("Unique identifier for the data product containing the data asset")
      @path
      dataProductId: string;

      /**
       * The unique identifier for the data asset whose scoped metadata is being retrieved.
       * Data assets represent individual datasets, tables, or data sources that can be
       * monitored for quality, profiling, and observability within a data product.
       */
      @doc("Unique identifier for the data asset whose scoped metadata is being retrieved")
      @path
      dataAssetId: string;
    },
    ScopedAssetMetadata
  >;

  /**
   * Update scoped asset meta data
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("Scoped Asset Metadata")
  @doc("Updates the scoped asset metadata for a given data asset within a business domain.")
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/scoped-asset-metadata")
  @patch(#{ implicitOptionality: true })
  op updateScopedAssetMetaData is RpcOperation<
    {
      /**
       * The unique identifier for the business domain that contains the data product.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      /**
       * The unique identifier for the data product that contains the data asset.
       * Data products are collections of related data assets that serve specific
       * business purposes or analytical use cases within a business domain.
       */
      @doc("Unique identifier for the data product containing the data asset")
      @path
      dataProductId: string;

      /**
       * The unique identifier for the data asset whose scoped metadata is being updated.
       * Data assets represent individual datasets, tables, or data sources that can be
       * monitored for quality, profiling, and observability within a data product.
       */
      @doc("Unique identifier for the data asset whose scoped metadata is being updated")
      @path
      dataAssetId: string;

      /**
       * The updated scoped asset metadata containing the modifications to be applied.
       */
      @doc("Updated scoped asset metadata with partial modifications")
      @bodyRoot
      request: ScopedAssetMetadata;
    },
    ScopedAssetMetadata
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("Scoped Asset Metadata")
  @doc("Creates or replaces the scoped asset metadata for a given data asset within a business domain.")
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/scoped-asset-metadata")
  @put
  op createScopedAssetMetaData is RpcOperation<
    {
      /**
       * The unique identifier for the business domain that contains the data product.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      /**
       * The unique identifier for the data product that contains the data asset.
       * Data products are collections of related data assets that serve specific
       * business purposes or analytical use cases within a business domain.
       */
      @doc("Unique identifier for the data product containing the data asset")
      @path
      dataProductId: string;

      /**
       * The unique identifier for the data asset whose scoped metadata is being created or replaced.
       * Data assets represent individual datasets, tables, or data sources that can be
       * monitored for quality, profiling, and observability within a data product.
       */
      @doc("Unique identifier for the data asset whose scoped metadata is being created or replaced")
      @path
      dataAssetId: string;

      /**
       * The scoped asset metadata entity containing the configuration and properties.
       */
      @doc("Scoped asset metadata entity with configuration and properties")
      @bodyRoot
      request: ScopedAssetMetadata;
    },
    ScopedAssetMetadata
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("Profiles")
  @doc("Creates or updates the profile for a given data asset within a business domain. Supports polling as a long-running operation.")
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}:profiles")
  @post
  @pollingOperation(profile)
  op profile is RpcOperation<
    {
      /**
       * The unique identifier for the business domain that contains the data product.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      /**
       * The unique identifier for the data product that contains the data asset.
       * Data products are collections of related data assets that serve specific
       * business purposes or analytical use cases within a business domain.
       */
      @doc("Unique identifier for the data product containing the data asset")
      @path
      dataProductId: string;

      /**
       * The unique identifier for the data asset whose profile is being created or updated.
       * Data assets represent individual datasets, tables, or data sources that can be
       * monitored for quality, profiling, and observability within a data product.
       */
      @doc("Unique identifier for the data asset whose profile is being created or updated")
      @path
      dataAssetId: string;

      /**
       * The profile entity containing the configuration and properties for the profile operation.
       */
      @doc("Profile entity with configuration and properties")
      @bodyRoot
      request: ProfileEntity;
    },
    ProfileEntityResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @tag("Profiles")
  @doc("Deletes a specific profile run for a given data asset within a business domain.")
  @delete
  op deleteProfileRun is DataQualityOperation.ResourceDelete<ProfileRun>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("JobRunMonitoring")
  @doc("Retrieves all runs associated with a specific scan under a given schedule.")
  @route("/business-domains/{businessDomainId}/schedules/{scheduleId}/scans/{scanId}/runs")
  @get
  op getRuns is RpcOperation<
    {
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      @doc("Unique identifier for the scheduled job within the business domain")
      @path
      scheduleId: string;

      @doc("Unique identifier for the scan within the scheduled job")
      @path
      scanId: string;

      @query("offset")
      @doc("Offset value for pagination or incremental retrieval of runs.")
      offset: int64;
    },
    ScheduleScanMonitoringResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("Reports")
  @doc("Retrieves the latest data quality snapshot report for a given business domain.")
  @route("/business-domains/{businessDomainId}/report/snapshots")
  @get
  op getLatestSnapshot is RpcOperation<
    {
      /**
       * The unique identifier for the business domain for which to retrieve the latest data quality snapshot.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain")
      @path
      businessDomainId: string;
    },
    {
      @doc("The data quality snapshot report content")
      @body
      content: DataQualityTrendResponse;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("Trend")
  @doc("Retrieves the opinion trend for a specific profile rule under a given data asset.")
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/rule-opinions/{ruleId}")
  @get
  op opinionTrend is RpcOperation<
    {
      /**
       * The unique identifier for the business domain that contains the data product.
       * Business domains represent high-level organizational units for data governance
       * and provide the top-level context for all data products and assets within them.
       */
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      /**
       * The unique identifier for the data product that contains the data asset.
       * Data products are collections of related data assets that serve specific
       * business purposes or analytical use cases within a business domain.
       */
      @doc("Unique identifier for the data product containing the data asset")
      @path
      dataProductId: string;

      /**
       * The unique identifier for the data asset whose rule opinion trend is being retrieved.
       * Data assets represent individual datasets, tables, or data sources that can be
       * monitored for quality, profiling, and observability within a data product.
       */
      @doc("Unique identifier for the data asset whose rule opinion trend is being retrieved")
      @path
      dataAssetId: string;

      /**
       * The unique identifier of the rule for which to retrieve the opinion trend.
       * Rules define data quality checks and validations that can be applied to data assets.
       */
      @doc("Unique identifier of the rule for opinion trend retrieval")
      @path
      ruleId: string;

      @query("startTime")
      @doc("Start time for the opinion trend query. If specified, endTime must also be provided. Maximum time window is 90 days.")
      startTime?: utcDateTime;

      @query("endTime")
      @doc("End time for the opinion trend query. Can only be used with startTime. Maximum time window is 90 days.")
      endTime?: utcDateTime;

      @query("maxRecordsToReturn")
      @doc("Maximum number of records to return in a single request. Must be between 1 and 100. Default is 10.")
      maxRecordsToReturn?: int32;
    },
    {
      @doc("List of opinion entities for the rule trend")
      @body
      value: OpinionEntity[];
    }
  >;

  /**
   * Get bulk asset metadata for all assets in an account
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @tag("BulkMetadata")
  @doc("Retrieves metadata for all assets in an account with pagination support. Returns up to 10 assets per request.")
  @route("/bulk-asset-metadata")
  @get
  op getBulkAssetMetadata is RpcOperation<
    {
      @query("continuationToken")
      @doc("Continuation token for pagination. Use this to get all results until continuationToken from the response becomes null.")
      continuationToken?: string;
    },
    BulkAssetMetadataResponse
  >;

  /**
   * Insert bulk asset metadata into a new account
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @tag("BulkMetadata")
  @doc("Inserts metadata for multiple assets into a new account ID.")
  @route("/bulk-asset-metadata")
  @put
  op createBulkAssetMetadata is RpcOperation<
    {
      @doc("Bulk asset metadata to insert")
      @bodyRoot
      request: BulkAssetMetadataRequest;
    },
    {
      @statusCode
      statusCode: 201;

      @doc("Success message")
      @body
      message: string;
    }
  >;
}
