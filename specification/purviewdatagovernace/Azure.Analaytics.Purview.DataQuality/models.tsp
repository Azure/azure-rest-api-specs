import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace PurviewDataQuality;

/**
 * AssetMetaDataObserverType
 */
union AssetMetadataObserverType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",
}

/**
 * Rule Parameters
 */
@parentResource(DataAsset)
@resource("rules")
model RuleParameters {
  /**
   * Unique Identifier for Rule
   */
  @key("ruleId")
  @visibility(Lifecycle.Create)
  ruleId: string;

  /**
   * Rule Entity response
   */
  response?: RuleEntity;
}

/**
 * Rule Entities
 */
@parentResource(DataAsset)
@resource("rules")
model RuleEntities {
  /**
   * Unique Identifier for Rule
   */
  @key("ruleId")
  @visibility(Lifecycle.Create)
  ruleId: string;

  /**
   * ruleEntity
   */
  ruleEntity: RuleEntity;
}

/**
 * Business Domain
 */
@resource("business-domains")
model BusinessDomain {
  /**
   * Get Business Domain
   */
  @key
  @visibility(Lifecycle.Create)
  businessDomainId: string; // This tells TypeSpec this is the path parameter
}

/**
 * Data Product
 */
@parentResource(BusinessDomain)
@resource("data-products")
model DataProduct {
  /**
   * Get Data Product
   */
  @key
  @visibility(Lifecycle.Create)
  dataProductId: string; // This tells TypeSpec this is the path parameter
}

/**
 * Data Asset
 */
@parentResource(DataProduct)
@resource("data-assets")
model DataAsset {
  /**
   * Get Data Asset
   */
  @key
  @visibility(Lifecycle.Create)
  dataAssetId: string; // This tells TypeSpec this is the path parameter
}

/**
 * Resource ID parameters for hierarchical path binding
 */
model DataAssetRuleResourceId {
  /**
   * Get Business Domain
   */
  @path
  businessDomainId: string;

  /**
   * Get Data Product
   */
  @path
  dataProductId: string;

  /**
   * Get Data Asset
   */
  @path
  dataAssetId: string;
}

/**
 * Represents a business/data quality rule entity.
 */
model RuleEntity {
  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  name: string;

  /**
   * Represents description of the rule.
   */
  description?: string;

  /**
   * Represents the type of rule.
   */
  type: string;

  /**
   * Represents the status of the rule.
   */
  status: string;

  /**
   * Holds additional properties related to rule type.
   */
  typeProperties?: TypeProperties;

  /**
   * Unique identifier of the rule.
   */
  id: string;

  /**
   * Reference to the related BusinessDomain entity.
   */
  businessDomain?: Reference;

  /**
   * Reference to the related DataProduct entity.
   */
  dataProduct?: Reference;

  /**
   * Reference to the related DataAsset entity.
   */
  dataAsset?: Reference;

  /**
   * Represents the rule's score.
   */
  score?: float64;
}

alias rulesParameter = {
  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  businessDomainId: string;

  /**
   * Represents description of the rule.
   */
  dataProductId: string;

  /**
   * Represents the type of rule.
   */
  dataAssetId: string;
};

/**
 * Holds additional properties related to rule type.
 */
model TypeProperties {
  /**
   * Represents a column in a dataset.
   */
  column?: Column;
}

/**
 * Represents a column in a dataset.
 */
model Column {
  /**
   * The type of the column.
   */
  type?: string;

  /**
   * The value of the column.
   */
  value?: string;
}

/**
 * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
 */
model Reference {
  /**
   * Type of the referenced entity.
   */
  type?: string;

  /**
   * Unique identifier of the referenced entity.
   */
  referenceId?: string;
}

/**
 * Represents a business/data quality rule entity.
 */
model RuleEntityResponse {
  /**
   * Status Code
   */
  @statusCode
  statusCode: 201;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  name: string;

  /**
   * Represents description of the rule.
   */
  description?: string;

  /**
   * Represents the type of rule.
   */
  type: string;

  /**
   * Represents the status of the rule.
   */
  status: string;

  /**
   * Holds additional properties related to rule type.
   */
  typeProperties?: TypeProperties;

  /**
   * Unique identifier of the rule.
   */
  id: string;

  /**
   * Reference to the related BusinessDomain entity.
   */
  businessDomain?: Reference;

  /**
   * Reference to the related DataProduct entity.
   */
  dataProduct?: Reference;

  /**
   * Reference to the related DataAsset entity.
   */
  dataAsset?: Reference;

  /**
   * Represents the rule's score.
   */
  score?: float64;
}

