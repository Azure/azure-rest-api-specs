import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

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
model ScheduleEntity {
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
   * Scope of the scan.
   */
  scope?: ScanScope;

  /**
   * Trigger configuration for the schedule.
   */
  trigger?: Trigger;

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
