import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewDataQuality;

union AssetMetadataObserverType {
  string,
  Basic: "Basic",
}

/**
 * Represents a business/data quality rule entity.
 */
model RuleEntity {
  name: string;
  description?: string;
  type: string;
  status: string;

  /**
   * Holds additional properties related to rule type.
   */
  typeProperties?: TypeProperties;

  @format("uuid")
  id: string;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  businessDomain?: Reference;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  dataProduct?: Reference;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  dataAsset?: Reference;

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
  type?: string;
  value?: string;
}

/**
 * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
 */
model Reference {
  type?: string;

  @format("uuid")
  referenceId?: string;
}

/**
 * Represents metadata observer entity for a data asset.
 */
model AssetMetadataObserver {
  @format("uuid")
  id?: string;

  name?: string;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  dataAsset?: Reference;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  createdBy?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;

  lastModifiedBy?: string;

  /**
   * Dictionary of <any>
   */
  executionData?: Record<unknown>;

  isDeleted?: boolean;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  businessDomain?: Reference;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  dataProduct?: Reference;

  eTag?: string;
  type?: AssetMetadataObserverType;
}

model ScheduleEntity {
  name?: string;
  id?: string;
  description?: string;

  /**
   * Dictionary of <AnyObject>
   */
  annotations?: Record<unknown>;

  /**
   * Reference to another entity (BusinessDomain, DataProduct, DataAsset).
   */
  businessDomain?: Reference;

  scope?: ScanScope;
  trigger?: Trigger;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;

  lastModifiedBy?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  createdBy?: string;

  /**
   * Dictionary of <AnyObject>
   */
  executionData?: Record<unknown>;
}

model ScanScope {
  type?: string;
  referenceId?: string;
}

model Trigger {
  type?: string;
  cron?: string;
}

model ScanDTO {
  scanType?: string;
}

model ScheduleScanMonitoringEntity {
  succeeded?: int64;
  failed?: int64;
  skipped?: int64;
  scheduleStatus?: string;
  scheduleName?: string;
  scheduleId?: string;
  scanId?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  accountId?: string;
  businessDomainId?: string;
  totalJobCount?: int64;
  status?: string;
  scheduleRunType?: string;
  scanType?: string;
  startedBy?: string;
  cancelledBy?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  cancelRequestTime?: utcDateTime;

  partitionKey?: string;
  rowKey?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  eTag?: string;
}

model JobMetadataEntity {
  runId?: string;
  dataProductId?: string;
  redundancyCheck?: boolean;
  accountId?: string;
  businessDomainId?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  submissionTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  cancelRequestTime?: utcDateTime;

  status?: string;
  pfsJobId?: string;
  message?: string;
  duration?: int64;
  startedBy?: string;
  cancelledBy?: string;
  jobType?: string;
  jobExecutionRegion?: string;
  dataAssetId?: string;
  dataAssetName?: string;
  scheduleId?: string;
  scheduleName?: string;
  qualifiedPath?: string;
  scanId?: string;
  scheduleScanType?: string;
  jobBillingSparkSku?: string;
  dataSourceType?: string;
  primaryDataSourceID?: string;
  puDetail?: string;
}

model JobHistoryEntity {
  @minLength(1)
  dataAssetId: string;

  @minLength(1)
  runId: string;

  @minLength(1)
  dataProductId: string;

  @minLength(1)
  businessDomainId: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  submissionTime?: utcDateTime;

  status?: string;
  jobType?: string;
  accountId?: string;
}

model JobConfigDTO {
  redundancyCheck?: boolean;
  datasetToDatasourceMappings?: DatasetToDatasourceMapping[];
}

model DatasetToDatasourceMapping {
  datasetAliasName?: string;
  datasourceId?: string;
}