/**
 * Represents a business/data quality rule entity.
 */
model RuleEntityBulkResponse {
  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  name: string;

  /**
   * Represents description of the rule.
   */
  description?: string;

  /**
   * Represents the type of rule.
   */
  type: string;

  /**
   * Represents the status of the rule.
   */
  status: string;

  /**
   * Holds additional properties related to rule type.
   */
  typeProperties?: TypeProperties;

  /**
   * Unique identifier of the rule.
   */
  id: string;

  /**
   * Reference to the related BusinessDomain entity.
   */
  businessDomain?: Reference;

  /**
   * Reference to the related DataProduct entity.
   */
  dataProduct?: Reference;

  /**
   * Reference to the related DataAsset entity.
   */
  dataAsset?: Reference;

  /**
   * Represents the rule's score.
   */
  score?: float64;
}

/**
 * Rule entity response
 */
model RuleEntityListResponse {
  /**
   * Status Code
   */
  @statusCode
  statusCode: 201;

  /**
   * Value RuleEntity
   */
  value: RuleEntityBulkResponse[];
}

/**
 * Represents metadata observer entity for a data asset.
 */
model AssetMetadataObserver {
  /**
   * Unique identifier of the observer.
   */
  id?: string;

  /**
   * Name of the observer.
   */
  name?: string;

  /**
   * Reference to the associated DataAsset entity.
   */
  dataAsset?: Reference;

  /**
   * Timestamp when the observer was created.
   */
  createdAt?: utcDateTime;

  /**
   * User who created the observer.
   */
  createdBy?: string;

  /**
   * Timestamp when the observer was last modified.
   */
  lastModifiedAt?: utcDateTime;

  /**
   * User who last modified the observer.
   */
  lastModifiedBy?: string;

  /**
   * Dictionary containing execution data.
   */
  executionData?: Record<string>;

  /**
   * Indicates if the observer is deleted.
   */
  isDeleted?: boolean;

  /**
   * Reference to the related BusinessDomain entity.
   */
  businessDomain?: Reference;

  /**
   * Reference to the related DataProduct entity.
   */
  dataProduct?: Reference;

  /**
   * ETag used for concurrency control.
   */
  eTag?: string;

  /**
   * Type of the observer.
   */
  type?: AssetMetadataObserverType;
}

/**
 * Represents a scheduled scan entity.
 */
model ScheduleEntityResponse {
  /**
   * Status Code
   */
  @statusCode
  statusCode: 201;

  /**
   * Name of the schedule.
   */
  name?: string;

  /**
   * Unique identifier of the schedule.
   */
  id?: string;

  /**
   * Description of the schedule.
   */
  description?: string;

  /**
   * Dictionary of annotations for the schedule.
   */
  annotations?: Record<string>;

  /**
   * Reference to the related BusinessDomain entity.
   */
  businessDomain?: Reference;

  /**
   * Scope of the scan, including data products and data assets.
   */
  scope?: {
    items: Array<{
      dataProduct: {
        referenceId: string;
        type: string;
      };
      dataAsset: {
        referenceId: string;
        type: string;
      };
    }>;
  };

  /**
   * Trigger configuration for the schedule.
   */
  trigger?: {
    type: string;
    typeProperties: {
      timezone?: string;
      isScheduled?: boolean;
      triggerTime?: utcDateTime;
    };
  };

  /**
   * Timestamp when the schedule was last modified.
   */
  lastModifiedAt?: utcDateTime;

  /**
   * User who last modified the schedule.
   */
  lastModifiedBy?: string;

  /**
   * Timestamp when the schedule was created.
   */
  createdAt?: utcDateTime;

  /**
   * User who created the schedule.
   */
  createdBy?: string;

  /**
   * Dictionary of execution data for the schedule.
   */
  executionData?: Record<string>;
}

/**
 * Represents a scheduled scan entity.
 */
