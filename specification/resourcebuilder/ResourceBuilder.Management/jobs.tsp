import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ResourceBuilder;

/** Job resource */
@parentResource(Pipeline)
model Job is ProxyResource<JobProperties> {
  /** The name of the job. */
  @segment("jobs")
  @key("jobName")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,63}$")
  name: string;

  /** Job kind discriminator. Determines which properties are valid for this job. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "kind is a valid top-level property for Job resource"
  kind: JobKind;
}

/** Job properties - properties vary by kind.
 * Each job kind has specific required and optional properties as documented below.
 */
model JobProperties {
  /** Provisioning state of the job. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  // ============================================
  // Common properties (available for all kinds)
  // ============================================
  /** Input datasets for the job. Required for AzureDataExplorerPublish and DataQualityValidation jobs. */
  inputs?: JobDataset[];

  /** Output datasets for the job. */
  outputs?: JobDataset[];

  // ============================================
  // Batch job specific properties (kind: "Batch")
  // ============================================
  /** Processing logic for the job. Required for Batch jobs. */
  processingLogic?: ProcessingLogic;

  /** Primary key attributes for the batch job. */
  @identifiers(#["keyAttribute"])
  primaryKeyAttributes?: PrimaryKeyAttribute[];

  /** Snapshot merge strategy. Used by Batch jobs. */
  snapshotMergeStrategy?: SnapshotMergeStrategy;

  /** Lookback start offset for merging with previous snapshot. Used by Batch jobs. */
  lookbackStartOffset?: string;

  /** Retention window to evict latest records. Used by Batch jobs. */
  retentionWindow?: string;

  // ============================================
  // AzureStorageAccountIngestion job specific properties (kind: "AzureStorageAccountIngestion")
  // ============================================
  /** Name of the output dataset for the job. Required for AzureStorageAccountIngestion and AzureDataExplorerIngestion jobs. */
  outputDatasetName?: string;

  /** Path to the blob partition used for data ingestion. Required for AzureStorageAccountIngestion jobs. */
  blobPartitionPath?: string;

  /** Time offset for the job execution. Used by AzureStorageAccountIngestion jobs. */
  timeOffset?: string;

  // ============================================
  // AzureDataExplorerPublish job specific properties (kind: "AzureDataExplorerPublish")
  // ============================================
  /** Sink to which data will be published in Azure Data Explorer. Required for AzureDataExplorerPublish jobs. */
  sink?: AzureDataExplorerSink;

  // ============================================
  // AzureDataExplorerIngestion job specific properties (kind: "AzureDataExplorerIngestion")
  // ============================================
  // Note: Uses processingLogic and outputDatasetName (defined above)

  // ============================================
  // DataQualityValidation job specific properties (kind: "DataQualityValidation")
  // ============================================

  /** Metric evaluations. Required for DataQualityValidation jobs. */
  metrics?: DataQualityMetrics;

  /** Data quality dataset validation. Required for DataQualityValidation jobs. */
  dataQualityValidation?: DataQualityValidation;

  // ============================================
  // AzureResourceNotificationPublish job specific properties (kind: "AzureResourceNotificationPublish")
  // ============================================
  /** Resource type (resource or relationship). Required for AzureResourceNotificationPublish jobs. */
  resourceType?: ResourceNotificationResourceType;

  // ============================================
  // AzureResourceGraph_Galaxy job specific properties (kind: "AzureResourceGraph_Galaxy")
  // ============================================
  // Note: Uses processingLogic, inputs, and outputs (defined above)
}

/** Job kind */
union JobKind {
  /** Batch job kind. */
  Batch: "Batch",

  /** Stream job kind. */
  Stream: "Stream",

  /** Azure Storage Account Ingestion job kind. */
  AzureStorageAccountIngestion: "AzureStorageAccountIngestion",

  /** Azure Data Explorer Publish job kind. */
  AzureDataExplorerPublish: "AzureDataExplorerPublish",

  /** Azure Data Explorer Ingestion job kind. */
  AzureDataExplorerIngestion: "AzureDataExplorerIngestion",

  /** Data Quality Validation job kind. */
  DataQualityValidation: "DataQualityValidation",

  /** Azure Resource Notification Publish job kind. */
  AzureResourceNotificationPublish: "AzureResourceNotificationPublish",

  /** Azure Resource Graph Galaxy job kind. */
  AzureResourceGraph_Galaxy: "AzureResourceGraph_Galaxy",

  string,
}

/** Job dataset reference */
model JobDataset {
  /** Dataset reference. */
  dataset: DatasetReference;

  /** View name of the dataset. Note: this can be used in the view name of the processing job logic of the job. */
  name?: string;

  /** Lookback start offset of the dataset, which defines how far back in time the dataset should consider data. */
  lookbackStartOffset?: string;

  /** Lookback end offset of the dataset, which defines the end of the time range for the dataset's data. */
  lookbackEndOffset?: string;

  /** Policy for handling missing partitions. Defaults to Fail. */
  missingPartitionPolicy?: MissingPartitionPolicy;
}

/** Dataset reference */
model DatasetReference {
  /** Resource ID of the dataset. Required when type is ResourceId. */
  id?: string;

  /** Canonical name of the dataset. Required when type is Catalog. */
  canonicalName?: string;

  /** Reference type. Determines which field (id or canonicalName) is required. */
  type: DatasetReferenceType;
}

/** Dataset reference type */
union DatasetReferenceType {
  /** Resource ID reference type. */
  ResourceId: "ResourceId",

  /** Catalog reference type. */
  Catalog: "Catalog",

  string,
}

/** Missing partition policy */
union MissingPartitionPolicy {
  /** Fail policy. */
  Fail: "Fail",

  /** Ignore policy. */
  Skip: "Skip",

  string,
}

/** Snapshot merge strategy */
union SnapshotMergeStrategy {
  /** No merge strategy. */
  NoMerge: "NoMerge",

  /** Incremental merge strategy. */
  IncrementalMerge: "IncrementalMerge",

  string,
}

/** Processing logic for a job */
model ProcessingLogic {
  /** The value or script to be executed as part of the processing logic (e.g., SQL, KQL, etc.). */
  value: string;

  /** The type of processing logic to be executed by the job. */
  type: ProcessingLogicType;
}

/** Processing logic type */
union ProcessingLogicType {
  /** Spark SQL processing logic type. */
  SparkSQL: "SparkSQL",

  /** KQL processing logic type. */
  KQL: "KQL",

  /** Azure Resource Graph KQL processing logic type. */
  ARG_KQL: "ARG_KQL",

  string,
}

/** Primary key attributes for batch job */
model PrimaryKeyAttribute {
  /** The key attribute. */
  keyAttribute: string;

  /** The timestamp attribute. */
  timestampAttribute: string;
}

/** Sink type */
union SinkType {
  /** Azure Data Explorer sink type. */
  AzureDataExplorerSink: "AzureDataExplorerSink",

  /** Resource Notification sink type. */
  ResourceNotificationSink: "ResourceNotificationSink",

  string,
}

/** Dataset sink base model */
@discriminator("type")
model DatasetSink {
  /** Sink type discriminator. */
  type: SinkType;

  /** Name of the sink. */
  name: string;
}

/** Azure Data Explorer sink */
model AzureDataExplorerSink extends DatasetSink {
  /** Sink type. */
  type: "AzureDataExplorerSink";

  /** Connection string or identifier for the Azure Data Explorer cluster. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Mark with @secret if the contents of this property should be kept private."
  azureDataExplorerClusterConnection: string;

  /** Name of the database within the Azure Data Explorer cluster. */
  azureDataExplorerClusterDatabase: string;

  /** Publish mode, which determines how data is written to the sink. Defaults to Overwrite. */
  publishMode?: PublishMode;

  /** Folder name of the Azure Data Explorer table. */
  folderName?: string;

  /** Table name of the Azure Data Explorer table. */
  tableName?: string;
}

/** Resource Notification sink */
model ResourceNotificationSink extends DatasetSink {
  /** Sink type. */
  type: "ResourceNotificationSink";
}

/** Publish mode */
union PublishMode {
  /** Overwrite publish mode. */
  Overwrite: "Overwrite",

  /** Append publish mode. */
  Append: "Append",

  string,
}

/** Resource notification resource type */
union ResourceNotificationResourceType {
  /** Default resource notification type. */
  Default: "Default",

  /** Resource notification for a resource. */
  Resource: "Resource",

  /** Resource notification for a relationship. */
  Relationship: "Relationship",

  string,
}

/** Data quality validation */
model DataQualityValidation {
  /** Dataset validation condition. */
  validationCondition: DataQualityValidationCondition;

  /** Validations to perform. */
  validations: string[];
}

/** Data quality validation condition */
union DataQualityValidationCondition {
  /** Always succeed condition. */
  AlwaysSucceed: "alwaysSucceed",

  /** Any validation succeeds condition. */
  Any: "any",

  /** All validations succeed condition. */
  All: "all",

  string,
}

/** Data quality metric evaluation */
model DataQualityMetricEvaluation {
  /** Metric evaluation type. */
  metricEvaluationType: DataQualityMetricEvaluationType;

  /** Filter of the metric evaluation. */
  filter?: string;

  /** Columns of the metric evaluation. */
  columns?: string[];

  /** Metric type of the evaluation. */
  metricType: DataQualityMetricType;

  /** Metric unit of the evaluation. Defaults to Count. */
  metricUnit?: DataQualityMetricUnit;

  /** Column name for the start time metric. */
  startTimeMetricColumn?: string;

  /** Column name for the end time metric. */
  endTimeMetricColumn?: string;
}

/** Data quality metric evaluation type */
union DataQualityMetricEvaluationType {
  /** Unknown evaluation type. */
  Unknown: "unknown",

  /** Table count evaluation type. */
  TableCount: "tableRowCount",

  /** Non-null column count evaluation type. */
  NonNullColumnCount: "nonNullColumnCount",

  /** Latency evaluation type. */
  Latency: "latency",

  /** Size evaluation type. */
  Size: "size",

  string,
}

/** Data quality metric type */
union DataQualityMetricType {
  /** Unknown metric type. */
  Unknown: "unknown",

  /** Count metric type. */
  Count: "count",

  /** Minimum metric type. */
  Minimum: "minimum",

  /** Maximum metric type. */
  Maximum: "maximum",

  /** P50 metric type. */
  P50: "P50",

  /** P90 metric type. */
  P90: "P90",

  /** Distinct count metric type. */
  DistinctCount: "distinctCount",

  string,
}

/** Data quality metric unit */
union DataQualityMetricUnit {
  /** Count unit. */
  Count: "count",

  /** Seconds unit. */
  Seconds: "seconds",

  /** Minutes unit. */
  Minutes: "minutes",

  /** Hours unit. */
  Hours: "hours",

  string,
}

/** Data quality metric validation */
model DataQualityMetricValidation {
  /** Data quality metric validation type. */
  dataQualityMetricValidationType?: DataQualityMetricValidationType;

  /** Data quality metric evaluation name. */
  dataQualityMetricEvaluationName?: string;

  /** Columns to validate. */
  columns?: string[];

  /** Denominator for validation. */
  denominator?: string;

  /** Upper threshold for validation. */
  upperThreshold?: float64;

  /** Lower threshold for validation. */
  lowerThreshold?: float64;

  /** Anomaly detection parameters. */
  anomalyDetectionParameters?: AutoDataQualityParameters;
}

/** Data quality metric validation type */
union DataQualityMetricValidationType {
  /** Unknown validation type. */
  Unknown: "unknown",

  /** Anomaly validation type. */
  AnomalyValidation: "anomalyValidation",

  /** Ratio validation type. */
  RatioValidation: "ratioValidation",

  /** Threshold validation type. */
  ThresholdValidation: "thresholdValidation",

  string,
}

/** Anomaly detection mode */
union AnomalyMode {
  /** Detects anomalies in either the negative or positive direction. */
  IsAnomaly: "isAnomaly",

  /** Detects anomalies only in the positive direction. */
  IsPositiveAnomaly: "isPositiveAnomaly",

  /** Detects anomalies only in the negative direction. */
  IsNegativeAnomaly: "isNegativeAnomaly",

  string,
}

/** Data quality metrics */
model DataQualityMetrics {
  /** Metric evaluations. */
  evaludations: DataQualityMetricEvaluationEntry[];

  /** Metric validations. */
  validations: DataQualityMetricValidationEntry[];
}

/** Data quality metric evaluation entry with name */
model DataQualityMetricEvaluationEntry {
  /** Name of the metric evaluation. */
  name: string;

  /** Metric evaluation details. */
  evaluation: DataQualityMetricEvaluation;
}

/** Data quality metric validation entry with name */
model DataQualityMetricValidationEntry {
  /** Name of the metric validation. */
  name: string;

  /** Metric validation details. */
  validation: DataQualityMetricValidation;
}

/** Auto data quality parameters */
model AutoDataQualityParameters {
  /** Sensitivity for anomaly detection. The value should be between 0 and 100. Defaults to 90. */
  sensitivity?: int32;

  /** Anomaly detection mode. */
  anomalyMode?: AnomalyMode;

  /** Lookback window in days. */
  lookbackWindowInDays?: int32;

  /** Minimum data points required for executing anomaly detection. */
  minimumDataPoints?: int32;

  /** Maximum data points required for executing anomaly detection. */
  maximumDataPoints?: int32;

  /** Maximum allowed margin. */
  maxAllowedMargin?: int32;

  /** Maximum allowed margin in percent. */
  maxAllowedMarginPercent?: int32;
}

@armResourceOperations
interface Jobs {
  get is ArmResourceRead<Job>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Job>;
  delete is ArmResourceDeleteSync<Job>;
  list is ArmResourceListByParent<Job>;
}
