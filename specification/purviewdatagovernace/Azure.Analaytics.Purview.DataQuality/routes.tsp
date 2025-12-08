import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/openapi";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.OpenAPI;

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

      @doc("Unique identifier for the rule")
      @path
      ruleId: string;

      @doc("Rule creation request")
      @body
      request: RuleEntity;
    },
    {
      @doc("HTTP status code indicating successful rule creation (201 Created)")
      @statusCode
      statusCode: 201;

      @doc("Created rule entity with complete configuration and metadata")
      @body
      rule: RuleEntity;
    }
  >;

  /**
   * Get Rules for Assets
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/rules")
  @get
  @tag("Rules")
  @doc("Retrieves all rules associated with data assets.")
  op getRules is RpcOperation<
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
    },
    {
      @doc("Array of rule entities")
      @body
      rules: RuleEntity[];
    }
  >;

  /**
   * Update a rule
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @patch(#{ implicitOptionality: true })
  @tag("Rules")
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/rules/{ruleId}")
  @doc("Updates an existing rule associated with a data asset.")
  op updateRule is RpcOperation<
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

      @doc("Unique identifier for the rule to update")
      @path
      ruleId: string;

      @doc("Rule update request")
      @body
      request: RuleEntity;
    },
    {
      @doc("Created rule entity with complete configuration and metadata")
      @body
      rule: RuleEntity;
    }
  >;

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
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/rules/{ruleId}")
  @get
  @tag("Rules")
  @doc("Retrieves a specific rule associated with a data asset.")
  op getRule is RpcOperation<
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

      @doc("Unique identifier for the data quality rule")
      @path
      ruleId: string;
    },
    {
      @doc("Rule entity with complete configuration and metadata")
      @body
      rule: RuleEntity;
    }
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
    {
      @statusCode
      statusCode: 201;

      @doc("Updated asset metadata")
      @body
      response: AssetMetadata;
    }
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
      request: ScheduleEntityRequestResponse;
    },
    {
      @statusCode
      statusCode: 201;

      @doc("Created schedule entity response")
      @body
      response: ScheduleEntityRequestResponse;
    }
  >;

  /**
   * Get Schedule
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  @tag("Schedules")
  @doc("Retrieves a specific scheduled job by its unique identifier under a business domain.")
  @route("/business-domains/{businessDomainId}/schedules/{scheduleId}")
  @get
  op getSchedule is RpcOperation<
    {
      @doc("Unique identifier for the business domain containing the data product")
      @path
      businessDomainId: string;

      @doc("Unique identifier for the scheduled job within the business domain")
      @path
      scheduleId: string;
    },
    ScheduleEntityRequestResponse
  >;

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
      request: ScheduleEntityRequestResponse;
    },
    {
      @statusCode
      statusCode: 200;

      @doc("Updated schedule entity response")
      @body
      response: ScheduleEntityRequestResponse;
    }
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Need to specify long-running operation extensions for 202 responses"
  @tag("ScheduleScan")
  @extension("x-ms-long-running-operation", true)
  @doc("Creates a scan under a specific business domain and schedule.")
  @post
  op scans is DataQualityOperation.ResourceAction<
    ScheduleEntity,
    ScanDTO,
    {
      @statusCode
      statusCode: 202;

      @body
      response: StatusMonitor;
    }
  >;

  /**
   * Cancel Scan
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "RpcOperation with path parameters is intentional for this service."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Need to specify long-running operation extensions for 202 responses"
  @post
  @tag("ScheduleScan")
  @doc("Cancels a specific scan under a given schedule within a business domain.")
  @extension("x-ms-long-running-operation", true)
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
      response: StatusMonitor;
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Need to specify long-running operation extensions for 202 responses"
  @route("/business-domains/{businessDomainId}/runs/{runId}:cancel")
  @post
  @tag("JobRunMonitoring")
  @doc("Cancels a specific scan run within a business domain.")
  @extension("x-ms-long-running-operation", true)
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
      response: StatusMonitor;
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
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Need to specify long-running operation extensions for 202 responses"
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}:observations")
  @tag("DQ Assessment Observations")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-examples",
    #{ Observation_Create: #{ $ref: "./examples/Observation_Create.json" } }
  )
  @doc("Triggers a long-running observation job for a specific data asset.")
  @post
  op observations is RpcOperation<
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

      @doc("Job configuration request payload")
      @body
      request: JobConfigDTO;
    },
    {
      @statusCode
      statusCode: 202;

      @doc("Status monitor for observation operation")
      @body
      response: StatusMonitor;
    }
  >;

  /**
   * Deletes a specific observation.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Need to specify long-running operation extensions for 202 responses"
  @delete
  @tag("DQ Assessment Observations")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-examples",
    #{ Observation_Delete: #{ $ref: "./examples/Observation_Delete.json" } }
  )
  @doc("Deletes a specific observation associated with a data asset.")
  op deleteObservation is DataQualityOperation.ResourceDelete<ObservationAssetMetadata>;

  /**
   * Retrieves all data source connections for a given business domain.
   *
   * This operation returns a paginated list of data source configurations,
   * including platform type, connectivity settings, and governance metadata.
   *
   * Supports optional filtering by data source name and continuation token-based pagination.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  @tag("DataSources")
  @doc("Retrieves all data source connections for a given business domain, with optional name filtering and pagination.")
  @route("/business-domains/{businessDomainId}/data-sources")
  @get
  op getDataSources is RpcOperation<
    {
      /**
       * The unique identifier of the business domain that contains the data sources.
       *
       * Business domains represent high-level organizational contexts for
       * data governance and ownership. Each business domain may contain multiple
       * data sources, data products, and assets.
       */
      @doc("Unique identifier of the business domain whose data sources are being retrieved.")
      @path
      businessDomainId: string;

      /**
       * Continuation token for retrieving the next set of paginated results.
       *
       * Returned by previous list operations when there are more results available.
       */
      @doc("Continuation token used for pagination of data source results.")
      @query("skipToken")
      skipToken?: string;

      /**
       * Optional case-insensitive name filter for narrowing the data sources list.
       *
       * Matches data source names that contain the specified substring.
       */
      @doc("Optional name filter to match data sources by partial or full name.")
      @query("name")
      name?: string;
    },
    {
      /**
       * HTTP 200 response indicating that the data sources were successfully retrieved.
       */
      @doc("HTTP 200 response indicating successful retrieval of data sources.")
      @statusCode
      statusCode: 200;

      /**
       * Response body containing the paginated list of data source entities,
       * each with its full configuration and metadata.
       */
      @doc("Body containing a paginated list of data source entities and their configurations.")
      @body
      body: DataSourceEntityListResponse;
    }
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @tag("DataSources")
  @doc("Updates an existing data source within a given business domain.")
  @extension(
    "x-ms-examples",
    #{ DataSource_Update: #{ $ref: "./examples/DataSource_Update.json" } }
  )
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
    {
      @statusCode
      statusCode: 201;

      @doc("Created data source entity with complete configuration and metadata")
      @body
      response: DataSourceEntity;
    }
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
    {
      @doc("Scoped asset metadata successfully deleted")
      @statusCode
      statusCode: 204;
    }
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
  @doc("Create or update the scoped asset metadata for a given data asset within a business domain.")
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
  /**
   * Create or update profile
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Multiple path parameters are required for this nested resource operation."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Should mention long running operations for actions"
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}:profile")
  @tag("Profiles")
  @extension("x-ms-long-running-operation", true)
  @doc("Creates or updates the profile for a given data asset within a business domain. Supports polling as a long-running operation.")
  @post
  op profile is RpcOperation<
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

      @doc("Profile entity request payload")
      @body
      request: ProfileEntity;
    },
    {
      @statusCode
      statusCode: 202;

      @doc("Status monitor for profile operation")
      @body
      response: StatusMonitor;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @tag("Profiles")
  @doc("Deletes a specific profile run for a given data asset within a business domain.")
  @extension(
    "x-ms-examples",
    #{ Profile_Delete: #{ $ref: "./examples/Profile_Delete.json" } }
  )
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
  @route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{assetId}/snapshots")
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

      @doc("Unique Data Product Identifier")
      @path
      dataProductId: string;

      @doc("Unique Data Asset Identifier")
      @path
      assetId: string;
    },
    {
      @doc("The data quality snapshot report content")
      @body
      content: ScoreSnapshot;
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
    BulkAssetMetadataRequestResponse
  >;

  /**
   * Insert bulk asset metadata into a new account
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @tag("BulkMetadata")
  @doc("Inserts metadata for multiple assets into a new account ID.")
  @extension(
    "x-ms-examples",
    #{
      BulkAssetMetadata_Create: #{
        $ref: "./examples/BulkAssetMetadata_Create.json",
      },
    }
  )
  @route("/bulk-asset-metadata")
  @put
  op createBulkAssetMetadata is RpcOperation<
    {
      @doc("Bulk asset metadata to insert")
      @bodyRoot
      request: BulkAssetMetadataRequestResponse;
    },
    {
      @statusCode
      statusCode: 201;

      @doc("Successful Response body")
      @body
      body: BulkAssetMetadataRequestResponse;
    }
  >;
}