model ScheduleEntity {
  /**
   * Unique identifier of the schedule.
   */
  id?: string;

  /**
   * Name of the schedule.
   */
  name?: string;

  /**
   * Description of the schedule.
   */
  description?: string;

  /**
   * Trigger configuration for the schedule.
   */
  trigger?: {
    type: string;
    typeProperties: {
      timezone?: string;
      isScheduled?: boolean;
      triggerTime?: utcDateTime;
    };
  };

  /**
   * Scope of the scan, including data products and data assets.
   */
  scope?: {
    items: Array<{
      dataProduct: {
        referenceId: string;
        type: string;
      };
      dataAsset: {
        referenceId: string;
        type: string;
      };
    }>;
  };

  /**
   * Reference to the related BusinessDomain entity.
   */
  businessDomain?: {
    type: string;
    referenceId: string;
  };

  /**
   * Timestamp when the schedule was created.
   */
  createdAt?: utcDateTime;

  /**
   * Timestamp when the schedule was last modified.
   */
  lastModifiedAt?: utcDateTime;

  /**
   * User who created the schedule.
   */
  createdBy?: string;

  /**
   * User who last modified the schedule.
   */
  lastModifiedBy?: string;

  /**
   * Entity tag for concurrency control.
   */
  eTag?: string;
}

/**
 * Defines the scan scope.
 */
model ScanScope {
  /**
   * Type of the scope.
   */
  type?: string;

  /**
   * Identifier of the referenced entity for the scope.
   */
  referenceId?: string;
}

/**
 * Defines a trigger for scans.
 */
model Trigger {
  /**
   * Type of trigger (e.g., manual, scheduled).
   */
  type?: string;

  /**
   * Cron expression for scheduled triggers.
   */
  cron?: string;
}

/**
 * Data transfer object for scan information.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
model ScanDTO {
  /**
   * Type of the scan.
   */
  scanType?: string;
}

/**
 * Monitoring information for schedule scans.
 */
model ScheduleScanMonitoringEntity {
  /**
   * Number of succeeded scans.
   */
  succeeded?: int64;

  /**
   * Number of failed scans.
   */
  failed?: int64;

  /**
   * Number of skipped scans.
   */
  skipped?: int64;

  /**
   * Status of the schedule.
   */
  scheduleStatus?: string;

  /**
   * Name of the schedule.
   */
  scheduleName?: string;

  /**
   * Unique identifier of the schedule.
   */
  scheduleId?: string;

  /**
   * Unique identifier of the scan.
   */
  scanId?: string;

  /**
   * Timestamp when the scan started.
   */
  startTime?: utcDateTime;

  /**
   * Timestamp when the scan ended.
   */
  endTime?: utcDateTime;

  /**
   * Identifier of the account.
   */
  accountId?: string;

  /**
   * Identifier of the business domain.
   */
  businessDomainId?: string;

  /**
   * Total number of jobs in the scan.
   */
  totalJobCount?: int64;

  /**
   * Status of the scan.
   */
  status?: string;

  /**
   * Type of schedule run.
   */
  scheduleRunType?: string;

  /**
   * Type of the scan.
   */
  scanType?: string;

  /**
   * User who started the scan.
   */
  startedBy?: string;

  /**
   * User who cancelled the scan.
   */
  cancelledBy?: string;

  /**
   * Timestamp when a cancel request was made.
   */
  cancelRequestTime?: utcDateTime;

  /**
   * Partition key for storage.
   */
  partitionKey?: string;

  /**
   * Row key for storage.
   */
  rowKey?: string;

  /**
   * Timestamp of the record.
   */
  timestamp?: utcDateTime;

  /**
   * ETag for concurrency control.
   */
  eTag?: string;
}

/**
 * Metadata for jobs.
 */
model JobMetadataEntity {
  /**
   * Unique run identifier for the job.
   */
  runId?: string;

  /**
   * Identifier of the data product.
   */
  dataProductId?: string;

  /**
   * Indicates if redundancy check is enabled.
   */
  redundancyCheck?: boolean;

  /**
   * Account identifier.
   */
  accountId?: string;

  /**
   * Business domain identifier.
   */
  businessDomainId?: string;

  /**
   * Timestamp when the job was submitted.
   */
  submissionTime?: utcDateTime;

  /**
   * Timestamp when the job started.
   */
  startTime?: utcDateTime;

  /**
   * Timestamp when the job ended.
   */
  endTime?: utcDateTime;

  /**
   * Timestamp when a cancel request was made.
   */
  cancelRequestTime?: utcDateTime;

  /**
   * Current job status.
   */
  status?: string;

  /**
   * Platform job ID.
   */
  pfsJobId?: string;

  /**
   * Job-related message.
   */
  message?: string;

  /**
   * Duration of the job in milliseconds.
   */
  duration?: int64;

  /**
   * User who started the job.
   */
  startedBy?: string;

  /**
   * User who cancelled the job.
   */
  cancelledBy?: string;

  /**
   * Type of job.
   */
  jobType?: string;

  /**
   * Region where the job executed.
   */
  jobExecutionRegion?: string;

  /**
   * Identifier of the associated data asset.
   */
  dataAssetId?: string;

  /**
   * Name of the associated data asset.
   */
  dataAssetName?: string;

  /**
   * Schedule identifier if job is scheduled.
   */
  scheduleId?: string;

  /**
   * Schedule name if job is scheduled.
   */
  scheduleName?: string;

  /**
   * Fully qualified path related to the job.
   */
  qualifiedPath?: string;

  /**
   * Scan identifier associated with the job.
   */
  scanId?: string;

  /**
   * Type of schedule scan.
   */
  scheduleScanType?: string;

  /**
   * Spark SKU used for job billing.
   */
  jobBillingSparkSku?: string;

  /**
   * Type of data source.
   */
  dataSourceType?: string;

  /**
   * Primary data source identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  primaryDataSourceID?: string;

  /**
   * Additional details related to Purview.
   */
  puDetail?: string;
}

/**
 * Job history information.
 */
model JobHistoryEntity {
  /**
   * Identifier of the data asset.
   */
  @minLength(1)
  dataAssetId: string;

  /**
   * Job run identifier.
   */
  @minLength(1)
  runId: string;

  /**
   * Identifier of the data product.
   */
  @minLength(1)
  dataProductId: string;

  /**
   * Business domain identifier.
   */
  @minLength(1)
  businessDomainId: string;

  /**
   * Timestamp when the job started.
   */
  startTime?: utcDateTime;

  /**
   * Timestamp when the job ended.
   */
  endTime?: utcDateTime;

  /**
   * Timestamp when the job was submitted.
   */
  submissionTime?: utcDateTime;

  /**
   * Status of the job.
   */
  status?: string;

  /**
   * Type of job.
   */
  jobType?: string;

  /**
   * Account identifier.
   */
  accountId?: string;
}

/**
 * Configuration for jobs.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
model JobConfigDTO {
  /**
   * Indicates if redundancy check is enabled.
   */
  redundancyCheck?: boolean;

  /**
   * Mappings between datasets and data sources.
   */
  datasetToDatasourceMappings?: DatasetToDatasourceMapping[];
}

/**
 * rule creation status
 */
model RuleCreationStatus {
  /**
   * Current state of the long-running operation
   */
  @lroStatus
  status: LroStatus;
}

/**
 * lro status
 */
union LroStatus {
  /**
   * In Progress status
   */
  InProgress: "InProgress",

  /**
   * Succeeded status
   */
  Succeeded: "Succeeded",

  /**
   * Failed status
   */
  Failed: "Failed",

  string,
}

/**
 * Maps a dataset to a datasource.
 */
model DatasetToDatasourceMapping {
  /**
   * Alias name of the dataset.
   */
  datasetAliasName?: string;

  /**
   * Identifier of the datasource.
   */
  datasourceId?: string;
}

/**
 * Job Config DTO Response
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
model JobConfigDTOResponse {
  /**
   * Status Code
   */
  @statusCode
  statusCode: 202;

  /**
   * Value
   */
  value: string;

  /**
   * lro status
   */
  @lroStatus
  statuslro: LroStatus;
}

/**
 * Job Config DTO Response
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
model ScanDTOResponse {
  /**
   * Status Code
   */
  @statusCode
  statusCode: 202;

  /**
   * Scan Id
   */
  scanId?: string;

  /**
   * lro status
   */
  @lroStatus
  statuslro: LroStatus;
}

/**
 * Represents metadata observer entity for a data asset.
 */
model AssetMetadataObserverResponse {
  /**
   * Status Code
   */
  @statusCode
  statusCode: 201;

  /**
   * id
   */
  id?: string;

  /**
   * name
   */
  name?: string;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  dataAsset?: Reference;

  /**
   * created at
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * created by
   */
  createdBy?: string;

  /**
   * last modified by
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;

  /**
   * last modified
   */
  lastModifiedBy?: string;

  /**
   * Dictionary of <any>
   */
  executionData?: Record<string>;

  /**
   * isDeleted
   */
  isDeleted?: boolean;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  businessDomain?: Reference;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  dataProduct?: Reference;

  /**
   * eTag
   */
  eTag?: string;

  /**
   * type
   */
  type?: AssetMetadataObserverType;
}

/**
 * Represents a data source entity with metadata, configuration, and optional scopes.
 */
model DataSourceEntity {
  /**
   * The display name of the data source connection.
   */
  name: string;

  /**
   * Unique identifier for the data source.
   */
  id?: string;

  /**
   * Indicates whether the data source is enabled with Virtual Network (VNet).
   */
  isVnetEnabled: boolean;

  /**
   * The Azure resource ID of the target resource (if applicable).
   */
  targetResourceId?: string;

  /**
   * The business domain this data source belongs to.
   */
  businessDomain: {
    /**
     * Type of business domain reference.
     */
    type: string;

    /**
     * Unique identifier for the business domain.
     */
    referenceId: string;
  };

  /**
   * ISO 8601 timestamp when the data source was last modified.
   */
  lastModifiedAt?: string;

  /**
   * Identifier (GUID or user ID) of the last modifier.
   */
  lastModifiedBy?: string;

  /**
   * The type of the data source (e.g., AzureSqlDatabase, Snowflake, AzureSynapseAnalytics).
   */
  type: string;

  /**
   * A dictionary of key-value pairs with additional properties
   * specific to the data source type.
   */
  typeProperties: Record<string>;

  /**
   * Optional list of scopes that define access levels or boundaries for this data source.
   */
  scopes?: Array<{
    /**
     * The scope definition containing type and included objects.
     */
    scope: {
      /**
       * The scope type (e.g., Sql).
       */
      type: string;

      /**
       * List of included items in the scope.
       */
      includes: string[];
    };

    /**
     * Unique identifier for the scope.
     */
    id: string;
  }>;
}

/**
 * Represents a data source entity with metadata, configuration, and optional scopes.
 */
model DataSourceEntityResponse {
  /**
   * Status Code
   */
  @statusCode
  statusCode: 201;

  /**
   * The display name of the data source connection.
   */
  name: string;

  /**
   * Unique identifier for the data source.
   */
  id: string;

  /**
   * Indicates whether the data source is enabled with Virtual Network (VNet).
   */
  isVnetEnabled: boolean;

  /**
   * The Azure resource ID of the target resource (if applicable).
   */
  targetResourceId?: string;

  /**
   * The business domain this data source belongs to.
   */
  businessDomain: {
    /**
     * Type of business domain reference.
     */
    type: string;

    /**
     * Unique identifier for the business domain.
     */
    referenceId: string;
  };

  /**
   * ISO 8601 timestamp when the data source was last modified.
   */
  lastModifiedAt: string;

  /**
   * Identifier (GUID or user ID) of the last modifier.
   */
  lastModifiedBy: string;

  /**
   * The type of the data source (e.g., AzureSqlDatabase, Snowflake, AzureSynapseAnalytics).
   */
  type: string;

  /**
   * A dictionary of key-value pairs with additional properties
   * specific to the data source type.
   */
  typeProperties: Record<string>;

  /**
   * Optional list of scopes that define access levels or boundaries for this data source.
   */
  scopes?: Array<{
    /**
     * The scope definition containing type and included objects.
     */
    scope: {
      /**
       * The scope type (e.g., Sql).
       */
      type: string;

      /**
       * List of included items in the scope.
       */
      includes: string[];
    };

    /**
     * Unique identifier for the scope.
     */
    id: string;
  }>;
}

/**
 * Profile Entity
 */
model ProfileEntity {
  /**
   * type
   */
  type: string;

  /**
   * Type properties
   */
  typeProperties: {
    location: {
      type: string;
      typeProperties: {
        fileSystem: string;
        folderPath: string;
      };
    }[];
  };

  /**
   * data source id
   */
  dataSourceId: string;

  /**
   * configuration
   */
  configuration: {
    keyColumns: {
      name: string;
    }[];
  };
}

/**
 * Profile Entity
 */
model ProfileEntityResponse {
  /**
   * status code
   */
  @statusCode
  statusCode: 202;

  /**
   * profile run id
   */
  profileRunId: string;

  /**
   * lro status
   */
  @lroStatus
  statuslro: LroStatus;
}

/**
 * Opinion Entity
 */
model OpinionEntity {
  /**
   * Get Business domain Id
   */
  businessDomainId: string;

  /**
   * Get data product id
   */
  dataProductId: string;

  /**
   * Get data asset id
   */
  dataAssetId: string;

  /**
   * Get control id
   */
  controlId: string;

  /**
   * Get opinion id
   */
  opinionId: string;

  /**
   * Get value
   */
  value?: string;

  /**
   * Get result At
   */
  resultedAt: utcDateTime;

  /**
   * Get outcomeId
   */
  outcomeId: string;

  /**
   * Get queryExecutionId
   */
  queryExecuted?: string;
}

/**
 * Empty response
 */
model EmptyResponse {}
