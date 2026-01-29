import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MachineLearningServices;

/**
 * Alias for proxy api version parameter
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
alias ProxyApiVersion = {
  /**
   * Api version used by proxy call
   */
  @query("proxy-api-version")
  `proxy-api-version`?: string;
};

/**
 * An enum describing the unit of usage measurement.
 */
union UsageUnit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Count: "Count",
}

/**
 * Three lettered code specifying the currency of the VM price. Example: USD
 */
union BillingCurrency {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  USD: "USD",
}

/**
 * The unit of time measurement for the specified VM price. Example: OneHour
 */
union UnitOfMeasure {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OneHour: "OneHour",
}

/**
 * Operating system type used by the VM.
 */
union VMPriceOSType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Linux: "Linux",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Windows: "Windows",
}

/**
 * The type of the VM.
 */
union VMTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  LowPriority: "LowPriority",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Spot: "Spot",
}

/**
 * An enum describing the unit of quota measurement.
 */
union QuotaUnit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Count: "Count",
}

/**
 * Status of update workspace quota.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Undefined: "Undefined",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Success: "Success",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failure: "Failure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  InvalidQuotaBelowClusterMinimum: "InvalidQuotaBelowClusterMinimum",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  InvalidQuotaExceedsSubscriptionLimit: "InvalidQuotaExceedsSubscriptionLimit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  InvalidVMFamilyName: "InvalidVMFamilyName",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OperationNotSupportedForSku: "OperationNotSupportedForSku",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OperationNotEnabledForRegion: "OperationNotEnabledForRegion",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Key: "Key",
}

/**
 * The type of compute
 */
union ComputeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AKS: "AKS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Kubernetes: "Kubernetes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AmlCompute: "AmlCompute",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ComputeInstance: "ComputeInstance",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  DataFactory: "DataFactory",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  VirtualMachine: "VirtualMachine",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  HDInsight: "HDInsight",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Databricks: "Databricks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  DataLakeAnalytics: "DataLakeAnalytics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SynapseSpark: "SynapseSpark",
}

/**
 * The provision state of the cluster. Valid values are Unknown, Updating, Provisioning, Succeeded, and Failed.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Canceled: "Canceled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union UnderlyingResourceAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Delete: "Delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Detach: "Detach",
}

/**
 * Type of the image. Possible values are: docker - For docker images. azureml - For AzureML Environment images (custom and curated)
 */
union ImageType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  docker: "docker",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  azureml: "azureml",
}

/**
 * Type of the Environment Variable. Possible values are: local - For local variable
 */
union EnvironmentVariableType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  local: "local",
}

/**
 * Protocol over which communication will happen over this endpoint
 */
union Protocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  tcp: "tcp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  udp: "udp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  http: "http",
}

/**
 * Type of Volume Definition. Possible Values: bind,volume,tmpfs,npipe
 */
union VolumeDefinitionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  bind: "bind",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  volume: "volume",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  tmpfs: "tmpfs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  npipe: "npipe",
}

/**
 * State of the compute node. Values are idle, running, preparing, unusable, leaving and preempted.
 */
union NodeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  idle: "idle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  running: "running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  preparing: "preparing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  unusable: "unusable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  leaving: "leaving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  preempted: "preempted",
}

/**
 * Data source type.
 */
union SourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Dataset: "Dataset",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Datastore: "Datastore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  URI: "URI",
}

/**
 * Mount Action.
 */
union MountAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Mount: "Mount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Unmount: "Unmount",
}

/**
 * Mount Mode.
 */
union MountMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ReadOnly: "ReadOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ReadWrite: "ReadWrite",
}

/**
 * Mount state.
 */
union MountState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  MountRequested: "MountRequested",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Mounted: "Mounted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  MountFailed: "MountFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UnmountRequested: "UnmountRequested",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UnmountFailed: "UnmountFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Unmounted: "Unmounted",
}

/**
 * Provisioning state of registry asset.
 */
union AssetProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
}

/**
 * Type of storage to use for the pending upload location
 */
union PendingUploadType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  TemporaryBlobReference: "TemporaryBlobReference",
}

/**
 * Enum to determine the PendingUpload credentials type.
 */
union PendingUploadCredentialType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SAS: "SAS",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union ListViewType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ActiveOnly: "ActiveOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ArchivedOnly: "ArchivedOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  All: "All",
}

/**
 * Enum to determine the type of data.
 */
union DataType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  uri_file: "uri_file",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  uri_folder: "uri_folder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  mltable: "mltable",
}

/**
 * Enum to determine the DataReference credentials type.
 */
union DataReferenceCredentialType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SAS: "SAS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  DockerCredentials: "DockerCredentials",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  NoCredentials: "NoCredentials",
}

/**
 * AutoRebuild setting for the derived image
 */
union AutoRebuildSetting {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OnBaseImageUpdate: "OnBaseImageUpdate",
}

/**
 * Environment type is either user created or curated by Azure ML service
 */
union EnvironmentType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Curated: "Curated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UserCreated: "UserCreated",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union VulnerabilityRisk {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UNKNOWN: "UNKNOWN",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CRITICAL: "CRITICAL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  HIGH: "HIGH",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  MEDIUM: "MEDIUM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  LOW: "LOW",
}

/**
 * The type of operating system.
 */
union OperatingSystemType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Linux: "Linux",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Windows: "Windows",
}

/**
 * State of endpoint provisioning.
 */
union EndpointProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Canceled: "Canceled",
}

/**
 * Enum to determine endpoint authentication mode.
 */
union EndpointAuthMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AMLToken: "AMLToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Key: "Key",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AADToken: "AADToken",
}

/**
 * The enumerated property types for batch deployments.
 */
union BatchDeploymentConfigurationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Model: "Model",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  PipelineComponent: "PipelineComponent",
}

/**
 * Log verbosity for batch inferencing.
 * Increasing verbosity order for logging is : Warning, Info and Debug.
 * The default value is Info.
 */
union BatchLoggingLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Info: "Info",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Debug: "Debug",
}

/**
 * Enum to determine which reference method to use for an asset.
 */
union ReferenceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Id: "Id",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  DataPath: "DataPath",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OutputPath: "OutputPath",
}

/**
 * Enum to determine how batch inferencing will handle output
 */
union BatchOutputAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SummaryOnly: "SummaryOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AppendRow: "AppendRow",
}

/**
 * Possible values for DeploymentProvisioningState.
 */
union DeploymentProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Scaling: "Scaling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Canceled: "Canceled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union CapabilityHostKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Agents: "Agents",
}

/**
 * Provisioning state of capability host.
 */
union CapabilityHostProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
}

/**
 * Enum to determine the datastore credentials type.
 */
union CredentialsType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AccountKey: "AccountKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Certificate: "Certificate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Sas: "Sas",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ServicePrincipal: "ServicePrincipal",
}

/**
 * Enum to determine the datastore contents type.
 */
union DatastoreType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureBlob: "AzureBlob",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureDataLakeGen1: "AzureDataLakeGen1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureDataLakeGen2: "AzureDataLakeGen2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureFile: "AzureFile",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OneLake: "OneLake",
}

/**
 * Enum to determine the datastore secrets type.
 */
union SecretsType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AccountKey: "AccountKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Certificate: "Certificate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Sas: "Sas",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ServicePrincipal: "ServicePrincipal",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union FeatureDataType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  String: "String",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Integer: "Integer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Long: "Long",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Float: "Float",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Double: "Double",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Binary: "Binary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Datetime: "Datetime",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Boolean: "Boolean",
}

/**
 * Enum to determine the email notification type.
 */
union EmailNotificationEnableType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  JobCompleted: "JobCompleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  JobFailed: "JobFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  JobCancelled: "JobCancelled",
}

/**
 * Enum to determine the webhook callback service type.
 */
union WebhookType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureDevOps: "AzureDevOps",
}

/**
 * Enum to describe the frequency of a recurrence schedule
 */
union RecurrenceFrequency {
  string,

  /**
   * Minute frequency
   */
  Minute: "Minute",

  /**
   * Hour frequency
   */
  Hour: "Hour",

  /**
   * Day frequency
   */
  Day: "Day",

  /**
   * Week frequency
   */
  Week: "Week",

  /**
   * Month frequency
   */
  Month: "Month",
}

/**
 * Enum of weekday
 */
union WeekDay {
  string,

  /**
   * Monday weekday
   */
  Monday: "Monday",

  /**
   * Tuesday weekday
   */
  Tuesday: "Tuesday",

  /**
   * Wednesday weekday
   */
  Wednesday: "Wednesday",

  /**
   * Thursday weekday
   */
  Thursday: "Thursday",

  /**
   * Friday weekday
   */
  Friday: "Friday",

  /**
   * Saturday weekday
   */
  Saturday: "Saturday",

  /**
   * Sunday weekday
   */
  Sunday: "Sunday",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union TriggerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Recurrence: "Recurrence",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Cron: "Cron",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union MaterializationStoreType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Online: "Online",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OnlineAndOffline: "OnlineAndOffline",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union DataAvailabilityStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Incomplete: "Incomplete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Complete: "Complete",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union OrderString {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CreatedAtDesc: "CreatedAtDesc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CreatedAtAsc: "CreatedAtAsc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UpdatedAtDesc: "UpdatedAtDesc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UpdatedAtAsc: "UpdatedAtAsc",
}

/**
 * State of pool related resources provisioning.
 */
union PoolProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Canceled: "Canceled",
}

/**
 * Enum to determine endpoint authentication mode.
 */
union AuthMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AAD: "AAD",
}

/**
 * Node scaling setting for the compute sku.
 */
union SkuScaleType {
  string,

  /**
   * Automatically scales node count.
   */
  Automatic: "Automatic",

  /**
   * Node count scaled upon user request.
   */
  Manual: "Manual",

  /**
   * Fixed set of nodes.
   */
  None: "None",
}

/**
 * Enum to determine identity framework.
 */
union IdentityConfigurationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Managed: "Managed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AMLToken: "AMLToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UserIdentity: "UserIdentity",
}

/**
 * Enum to determine the type of job.
 */
union JobType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AutoML: "AutoML",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Command: "Command",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Sweep: "Sweep",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Pipeline: "Pipeline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Spark: "Spark",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @removed(Versions.v2025_12_01)
  FineTuning: "FineTuning",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @removed(Versions.v2025_12_01)
  Distillation: "Distillation",
}

/**
 * The enumerated types for the nodes value
 */
union NodesValueType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  All: "All",
}

/**
 * The status of a job.
 */
union JobStatus {
  string,

  /**
   * Run hasn't started yet.
   */
  NotStarted: "NotStarted",

  /**
   * Run has started. The user has a run ID.
   */
  Starting: "Starting",

  /**
   * (Not used currently) It will be used if ES is creating the compute target.
   */
  Provisioning: "Provisioning",

  /**
   * The run environment is being prepared.
   */
  Preparing: "Preparing",

  /**
   * The job is queued in the compute target. For example, in BatchAI the job is in queued state, while waiting for all required nodes to be ready.
   */
  Queued: "Queued",

  /**
   * The job started to run in the compute target.
   */
  Running: "Running",

  /**
   * Job is completed in the target. It is in output collection state now.
   */
  Finalizing: "Finalizing",

  /**
   * Cancellation has been requested for the job.
   */
  CancelRequested: "CancelRequested",

  /**
   * Job completed successfully. This reflects that both the job itself and output collection states completed successfully
   */
  Completed: "Completed",

  /**
   * Job failed.
   */
  Failed: "Failed",

  /**
   * Following cancellation request, the job is now successfully canceled.
   */
  Canceled: "Canceled",

  /**
   * When heartbeat is enabled, if the run isn't updating any information to RunHistory then the run goes to NotResponding state.
   * NotResponding is the only state that is exempt from strict transition orders. A run can go from NotResponding to any of the previous states.
   */
  NotResponding: "NotResponding",

  /**
   * The job is paused by users. Some adjustment to labeling jobs can be made only in paused state.
   */
  Paused: "Paused",

  /**
   * Default job status if not mapped to all other statuses
   */
  Unknown: "Unknown",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union MarketplaceSubscriptionStatus {
  string,

  /**
   * The customer can now use the Marketplace Subscription's
   * model and will be billed.
   */
  Subscribed: "Subscribed",

  /**
   * The customer could not be billed for the Marketplace Subscription.
   * The customer will not be able to access the model.
   */
  Suspended: "Suspended",

  /**
   * Marketplace Subscriptions reach this state in response to an explicit customer or CSP action.
   * A Marketplace Subscription can also be canceled implicitly, as a result of nonpayment of dues,
   * after being in the Suspended state for some time.
   */
  Unsubscribed: "Unsubscribed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union MarketplaceSubscriptionProvisioningState {
  string,

  /**
   * MarketplaceSubscription is being created.
   */
  Creating: "Creating",

  /**
   * MarketplaceSubscription is being deleted.
   */
  Deleting: "Deleting",

  /**
   * MarketplaceSubscription is successfully provisioned.
   */
  Succeeded: "Succeeded",

  /**
   * MarketplaceSubscription provisioning failed.
   */
  Failed: "Failed",

  /**
   * MarketplaceSubscription is being updated.
   */
  Updating: "Updating",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Canceled: "Canceled",
}

/**
 * Enum to determine endpoint compute type.
 */
union EndpointComputeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Managed: "Managed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Kubernetes: "Kubernetes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureMLCompute: "AzureMLCompute",
}

/**
 * Enum to determine whether PublicNetworkAccess is Enabled or Disabled.
 */
union PublicNetworkAccessType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union DataCollectionMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union RollingRateType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Year: "Year",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Month: "Month",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Day: "Day",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Hour: "Hour",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Minute: "Minute",
}

/**
 * Enum to determine whether PublicNetworkAccess is Enabled or Disabled for egress of a deployment.
 */
union EgressPublicNetworkAccessType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union ScaleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  TargetUtilization: "TargetUtilization",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union ContainerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  StorageInitializer: "StorageInitializer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  InferenceServer: "InferenceServer",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union KeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Secondary: "Secondary",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union ScheduleListViewType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  EnabledOnly: "EnabledOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  DisabledOnly: "DisabledOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  All: "All",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union ScheduleActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CreateJob: "CreateJob",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  InvokeBatchEndpoint: "InvokeBatchEndpoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CreateMonitor: "CreateMonitor",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union ScheduleProvisioningStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Canceled: "Canceled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union ServerlessInferenceEndpointAuthMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Key: "Key",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AAD: "AAD",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  KeyAndAAD: "KeyAndAAD",
}

/**
 * Specifies the current safety level for content safety.
 */
union ContentSafetyLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Blocking: "Blocking",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deferred: "Deferred",
}

/**
 * Specifies the status of content safety.
 */
union ContentSafetyStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
}

/**
 * State of the Serverless Endpoint.
 */
union ServerlessEndpointState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Suspending: "Suspending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Reinstating: "Reinstating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Online: "Online",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CreationFailed: "CreationFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  DeletionFailed: "DeletionFailed",
}

/**
 * Connection status of the service consumer with the service provider
 */
union EndpointServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disconnected: "Disconnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Timeout: "Timeout",
}

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Internal: "Internal",
}

/**
 * Indicates whether or not the encryption is enabled for the workspace.
 */
union EncryptionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
}

/**
 * Isolation mode for the managed network of a machine learning workspace.
 */
union IsolationMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AllowInternetOutbound: "AllowInternetOutbound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AllowOnlyApprovedOutbound: "AllowOnlyApprovedOutbound",
}

/**
 * Category of a managed network Outbound Rule of a machine learning workspace.
 */
union RuleCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Required: "Required",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Recommended: "Recommended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UserDefined: "UserDefined",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Dependency: "Dependency",
}

/**
 * Type of a managed network Outbound Rule of a machine learning workspace.
 */
union RuleStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
}

/**
 * Type of a managed network Outbound Rule of a machine learning workspace.
 */
union RuleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  FQDN: "FQDN",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  PrivateEndpoint: "PrivateEndpoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ServiceTag: "ServiceTag",
}

/**
 * Status for the managed network of a machine learning workspace.
 */
union ManagedNetworkStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Active: "Active",
}

/**
 * Firewall Sku used for FQDN Rules
 */
union FirewallSku {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Basic: "Basic",
}

/**
 * The Kind of the managed network. Users can switch from V1 to V2 for granular access controls, but cannot switch back to V1 once V2 is enabled.
 */
union ManagedNetworkKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  V2: "V2",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union DefaultActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deny: "Deny",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Allow: "Allow",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
union PrivateEndpointConnectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
}

/**
 * The auth mode used for accessing the system datastores of the workspace.
 */
union SystemDatastoresAuthMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AccessKey: "AccessKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Identity: "Identity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UserDelegationSAS: "UserDelegationSAS",
}

/**
 * Authentication type of the connection target
 */
union ConnectionAuthType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  PAT: "PAT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UsernamePassword: "UsernamePassword",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SAS: "SAS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AccountKey: "AccountKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ServicePrincipal: "ServicePrincipal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AccessKey: "AccessKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ApiKey: "ApiKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CustomKeys: "CustomKeys",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OAuth2: "OAuth2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AAD: "AAD",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  DelegatedSAS: "DelegatedSAS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ProjectManagedIdentity: "ProjectManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AccountManagedIdentity: "AccountManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UserEntraToken: "UserEntraToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AgentUserImpersonation: "AgentUserImpersonation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AgenticIdentityToken: "AgenticIdentityToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AgenticUser: "AgenticUser",
}

/**
 * Category of the connection
 */
union ConnectionCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  PythonFeed: "PythonFeed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ContainerRegistry: "ContainerRegistry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Git: "Git",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  S3: "S3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Snowflake: "Snowflake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureKeyVault: "AzureKeyVault",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureSqlDb: "AzureSqlDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureSynapseAnalytics: "AzureSynapseAnalytics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureMySqlDb: "AzureMySqlDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzurePostgresDb: "AzurePostgresDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ADLSGen2: "ADLSGen2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureContainerAppEnvironment: "AzureContainerAppEnvironment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Redis: "Redis",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ApiKey: "ApiKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureOpenAI: "AzureOpenAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AIServices: "AIServices",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CognitiveSearch: "CognitiveSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CognitiveService: "CognitiveService",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CustomKeys: "CustomKeys",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureBlob: "AzureBlob",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureStorageAccount: "AzureStorageAccount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureOneLake: "AzureOneLake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CosmosDb: "CosmosDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CosmosDbMongoDbApi: "CosmosDbMongoDbApi",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureDataExplorer: "AzureDataExplorer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureMariaDb: "AzureMariaDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureDatabricksDeltaLake: "AzureDatabricksDeltaLake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureSqlMi: "AzureSqlMi",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureTableStorage: "AzureTableStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AmazonRdsForOracle: "AmazonRdsForOracle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AmazonRdsForSqlServer: "AmazonRdsForSqlServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AmazonRedshift: "AmazonRedshift",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Db2: "Db2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Drill: "Drill",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  GoogleBigQuery: "GoogleBigQuery",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Greenplum: "Greenplum",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Hbase: "Hbase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Hive: "Hive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Impala: "Impala",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Informix: "Informix",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  MariaDb: "MariaDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  MicrosoftAccess: "MicrosoftAccess",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  MySql: "MySql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Netezza: "Netezza",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Oracle: "Oracle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Phoenix: "Phoenix",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  PostgreSql: "PostgreSql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Presto: "Presto",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SapOpenHub: "SapOpenHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SapBw: "SapBw",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SapHana: "SapHana",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SapTable: "SapTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Spark: "Spark",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SqlServer: "SqlServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Sybase: "Sybase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Teradata: "Teradata",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Vertica: "Vertica",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Pinecone: "Pinecone",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Databricks: "Databricks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Cassandra: "Cassandra",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Couchbase: "Couchbase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  MongoDbV2: "MongoDbV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  MongoDbAtlas: "MongoDbAtlas",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AmazonS3Compatible: "AmazonS3Compatible",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  FileServer: "FileServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  FtpServer: "FtpServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  GoogleCloudStorage: "GoogleCloudStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Hdfs: "Hdfs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OracleCloudStorage: "OracleCloudStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Sftp: "Sftp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  GenericHttp: "GenericHttp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ODataRest: "ODataRest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Odbc: "Odbc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  GenericRest: "GenericRest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  RemoteTool: "RemoteTool",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AmazonMws: "AmazonMws",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Concur: "Concur",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Dynamics: "Dynamics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  DynamicsAx: "DynamicsAx",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  DynamicsCrm: "DynamicsCrm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  GoogleAdWords: "GoogleAdWords",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Hubspot: "Hubspot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Jira: "Jira",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Magento: "Magento",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Marketo: "Marketo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Office365: "Office365",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Eloqua: "Eloqua",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Responsys: "Responsys",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OracleServiceCloud: "OracleServiceCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  PayPal: "PayPal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  QuickBooks: "QuickBooks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Salesforce: "Salesforce",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SalesforceServiceCloud: "SalesforceServiceCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SalesforceMarketingCloud: "SalesforceMarketingCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SapCloudForCustomer: "SapCloudForCustomer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SapEcc: "SapEcc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ServiceNow: "ServiceNow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SharePointOnlineList: "SharePointOnlineList",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Shopify: "Shopify",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Square: "Square",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  WebTable: "WebTable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Xero: "Xero",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Zoho: "Zoho",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  GenericContainerRegistry: "GenericContainerRegistry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Elasticsearch: "Elasticsearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AppInsights: "AppInsights",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AppConfig: "AppConfig",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OpenAI: "OpenAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Serp: "Serp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  BingLLMSearch: "BingLLMSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Serverless: "Serverless",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ManagedOnlineEndpoint: "ManagedOnlineEndpoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ApiManagement: "ApiManagement",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ModelGateway: "ModelGateway",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  GroundingWithBingSearch: "GroundingWithBingSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  GroundingWithCustomSearch: "GroundingWithCustomSearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Sharepoint: "Sharepoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  MicrosoftFabric: "MicrosoftFabric",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  PowerPlatformEnvironment: "PowerPlatformEnvironment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  RemoteA2A: "RemoteA2A",
}

/**
 * Group based on connection category
 */
union ConnectionGroup {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Azure: "Azure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  AzureAI: "AzureAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Database: "Database",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  NoSQL: "NoSQL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  File: "File",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  GenericProtocol: "GenericProtocol",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ServicesAndApps: "ServicesAndApps",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union ManagedPERequirement {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Required: "Required",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  NotRequired: "NotRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  NotApplicable: "NotApplicable",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union ManagedPEStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  NotApplicable: "NotApplicable",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union DefaultResourceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  NotStarted: "NotStarted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Scaling: "Scaling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
}

/**
 * Model lifecycle status.
 */
union ModelLifecycleStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  GenerallyAvailable: "GenerallyAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Preview: "Preview",
}

/**
 * Level at which content is filtered.
 */
union AllowedContentLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Low: "Low",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Medium: "Medium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  High: "High",
}

/**
 * Content source to apply the Content Filters.
 */
union RaiPolicyContentSource {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Prompt: "Prompt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Completion: "Completion",
}

/**
 * Content Filters mode.
 */
union RaiPolicyMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deferred: "Deferred",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Blocking: "Blocking",
}

/**
 * Content Filters policy type.
 */
union RaiPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UserManaged: "UserManaged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SystemManaged: "SystemManaged",
}

/**
 * Type of the endpoint.
 */
union EndpointType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  `Azure.OpenAI`: "Azure.OpenAI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  `Azure.Speech`: "Azure.Speech",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  `Azure.ContentSafety`: "Azure.ContentSafety",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  `Azure.Llama`: "Azure.Llama",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  managedOnlineEndpoint: "managedOnlineEndpoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  serverlessEndpoint: "serverlessEndpoint",
}

/**
 * Level of workspace setup error
 */
union DiagnoseResultLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Information: "Information",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union ServiceAccountKeyName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Key1: "Key1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Key2: "Key2",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
union ManagedNetworkProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deferred: "Deferred",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleted: "Deleted",
}

/**
 * Intended usage of the cluster
 */
union ClusterPurpose {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  FastProd: "FastProd",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  DenseProd: "DenseProd",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  DevTest: "DevTest",
}

/**
 * Enable or disable ssl for scoring
 */
union SslConfigStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Auto: "Auto",
}

/**
 * Load Balancer Type
 */
union LoadBalancerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  PublicIp: "PublicIp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  InternalLoadBalancer: "InternalLoadBalancer",
}

/**
 * Compute OS Type
 */
union OsType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Linux: "Linux",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Windows: "Windows",
}

/**
 * Virtual Machine priority
 */
union VmPriority {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Dedicated: "Dedicated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  LowPriority: "LowPriority",
}

/**
 * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on all nodes of the cluster. Enabled - Indicates that the public ssh port is open on all nodes of the cluster. NotSpecified - Indicates that the public ssh port is closed on all nodes of the cluster if VNet is defined, else is open all public nodes. It can be default only during cluster creation time, after creation it will be either enabled or disabled.
 */
union RemoteLoginPortPublicAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  NotSpecified: "NotSpecified",
}

/**
 * Allocation state of the compute. Possible values are: steady - Indicates that the compute is not resizing. There are no changes to the number of compute nodes in the compute in progress. A compute enters this state when it is created and when no operations are being performed on the compute to change the number of compute nodes. resizing - Indicates that the compute is resizing; that is, compute nodes are being added to or removed from the compute.
 */
union AllocationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Steady: "Steady",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Resizing: "Resizing",
}

/**
 * Policy for sharing applications on this compute instance among users of parent workspace. If Personal, only the creator can access applications on this compute instance. When Shared, any workspace user can access applications on this instance depending on his/her assigned role.
 */
union ApplicationSharingPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Personal: "Personal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Shared: "Shared",
}

/**
 * Indicates whether mlflow autologger is enabled for notebooks.
 */
union MlflowAutologger {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
}

/**
 * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on this instance. Enabled - Indicates that the public ssh port is open and accessible according to the VNet/subnet policy if applicable.
 */
union SshPublicAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
}

/**
 * The os patching status.
 */
union PatchStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CompletedWithWarnings: "CompletedWithWarnings",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Unknown: "Unknown",
}

/**
 * Current state of an ComputeInstance.
 */
union ComputeInstanceState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CreateFailed: "CreateFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Restarting: "Restarting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Resizing: "Resizing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  JobRunning: "JobRunning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SettingUp: "SettingUp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SetupFailed: "SetupFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Starting: "Starting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Stopping: "Stopping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UserSettingUp: "UserSettingUp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  UserSetupFailed: "UserSetupFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Unusable: "Unusable",
}

/**
 * The Compute Instance Authorization type. Available values are personal (default).
 */
union ComputeInstanceAuthorizationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  personal: "personal",
}

/**
 * Name of the last operation.
 */
union OperationName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Create: "Create",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Start: "Start",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Stop: "Stop",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Restart: "Restart",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Resize: "Resize",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Reimage: "Reimage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Delete: "Delete",
}

/**
 * Operation status.
 */
union OperationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  CreateFailed: "CreateFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  StartFailed: "StartFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  StopFailed: "StopFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  RestartFailed: "RestartFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ResizeFailed: "ResizeFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ReimageFailed: "ReimageFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  DeleteFailed: "DeleteFailed",
}

/**
 * Trigger of operation.
 */
union OperationTrigger {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Schedule: "Schedule",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  IdleShutdown: "IdleShutdown",
}

/**
 * The current deployment state of schedule.
 */
union ProvisioningStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
}

/**
 * Is the schedule enabled or disabled?
 */
union ScheduleStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Disabled: "Disabled",
}

/**
 * [Required] The compute power action.
 */
union ComputePowerAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Start: "Start",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Stop: "Stop",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union ComputeTriggerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Recurrence: "Recurrence",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Cron: "Cron",
}

/**
 * Enum to describe the frequency of a compute recurrence schedule
 */
union ComputeRecurrenceFrequency {
  string,

  /**
   * Minute frequency
   */
  Minute: "Minute",

  /**
   * Hour frequency
   */
  Hour: "Hour",

  /**
   * Day frequency
   */
  Day: "Day",

  /**
   * Week frequency
   */
  Week: "Week",

  /**
   * Month frequency
   */
  Month: "Month",
}

/**
 * Enum of weekday
 */
union ComputeWeekDay {
  string,

  /**
   * Monday weekday
   */
  Monday: "Monday",

  /**
   * Tuesday weekday
   */
  Tuesday: "Tuesday",

  /**
   * Wednesday weekday
   */
  Wednesday: "Wednesday",

  /**
   * Thursday weekday
   */
  Thursday: "Thursday",

  /**
   * Friday weekday
   */
  Friday: "Friday",

  /**
   * Saturday weekday
   */
  Saturday: "Saturday",

  /**
   * Sunday weekday
   */
  Sunday: "Sunday",
}

/**
 * The current deployment state of schedule.
 */
union ScheduleProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Failed: "Failed",
}

/**
 * Auto save settings.
 */
union Autosave {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Local: "Local",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Remote: "Remote",
}

/**
 * network of this container.
 */
union Network {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Bridge: "Bridge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Host: "Host",
}

/**
 * Caching type of Data Disk.
 */
union Caching {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ReadOnly: "ReadOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ReadWrite: "ReadWrite",
}

/**
 * type of this storage account.
 */
union StorageAccountType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Standard_LRS: "Standard_LRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Premium_LRS: "Premium_LRS",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union MonitoringFeatureFilterType {
  string,

  /**
   * Includes all features.
   */
  AllFeatures: "AllFeatures",

  /**
   * Only includes the top contributing features, measured by feature attribution.
   */
  TopNByAttribution: "TopNByAttribution",

  /**
   * Includes a user-defined subset of features.
   */
  FeatureSubset: "FeatureSubset",
}

/**
 * Monitor compute identity type enum.
 */
union MonitorComputeIdentityType {
  string,

  /**
   * Authenticates through user's AML token.
   */
  AmlToken: "AmlToken",

  /**
   * Authenticates through a user-provided managed identity.
   */
  ManagedIdentity: "ManagedIdentity",
}

/**
 * Enum to determine the input data delivery mode.
 */
union InputDeliveryMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ReadOnlyMount: "ReadOnlyMount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ReadWriteMount: "ReadWriteMount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Download: "Download",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Direct: "Direct",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  EvalMount: "EvalMount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  EvalDownload: "EvalDownload",
}

/**
 * Output data delivery mode enums.
 */
union OutputDeliveryMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ReadWriteMount: "ReadWriteMount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Upload: "Upload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Direct: "Direct",
}

/**
 * Enum to determine forecast horizon selection mode.
 */
union ForecastHorizonMode {
  string,

  /**
   * Forecast horizon to be determined automatically.
   */
  Auto: "Auto",

  /**
   * Use the custom forecast horizon.
   */
  Custom: "Custom",
}

/**
 * Enum to determine the Job Output Type.
 */
union JobOutputType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  uri_file: "uri_file",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  uri_folder: "uri_folder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  mltable: "mltable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  custom_model: "custom_model",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  mlflow_model: "mlflow_model",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  triton_model: "triton_model",
}

/**
 * Enum to determine the job tier.
 */
union JobTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Null: "Null",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Spot: "Spot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Premium: "Premium",
}

/**
 * Enum for setting log verbosity.
 */
union LogVerbosity {
  string,

  /**
   * No logs emitted.
   */
  NotSet: "NotSet",

  /**
   * Debug and above log statements logged.
   */
  Debug: "Debug",

  /**
   * Info and above log statements logged.
   */
  Info: "Info",

  /**
   * Warning and above log statements logged.
   */
  Warning: "Warning",

  /**
   * Error and above log statements logged.
   */
  Error: "Error",

  /**
   * Only critical statements logged.
   */
  Critical: "Critical",
}

/**
 * AutoMLJob Task type.
 */
union TaskType {
  string,

  /**
   * Classification in machine learning and statistics is a supervised learning approach in which
   * the computer program learns from the data given to it and make new observations or classifications.
   */
  Classification: "Classification",

  /**
   * Regression means to predict the value using the input data. Regression models are used to predict a continuous value.
   */
  Regression: "Regression",

  /**
   * Forecasting is a special kind of regression task that deals with time-series data and creates forecasting model
   * that can be used to predict the near future values based on the inputs.
   */
  Forecasting: "Forecasting",

  /**
   * Image Classification. Multi-class image classification is used when an image is classified with only a single label
   * from a set of classes - e.g. each image is classified as either an image of a 'cat' or a 'dog' or a 'duck'.
   */
  ImageClassification: "ImageClassification",

  /**
   * Image Classification Multilabel. Multi-label image classification is used when an image could have one or more labels
   * from a set of labels - e.g. an image could be labeled with both 'cat' and 'dog'.
   */
  ImageClassificationMultilabel: "ImageClassificationMultilabel",

  /**
   * Image Object Detection. Object detection is used to identify objects in an image and locate each object with a
   * bounding box e.g. locate all dogs and cats in an image and draw a bounding box around each.
   */
  ImageObjectDetection: "ImageObjectDetection",

  /**
   * Image Instance Segmentation. Instance segmentation is used to identify objects in an image at the pixel level,
   * drawing a polygon around each object in the image.
   */
  ImageInstanceSegmentation: "ImageInstanceSegmentation",

  /**
   * Text classification (also known as text tagging or text categorization) is the process of sorting texts into categories.
   * Categories are mutually exclusive.
   */
  TextClassification: "TextClassification",

  /**
   * Multilabel classification task assigns each sample to a group (zero or more) of target labels.
   */
  TextClassificationMultilabel: "TextClassificationMultilabel",

  /**
   * Text Named Entity Recognition a.k.a. TextNER.
   * Named Entity Recognition (NER) is the ability to take free-form text and identify the occurrences of entities such as people, locations, organizations, and more.
   */
  TextNER: "TextNER",
}

/**
 * Enum to determine the Job Input Type.
 */
union JobInputType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  literal: "literal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  uri_file: "uri_file",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  uri_folder: "uri_folder",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  mltable: "mltable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  custom_model: "custom_model",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  mlflow_model: "mlflow_model",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  triton_model: "triton_model",
}

/**
 * Determines how N-Cross validations value is determined.
 */
union NCrossValidationsMode {
  string,

  /**
   * Determine N-Cross validations value automatically. Supported only for 'Forecasting' AutoML task.
   */
  Auto: "Auto",

  /**
   * Use custom N-Cross validations value.
   */
  Custom: "Custom",
}

/**
 * Forecasting seasonality mode.
 */
union SeasonalityMode {
  string,

  /**
   * Seasonality to be determined automatically.
   */
  Auto: "Auto",

  /**
   * Use the custom seasonality value.
   */
  Custom: "Custom",
}

/**
 * Target lags selection modes.
 */
union TargetLagsMode {
  string,

  /**
   * Target lags to be determined automatically.
   */
  Auto: "Auto",

  /**
   * Use the custom target lags.
   */
  Custom: "Custom",
}

/**
 * Target rolling windows size mode.
 */
union TargetRollingWindowSizeMode {
  string,

  /**
   * Determine rolling windows size automatically.
   */
  Auto: "Auto",

  /**
   * Use the specified rolling window size.
   */
  Custom: "Custom",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union ServiceDataAccessAuthIdentity {
  string,

  /**
   * Do not use any identity for service data access.
   */
  None: "None",

  /**
   * Use the system assigned managed identity of the Workspace to authenticate service data access.
   */
  WorkspaceSystemAssignedIdentity: "WorkspaceSystemAssignedIdentity",

  /**
   * Use the user assigned managed identity of the Workspace to authenticate service data access.
   */
  WorkspaceUserAssignedIdentity: "WorkspaceUserAssignedIdentity",
}

/**
 * Enum to determine the type of fine tuning.
 */
union ModelProvider {
  string,

  /**
   * Fine tuning using Azure Open AI model.
   */
  AzureOpenAI: "AzureOpenAI",

  /**
   * Fine tuning using custom model.
   */
  Custom: "Custom",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union FineTuningTaskType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ChatCompletion: "ChatCompletion",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  TextCompletion: "TextCompletion",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  TextClassification: "TextClassification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  QuestionAnswering: "QuestionAnswering",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  TextSummarization: "TextSummarization",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  TokenClassification: "TokenClassification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  TextTranslation: "TextTranslation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ImageClassification: "ImageClassification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ImageInstanceSegmentation: "ImageInstanceSegmentation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  ImageObjectDetection: "ImageObjectDetection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  VideoMultiObjectTracking: "VideoMultiObjectTracking",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union EarlyTerminationPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Bandit: "Bandit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  MedianStopping: "MedianStopping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  TruncationSelection: "TruncationSelection",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union SamplingAlgorithmType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Grid: "Grid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Random: "Random",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Bayesian: "Bayesian",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union CategoricalDataDriftMetric {
  string,

  /**
   * The Jensen Shannon Distance (JSD) metric.
   */
  JensenShannonDistance: "JensenShannonDistance",

  /**
   * The Population Stability Index (PSI) metric.
   */
  PopulationStabilityIndex: "PopulationStabilityIndex",

  /**
   * The Pearsons Chi Squared Test metric.
   */
  PearsonsChiSquaredTest: "PearsonsChiSquaredTest",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union MonitoringFeatureDataType {
  string,

  /**
   * Used for features of numerical data type.
   */
  Numerical: "Numerical",

  /**
   * Used for features of categorical data type.
   */
  Categorical: "Categorical",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union CategoricalDataQualityMetric {
  string,

  /**
   * Calculates the rate of null values.
   */
  NullValueRate: "NullValueRate",

  /**
   * Calculates the rate of data type errors.
   */
  DataTypeErrorRate: "DataTypeErrorRate",

  /**
   * Calculates the rate values are out of bounds.
   */
  OutOfBoundsRate: "OutOfBoundsRate",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union CategoricalPredictionDriftMetric {
  string,

  /**
   * The Jensen Shannon Distance (JSD) metric.
   */
  JensenShannonDistance: "JensenShannonDistance",

  /**
   * The Population Stability Index (PSI) metric.
   */
  PopulationStabilityIndex: "PopulationStabilityIndex",

  /**
   * The Pearsons Chi Squared Test metric.
   */
  PearsonsChiSquaredTest: "PearsonsChiSquaredTest",
}

/**
 * Primary metrics for classification tasks.
 */
union ClassificationPrimaryMetrics {
  string,

  /**
   * AUC is the Area under the curve.
   * This metric represents arithmetic mean of the score for each class,
   * weighted by the number of true instances in each class.
   */
  AUCWeighted: "AUCWeighted",

  /**
   * Accuracy is the ratio of predictions that exactly match the true class labels.
   */
  Accuracy: "Accuracy",

  /**
   * Normalized macro recall is recall macro-averaged and normalized, so that random
   * performance has a score of 0, and perfect performance has a score of 1.
   */
  NormMacroRecall: "NormMacroRecall",

  /**
   * The arithmetic mean of the average precision score for each class, weighted by
   * the number of true instances in each class.
   */
  AveragePrecisionScoreWeighted: "AveragePrecisionScoreWeighted",

  /**
   * The arithmetic mean of precision for each class, weighted by number of true instances in each class.
   */
  PrecisionScoreWeighted: "PrecisionScoreWeighted",
}

/**
 * Enum for all classification models supported by AutoML.
 */
union ClassificationModels {
  string,

  /**
   * Logistic regression is a fundamental classification technique.
   * It belongs to the group of linear classifiers and is somewhat similar to polynomial and linear regression.
   * Logistic regression is fast and relatively uncomplicated, and it's convenient for you to interpret the results.
   * Although it's essentially a method for binary classification, it can also be applied to multiclass problems.
   */
  LogisticRegression: "LogisticRegression",

  /**
   * SGD: Stochastic gradient descent is an optimization algorithm often used in machine learning applications
   * to find the model parameters that correspond to the best fit between predicted and actual outputs.
   */
  SGD: "SGD",

  /**
   * The multinomial Naive Bayes classifier is suitable for classification with discrete features (e.g., word counts for text classification).
   * The multinomial distribution normally requires integer feature counts. However, in practice, fractional counts such as tf-idf may also work.
   */
  MultinomialNaiveBayes: "MultinomialNaiveBayes",

  /**
   * Naive Bayes classifier for multivariate Bernoulli models.
   */
  BernoulliNaiveBayes: "BernoulliNaiveBayes",

  /**
   * A support vector machine (SVM) is a supervised machine learning model that uses classification algorithms for two-group classification problems.
   * After giving an SVM model sets of labeled training data for each category, they're able to categorize new text.
   */
  SVM: "SVM",

  /**
   * A support vector machine (SVM) is a supervised machine learning model that uses classification algorithms for two-group classification problems.
   * After giving an SVM model sets of labeled training data for each category, they're able to categorize new text.
   * Linear SVM performs best when input data is linear, i.e., data can be easily classified by drawing the straight line between classified values on a plotted graph.
   */
  LinearSVM: "LinearSVM",

  /**
   * K-nearest neighbors (KNN) algorithm uses 'feature similarity' to predict the values of new datapoints
   * which further means that the new data point will be assigned a value based on how closely it matches the points in the training set.
   */
  KNN: "KNN",

  /**
   * Decision Trees are a non-parametric supervised learning method used for both classification and regression tasks.
   * The goal is to create a model that predicts the value of a target variable by learning simple decision rules inferred from the data features.
   */
  DecisionTree: "DecisionTree",

  /**
   * Random forest is a supervised learning algorithm.
   * The "forest" it builds, is an ensemble of decision trees, usually trained with the "bagging" method.
   * The general idea of the bagging method is that a combination of learning models increases the overall result.
   */
  RandomForest: "RandomForest",

  /**
   * Extreme Trees is an ensemble machine learning algorithm that combines the predictions from many decision trees. It is related to the widely used random forest algorithm.
   */
  ExtremeRandomTrees: "ExtremeRandomTrees",

  /**
   * LightGBM is a gradient boosting framework that uses tree based learning algorithms.
   */
  LightGBM: "LightGBM",

  /**
   * The technique of transiting week learners into a strong learner is called Boosting. The gradient boosting algorithm process works on this theory of execution.
   */
  GradientBoosting: "GradientBoosting",

  /**
   * XGBoost: Extreme Gradient Boosting Algorithm. This algorithm is used for structured data where target column values can be divided into distinct class values.
   */
  XGBoostClassifier: "XGBoostClassifier",
}

/**
 * The meta-learner is a model trained on the output of the individual heterogeneous models.
 * Default meta-learners are LogisticRegression for classification tasks (or LogisticRegressionCV if cross-validation is enabled) and ElasticNet for regression/forecasting tasks (or ElasticNetCV if cross-validation is enabled).
 * This parameter can be one of the following strings: LogisticRegression, LogisticRegressionCV, LightGBMClassifier, ElasticNet, ElasticNetCV, LightGBMRegressor, or LinearRegression
 */
union StackMetaLearnerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  None: "None",

  /**
   * Default meta-learners are LogisticRegression for classification tasks.
   */
  LogisticRegression: "LogisticRegression",

  /**
   * Default meta-learners are LogisticRegression for classification task when CV is on.
   */
  LogisticRegressionCV: "LogisticRegressionCV",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  LightGBMClassifier: "LightGBMClassifier",

  /**
   * Default meta-learners are LogisticRegression for regression task.
   */
  ElasticNet: "ElasticNet",

  /**
   * Default meta-learners are LogisticRegression for regression task when CV is on.
   */
  ElasticNetCV: "ElasticNetCV",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  LightGBMRegressor: "LightGBMRegressor",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  LinearRegression: "LinearRegression",
}

/**
 * Enum for all classification models supported by AutoML.
 */
union BlockedTransformers {
  string,

  /**
   * Target encoding for text data.
   */
  TextTargetEncoder: "TextTargetEncoder",

  /**
   * Ohe hot encoding creates a binary feature transformation.
   */
  OneHotEncoder: "OneHotEncoder",

  /**
   * Target encoding for categorical data.
   */
  CatTargetEncoder: "CatTargetEncoder",

  /**
   * Tf-Idf stands for, term-frequency times inverse document-frequency. This is a common term weighting scheme for identifying information from documents.
   */
  TfIdf: "TfIdf",

  /**
   * Weight of Evidence encoding is a technique used to encode categorical variables. It uses the natural log of the P(1)/P(0) to create weights.
   */
  WoETargetEncoder: "WoETargetEncoder",

  /**
   * Label encoder converts labels/categorical variables in a numerical form.
   */
  LabelEncoder: "LabelEncoder",

  /**
   * Word embedding helps represents words or phrases as a vector, or a series of numbers.
   */
  WordEmbedding: "WordEmbedding",

  /**
   * Naive Bayes is a classified that is used for classification of discrete features that are categorically distributed.
   */
  NaiveBayes: "NaiveBayes",

  /**
   * Count Vectorizer converts a collection of text documents to a matrix of token counts.
   */
  CountVectorizer: "CountVectorizer",

  /**
   * Hashing One Hot Encoder can turn categorical variables into a limited number of new features. This is often used for high-cardinality categorical features.
   */
  HashOneHotEncoder: "HashOneHotEncoder",
}

/**
 * Featurization mode - determines data featurization mode.
 */
union FeaturizationMode {
  string,

  /**
   * Auto mode, system performs featurization without any custom featurization inputs.
   */
  Auto: "Auto",

  /**
   * Custom featurization.
   */
  Custom: "Custom",

  /**
   * Featurization off. 'Forecasting' task cannot use this value.
   */
  Off: "Off",
}

/**
 * Enum to determine the job distribution type.
 */
union DistributionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  PyTorch: "PyTorch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  TensorFlow: "TensorFlow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Mpi: "Mpi",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union JobLimitsType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Command: "Command",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Sweep: "Sweep",
}

/**
 * Monitor compute type enum.
 */
union MonitorComputeType {
  string,

  /**
   * Serverless Spark compute.
   */
  ServerlessSpark: "ServerlessSpark",
}

/**
 * Model task type enum.
 */
union ModelTaskType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Classification: "Classification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Regression: "Regression",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union MonitoringNotificationType {
  string,

  /**
   * Enables email notifications through AML notifications.
   */
  AmlNotification: "AmlNotification",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union MonitoringSignalType {
  string,

  /**
   * Tracks model input data distribution change, comparing against training data or past production data.
   */
  DataDrift: "DataDrift",

  /**
   * Tracks prediction result data distribution change, comparing against validation/test label data or past production data.
   */
  PredictionDrift: "PredictionDrift",

  /**
   * Tracks model input data integrity.
   */
  DataQuality: "DataQuality",

  /**
   * Tracks feature importance change in production, comparing against feature importance at training time.
   */
  FeatureAttributionDrift: "FeatureAttributionDrift",

  /**
   * Tracks a custom signal provided by users.
   */
  Custom: "Custom",
}

/**
 * Monitoring input data type enum.
 */
union MonitoringInputDataType {
  string,

  /**
   * An input data with a fixed window size.
   */
  Static: "Static",

  /**
   * An input data which rolls relatively to the monitor's current run time.
   */
  Rolling: "Rolling",

  /**
   * An input data with tabular format which doesn't require preprocessing.
   */
  Fixed: "Fixed",
}

/**
 * The mode of operation for computing feature importance.
 */
union FeatureImportanceMode {
  string,

  /**
   * Disables computing feature importance within a signal.
   */
  Disabled: "Disabled",

  /**
   * Enables computing feature importance within a signal.
   */
  Enabled: "Enabled",
}

/**
 * Enum to determine the type of Data Generation Task.
 */
union DataGenerationTaskType {
  string,

  /**
   * Generate conversational data (multi/single turn)
   */
  Conversation: "Conversation",

  /**
   * Generate Math data for numerical responses
   */
  Math: "Math",

  /**
   * Generate Natural Language Inference data
   */
  Nli: "Nli",

  /**
   * Generate Natural Language Understanding data for Question Answering data
   */
  NluQa: "NluQa",

  /**
   * Generate Key Summary for an Article
   */
  Summarization: "Summarization",
}

/**
 * Enum to determine the type of Data Generation.
 */
union DataGenerationType {
  string,

  /**
   * Label Generation by Teacher Model Inferencing
   */
  LabelGeneration: "LabelGeneration",

  /**
   * Synthetic Data Generation
   */
  DataGeneration: "DataGeneration",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union FeatureAttributionMetric {
  string,

  /**
   * The Normalized Discounted Cumulative Gain metric.
   */
  NormalizedDiscountedCumulativeGain: "NormalizedDiscountedCumulativeGain",
}

/**
 * Flag for generating lags for the numeric features.
 */
union FeatureLags {
  string,

  /**
   * No feature lags generated.
   */
  None: "None",

  /**
   * System auto-generates feature lags.
   */
  Auto: "Auto",
}

/**
 * The parameter defining how if AutoML should handle short time series.
 */
union ShortSeriesHandlingConfiguration {
  string,

  /**
   * Represents no/null value.
   */
  None: "None",

  /**
   * Short series will be padded if there are no long series, otherwise short series will be dropped.
   */
  Auto: "Auto",

  /**
   * All the short series will be padded.
   */
  Pad: "Pad",

  /**
   * All the short series will be dropped.
   */
  Drop: "Drop",
}

/**
 * Target aggregate function.
 */
union TargetAggregationFunction {
  string,

  /**
   * Represent no value set.
   */
  None: "None",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Sum: "Sum",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Max: "Max",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Min: "Min",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Mean: "Mean",
}

/**
 * Configure STL Decomposition of the time-series target column.
 */
union UseStl {
  string,

  /**
   * No stl decomposition.
   */
  None: "None",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Season: "Season",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SeasonTrend: "SeasonTrend",
}

/**
 * Primary metrics for Forecasting task.
 */
union ForecastingPrimaryMetrics {
  string,

  /**
   * The Spearman's rank coefficient of correlation is a non-parametric measure of rank correlation.
   */
  SpearmanCorrelation: "SpearmanCorrelation",

  /**
   * The Normalized Root Mean Squared Error (NRMSE) the RMSE facilitates the comparison between models with different scales.
   */
  NormalizedRootMeanSquaredError: "NormalizedRootMeanSquaredError",

  /**
   * The R2 score is one of the performance evaluation measures for forecasting-based machine learning models.
   */
  R2Score: "R2Score",

  /**
   * The Normalized Mean Absolute Error (NMAE) is a validation metric to compare the Mean Absolute Error (MAE) of (time) series with different scales.
   */
  NormalizedMeanAbsoluteError: "NormalizedMeanAbsoluteError",
}

/**
 * Enum for all forecasting models supported by AutoML.
 */
union ForecastingModels {
  string,

  /**
   * Auto-Autoregressive Integrated Moving Average (ARIMA) model uses time-series data and statistical analysis to interpret the data and make future predictions.
   * This model aims to explain data by using time series data on its past values and uses linear regression to make predictions.
   */
  AutoArima: "AutoArima",

  /**
   * Prophet is a procedure for forecasting time series data based on an additive model where non-linear trends are fit with yearly, weekly, and daily seasonality, plus holiday effects.
   * It works best with time series that have strong seasonal effects and several seasons of historical data. Prophet is robust to missing data and shifts in the trend, and typically handles outliers well.
   */
  Prophet: "Prophet",

  /**
   * The Naive forecasting model makes predictions by carrying forward the latest target value for each time-series in the training data.
   */
  Naive: "Naive",

  /**
   * The Seasonal Naive forecasting model makes predictions by carrying forward the latest season of target values for each time-series in the training data.
   */
  SeasonalNaive: "SeasonalNaive",

  /**
   * The Average forecasting model makes predictions by carrying forward the average of the target values for each time-series in the training data.
   */
  Average: "Average",

  /**
   * The Seasonal Average forecasting model makes predictions by carrying forward the average value of the latest season of data for each time-series in the training data.
   */
  SeasonalAverage: "SeasonalAverage",

  /**
   * Exponential smoothing is a time series forecasting method for univariate data that can be extended to support data with a systematic trend or seasonal component.
   */
  ExponentialSmoothing: "ExponentialSmoothing",

  /**
   * An Autoregressive Integrated Moving Average with Explanatory Variable (ARIMAX) model can be viewed as a multiple regression model with one or more autoregressive (AR) terms and/or one or more moving average (MA) terms.
   * This method is suitable for forecasting when data is stationary/non stationary, and multivariate with any type of data pattern, i.e., level/trend /seasonality/cyclicity.
   */
  Arimax: "Arimax",

  /**
   * TCNForecaster: Temporal Convolutional Networks Forecaster. //TODO: Ask forecasting team for brief intro.
   */
  TCNForecaster: "TCNForecaster",

  /**
   * Elastic net is a popular type of regularized linear regression that combines two popular penalties, specifically the L1 and L2 penalty functions.
   */
  ElasticNet: "ElasticNet",

  /**
   * The technique of transiting week learners into a strong learner is called Boosting. The gradient boosting algorithm process works on this theory of execution.
   */
  GradientBoosting: "GradientBoosting",

  /**
   * Decision Trees are a non-parametric supervised learning method used for both classification and regression tasks.
   * The goal is to create a model that predicts the value of a target variable by learning simple decision rules inferred from the data features.
   */
  DecisionTree: "DecisionTree",

  /**
   * K-nearest neighbors (KNN) algorithm uses 'feature similarity' to predict the values of new datapoints
   * which further means that the new data point will be assigned a value based on how closely it matches the points in the training set.
   */
  KNN: "KNN",

  /**
   * Lasso model fit with Least Angle Regression a.k.a. Lars. It is a Linear Model trained with an L1 prior as regularizer.
   */
  LassoLars: "LassoLars",

  /**
   * SGD: Stochastic gradient descent is an optimization algorithm often used in machine learning applications
   * to find the model parameters that correspond to the best fit between predicted and actual outputs.
   * It's an inexact but powerful technique.
   */
  SGD: "SGD",

  /**
   * Random forest is a supervised learning algorithm.
   * The "forest" it builds, is an ensemble of decision trees, usually trained with the "bagging" method.
   * The general idea of the bagging method is that a combination of learning models increases the overall result.
   */
  RandomForest: "RandomForest",

  /**
   * Extreme Trees is an ensemble machine learning algorithm that combines the predictions from many decision trees. It is related to the widely used random forest algorithm.
   */
  ExtremeRandomTrees: "ExtremeRandomTrees",

  /**
   * LightGBM is a gradient boosting framework that uses tree based learning algorithms.
   */
  LightGBM: "LightGBM",

  /**
   * XGBoostRegressor: Extreme Gradient Boosting Regressor is a supervised machine learning model using ensemble of base learners.
   */
  XGBoostRegressor: "XGBoostRegressor",
}

/**
 * Learning rate scheduler enum.
 */
union LearningRateScheduler {
  string,

  /**
   * No learning rate scheduler selected.
   */
  None: "None",

  /**
   * Cosine Annealing With Warmup.
   */
  WarmupCosine: "WarmupCosine",

  /**
   * Step learning rate scheduler.
   */
  Step: "Step",
}

/**
 * Stochastic optimizer for image models.
 */
union StochasticOptimizer {
  string,

  /**
   * No optimizer selected.
   */
  None: "None",

  /**
   * Stochastic Gradient Descent optimizer.
   */
  Sgd: "Sgd",

  /**
   * Adam is algorithm the optimizes stochastic objective functions based on adaptive estimates of moments
   */
  Adam: "Adam",

  /**
   * AdamW is a variant of the optimizer Adam that has an improved implementation of weight decay.
   */
  Adamw: "Adamw",
}

/**
 * Primary metrics for classification multilabel tasks.
 */
union ClassificationMultilabelPrimaryMetrics {
  string,

  /**
   * AUC is the Area under the curve.
   * This metric represents arithmetic mean of the score for each class,
   * weighted by the number of true instances in each class.
   */
  AUCWeighted: "AUCWeighted",

  /**
   * Accuracy is the ratio of predictions that exactly match the true class labels.
   */
  Accuracy: "Accuracy",

  /**
   * Normalized macro recall is recall macro-averaged and normalized, so that random
   * performance has a score of 0, and perfect performance has a score of 1.
   */
  NormMacroRecall: "NormMacroRecall",

  /**
   * The arithmetic mean of the average precision score for each class, weighted by
   * the number of true instances in each class.
   */
  AveragePrecisionScoreWeighted: "AveragePrecisionScoreWeighted",

  /**
   * The arithmetic mean of precision for each class, weighted by number of true instances in each class.
   */
  PrecisionScoreWeighted: "PrecisionScoreWeighted",

  /**
   * Intersection Over Union. Intersection of predictions divided by union of predictions.
   */
  IOU: "IOU",
}

/**
 * Primary metrics for InstanceSegmentation tasks.
 */
union InstanceSegmentationPrimaryMetrics {
  string,

  /**
   * Mean Average Precision (MAP) is the average of AP (Average Precision).
   * AP is calculated for each class and averaged to get the MAP.
   */
  MeanAveragePrecision: "MeanAveragePrecision",
}

/**
 * Image model size.
 */
union ModelSize {
  string,

  /**
   * No value selected.
   */
  None: "None",

  /**
   * Small size.
   */
  Small: "Small",

  /**
   * Medium size.
   */
  Medium: "Medium",

  /**
   * Large size.
   */
  Large: "Large",

  /**
   * Extra large size.
   */
  ExtraLarge: "ExtraLarge",
}

/**
 * Metric computation method to use for validation metrics in image tasks.
 */
union ValidationMetricType {
  string,

  /**
   * No metric.
   */
  None: "None",

  /**
   * Coco metric.
   */
  Coco: "Coco",

  /**
   * Voc metric.
   */
  Voc: "Voc",

  /**
   * CocoVoc metric.
   */
  CocoVoc: "CocoVoc",
}

/**
 * Primary metrics for Image ObjectDetection task.
 */
union ObjectDetectionPrimaryMetrics {
  string,

  /**
   * Mean Average Precision (MAP) is the average of AP (Average Precision).
   * AP is calculated for each class and averaged to get the MAP.
   */
  MeanAveragePrecision: "MeanAveragePrecision",
}

/**
 * Enum to determine OneLake artifact type.
 */
union OneLakeArtifactType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  LakeHouse: "LakeHouse",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union NumericalDataDriftMetric {
  string,

  /**
   * The Jensen Shannon Distance (JSD) metric.
   */
  JensenShannonDistance: "JensenShannonDistance",

  /**
   * The Population Stability Index (PSI) metric.
   */
  PopulationStabilityIndex: "PopulationStabilityIndex",

  /**
   * The Normalized Wasserstein Distance metric.
   */
  NormalizedWassersteinDistance: "NormalizedWassersteinDistance",

  /**
   * The Two Sample Kolmogorov-Smirnov Test (two-sample Kâ€“S) metric.
   */
  TwoSampleKolmogorovSmirnovTest: "TwoSampleKolmogorovSmirnovTest",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union NumericalDataQualityMetric {
  string,

  /**
   * Calculates the rate of null values.
   */
  NullValueRate: "NullValueRate",

  /**
   * Calculates the rate of data type errors.
   */
  DataTypeErrorRate: "DataTypeErrorRate",

  /**
   * Calculates the rate values are out of bounds.
   */
  OutOfBoundsRate: "OutOfBoundsRate",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union NumericalPredictionDriftMetric {
  string,

  /**
   * The Jensen Shannon Distance (JSD) metric.
   */
  JensenShannonDistance: "JensenShannonDistance",

  /**
   * The Population Stability Index (PSI) metric.
   */
  PopulationStabilityIndex: "PopulationStabilityIndex",

  /**
   * The Normalized Wasserstein Distance metric.
   */
  NormalizedWassersteinDistance: "NormalizedWassersteinDistance",

  /**
   * The Two Sample Kolmogorov-Smirnov Test (two-sample Kâ€“S) metric.
   */
  TwoSampleKolmogorovSmirnovTest: "TwoSampleKolmogorovSmirnovTest",
}

/**
 * Defines supported metric goals for hyperparameter tuning
 */
union Goal {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Minimize: "Minimize",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Maximize: "Maximize",
}

/**
 * The specific type of random algorithm
 */
union RandomSamplingAlgorithmRule {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Random: "Random",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Sobol: "Sobol",
}

/**
 * Primary metrics for Regression task.
 */
union RegressionPrimaryMetrics {
  string,

  /**
   * The Spearman's rank coefficient of correlation is a nonparametric measure of rank correlation.
   */
  SpearmanCorrelation: "SpearmanCorrelation",

  /**
   * The Normalized Root Mean Squared Error (NRMSE) the RMSE facilitates the comparison between models with different scales.
   */
  NormalizedRootMeanSquaredError: "NormalizedRootMeanSquaredError",

  /**
   * The R2 score is one of the performance evaluation measures for forecasting-based machine learning models.
   */
  R2Score: "R2Score",

  /**
   * The Normalized Mean Absolute Error (NMAE) is a validation metric to compare the Mean Absolute Error (MAE) of (time) series with different scales.
   */
  NormalizedMeanAbsoluteError: "NormalizedMeanAbsoluteError",
}

/**
 * Enum for all Regression models supported by AutoML.
 */
union RegressionModels {
  string,

  /**
   * Elastic net is a popular type of regularized linear regression that combines two popular penalties, specifically the L1 and L2 penalty functions.
   */
  ElasticNet: "ElasticNet",

  /**
   * The technique of transiting week learners into a strong learner is called Boosting. The gradient boosting algorithm process works on this theory of execution.
   */
  GradientBoosting: "GradientBoosting",

  /**
   * Decision Trees are a non-parametric supervised learning method used for both classification and regression tasks.
   * The goal is to create a model that predicts the value of a target variable by learning simple decision rules inferred from the data features.
   */
  DecisionTree: "DecisionTree",

  /**
   * K-nearest neighbors (KNN) algorithm uses 'feature similarity' to predict the values of new datapoints
   * which further means that the new data point will be assigned a value based on how closely it matches the points in the training set.
   */
  KNN: "KNN",

  /**
   * Lasso model fit with Least Angle Regression a.k.a. Lars. It is a Linear Model trained with an L1 prior as regularizer.
   */
  LassoLars: "LassoLars",

  /**
   * SGD: Stochastic gradient descent is an optimization algorithm often used in machine learning applications
   * to find the model parameters that correspond to the best fit between predicted and actual outputs.
   * It's an inexact but powerful technique.
   */
  SGD: "SGD",

  /**
   * Random forest is a supervised learning algorithm.
   * The "forest" it builds, is an ensemble of decision trees, usually trained with the "bagging" method.
   * The general idea of the bagging method is that a combination of learning models increases the overall result.
   */
  RandomForest: "RandomForest",

  /**
   * Extreme Trees is an ensemble machine learning algorithm that combines the predictions from many decision trees. It is related to the widely used random forest algorithm.
   */
  ExtremeRandomTrees: "ExtremeRandomTrees",

  /**
   * LightGBM is a gradient boosting framework that uses tree based learning algorithms.
   */
  LightGBM: "LightGBM",

  /**
   * XGBoostRegressor: Extreme Gradient Boosting Regressor is a supervised machine learning model using ensemble of base learners.
   */
  XGBoostRegressor: "XGBoostRegressor",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
union SparkJobEntryType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SparkJobPythonEntry: "SparkJobPythonEntry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  SparkJobScalaEntry: "SparkJobScalaEntry",
}

/**
 * Deployment model version upgrade option.
 */
union DeploymentModelVersionUpgradeOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OnceNewDefaultVersionAvailable: "OnceNewDefaultVersionAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  OnceCurrentVersionExpired: "OnceCurrentVersionExpired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  NoAutoUpgrade: "NoAutoUpgrade",
}

/**
 * The action enum for networking rule.
 */
union RuleAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  Deny: "Deny",
}

/**
 * The List Usages operation response.
 */
model ListUsagesResult is Azure.Core.Page<Usage>;

/**
 * Describes AML Resource Usage.
 */
model Usage {
  /**
   * Specifies the resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Region of the AML workspace in the id.
   */
  @visibility(Lifecycle.Read)
  amlWorkspaceLocation?: string;

  /**
   * Specifies the resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * An enum describing the unit of usage measurement.
   */
  @visibility(Lifecycle.Read)
  unit?: UsageUnit;

  /**
   * The current usage of the resource.
   */
  @visibility(Lifecycle.Read)
  currentValue?: int64;

  /**
   * The maximum permitted usage of the resource.
   */
  @visibility(Lifecycle.Read)
  limit?: int64;

  /**
   * The name of the type of usage.
   */
  @visibility(Lifecycle.Read)
  name?: UsageName;
}

/**
 * The Usage Names.
 */
model UsageName {
  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * The localized name of the resource.
   */
  @visibility(Lifecycle.Read)
  localizedValue?: string;
}

/**
 * The List Virtual Machine size operation response.
 */
model VirtualMachineSizeListResult {
  /**
   * The list of virtual machine sizes supported by AmlCompute.
   */
  @identifiers(#["name"])
  value?: VirtualMachineSize[];
}

/**
 * Describes the properties of a VM size.
 */
model VirtualMachineSize {
  /**
   * The name of the virtual machine size.
   */
  @summary("Virtual Machine size name")
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The family name of the virtual machine size.
   */
  @summary("Virtual Machine family name")
  @visibility(Lifecycle.Read)
  family?: string;

  /**
   * The number of vCPUs supported by the virtual machine size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  @summary("Number of vPUs")
  @visibility(Lifecycle.Read)
  vCPUs?: int32;

  /**
   * The number of gPUs supported by the virtual machine size.
   */
  @summary("Number of gPUs")
  @visibility(Lifecycle.Read)
  gpus?: int32;

  /**
   * The OS VHD disk size, in MB, allowed by the virtual machine size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  @summary("OS VHD Disk size")
  @visibility(Lifecycle.Read)
  osVhdSizeMB?: int32;

  /**
   * The resource volume size, in MB, allowed by the virtual machine size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  @summary("Resource volume size")
  @visibility(Lifecycle.Read)
  maxResourceVolumeMB?: int32;

  /**
   * The amount of memory, in GB, supported by the virtual machine size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  @summary("Memory size")
  @visibility(Lifecycle.Read)
  memoryGB?: float64;

  /**
   * Specifies if the virtual machine size supports low priority VMs.
   */
  @summary("Low priority capable")
  @visibility(Lifecycle.Read)
  lowPriorityCapable?: boolean;

  /**
   * Specifies if the virtual machine size supports premium IO.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  @summary("Premium IO supported")
  @visibility(Lifecycle.Read)
  premiumIO?: boolean;

  /**
   * The estimated price information for using a VM.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  @summary("Estimated VM prices")
  estimatedVMPrices?: EstimatedVMPrices;

  /**
   * Specifies the compute types supported by the virtual machine size.
   */
  @summary("Supported Compute Types")
  supportedComputeTypes?: string[];
}

/**
 * The estimated price info for using a VM.
 */
model EstimatedVMPrices {
  /**
   * Three lettered code specifying the currency of the VM price. Example: USD
   */
  @summary("Billing currency")
  billingCurrency: BillingCurrency;

  /**
   * The unit of time measurement for the specified VM price. Example: OneHour
   */
  @summary("Unit of time measure")
  unitOfMeasure: UnitOfMeasure;

  /**
   * The list of estimated prices for using a VM of a particular OS type, tier, etc.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Array items do not have stable identifiers"
  @OpenAPI.extension("x-ms-identifiers", #[])
  @summary("List of estimated VM prices.")
  values: EstimatedVMPrice[];
}

/**
 * The estimated price info for using a VM of a particular OS type, tier, etc.
 */
model EstimatedVMPrice {
  /**
   * The price charged for using the VM.
   */
  @summary("Retail price")
  retailPrice: float64;

  /**
   * Operating system type used by the VM.
   */
  @summary("OS type")
  osType: VMPriceOSType;

  /**
   * The type of the VM.
   */
  @summary("VM tier")
  vmTier: VMTier;
}

/**
 * Quota update parameters.
 */
model QuotaUpdateParameters {
  /**
   * The list for update quota.
   */
  value?: QuotaBaseProperties[];

  /**
   * Region of workspace quota to be updated.
   */
  location?: string;
}

/**
 * The properties for Quota update or retrieval.
 */
model QuotaBaseProperties {
  /**
   * Specifies the resource ID.
   */
  id?: string;

  /**
   * Specifies the resource type.
   */
  type?: string;

  /**
   * The maximum permitted quota of the resource.
   */
  @summary("Limit.")
  limit?: int64;

  /**
   * An enum describing the unit of quota measurement.
   */
  unit?: QuotaUnit;
}

/**
 * The result of update workspace quota.
 */
model UpdateWorkspaceQuotasResult {
  /**
   * The list of workspace quota update result.
   */
  @visibility(Lifecycle.Read)
  value?: UpdateWorkspaceQuotas[];

  /**
   * The URI to fetch the next page of workspace quota update result. Call ListNext() with this to fetch the next page of Workspace Quota update result.
   */
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * The properties for update Quota response.
 */
model UpdateWorkspaceQuotas {
  /**
   * Specifies the resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Specifies the resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The maximum permitted quota of the resource.
   */
  @summary("Limit.")
  limit?: int64;

  /**
   * An enum describing the unit of quota measurement.
   */
  @visibility(Lifecycle.Read)
  unit?: QuotaUnit;

  /**
   * Status of update workspace quota.
   */
  @summary("Update Workspace Quota Status.")
  @visibility(Lifecycle.Read)
  status?: Status;
}

/**
 * The List WorkspaceQuotasByVMFamily operation response.
 */
model ListWorkspaceQuotas is Azure.Core.Page<ResourceQuota>;

/**
 * The quota assigned to a resource.
 */
model ResourceQuota {
  /**
   * Specifies the resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Region of the AML workspace in the id.
   */
  @visibility(Lifecycle.Read)
  amlWorkspaceLocation?: string;

  /**
   * Specifies the resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: ResourceName;

  /**
   * The maximum permitted quota of the resource.
   */
  @visibility(Lifecycle.Read)
  @summary("Limit.")
  limit?: int64;

  /**
   * An enum describing the unit of quota measurement.
   */
  @visibility(Lifecycle.Read)
  unit?: QuotaUnit;
}

/**
 * The Resource Name.
 */
model ResourceName {
  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * The localized name of the resource.
   */
  @visibility(Lifecycle.Read)
  localizedValue?: string;
}

/**
 * Paginated list of Machine Learning compute objects wrapped in ARM resource envelope.
 */
model PaginatedComputeResourcesList is Azure.Core.Page<ComputeResource>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
model ComputeResourceSchema {
  /**
   * Compute properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Property intentionally duplicated for API compatibility"
  properties?: Compute;
}

/**
 * Machine Learning compute object.
 */
@discriminator("computeType")
model Compute {
  /**
   * The type of compute
   */
  computeType: ComputeType;

  /**
   * Location for the underlying compute
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  computeLocation?: string;

  /**
   * The provision state of the cluster. Valid values are Unknown, Updating, Provisioning, Succeeded, and Failed.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The description of the Machine Learning compute.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  description?: string | null;

  /**
   * The time at which the compute was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The time at which the compute was last modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedOn?: utcDateTime;

  /**
   * ARM resource id of the underlying compute
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  resourceId?: string | null;

  /**
   * Errors during provisioning
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["/error/code"])
  provisioningErrors?: ErrorResponse[] | null;

  /**
   * Indicating whether the compute was provisioned by user and brought from outside if true, or machine learning service provisioned it if false.
   */
  @visibility(Lifecycle.Read)
  isAttachedCompute?: boolean;

  /**
   * Opt-out of local authentication and ensure customers can use only MSI and AAD exclusively for authentication.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  disableLocalAuth?: boolean;
}

/**
 * AmlCompute update parameters.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Existing API uses custom patch envelope"
model ClusterUpdateParameters {
  /**
   * The properties of the amlCompute.
   */
  properties?: ClusterUpdateProperties;
}

/**
 * The properties of a amlCompute that need to be updated.
 */
model ClusterUpdateProperties {
  /**
   * Properties of ClusterUpdate
   */
  properties?: ScaleSettingsInformation;
}

/**
 * Desired scale settings for the amlCompute.
 */
model ScaleSettingsInformation {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @summary("Scale settings.")
  scaleSettings?: ScaleSettings;
}

/**
 * scale settings for AML Compute
 */
model ScaleSettings {
  /**
   * Max number of nodes to use
   */
  maxNodeCount: int32;

  /**
   * Min number of nodes to use
   */
  minNodeCount?: int32 = 0;

  /**
   * Node Idle Time before scaling down amlCompute. This string needs to be in the RFC Format.
   */
  nodeIdleTimeBeforeScaleDown?: duration;
}

/**
 * Specifies the custom service configuration
 */
model CustomService {
  ...Record<unknown>;

  /**
   * Name of the Custom Service
   */
  name?: string;

  /**
   * Describes the Image Specifications
   */
  image?: Image;

  /**
   * Environment Variable for the container
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  environmentVariables?: Record<EnvironmentVariable>;

  /**
   * Describes the docker settings for the image
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  docker?: Docker | null;

  /**
   * Configuring the endpoints for the container
   */
  @identifiers(#["name"])
  endpoints?: Endpoint[];

  /**
   * Configuring the volumes for the container
   */
  @identifiers(#["source", "target"])
  volumes?: VolumeDefinition[];

  /**
   * Describes the jupyter kernel settings for the image if its a custom environment
   */
  kernel?: JupyterKernelConfig;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model Image {
  ...Record<unknown>;

  /**
   * Type of the image. Possible values are: docker - For docker images. azureml - For AzureML Environment images (custom and curated)
   */
  @summary("Type of the image")
  type?: ImageType = ImageType.docker;

  /**
   * Image reference URL if type is docker. Environment name if type is azureml
   */
  reference?: string;

  /**
   * Version of image being used. If latest then skip this field
   */
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EnvironmentVariable {
  ...Record<unknown>;

  /**
   * Type of the Environment Variable. Possible values are: local - For local variable
   */
  @summary("Type of Environment Variable")
  type?: EnvironmentVariableType = EnvironmentVariableType.local;

  /**
   * Value of the Environment variable
   */
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model Docker {
  ...Record<unknown>;

  /**
   * Indicate whether container shall run in privileged or non-privileged mode.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  privileged?: boolean | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model Endpoint {
  /**
   * Protocol over which communication will happen over this endpoint
   */
  @summary("Endpoint Communication Protocol")
  protocol?: Protocol = Protocol.tcp;

  /**
   * Name of the Endpoint
   */
  name?: string;

  /**
   * Application port inside the container.
   */
  target?: int32;

  /**
   * Port over which the application is exposed from container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  published?: int32 | null;

  /**
   * Host IP over which the application is exposed from the container
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  hostIp?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model VolumeDefinition {
  /**
   * Type of Volume Definition. Possible Values: bind,volume,tmpfs,npipe
   */
  @summary("Type of Volume Definition")
  type?: VolumeDefinitionType = VolumeDefinitionType.bind;

  /**
   * Indicate whether to mount volume as readOnly. Default value for this is false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  readOnly?: boolean | null;

  /**
   * Source of the mount. For bind mounts this is the host path.
   */
  source?: string;

  /**
   * Target of the mount. For bind mounts this is the path in the container.
   */
  target?: string;

  /**
   * Consistency of the volume
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  consistency?: string | null;

  /**
   * Bind Options of the mount
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  bind?: BindOptions | null;

  /**
   * Volume Options of the mount
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  volume?: VolumeOptions | null;

  /**
   * tmpfs option of the mount
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tmpfs?: TmpfsOptions | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model BindOptions {
  /**
   * Type of Bind Option
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  propagation?: string | null;

  /**
   * Indicate whether to create host path.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  createHostPath?: boolean | null;

  /**
   * Mention the selinux options.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  selinux?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model VolumeOptions {
  /**
   * Indicate whether volume is nocopy
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  nocopy?: boolean | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model TmpfsOptions {
  /**
   * Mention the Tmpfs size
   */
  size?: int32;
}

/**
 * Jupyter kernel configuration.
 */
model JupyterKernelConfig {
  /**
   * Argument to the the runtime
   */
  argv?: string[];

  /**
   * Display name of the kernel
   */
  displayName?: string;

  /**
   * Language of the kernel [Example value: python]
   */
  language?: string;
}

/**
 * Result of AmlCompute Nodes
 */
model AmlComputeNodesInformation {
  /**
   * The collection of returned AmlCompute nodes details.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  @identifiers(#["nodeId"])
  nodes?: AmlComputeNodeInformation[];

  /**
   * The continuation token.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

/**
 * Compute node information related to a AmlCompute.
 */
model AmlComputeNodeInformation {
  /**
   * ID of the compute node.
   */
  @visibility(Lifecycle.Read)
  @summary("Node ID.")
  nodeId?: string;

  /**
   * Private IP address of the compute node.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  @summary("Private IP address.")
  privateIpAddress?: string | null;

  /**
   * Public IP address of the compute node.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  @summary("Public IP address.")
  publicIpAddress?: string | null;

  /**
   * SSH port number of the node.
   */
  @visibility(Lifecycle.Read)
  @summary("Port.")
  port?: int32;

  /**
   * State of the compute node. Values are idle, running, preparing, unusable, leaving and preempted.
   */
  @visibility(Lifecycle.Read)
  nodeState?: NodeState;

  /**
   * ID of the Experiment running on the node, if any else null.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  @summary("Run ID.")
  runId?: string | null;
}

/**
 * Secrets related to a Machine Learning compute. Might differ for every type of compute.
 */
@discriminator("computeType")
model ComputeSecrets {
  /**
   * The type of compute
   */
  computeType: ComputeType;
}

/**
 * Defines an Aml Instance DataMount.
 */
model ComputeInstanceDataMount {
  /**
   * Source of the ComputeInstance data mount.
   */
  source?: string;

  /**
   * Data source type.
   */
  sourceType?: SourceType;

  /**
   * name of the ComputeInstance data mount.
   */
  mountName?: string;

  /**
   * Mount Action.
   */
  mountAction?: MountAction;

  /**
   * Mount Mode.
   */
  mountMode?: MountMode;

  /**
   * who this data mount created by.
   */
  createdBy?: string;

  /**
   * Path of this data mount.
   */
  mountPath?: string;

  /**
   * Mount state.
   */
  mountState?: MountState;

  /**
   * The time when the disk mounted.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @summary("Mounted time.")
  mountedOn?: utcDateTime;

  /**
   * Error of this data mount.
   */
  error?: string;
}

/**
 * Stops compute instance after user defined period of inactivity.
 */
model IdleShutdownSetting {
  /**
   * Time is defined in ISO8601 format. Minimum is 15 min, maximum is 3 days.
   */
  idleTimeBeforeShutdown?: string;
}

/**
 * Schema for Compute Instance resize.
 */
model ResizeSchema {
  /**
   * The name of the virtual machine size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  targetVMSize?: string;
}

/**
 * A paginated list of AvailableQuota entities.
 */
model AvailableQuotaArmPaginatedResult is Azure.Core.Page<AvailableQuota>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model AvailableQuota {
  /**
   * Available quota properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  properties?: AvailableQuotaProperties | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model AvailableQuotaProperties {
  /**
   * The number of available quota
   */
  total?: int64;
}

/**
 * A paginated list of UsageAndQuotaDetails entities.
 */
model UsageAndQuotaDetailsArmPaginatedResult
  is Azure.Core.Page<UsageAndQuotaDetails>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model UsageAndQuotaDetails {
  /**
   * Model collection name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelCollection?: string | null;

  /**
   * The total number of quota
   */
  quota?: int64;

  /**
   * Usage details for each deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  usageDetails?: PTUDeploymentUsage[] | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model PTUDeploymentUsage {
  /**
   * Usage number from the collection level quota
   */
  collectionQuotaUsage?: int64;

  /**
   * Deployment name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  deploymentName?: string | null;

  /**
   * Resource group name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  resourceGroup?: string | null;

  /**
   * Usage number from subscription level quota
   */
  usage?: int64;

  /**
   * Workspace name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  workspaceName?: string | null;
}

/**
 * A paginated list of CodeContainer entities.
 */
model CodeContainerResourceArmPaginatedResult is Azure.Core.Page<CodeContainer>;

/**
 * Container for code asset versions.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model CodeContainerProperties extends AssetContainer {
  /**
   * Provisioning state for the code container.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model AssetContainer extends ResourceBase {
  /**
   * Is the asset archived?
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isArchived?: boolean = false;

  /**
   * The latest version inside this container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  latestVersion?: string | null;

  /**
   * The next auto incremental version
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  nextVersion?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ResourceBase {
  /**
   * The asset description text.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  description?: string | null;

  /**
   * The asset property dictionary.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Property intentionally duplicated for API compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  properties?: Record<string | null> | null;

  /**
   * Tag dictionary. Tags can be added, removed, and updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tags?: Record<string | null> | null;
}

/**
 * A paginated list of CodeVersion entities.
 */
model CodeVersionResourceArmPaginatedResult is Azure.Core.Page<CodeVersion>;

/**
 * Code asset version details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model CodeVersionProperties extends AssetBase {
  /**
   * Uri where code is located
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  codeUri?: string | null;

  /**
   * Provisioning state for the code version.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model AssetBase extends ResourceBase {
  /**
   * If the name version are system generated (anonymous registration).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isAnonymous?: boolean = false;

  /**
   * Is the asset archived?
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isArchived?: boolean = false;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model PendingUploadRequestDto {
  /**
   * If PendingUploadId = null then random guid will be used.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  pendingUploadId?: string | null;

  /**
   * Type of storage to use for the pending upload location
   */
  pendingUploadType?: PendingUploadType = PendingUploadType.TemporaryBlobReference;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model PendingUploadResponseDto {
  /**
   * Container level read, write, list SAS
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  blobReferenceForConsumption?: BlobReferenceForConsumptionDto | null;

  /**
   * ID for this upload request
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  pendingUploadId?: string | null;

  /**
   * Type of storage to use for the pending upload location
   */
  pendingUploadType?: PendingUploadType = PendingUploadType.TemporaryBlobReference;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model BlobReferenceForConsumptionDto {
  /**
   * Blob URI path for client to upload data.
   * Example: https://blob.windows.core.net/Container/Path
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  blobUri?: url | null;

  /**
   * Credential info to access storage account
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  credential?: PendingUploadCredentialDto | null;

  /**
   * Arm ID of the storage account to use
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  storageAccountArmId?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("credentialType")
model PendingUploadCredentialDto {
  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialType: PendingUploadCredentialType;
}

/**
 * A paginated list of ComponentContainer entities.
 */
model ComponentContainerResourceArmPaginatedResult
  is Azure.Core.Page<ComponentContainer>;

/**
 * Component container definition.
 * <see href="https://docs.microsoft.com/en-us/azure/machine-learning/reference-yaml-component-command" />
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model ComponentContainerProperties extends AssetContainer {
  /**
   * Provisioning state for the component container.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;
}

/**
 * A paginated list of ComponentVersion entities.
 */
model ComponentVersionResourceArmPaginatedResult
  is Azure.Core.Page<ComponentVersion>;

/**
 * Definition of a component version: defines resources that span component types.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model ComponentVersionProperties extends AssetBase {
  /**
   * Defines Component definition details.
   * <see href="https://docs.microsoft.com/en-us/azure/machine-learning/reference-yaml-component-command" />
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  componentSpec?: unknown | null;

  /**
   * Provisioning state for the component version.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;
}

/**
 * A paginated list of DataContainer entities.
 */
model DataContainerResourceArmPaginatedResult is Azure.Core.Page<DataContainer>;

/**
 * Container for data asset versions.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
model DataContainerProperties extends AssetContainer {
  /**
   * [Required] Specifies the type of data.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataType: DataType;
}

/**
 * A paginated list of DataVersionBase entities.
 */
model DataVersionBaseResourceArmPaginatedResult
  is Azure.Core.Page<DataVersionBase>;

/**
 * Data version base definition
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
@discriminator("dataType")
model DataVersionBaseProperties extends AssetBase {
  /**
   * [Required] Specifies the type of data.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataType: DataType;

  /**
   * [Required] Uri of the data. Example: https://go.microsoft.com/fwlink/?linkid=2202330
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  dataUri: string;
}

/**
 * BlobReferenceSASRequest for getBlobReferenceSAS API
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model GetBlobReferenceSASRequestDto {
  /**
   * Id of the asset to be accessed
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  assetId?: string | null;

  /**
   * Blob uri of the asset to be accessed
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  blobUri?: url | null;
}

/**
 * BlobReferenceSASResponse for getBlobReferenceSAS API
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model GetBlobReferenceSASResponseDto {
  /**
   * Blob reference for consumption details
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  blobReferenceForConsumption?: GetBlobReferenceForConsumptionDto | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model GetBlobReferenceForConsumptionDto {
  /**
   * Blob uri, example: https://blob.windows.core.net/Container/Path
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  blobUri?: url | null;

  /**
   * Credential info to access storage account
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  credential?: DataReferenceCredential | null;

  /**
   * The ARM id of the storage account
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  storageAccountArmId?: string | null;
}

/**
 * DataReferenceCredential base class
 */
@discriminator("credentialType")
model DataReferenceCredential {
  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialType: DataReferenceCredentialType;
}

/**
 * A paginated list of EnvironmentContainer entities.
 */
model EnvironmentContainerResourceArmPaginatedResult
  is Azure.Core.Page<EnvironmentContainer>;

/**
 * Container for environment specification versions.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model EnvironmentContainerProperties extends AssetContainer {
  /**
   * Provisioning state for the environment container.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;
}

/**
 * A paginated list of EnvironmentVersion entities.
 */
model EnvironmentVersionResourceArmPaginatedResult
  is Azure.Core.Page<EnvironmentVersion>;

/**
 * Environment version details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model EnvironmentVersionProperties extends AssetBase {
  /**
   * AutoRebuild setting for the derived image
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  autoRebuild?: AutoRebuildSetting = AutoRebuildSetting.Disabled;

  /**
   * Configuration settings for Docker build context.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  build?: BuildContext;

  /**
   * Standard configuration file used by Conda that lets you install any kind of package, including Python, R, and C/C++ packages.
   * <see href="https://repo2docker.readthedocs.io/en/latest/config_files.html#environment-yml-install-a-conda-environment" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  condaFile?: string;

  /**
   * Environment type is either user managed or curated by the Azure ML service
   * <see href="https://docs.microsoft.com/en-us/azure/machine-learning/resource-curated-environments" />
   */
  @visibility(Lifecycle.Read)
  environmentType?: EnvironmentType;

  /**
   * Name of the image that will be used for the environment.
   * <seealso href="https://docs.microsoft.com/en-us/azure/machine-learning/how-to-deploy-custom-docker-image#use-a-custom-base-image" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  image?: string;

  /**
   * Environment image details.
   */
  @removed(Versions.v2025_12_01)
  imageDetails?: ImageDetails;

  /**
   * Defines configuration specific to inference.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inferenceConfig?: InferenceContainerProperties;

  /**
   * The type of operating system.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  osType?: OperatingSystemType = OperatingSystemType.Linux;

  /**
   * Provisioning state for the environment version.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;

  /**
   * Stage in the environment lifecycle assigned to this environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  stage?: string | null;
}

/**
 * Configuration settings for Docker build context
 */
model BuildContext {
  /**
   * [Required] URI of the Docker build context used to build the image. Supports blob URIs on environment creation and may return blob or Git URIs.
   * <seealso href="https://docs.docker.com/engine/reference/commandline/build/#extended-description" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  contextUri: string;

  /**
   * Path to the Dockerfile in the build context.
   * <seealso href="https://docs.docker.com/engine/reference/builder/" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dockerfilePath?: string = "Dockerfile";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@removed(Versions.v2025_12_01)
model ImageDetails {
  /**
   * Indicates if image exists
   */
  exists?: boolean;

  /**
   * Container image details
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  image?: ImageInfo | null;

  /**
   * Vulnerability findings details
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  vulnerabilityFindings?: VulnerabilityFindings | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ImageInfo {
  /**
   * Image digest
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  digest?: string | null;

  /**
   * Container registry host name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  hostname?: string | null;

  /**
   * Repository name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  repository?: string | null;

  /**
   * Image tag
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tag?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model VulnerabilityFindings {
  /**
   * AssetId (Image digest).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  assetId?: string | null;

  /**
   * Number of critical findings.
   */
  @visibility(Lifecycle.Read)
  criticalFindingsCount?: int32;

  /**
   * List of vulnerability findings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  data?: VulnerabilityDetails[] | null;

  /**
   * Time the report was generated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  generatedTime?: utcDateTime;

  /**
   * Number of high findings.
   */
  @visibility(Lifecycle.Read)
  highFindingsCount?: int32;

  /**
   * Scan result date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  lastScanDate?: utcDateTime | null;

  /**
   * Vulnerability scanner name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  scanner?: string | null;

  /**
   * Data source (internal).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  source?: string | null;

  /**
   * Total findings count.
   */
  @visibility(Lifecycle.Read)
  totalFindingsCount?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model VulnerabilityDetails {
  /**
   * CVE id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  cve?: string | null;

  /**
   * CVE url.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  cveUrl?: string | null;

  /**
   * DueDate for vulnerability. Provider data or PublishDate + 30 days.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  dueDate?: utcDateTime | null;

  /**
   * Vulnerability ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  id?: string | null;

  /**
   * Dependency details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  packageDetails?: PackageDetails[] | null;

  /**
   * Indicates if there is a known patch for vulnerability.
   */
  patchable?: boolean;

  /**
   * Vulnerability ID from provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  providerId?: string | null;

  /**
   * Vulnerability publish date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  publishDate?: utcDateTime | null;

  /**
   * Vulnerability Risk value.
   */
  risk?: VulnerabilityRisk;

  /**
   * Vulnerability description.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  solution?: string | null;

  /**
   * Vulnerability name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  title?: string | null;

  /**
   * Vendor vulnerability ID (USN, GH Advisory, etc).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  vendorId?: string | null;

  /**
   * Vendor vulnerability url.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  vendorUrl?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model PackageDetails {
  /**
   * Install path.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  installPath?: string | null;

  /**
   * Installed version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  installedVersion?: string | null;

  /**
   * Package or dependency name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  name?: string | null;

  /**
   * Patched version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  patchedVersion?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model InferenceContainerProperties {
  /**
   * The route to check the liveness of the inference server container.
   */
  livenessRoute?: Route;

  /**
   * The route to check the readiness of the inference server container.
   */
  readinessRoute?: Route;

  /**
   * The port to send the scoring requests to, within the inference server container.
   */
  scoringRoute?: Route;

  /**
   * The route to check the startup of the application in the container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  startupRoute?: Route | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model Route {
  /**
   * [Required] The path for the route.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  path: string;

  /**
   * [Required] The port for the route.
   */
  port: int32;
}

/**
 * A paginated list of ModelContainer entities.
 */
model ModelContainerResourceArmPaginatedResult
  is Azure.Core.Page<ModelContainer>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ModelContainerProperties extends AssetContainer {
  /**
   * Provisioning state for the model container.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;
}

/**
 * A paginated list of ModelVersion entities.
 */
model ModelVersionResourceArmPaginatedResult is Azure.Core.Page<ModelVersion>;

/**
 * Model asset version details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model ModelVersionProperties extends AssetBase {
  /**
   * Mapping of model flavors to their properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  flavors?: Record<FlavorData | null> | null;

  /**
   * Name of the training job which produced this model
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  jobName?: string | null;

  /**
   * The storage format for this entity. Used for NCD.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelType?: string | null;

  /**
   * The URI path to the model contents.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelUri?: string | null;

  /**
   * Provisioning state for the model version.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;

  /**
   * Stage in the model lifecycle assigned to this model
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  stage?: string | null;

  /**
   * Array of dataset references
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  datasets?: DatasetReference[] | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model FlavorData {
  /**
   * Model flavor-specific data.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  data?: Record<string | null> | null;
}

/**
 * Dataset reference object.
 */
model DatasetReference {
  /**
   * The name of the dataset reference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  name?: string | null;

  /**
   * The fully qualified ARM id of the dataset reference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  id?: string | null;
}

/**
 * A paginated list of BatchEndpoint entities.
 */
model BatchEndpointTrackedResourceArmPaginatedResult
  is Azure.Core.Page<BatchEndpoint>;

/**
 * Batch endpoint configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model BatchEndpointProperties extends EndpointPropertiesBase {
  /**
   * Default values for Batch Endpoint
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  defaults?: BatchEndpointDefaults | null;

  /**
   * Provisioning state for the endpoint.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EndpointProvisioningState;
}

/**
 * Batch endpoint default values
 */
model BatchEndpointDefaults {
  /**
   * Name of the deployment that will be default for the endpoint.
   * This deployment will end up getting 100% traffic when the endpoint scoring URL is invoked.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  deploymentName?: string | null;
}

/**
 * Inference Endpoint base definition
 */
model EndpointPropertiesBase {
  /**
   * [Required] The authentication method for invoking the endpoint (data plane operation). Use 'Key' for key-based authentication. Use 'AMLToken' for Azure Machine Learning token-based authentication. Use 'AADToken' for Microsoft Entra token-based authentication.
   */
  authMode: EndpointAuthMode;

  /**
   * Description of the inference endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  description?: string | null;

  /**
   * EndpointAuthKeys to set initially on an Endpoint.
   * This property will always be returned as null. AuthKey values must be retrieved using the ListKeys API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Create)
  @secret
  keys?: EndpointAuthKeys | null;

  /**
   * Property dictionary. Properties can be added, but not removed or altered.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Property intentionally duplicated for API compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  properties?: Record<string | null> | null;

  /**
   * Endpoint URI.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  scoringUri?: url | null;

  /**
   * Endpoint Swagger URI.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  swaggerUri?: url | null;
}

/**
 * Keys for endpoint authentication.
 */
model EndpointAuthKeys {
  /**
   * The primary key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @secret
  primaryKey?: string | null;

  /**
   * The secondary key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @secret
  secondaryKey?: string | null;
}

/**
 * Strictly used in update requests.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Existing API uses custom patch envelope"
model PartialMinimalTrackedResourceWithIdentity
  extends PartialMinimalTrackedResource {
  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: PartialManagedServiceIdentity;
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
model PartialManagedServiceIdentity {
  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  type?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  userAssignedIdentities?: Record<unknown>;
}

/**
 * Strictly used in update requests.
 */
model PartialMinimalTrackedResource {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tags?: Record<string | null>;
}

/**
 * A paginated list of BatchDeployment entities.
 */
model BatchDeploymentTrackedResourceArmPaginatedResult
  is Azure.Core.Page<BatchDeployment>;

/**
 * Batch inference settings per deployment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model BatchDeploymentProperties extends EndpointDeploymentPropertiesBase {
  /**
   * Compute target for batch inference operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  compute?: string | null;

  /**
   * Properties relevant to different deployment types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  deploymentConfiguration?: BatchDeploymentConfiguration | null;

  /**
   * Error threshold, if the error count for the entire input goes above this value,
   * the batch inference will be aborted. Range is [-1, int.MaxValue].
   * For FileDataset, this value is the count of file failures.
   * For TabularDataset, this value is the count of record failures.
   * If set to -1 (the lower bound), all failures during batch inference will be ignored.
   */
  errorThreshold?: int32 = -1;

  /**
   * Log verbosity for batch inferencing.
   * Increasing verbosity order for logging is : Warning, Info and Debug.
   * The default value is Info.
   */
  loggingLevel?: BatchLoggingLevel = BatchLoggingLevel.Info;

  /**
   * Indicates maximum number of parallelism per instance.
   */
  maxConcurrencyPerInstance?: int32 = 1;

  /**
   * Size of the mini-batch passed to each batch invocation.
   * For FileDataset, this is the number of files per mini-batch.
   * For TabularDataset, this is the size of the records in bytes, per mini-batch.
   */
  miniBatchSize?: int64 = 10;

  /**
   * Reference to the model asset for the endpoint deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  `model`?: AssetReferenceBase | null;

  /**
   * Enum to determine how batch inferencing will handle output
   */
  outputAction?: BatchOutputAction = BatchOutputAction.AppendRow;

  /**
   * Customized output file name for append_row output action.
   */
  outputFileName?: string = "predictions.csv";

  /**
   * Provisioning state for the endpoint deployment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DeploymentProvisioningState;

  /**
   * Indicates compute configuration for the job.
   * If not provided, will default to the defaults defined in ResourceConfiguration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  resources?: DeploymentResourceConfiguration | null;

  /**
   * Retry Settings for the batch inference operation.
   * If not provided, will default to the defaults defined in BatchRetrySettings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  retrySettings?: BatchRetrySettings | null;
}

/**
 * Properties relevant to different deployment types.
 */
@discriminator("deploymentConfigurationType")
model BatchDeploymentConfiguration {
  /**
   * [Required] The type of the deployment
   */
  deploymentConfigurationType: BatchDeploymentConfigurationType;
}

/**
 * Base definition for asset references.
 */
@discriminator("referenceType")
model AssetReferenceBase {
  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: ReferenceType;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Empty model used as placeholder in API"
model DeploymentResourceConfiguration extends ResourceConfiguration {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ResourceConfiguration {
  /**
   * Optional number of instances or nodes used by the compute target.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  instanceCount?: int32 = 1;

  /**
   * Optional type of VM used as supported by the compute target.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  instanceType?: string | null;

  /**
   * Additional properties bag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  properties?: Record<unknown | null> | null;
}

/**
 * Retry settings for a batch inference operation.
 */
model BatchRetrySettings {
  /**
   * Maximum retry count for a mini-batch
   */
  maxRetries?: int32 = 3;

  /**
   * Invocation timeout for a mini-batch, in ISO 8601 format.
   */
  timeout?: duration = duration.fromISO("PT30S");
}

/**
 * Base definition for endpoint deployment.
 */
model EndpointDeploymentPropertiesBase {
  /**
   * Code configuration for the endpoint deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  codeConfiguration?: CodeConfiguration | null;

  /**
   * Description of the endpoint deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  description?: string | null;

  /**
   * ARM resource ID or AssetId of the environment specification for the endpoint deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  environmentId?: string | null;

  /**
   * Environment variables configuration for the deployment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  environmentVariables?: Record<string | null> | null;

  /**
   * Property dictionary. Properties can be added, but not removed or altered.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Property intentionally duplicated for API compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  properties?: Record<string | null> | null;
}

/**
 * Configuration for a scoring code asset.
 */
model CodeConfiguration {
  /**
   * ARM resource ID of the code asset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  codeId?: string | null;

  /**
   * [Required] The script to execute on startup. eg. "score.py"
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  scoringScript: string;
}

/**
 * Strictly used in update requests.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Existing API uses custom patch envelope"
model PartialBatchDeploymentPartialMinimalTrackedResourceWithProperties {
  /**
   * Additional attributes of the entity.
   */
  properties?: PartialBatchDeployment;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  tags?: Record<string | null>;
}

/**
 * Mutable batch inference settings per deployment.
 */
model PartialBatchDeployment {
  /**
   * Description of the endpoint deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  description?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CapabilityHostProperties extends ResourceBase {
  /**
   * List of Aca Environment connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  acaEnvironmentConnections?: string[] | null;

  /**
   * List of AI services connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  aiServicesConnections?: string[] | null;

  /**
   * Kind of this capability host.
   */
  capabilityHostKind?: CapabilityHostKind = CapabilityHostKind.Agents;

  /**
   * Customer subnet info to help set up this capability host.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  customerSubnet?: string | null;

  /**
   * Provisioning state for the CapabilityHost.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CapabilityHostProvisioningState;

  /**
   * List of Storage connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  storageConnections?: string[] | null;

  /**
   * List of Thread storage connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  threadStorageConnections?: string[] | null;

  /**
   * List of VectorStore connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  vectorStoreConnections?: string[] | null;

  /**
   * List of messages containing errors.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  messages?: string[] | null;
}

/**
 * Publishing destination registry asset information
 */
model DestinationAsset {
  /**
   * Destination asset name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  destinationName?: string | null;

  /**
   * Destination asset version
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  destinationVersion?: string | null;

  /**
   * Destination registry name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  registryName?: string | null;
}

/**
 * A paginated list of Datastore entities.
 */
model DatastoreResourceArmPaginatedResult is Azure.Core.Page<Datastore>;

/**
 * Base definition for datastore contents configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
@discriminator("datastoreType")
model DatastoreProperties extends ResourceBase {
  /**
   * [Required] Account credentials.
   */
  credentials: DatastoreCredentials;

  /**
   * Enum to determine the datastore contents type.
   */
  datastoreType: DatastoreType;

  /**
   * Readonly property to indicate if datastore is the workspace default datastore
   */
  @visibility(Lifecycle.Read)
  isDefault?: boolean;
}

/**
 * Base definition for datastore credentials.
 */
@discriminator("credentialsType")
model DatastoreCredentials {
  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: CredentialsType;
}

/**
 * Secret expiration configuration.
 */
model SecretExpiry {
  /**
   * Indicates if the secret is expirable.
   */
  expirableSecret?: boolean = false;

  /**
   * Number of hours after which the secret will expire.
   */
  expireAfterHours?: int32 = 1;
}

/**
 * Base definition for datastore secrets.
 */
@discriminator("secretsType")
model DatastoreSecrets {
  /**
   * [Required] Credential type used to authentication with storage.
   */
  secretsType: SecretsType;
}

/**
 * A paginated list of FeaturesetContainer entities.
 */
model FeaturesetContainerResourceArmPaginatedResult
  is Azure.Core.Page<FeaturesetContainer>;

/**
 * DTO object representing feature set
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model FeaturesetContainerProperties extends AssetContainer {
  /**
   * Provisioning state for the featureset container.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;
}

/**
 * A paginated list of Feature entities.
 */
model FeatureResourceArmPaginatedResult is Azure.Core.Page<Feature>;

/**
 * DTO object representing feature
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
model FeatureProperties extends ResourceBase {
  /**
   * Specifies type
   */
  dataType?: FeatureDataType = FeatureDataType.String;

  /**
   * Specifies name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  featureName?: string | null;
}

/**
 * A paginated list of FeaturesetVersion entities.
 */
model FeaturesetVersionResourceArmPaginatedResult
  is Azure.Core.Page<FeaturesetVersion>;

/**
 * DTO object representing feature set version
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model FeaturesetVersionProperties extends AssetBase {
  /**
   * Specifies list of entities
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  entities?: string[] | null;

  /**
   * Specifies the materialization settings
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  materializationSettings?: MaterializationSettings | null;

  /**
   * Provisioning state for the featureset version container.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;

  /**
   * Specifies the feature spec details
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  specification?: FeaturesetSpecification | null;

  /**
   * Specifies the asset stage
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  stage?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model MaterializationSettings {
  /**
   * Specifies the notification details
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  notification?: NotificationSetting | null;

  /**
   * Specifies the compute resource settings
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  resource?: MaterializationComputeResource | null;

  /**
   * Specifies the schedule details
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  schedule?: RecurrenceTrigger | null;

  /**
   * Specifies the spark compute settings
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  sparkConfiguration?: Record<string | null> | null;

  /**
   * Specifies the stores to which materialization should happen
   */
  storeType?: MaterializationStoreType = MaterializationStoreType.None;
}

/**
 * Configuration for notification.
 */
model NotificationSetting {
  /**
   * Send email notification to user on specified notification type
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  emailOn?: EmailNotificationEnableType[] | null;

  /**
   * This is the email recipient list which has a limitation of 499 characters in total concat with comma separator
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  emails?: string[] | null;

  /**
   * Send webhook callback to a service. Key is a user-provided name for the webhook.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  webhooks?: Record<Webhook | null> | null;
}

/**
 * Webhook base
 */
@discriminator("webhookType")
model Webhook {
  /**
   * Send callback on a specified notification event
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  eventType?: string | null;

  /**
   * [Required] Specifies the type of service to send a callback
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  webhookType: WebhookType;
}

/**
 * DTO object representing compute resource
 */
model MaterializationComputeResource {
  /**
   * Specifies the instance type
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  instanceType?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model RecurrenceTrigger extends TriggerBase {
  /**
   * [Required] The frequency to trigger schedule.
   */
  frequency: RecurrenceFrequency;

  /**
   * [Required] Specifies schedule interval in conjunction with frequency
   */
  interval: int32;

  /**
   * The recurrence schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  schedule?: RecurrenceSchedule | null;

  /**
   * [Required]
   */
  triggerType: "Recurrence";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model RecurrenceSchedule {
  /**
   * [Required] List of hours for the schedule.
   */
  hours: int32[];

  /**
   * [Required] List of minutes for the schedule.
   */
  minutes: int32[];

  /**
   * List of month days for the schedule
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  monthDays?: int32[] | null;

  /**
   * List of days for the schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  weekDays?: WeekDay[] | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("triggerType")
model TriggerBase {
  /**
   * Specifies end time of schedule in ISO 8601, but without a UTC offset. Refer https://en.wikipedia.org/wiki/ISO_8601.
   * Recommented format would be "2022-06-01T00:00:01"
   * If not present, the schedule will run indefinitely
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  endTime?: string | null;

  /**
   * Specifies start time of schedule in ISO 8601 format, but without a UTC offset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  startTime?: string | null;

  /**
   * Specifies time zone in which the schedule runs.
   * TimeZone should follow Windows time zone format. Refer: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11
   */
  timeZone?: string = "UTC";

  /**
   * [Required]
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  triggerType: TriggerType;
}

/**
 * DTO object representing specification
 */
model FeaturesetSpecification {
  /**
   * Specifies the spec path
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  path?: string | null;
}

/**
 * Request payload for creating a backfill request for a given feature set version
 */
model FeaturesetVersionBackfillRequest {
  /**
   * Specified the data availability status that you want to backfill
   */
  dataAvailabilityStatus?: DataAvailabilityStatus[];

  /**
   * Specifies description
   */
  description?: string;

  /**
   * Specifies description
   */
  displayName?: string;

  /**
   * Specifies the backfill feature window to be materialized
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  featureWindow?: FeatureWindow | null;

  /**
   * Specify the jobId to retry the failed materialization
   */
  jobId?: string;

  /**
   * Specifies the properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  properties?: Record<string | null>;

  /**
   * Specifies the compute resource settings
   */
  resource?: MaterializationComputeResource;

  /**
   * Specifies the spark compute settings
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  sparkConfiguration?: Record<string | null>;

  /**
   * Specifies the tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  tags?: Record<string | null>;
}

/**
 * Specifies the feature window
 */
model FeatureWindow {
  /**
   * Specifies the feature window end time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  featureWindowEnd?: utcDateTime | null;

  /**
   * Specifies the feature window start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  featureWindowStart?: utcDateTime | null;
}

/**
 * Response payload for creating a backfill request for a given feature set version
 */
model FeaturesetVersionBackfillResponse {
  /**
   * List of jobs submitted as part of the backfill request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  jobIds?: string[] | null;
}

/**
 * A paginated list of FeaturestoreEntityContainer entities.
 */
model FeaturestoreEntityContainerResourceArmPaginatedResult
  is Azure.Core.Page<FeaturestoreEntityContainer>;

/**
 * DTO object representing feature entity
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model FeaturestoreEntityContainerProperties extends AssetContainer {
  /**
   * Provisioning state for the featurestore entity container.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;
}

/**
 * A paginated list of FeaturestoreEntityVersion entities.
 */
model FeaturestoreEntityVersionResourceArmPaginatedResult
  is Azure.Core.Page<FeaturestoreEntityVersion>;

/**
 * DTO object representing feature entity version
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model FeaturestoreEntityVersionProperties extends AssetBase {
  /**
   * Specifies index columns
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @OpenAPI.extension("x-ms-identifiers", #[])
  indexColumns?: IndexColumn[] | null;

  /**
   * Provisioning state for the featurestore entity version.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;

  /**
   * Specifies the asset stage
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  stage?: string | null;
}

/**
 * DTO object representing index column
 */
model IndexColumn {
  /**
   * Specifies the column name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  columnName?: string | null;

  /**
   * Specifies the data type
   */
  dataType?: FeatureDataType = FeatureDataType.String;
}

/**
 * A paginated list of InferencePool entities.
 */
model InferencePoolTrackedResourceArmPaginatedResult
  is Azure.Core.Page<InferencePool>;

/**
 * Inference pool configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model InferencePoolProperties extends PropertiesBase {
  /**
   * Provisioning state for the pool.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PoolProvisioningState;

  /**
   * Gets or sets ScaleUnitConfiguration for the inference pool. Used if PoolType=ScaleUnit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  scaleUnitConfiguration?: ScaleUnitConfiguration | null;
}

/**
 * Configuration for ScaleUnit pool.
 */
model ScaleUnitConfiguration {
  /**
   * Gets or sets a value indicating whether PublicEgress is disabled.
   */
  disablePublicEgress?: boolean = false;

  /**
   * Gets or sets a list of Registry sources that will be used to confirm identity, storage, ACR.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  registries?: string[] | null;
}

/**
 * Base definition for pool resources.
 */
model PropertiesBase {
  /**
   * Description of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  description?: string | null;

  /**
   * Property dictionary. Properties can be added, but not removed or altered.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Property intentionally duplicated for API compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  properties?: StringStringKeyValuePair[] | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model StringStringKeyValuePair {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  key?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  value?: string;
}

/**
 * Strictly used in update requests.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model PartialMinimalTrackedResourceWithSkuAndIdentity
  extends PartialMinimalTrackedResource {
  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: PartialManagedServiceIdentity;

  /**
   * Sku details required for ARM contract for Autoscaling.
   */
  sku?: PartialSku;
}

/**
 * Common SKU definition.
 */
model PartialSku {
  /**
   * If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
   */
  capacity?: int32;

  /**
   * If the service has different generations of hardware, for the same SKU, then that can be captured here.
   */
  family?: string;

  /**
   * The name of the SKU. Ex - P3. It is typically a letter+number code.
   */
  name?: string;

  /**
   * The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.
   */
  size?: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: Azure.ResourceManager.CommonTypes.SkuTier;
}

/**
 * A paginated list of InferenceEndpoint entities.
 */
model InferenceEndpointTrackedResourceArmPaginatedResult
  is Azure.Core.Page<InferenceEndpoint>;

/**
 * InferenceEndpoint configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model InferenceEndpointProperties extends PropertiesBase {
  /**
   * [Required] Authentication mode for the endpoint.
   */
  authMode: AuthMode;

  /**
   * Endpoint URI for the inference endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  endpointUri?: url | null;

  /**
   * [Required] Group within the same pool with which this endpoint needs to be associated with.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  groupName: string;

  /**
   * Provisioning state for the endpoint.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PoolProvisioningState;

  /**
   * RequestConfiguration for endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  requestConfiguration?: RequestConfiguration | null;
}

/**
 * Scoring requests configuration.
 */
model RequestConfiguration {
  /**
   * The number of maximum concurrent requests per node allowed per deployment. Defaults to 1.
   */
  maxConcurrentRequestsPerInstance?: int32 = 1;

  /**
   * The scoring timeout in ISO 8601 format.
   * Defaults to 5000ms.
   */
  requestTimeout?: duration = duration.fromISO("PT5S");
}

/**
 * A paginated list of InferenceGroup entities.
 */
model InferenceGroupTrackedResourceArmPaginatedResult
  is Azure.Core.Page<InferenceGroup>;

/**
 * Inference group configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model InferenceGroupProperties extends PropertiesBase {
  /**
   * Gets or sets environment configuration for the inference group. Used if PoolType=ScaleUnit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  environmentConfiguration?: GroupEnvironmentConfiguration | null;

  /**
   * Gets or sets model configuration for the inference group. Used if PoolType=ScaleUnit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelConfiguration?: GroupModelConfiguration | null;

  /**
   * Gets or sets compute instance type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  nodeSkuType?: string | null;

  /**
   * Provisioning state for the inference group.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PoolProvisioningState;

  /**
   * Gets or sets Scale Unit size.
   */
  scaleUnitSize?: int32;
}

/**
 * Environment configuration options.
 */
model GroupEnvironmentConfiguration {
  /**
   * ARM resource ID of the environment specification for the inference pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  environmentId?: string | null;

  /**
   * Environment variables configuration for the inference pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  environmentVariables?: StringStringKeyValuePair[] | null;

  /**
   * Liveness probe monitors the health of the container regularly.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  livenessProbe?: ProbeSettings | null;

  /**
   * Readiness probe validates if the container is ready to serve traffic. The properties and defaults are the same as liveness probe.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  readinessProbe?: ProbeSettings | null;

  /**
   * This verifies whether the application within a container is started. Startup probes run before any other probe, and, unless it finishes successfully, disables other probes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  startupProbe?: ProbeSettings | null;
}

/**
 * Deployment container liveness/readiness probe configuration.
 */
model ProbeSettings {
  /**
   * The number of failures to allow before returning an unhealthy status.
   */
  failureThreshold?: int32 = 30;

  /**
   * The delay before the first probe in ISO 8601 format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  initialDelay?: duration | null;

  /**
   * The length of time between probes in ISO 8601 format.
   */
  period?: duration = duration.fromISO("PT10S");

  /**
   * The number of successful probes before returning a healthy status.
   */
  successThreshold?: int32 = 1;

  /**
   * The probe timeout in ISO 8601 format.
   */
  timeout?: duration = duration.fromISO("PT2S");
}

/**
 * Model configuration options.
 */
model GroupModelConfiguration {
  /**
   * The URI path to the model.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelId?: string | null;
}

/**
 * Strictly used in update requests.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Existing API uses custom patch envelope"
model PartialMinimalTrackedResourceWithSku
  extends PartialMinimalTrackedResource {
  /**
   * Sku details required for ARM contract for Autoscaling.
   */
  sku?: PartialSku;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DeltaModelStatusRequest {
  /**
   * Gets or sets collection of delta models to retrieve status for.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  deltaModels?: string[] | null;

  /**
   * Gets or sets target base model.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  targetBaseModel?: string | null;
}

/**
 * Contract returning to user the delta models.
 */
model DeltaModelStatusResponse {
  /**
   * Gets or sets actual instance count.
   */
  actualInstanceCount?: int32 = 0;

  /**
   * Gets or sets dictionary representing modelID and its current state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  deltaModels?: Record<DeltaModelCurrentState[] | null> | null;

  /**
   * Gets or sets expected instance count.
   */
  expectedInstanceCount?: int32 = 0;

  /**
   * Gets or sets revision ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  revisionId?: string | null;

  /**
   * Gets or sets target base model.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  targetBaseModel?: string | null;
}

/**
 * Contract for DeltaModelCurrentState.
 */
model DeltaModelCurrentState {
  /**
   * Gets or sets Count of instances with model.
   */
  count?: int32 = 0;

  /**
   * Gets or sets sample of instances with model.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  sampleInstanceID?: string | null;

  /**
   * Gets or sets status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  status?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DeltaModelListRequest {
  /**
   * Gets or sets number of delta models to return. Default: -1, means that all will be returned.
   */
  count?: int32 = -1;

  /**
   * Gets or sets skip token for paginated response.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  skipToken?: string | null;

  /**
   * Gets or sets target base model.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  targetBaseModel?: string | null;
}

/**
 * A paginated list of String entities.
 */
model StringArmPaginatedResult {
  /**
   * The Stringforlist items on this page
   */
  @pageItems
  value: string[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: url;
}

/**
 * Contract base for DeltaModelChangeRequest. Used for adding or removing.
 */
model DeltaModelModifyRequest {
  /**
   * Gets or sets delta models to remove.
   */
  #suppress "@azure-tools/typespec-azure-core/unique-items-invalid-type" "Array contains unique string items"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @uniqueItems
  addDeltaModels?: string[] | null;

  /**
   * Gets or sets delta models to remove.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/unique-items-invalid-type" "Array contains unique string items"
  @uniqueItems
  removeDeltaModels?: string[] | null;

  /**
   * Gets or sets target base model.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  targetBaseModel?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model GroupStatus {
  /**
   * Gets or sets the actual capacity info for the group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  actualCapacityInfo?: ActualCapacityInfo | null;

  /**
   * Gets or sets the actual number of endpoints in the group.
   */
  endpointCount?: int32 = 0;

  /**
   * Gets or sets the request number of instances for the group.
   */
  requestedCapacity?: int32 = 0;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ActualCapacityInfo {
  /**
   * Gets or sets the total number of instances (scale units) regardless of provisioning state or whether current group payload version matches the target group payload.
   */
  total?: int32 = 0;

  /**
   * Gets or sets the number of instances (scale units) which have Succeeded provisioning state and target group payload.
   */
  succeeded?: int32 = 0;

  /**
   * Gets or sets the number of instances (scale units) which have Failed provisioning state and have target group payload.
   */
  failed?: int32 = 0;

  /**
   * Gets or sets the number of instances (scale units) which have Succeeded provisioning state but do not have target group payload.
   */
  outdatedSucceeded?: int32 = 0;

  /**
   * Gets or sets the number of instances (scale units) which have Failed provisioning state but do not have target group payload.
   */
  outdatedFailed?: int32 = 0;
}

/**
 * A paginated list of SkuResource entities.
 */
model SkuResourceArmPaginatedResult is Azure.Core.Page<SkuResource>;

/**
 * Fulfills ARM Contract requirement to list all available SKUS for a resource.
 */
model SkuResource {
  /**
   * Gets or sets the Sku Capacity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  capacity?: SkuCapacity | null;

  /**
   * The resource type name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  resourceType?: string | null;

  /**
   * Gets or sets the Sku.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  sku?: SkuSetting | null;
}

/**
 * SKU capacity information
 */
model SkuCapacity {
  /**
   * Gets or sets the default capacity.
   */
  default?: int32 = 0;

  /**
   * Gets or sets the maximum.
   */
  maximum?: int32 = 0;

  /**
   * Gets or sets the minimum.
   */
  minimum?: int32 = 0;

  /**
   * Node scaling setting for the compute sku.
   */
  scaleType?: SkuScaleType = SkuScaleType.Automatic;
}

/**
 * SkuSetting fulfills the need for stripped down SKU info in ARM contract.
 */
model SkuSetting {
  /**
   * [Required] The name of the SKU. Ex - P3. It is typically a letter+number code.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  name: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: Azure.ResourceManager.CommonTypes.SkuTier = Azure.ResourceManager.CommonTypes.SkuTier.Basic;
}

/**
 * A paginated list of JobBase entities.
 */
model JobBaseResourceArmPaginatedResult is Azure.Core.Page<JobBase>;

/**
 * Base definition for a job.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
@discriminator("jobType")
model JobBaseProperties extends ResourceBase {
  /**
   * ARM resource ID of the component resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  componentId?: string | null;

  /**
   * ARM resource ID of the compute resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  computeId?: string | null;

  /**
   * Display name of job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  displayName?: string | null;

  /**
   * The name of the experiment the job belongs to. If not set, the job is placed in the "Default" experiment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  experimentName?: string = "Default";

  /**
   * Identity configuration. If set, this should be one of AmlToken, ManagedIdentity, UserIdentity or null.
   * Defaults to AmlToken if null.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identity?: IdentityConfiguration | null;

  /**
   * Is the asset archived?
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isArchived?: boolean = false;

  /**
   * [Required] Specifies the type of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobType: JobType;

  /**
   * Notification setting for the job
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  notificationSetting?: NotificationSetting | null;

  /**
   * Parent job name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @removed(Versions.v2025_12_01)
  parentJobName?: string | null;

  /**
   * List of JobEndpoints.
   * For local jobs, a job endpoint will have an endpoint value of FileStreamObject.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  services?: Record<JobService | null> | null;

  /**
   * Status of the job.
   */
  @visibility(Lifecycle.Read)
  status?: JobStatus;
}

/**
 * Base definition for identity configuration.
 */
@discriminator("identityType")
model IdentityConfiguration {
  /**
   * [Required] Specifies the type of identity framework.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identityType: IdentityConfigurationType;
}

/**
 * Job endpoint definition
 */
model JobService {
  /**
   * Url for endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string | null;

  /**
   * Any error in the service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  errorMessage?: string | null;

  /**
   * Endpoint type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobServiceType?: string | null;

  /**
   * Nodes that user would like to start the service on.
   * If Nodes is not set or set to null, the service will only be started on leader node.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  nodes?: Nodes | null;

  /**
   * Port for endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  port?: int32 | null;

  /**
   * Additional properties to set on the endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  properties?: Record<string | null> | null;

  /**
   * Status of endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  status?: string | null;
}

/**
 * Abstract Nodes definition
 */
@discriminator("nodesValueType")
model Nodes {
  /**
   * [Required] Type of the Nodes value
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  nodesValueType: NodesValueType;
}

/**
 * A paginated list of MarketplaceSubscription entities.
 */
model MarketplaceSubscriptionResourceArmPaginatedResult
  is Azure.Core.Page<MarketplaceSubscription>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model MarketplaceSubscriptionProperties {
  /**
   * Marketplace Plan associated with the Marketplace Subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  marketplacePlan?: MarketplacePlan | null;

  /**
   * Current status of the Marketplace Subscription.
   */
  @visibility(Lifecycle.Read)
  marketplaceSubscriptionStatus?: MarketplaceSubscriptionStatus;

  /**
   * [Required] Target Marketplace Model ID to create a Marketplace Subscription for.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  modelId: string;

  /**
   * Provisioning State of the Marketplace Subscription.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: MarketplaceSubscriptionProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model MarketplacePlan {
  /**
   * The identifying name of the Offer of the Marketplace Plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  offerId?: string | null;

  /**
   * The identifying name of the Plan of the Marketplace Plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  planId?: string | null;

  /**
   * The identifying name of the Publisher of the Marketplace Plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  publisherId?: string | null;
}

/**
 * A paginated list of OnlineEndpoint entities.
 */
model OnlineEndpointTrackedResourceArmPaginatedResult
  is Azure.Core.Page<OnlineEndpoint>;

/**
 * Online endpoint configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model OnlineEndpointProperties extends EndpointPropertiesBase {
  /**
   * ARM resource ID of the compute if it exists.
   * optional
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  compute?: string | null;

  /**
   * Percentage of traffic to be mirrored to each deployment without using returned scoring. Traffic values need to sum to utmost 50.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  mirrorTraffic?: Record<int32> | null;

  /**
   * Provisioning state for the endpoint.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EndpointProvisioningState;

  /**
   * Enum to determine whether PublicNetworkAccess is Enabled or Disabled.
   */
  publicNetworkAccess?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * Percentage of traffic from endpoint to divert to each deployment. Traffic values need to sum to 100.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  traffic?: Record<int32> | null;
}

/**
 * A paginated list of OnlineDeployment entities.
 */
model OnlineDeploymentTrackedResourceArmPaginatedResult
  is Azure.Core.Page<OnlineDeployment>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("endpointComputeType")
model OnlineDeploymentProperties extends EndpointDeploymentPropertiesBase {
  /**
   * If true, enables Application Insights logging.
   */
  appInsightsEnabled?: boolean = false;

  /**
   * The mdc configuration, we disable mdc when it's null.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  dataCollector?: DataCollector | null;

  /**
   * Enum to determine whether PublicNetworkAccess is Enabled or Disabled for egress of a deployment.
   */
  egressPublicNetworkAccess?: EgressPublicNetworkAccessType = EgressPublicNetworkAccessType.Enabled;

  /**
   * [Required] The compute type of the endpoint.
   */
  endpointComputeType: EndpointComputeType;

  /**
   * Compute instance type. Default: Standard_F4s_v2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  instanceType?: string | null = "Standard_F4s_v2";

  /**
   * Liveness probe monitors the health of the container regularly.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  livenessProbe?: ProbeSettings | null;

  /**
   * The URI path to the model.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  `model`?: string | null;

  /**
   * The path to mount the model in custom container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelMountPath?: string | null;

  /**
   * Provisioning state for the endpoint deployment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DeploymentProvisioningState;

  /**
   * Readiness probe validates if the container is ready to serve traffic. The properties and defaults are the same as liveness probe.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  readinessProbe?: ProbeSettings | null;

  /**
   * Request settings for the deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  requestSettings?: OnlineRequestSettings | null;

  /**
   * Scale settings for the deployment.
   * If it is null or not provided,
   * it defaults to TargetUtilizationScaleSettings for KubernetesOnlineDeployment
   * and to DefaultScaleSettings for ManagedOnlineDeployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  scaleSettings?: OnlineScaleSettings | null;

  /**
   * Startup probe verify whether an application within a container has started successfully.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  startupProbe?: ProbeSettings | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DataCollector {
  /**
   * [Required] The collection configuration. Each collection has it own configuration to collect model data and the name of collection can be arbitrary string.
   * Model data collector can be used for either payload logging or custom logging or both of them. Collection request and response are reserved for payload logging, others are for custom logging.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  collections: Record<Collection | null>;

  /**
   * The request logging configuration for mdc, it includes advanced logging settings for all collections. It's optional.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  requestLogging?: RequestLogging | null;

  /**
   * When model data is collected to blob storage, we need to roll the data to different path to avoid logging all of them in a single blob file.
   * If the rolling rate is hour, all data will be collected in the blob path /yyyy/MM/dd/HH/.
   * If it's day, all data will be collected in blob path /yyyy/MM/dd/.
   * The other benefit of rolling path is that model monitoring ui is able to select a time range of data very quickly.
   */
  rollingRate?: RollingRateType = RollingRateType.Hour;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model Collection {
  /**
   * The msi client id used to collect logging to blob storage. If it's null,backend will pick a registered endpoint identity to auth.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  clientId?: string | null;

  /**
   * Enable or disable data collection.
   */
  dataCollectionMode?: DataCollectionMode = DataCollectionMode.Disabled;

  /**
   * The data asset arm resource id. Client side will ensure data asset is pointing to the blob storage, and backend will collect data to the blob storage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  dataId?: string | null;

  /**
   * The sampling rate for collection. Sampling rate 1.0 means we collect 100% of data by default.
   */
  samplingRate?: float64 = 1;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model RequestLogging {
  /**
   * For payload logging, we only collect payload by default. If customers also want to collect the specified headers, they can set them in captureHeaders so that backend will collect those headers along with payload.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  captureHeaders?: string[] | null;
}

/**
 * Online deployment scoring requests configuration.
 */
model OnlineRequestSettings {
  /**
   * The number of maximum concurrent requests per node allowed per deployment. Defaults to 1.
   */
  maxConcurrentRequestsPerInstance?: int32 = 1;

  /**
   * (Deprecated for Managed Online Endpoints) The maximum amount of time a request will stay in the queue in ISO 8601 format.
   * Defaults to 500ms.
   * (Now increase `request_timeout_ms` to account for any networking/queue delays)
   */
  maxQueueWait?: duration = duration.fromISO("PT0.5S");

  /**
   * The scoring timeout in ISO 8601 format.
   * Defaults to 5000ms.
   */
  requestTimeout?: duration = duration.fromISO("PT5S");
}

/**
 * Online deployment scaling configuration.
 */
@discriminator("scaleType")
model OnlineScaleSettings {
  /**
   * [Required] Type of deployment scaling algorithm
   */
  scaleType: ScaleType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DeploymentLogsRequest {
  /**
   * The type of container to retrieve logs from.
   */
  containerType?: ContainerType = ContainerType.InferenceServer;

  /**
   * The maximum number of lines to tail.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tail?: int32 | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DeploymentLogs {
  /**
   * The retrieved online deployment logs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  content?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model RegenerateEndpointKeysRequest {
  /**
   * [Required] Specification for which type of key to generate. Primary or Secondary.
   */
  keyType: KeyType;

  /**
   * The value the key is set to.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  keyValue?: string | null;
}

/**
 * Service Token
 */
model EndpointAuthToken {
  /**
   * Access token for endpoint authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @secret
  accessToken?: string | null;

  /**
   * Access token expiry time (UTC).
   */
  expiryTimeUtc?: int64 = 0;

  /**
   * Refresh access token after time (UTC).
   */
  refreshAfterTimeUtc?: int64 = 0;

  /**
   * Access token type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tokenType?: string | null;
}

/**
 * A paginated list of Schedule entities.
 */
model ScheduleResourceArmPaginatedResult is Azure.Core.Page<Schedule>;

/**
 * Base definition of a schedule
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model ScheduleProperties extends ResourceBase {
  /**
   * [Required] Specifies the action of the schedule
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  action: ScheduleActionBase;

  /**
   * Display name of schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  displayName?: string | null;

  /**
   * Is the schedule enabled?
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isEnabled?: boolean = true;

  /**
   * Provisioning state for the schedule.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ScheduleProvisioningStatus;

  /**
   * [Required] Specifies the trigger details
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  trigger: TriggerBase;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("actionType")
model ScheduleActionBase {
  /**
   * [Required] Specifies the action type of the schedule
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  actionType: ScheduleActionType;
}

/**
 * A paginated list of ServerlessEndpoint entities.
 */
model ServerlessEndpointTrackedResourceArmPaginatedResult
  is Azure.Core.Page<ServerlessEndpoint>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ServerlessEndpointProperties {
  /**
   * [Required] Specifies the authentication mode for the Serverless endpoint.
   */
  authMode: ServerlessInferenceEndpointAuthMode;

  /**
   * Specifies the content safety options. If omitted, the default content safety settings will be configured
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  contentSafety?: ContentSafety | null;

  /**
   * The current state of the ServerlessEndpoint.
   */
  @visibility(Lifecycle.Read)
  endpointState?: ServerlessEndpointState;

  /**
   * The inference uri to target when making requests against the serverless endpoint
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  inferenceEndpoint?: ServerlessInferenceEndpoint | null;

  /**
   * The MarketplaceSubscription Azure ID associated to this ServerlessEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  marketplaceSubscriptionId?: string | null;

  /**
   * The model settings (model id) for the model being serviced on the ServerlessEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelSettings?: ModelSettings | null;

  /**
   * State of endpoint provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EndpointProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ContentSafety {
  /**
   * Specifies the current safety level for content safety.
   */
  @removed(Versions.v2025_12_01)
  contentSafetyLevel?: ContentSafetyLevel = ContentSafetyLevel.Blocking;

  /**
   * [Required] Specifies the status of content safety.
   */
  contentSafetyStatus: ContentSafetyStatus;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ServerlessInferenceEndpoint {
  /**
   * Specifies any required headers to target this serverless endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read)
  headers?: Record<string | null> | null;

  /**
   * [Required] The inference uri to target when making requests against the Serverless Endpoint.
   */
  @visibility(Lifecycle.Read)
  uri: url;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ModelSettings {
  /**
   * The unique model identifier that this ServerlessEndpoint should provision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelId?: string | null;
}

/**
 * A paginated list of Registry entities.
 */
model RegistryTrackedResourceArmPaginatedResult is Azure.Core.Page<Registry>;

/**
 * Details of the Registry
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
model RegistryProperties {
  /**
   * Discovery URL for the Registry
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  discoveryUrl?: string | null;

  /**
   * IntellectualPropertyPublisher for the registry
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  intellectualPropertyPublisher?: string | null;

  /**
   * ResourceId of the managed RG if the registry has system created resources
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  managedResourceGroup?: ArmResourceId | null;

  /**
   * Managed resource group specific settings
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  managedResourceGroupSettings?: ManagedResourceGroupSettings | null;

  /**
   * MLFlow Registry URI for the Registry
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  mlFlowRegistryUri?: string | null;

  /**
   * Private endpoint connections info used for pending connections in private link portal
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  registryPrivateEndpointConnections?: RegistryPrivateEndpointConnection[] | null;

  /**
   * Is the Registry accessible from the internet?
   * Possible values: "Enabled" or "Disabled"
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  publicNetworkAccess?: string | null;

  /**
   * Details of each region the registry is in
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @OpenAPI.extension("x-ms-identifiers", #[])
  regionDetails?: RegistryRegionArmDetails[] | null;
}

/**
 * ARM ResourceId of a resource
 */
model ArmResourceId {
  /**
   * Arm ResourceId is in the format "/subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Storage/storageAccounts/{StorageAccountName}"
   * or "/subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{AcrName}"
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  resourceId?: string | null;
}

/**
 * Managed resource group settings
 */
model ManagedResourceGroupSettings {
  /**
   * List of assigned identities for the managed resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @OpenAPI.extension("x-ms-identifiers", #[])
  assignedIdentities?: ManagedResourceGroupAssignedIdentities[] | null;
}

/**
 * Details for managed resource group assigned identities.
 */
model ManagedResourceGroupAssignedIdentities {
  /**
   * Identity principal Id
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Format not applicable for this property"
  principalId?: Azure.Core.uuid;
}

/**
 * Private endpoint connection definition.
 */
model RegistryPrivateEndpointConnection {
  /**
   * This is the private endpoint connection name created on SRP
   * Full resource id: /subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.MachineLearningServices/{resourceType}/{resourceName}/registryPrivateEndpointConnections/{peConnectionName}
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  id?: string | null;

  /**
   * Same as workspace location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string | null;

  /**
   * Properties of the Private Endpoint Connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  properties?: RegistryPrivateEndpointConnectionProperties | null;
}

/**
 * Properties of the Private Endpoint Connection
 */
model RegistryPrivateEndpointConnectionProperties {
  /**
   * The group ids
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  groupIds?: string[] | null;

  /**
   * The PE network resource that is linked to this PE connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  privateEndpoint?: PrivateEndpointResource | null;

  /**
   * The connection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  registryPrivateLinkServiceConnectionState?: RegistryPrivateLinkServiceConnectionState | null;

  /**
   * One of null, "Succeeded", "Provisioning", "Failed". While not approved, it's null.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  provisioningState?: string | null;
}

/**
 * The PE network resource that is linked to this PE connection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model PrivateEndpointResource
  extends Azure.ResourceManager.CommonTypes.PrivateEndpoint {
  /**
   * The subnetId that the private endpoint is connected to.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  subnetArmId?: string | null;
}

/**
 * The connection state.
 */
model RegistryPrivateLinkServiceConnectionState {
  /**
   * Some RP chose "None". Other RPs use this for region expansion.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  actionsRequired?: string | null;

  /**
   * User-defined message that, per NRP doc, may be used for approval-related message.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  description?: string | null;

  /**
   * Connection status of the service consumer with the service provider
   */
  status?: EndpointServiceConnectionStatus;
}

/**
 * Details for each region the registry is in
 */
model RegistryRegionArmDetails {
  /**
   * List of ACR accounts
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @OpenAPI.extension("x-ms-identifiers", #[])
  acrDetails?: AcrDetails[] | null;

  /**
   * The location where the registry exists
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  location?: string | null;

  /**
   * List of storage accounts
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @OpenAPI.extension("x-ms-identifiers", #[])
  storageAccountDetails?: StorageAccountDetails[] | null;
}

/**
 * Details of ACR account to be used for the Registry
 */
model AcrDetails {
  /**
   * Details of system created ACR account to be used for the Registry
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  systemCreatedAcrAccount?: SystemCreatedAcrAccount | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model SystemCreatedAcrAccount {
  /**
   * Name of the ACR account
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  acrAccountName?: string | null;

  /**
   * SKU of the ACR account
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  acrAccountSku?: string | null;

  /**
   * This is populated once the ACR account is created.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  armResourceId?: ArmResourceId | null;
}

/**
 * Details of storage account to be used for the Registry
 */
model StorageAccountDetails {
  /**
   * Details of system created storage account to be used for the registry
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  systemCreatedStorageAccount?: SystemCreatedStorageAccount | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model SystemCreatedStorageAccount {
  /**
   * Public blob access allowed
   */
  allowBlobPublicAccess?: boolean;

  /**
   * This is populated once the storage account is created.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  armResourceId?: ArmResourceId | null;

  /**
   * HNS enabled for storage account
   */
  storageAccountHnsEnabled?: boolean;

  /**
   * Name of the storage account
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  storageAccountName?: string | null;

  /**
   * Allowed values:
   * "Standard_LRS",
   * "Standard_GRS",
   * "Standard_RAGRS",
   * "Standard_ZRS",
   * "Standard_GZRS",
   * "Standard_RAGZRS",
   * "Premium_LRS",
   * "Premium_ZRS"
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  storageAccountType?: string | null;
}

/**
 * Strictly used in update requests.
 */
model PartialRegistryPartialTrackedResource {
  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: RegistryPartialManagedServiceIdentity;

  /**
   * Sku details required for ARM contract for Autoscaling.
   */
  sku?: PartialSku;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  tags?: Record<string | null>;
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Empty model used as placeholder in API"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model RegistryPartialManagedServiceIdentity
  extends Azure.ResourceManager.CommonTypes.ManagedServiceIdentity {}

/**
 * The List Aml user feature operation response.
 */
model ListAmlUserFeatureResult is Azure.Core.Page<AmlUserFeature>;

/**
 * Features enabled for a workspace
 */
model AmlUserFeature {
  /**
   * Specifies the feature ID
   */
  id?: string;

  /**
   * Specifies the feature name
   */
  displayName?: string;

  /**
   * Describes the feature for user experience
   */
  description?: string;
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * The properties of a machine learning workspace.
 */
model WorkspaceProperties {
  /**
   * The URI of agents endpoint associated with this workspace.
   */
  @removed(Versions.v2025_12_01)
  @visibility(Lifecycle.Read)
  agentsEndpointUri?: url;

  /**
   * The flag to indicate whether to allow public access when behind VNet.
   */
  allowPublicAccessWhenBehindVnet?: boolean;

  /**
   * The flag to indicate whether we will do role assignment for the workspace MSI on resource group level.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  @removed(Versions.v2025_12_01)
  allowRoleAssignmentOnRG?: boolean;

  /**
   * ARM id of the application insights associated with this workspace.
   */
  applicationInsights?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  associatedWorkspaces?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @removed(Versions.v2025_12_01)
  containerRegistries?: string[];

  /**
   * ARM id of the container registry associated with this workspace.
   */
  containerRegistry?: string;

  /**
   * The description of this workspace.
   */
  description?: string;

  /**
   * Url for the discovery service to identify regional endpoints for machine learning experimentation services
   */
  discoveryUrl?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  enableDataIsolation?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  enableServiceSideCMKEncryption?: boolean;

  /**
   * Flag to tell if simplified CMK should be enabled for this workspace.
   */
  @removed(Versions.v2025_12_01)
  enableSimplifiedCmk?: boolean;

  /**
   * Flag to tell if SoftwareBillOfMaterials should be enabled for this workspace.
   */
  @removed(Versions.v2025_12_01)
  enableSoftwareBillOfMaterials?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  encryption?: EncryptionProperty;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @removed(Versions.v2025_12_01)
  existingWorkspaces?: string[];

  /**
   * Settings for feature store type workspace.
   */
  featureStoreSettings?: FeatureStoreSettings;

  /**
   * The friendly name for this workspace. This name in mutable
   */
  friendlyName?: string;

  /**
   * The flag to signal HBI data in the workspace and reduce diagnostic data collected by the service
   */
  hbiWorkspace?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  hubResourceId?: string;

  /**
   * The compute name for image build
   */
  imageBuildCompute?: string;

  /**
   * The list of IPv4  addresses that are allowed to access the workspace.
   */
  @removed(Versions.v2025_12_01)
  ipAllowlist?: string[];

  /**
   * ARM id of the key vault associated with this workspace. This cannot be changed once the workspace has been created
   */
  keyVault?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @removed(Versions.v2025_12_01)
  keyVaults?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  managedNetwork?: ManagedNetworkSettings;

  /**
   * The URI associated with this workspace that machine learning flow must point at to set up tracking.
   */
  @visibility(Lifecycle.Read)
  mlFlowTrackingUri?: string;

  /**
   * A set of rules governing the network accessibility of the workspace.
   */
  @removed(Versions.v2025_12_01)
  networkAcls?: NetworkAcls;

  /**
   * The notebook info of Azure ML workspace.
   */
  @visibility(Lifecycle.Read)
  notebookInfo?: NotebookResourceInfo;

  /**
   * The user assigned identity resource id that represents the workspace identity.
   */
  primaryUserAssignedIdentity?: string;

  /**
   * The list of private endpoint connections in the workspace.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Count of private connections in the workspace
   */
  @visibility(Lifecycle.Read)
  privateLinkCount?: int32;

  /**
   * Set to trigger the provisioning of the managed VNet with the default Options when creating a Workspace with the managed VNet enabled, or else it does nothing.
   */
  provisionNetworkNow?: boolean;

  /**
   * The current deployment state of workspace resource. The provisioningState is to indicate states for resource provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Whether requests from Public Network are allowed.
   */
  publicNetworkAccess?: PublicNetworkAccessType;

  /**
   * Settings for serverless compute in a workspace
   */
  serverlessComputeSettings?: ServerlessComputeSettings;

  /**
   * The service managed resource settings.
   */
  serviceManagedResourcesSettings?: ServiceManagedResourcesSettings;

  /**
   * The name of the managed resource group created by workspace RP in customer subscription if the workspace is CMK workspace
   */
  @visibility(Lifecycle.Read)
  serviceProvisionedResourceGroup?: string;

  /**
   * The list of shared private link resources in this workspace.
   */
  @identifiers(#["name"])
  sharedPrivateLinkResources?: SharedPrivateLinkResource[];

  /**
   * Retention time in days after workspace get soft deleted.
   */
  @removed(Versions.v2025_12_01)
  softDeleteRetentionInDays?: int32;

  /**
   * ARM id of the storage account associated with this workspace. This cannot be changed once the workspace has been created
   */
  storageAccount?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @removed(Versions.v2025_12_01)
  storageAccounts?: string[];

  /**
   * If the storage associated with the workspace has hierarchical namespace(HNS) enabled.
   */
  @visibility(Lifecycle.Read)
  storageHnsEnabled?: boolean;

  /**
   * The auth mode used for accessing the system datastores of the workspace.
   */
  systemDatastoresAuthMode?: SystemDatastoresAuthMode;

  /**
   * The tenant id associated with this workspace.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Enabling v1_legacy_mode may prevent you from using features provided by the v2 API.
   */
  v1LegacyMode?: boolean;

  /**
   * WorkspaceHub's configuration object.
   */
  workspaceHubConfig?: WorkspaceHubConfig;

  /**
   * The immutable id associated with this workspace.
   */
  @visibility(Lifecycle.Read)
  workspaceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EncryptionProperty {
  /**
   * The byok cosmosdb account that customer brings to store customer's data
   * with encryption
   */
  cosmosDbResourceId?: string;

  /**
   * Identity to be used with the keyVault
   */
  identity?: IdentityForCmk;

  /**
   * KeyVault details to do the encryption
   */
  keyVaultProperties: KeyVaultProperties;

  /**
   * The byok search account that customer brings to store customer's data
   * with encryption
   */
  searchAccountResourceId?: string;

  /**
   * Indicates whether or not the encryption is enabled for the workspace.
   */
  status: EncryptionStatus;

  /**
   * The byok storage account that customer brings to store customer's data
   * with encryption
   */
  storageAccountResourceId?: string;
}

/**
 * Identity object used for encryption.
 */
model IdentityForCmk {
  /**
   * UserAssignedIdentity to be used to fetch the encryption key from keyVault
   */
  userAssignedIdentity?: string;
}

/**
 * Customer Key vault properties.
 */
model KeyVaultProperties {
  /**
   * Currently, we support only SystemAssigned MSI.
   * We need this when we support UserAssignedIdentities
   */
  identityClientId?: string;

  /**
   * KeyVault key identifier to encrypt the data
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  keyIdentifier: string;

  /**
   * KeyVault Arm Id that contains the data encryption key
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  keyVaultArmId: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model FeatureStoreSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  computeRuntime?: ComputeRuntimeDto;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  offlineStoreConnectionName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  onlineStoreConnectionName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ComputeRuntimeDto {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  sparkRuntimeVersion?: string;
}

/**
 * Managed Network settings for a machine learning workspace.
 */
model ManagedNetworkSettings {
  /**
   * A flag to indicate if monitoring needs to be enabled for the managed network.
   */
  enableNetworkMonitor?: boolean = false;

  /**
   * Isolation mode for the managed network of a machine learning workspace.
   */
  isolationMode?: IsolationMode;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  networkId?: string;

  /**
   * Dictionary of <OutboundRule>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  outboundRules?: Record<OutboundRule> | null;

  /**
   * Status of the Provisioning for the managed network of a machine learning workspace.
   */
  status?: ManagedNetworkProvisionStatus;

  /**
   * Firewall Sku used for FQDN Rules
   */
  firewallSku?: FirewallSku;

  /**
   * The Kind of the managed network. Users can switch from V1 to V2 for granular access controls, but cannot switch back to V1 once V2 is enabled.
   */
  managedNetworkKind?: ManagedNetworkKind;

  /**
   * Public IP address assigned to the Azure Firewall.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  firewallPublicIpAddress?: string | null;
}

/**
 * Outbound Rule for the managed network of a machine learning workspace.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
@discriminator("type")
model OutboundRule {
  /**
   * Category of a managed network Outbound Rule of a machine learning workspace.
   */
  category?: RuleCategory;

  /**
   * Type of a managed network Outbound Rule of a machine learning workspace.
   */
  status?: RuleStatus;

  /**
   * Type of a managed network Outbound Rule of a machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Property intentionally duplicated for API compatibility"
  type: RuleType;

  /**
   * Error information about an outbound rule of a machine learning workspace if RuleStatus is failed.
   */
  @visibility(Lifecycle.Read)
  errorInformation?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  parentRuleNames?: string[];
}

/**
 * Status of the Provisioning for the managed network of a machine learning workspace.
 */
model ManagedNetworkProvisionStatus {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  sparkReady?: boolean;

  /**
   * Status for the managed network of a machine learning workspace.
   */
  status?: ManagedNetworkStatus;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model NetworkAcls {
  /**
   * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
   */
  defaultAction?: DefaultActionType;

  /**
   * Rules governing the accessibility of a resource from a specific ip address or ip range.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Array items do not have stable identifiers"
  ipRules?: IPRule[];
}

/**
 * Contains an IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78). Value could be 'Allow' or  'Deny'.
 */
model IPRule {
  /**
   * An IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78). Value could be 'Allow' or  'Deny'.
   */
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model NotebookResourceInfo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  fqdn?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  isPrivateLinkEnabled?: boolean;

  /**
   * The error that occurs when preparing notebook.
   */
  notebookPreparationError?: NotebookPreparationError;

  /**
   * the data plane resourceId that used to initialize notebook component
   */
  resourceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model NotebookPreparationError {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  errorMessage?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  statusCode?: int32;
}

/**
 * Private endpoint connection properties.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model PrivateEndpointConnectionProperties {
  privateEndpoint?: WorkspacePrivateEndpointResource;

  /**
   * The connection state.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /**
   * The current provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model WorkspacePrivateEndpointResource {
  /**
   * e.g. /subscriptions/{networkSubscriptionId}/resourceGroups/{rgName}/providers/Microsoft.Network/privateEndpoints/{privateEndpointName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The subnetId that the private endpoint is connected to.
   */
  @visibility(Lifecycle.Read)
  subnetArmId?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Some RP chose "None". Other RPs use this for region expansion.
   */
  actionsRequired?: string;

  /**
   * User-defined message that, per NRP doc, may be used for approval-related message.
   */
  description?: string;

  /**
   * Connection status of the service consumer with the service provider\r\nPossible state transitions\r\nPending -> Approved (Service provider approves the connection request)\r\nPending -> Rejected (Service provider rejects the connection request)\r\nPending -> Disconnected (Service provider deletes the connection)\r\nApproved -> Rejected (Service provider rejects the approved connection)\r\nApproved -> Disconnected (Service provider deletes the connection)\r\nRejected -> Pending (Service consumer re-initiates the connection request that was rejected)\r\nRejected -> Disconnected (Service provider deletes the connection)
   */
  status?: EndpointServiceConnectionStatus;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ServerlessComputeSettings {
  /**
   * The resource ID of an existing virtual network subnet in which serverless compute nodes should be deployed
   */
  serverlessComputeCustomSubnet?: Azure.Core.armResourceIdentifier;

  /**
   * The flag to signal if serverless compute nodes deployed in custom vNet would have no public IP addresses for a workspace with private endpoint
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  serverlessComputeNoPublicIP?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ServiceManagedResourcesSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  cosmosDb?: CosmosDbSettings;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CosmosDbSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  collectionsThroughput?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model SharedPrivateLinkResource {
  /**
   * Unique name of the private link
   */
  name?: string;

  /**
   * Properties of a shared private link resource.
   */
  properties?: SharedPrivateLinkResourceProperty;
}

/**
 * Properties of a shared private link resource.
 */
model SharedPrivateLinkResourceProperty {
  /**
   * group id of the private link
   */
  groupId?: string;

  /**
   * the resource id that private link links to
   */
  privateLinkResourceId?: string;

  /**
   * Request message
   */
  requestMessage?: string;

  /**
   * Connection status of the service consumer with the service provider\r\nPossible state transitions\r\nPending -> Approved (Service provider approves the connection request)\r\nPending -> Rejected (Service provider rejects the connection request)\r\nPending -> Disconnected (Service provider deletes the connection)\r\nApproved -> Rejected (Service provider rejects the approved connection)\r\nApproved -> Disconnected (Service provider deletes the connection)\r\nRejected -> Pending (Service consumer re-initiates the connection request that was rejected)\r\nRejected -> Disconnected (Service provider deletes the connection)
   */
  status?: EndpointServiceConnectionStatus;
}

/**
 * WorkspaceHub's configuration object.
 */
model WorkspaceHubConfig {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  additionalWorkspaceStorageAccounts?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  defaultWorkspaceResourceGroup?: string;
}

/**
 * The parameters for updating a machine learning workspace.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model WorkspaceUpdateParameters {
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * The properties that the machine learning workspace will be updated with.
   */
  properties?: WorkspacePropertiesUpdateParameters;

  /**
   * Optional. This field is required to be implemented by the RP because AML is supporting more than one tier
   */
  sku?: Azure.ResourceManager.CommonTypes.Sku;

  /**
   * The resource tags for the machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  tags?: Record<string>;
}

/**
 * The parameters for updating a machine learning workspace.
 */
model WorkspacePropertiesUpdateParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  @removed(Versions.v2025_12_01)
  allowRoleAssignmentOnRG?: boolean;

  /**
   * ARM id of the application insights associated with this workspace.
   */
  applicationInsights?: string;

  /**
   * ARM id of the container registry associated with this workspace.
   */
  containerRegistry?: string;

  /**
   * The description of this workspace.
   */
  description?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  enableDataIsolation?: boolean;

  /**
   * Flag to tell if SoftwareBillOfMaterials should be enabled for this workspace
   */
  @removed(Versions.v2025_12_01)
  enableSoftwareBillOfMaterials?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  encryption?: EncryptionUpdateProperties;

  /**
   * Settings for feature store type workspace.
   */
  featureStoreSettings?: FeatureStoreSettings;

  /**
   * The friendly name for this workspace. This name in mutable
   */
  friendlyName?: string;

  /**
   * The compute name for image build
   */
  imageBuildCompute?: string;

  /**
   * The list of IPv4 addresses that are allowed to access the workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @removed(Versions.v2025_12_01)
  ipAllowlist?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  managedNetwork?: ManagedNetworkSettings;

  /**
   * A set of rules governing the network accessibility of the workspace.
   */
  @removed(Versions.v2025_12_01)
  networkAcls?: NetworkAcls;

  /**
   * The user assigned identity resource id that represents the workspace identity.
   */
  primaryUserAssignedIdentity?: string;

  /**
   * Whether requests from Public Network are allowed.
   */
  publicNetworkAccess?: PublicNetworkAccessType;

  /**
   * Settings for serverless compute in a workspace
   */
  serverlessComputeSettings?: ServerlessComputeSettings;

  /**
   * The service managed resource settings.
   */
  serviceManagedResourcesSettings?: ServiceManagedResourcesSettings;

  /**
   * Retention time in days after workspace get soft deleted.
   */
  @removed(Versions.v2025_12_01)
  softDeleteRetentionInDays?: int32;

  /**
   * The auth mode used for accessing the system datastores of the workspace.
   */
  systemDatastoresAuthMode?: SystemDatastoresAuthMode;

  /**
   * Enabling v1_legacy_mode may prevent you from using features provided by the v2 API.
   */
  v1LegacyMode?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EncryptionUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  keyVaultProperties: EncryptionKeyVaultUpdateProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EncryptionKeyVaultUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  keyIdentifier: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model WorkspaceConnectionPropertiesV2BasicResourceArmPaginatedResult
  is Azure.Core.Page<WorkspaceConnectionPropertiesV2BasicResource>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("authType")
model WorkspaceConnectionPropertiesV2 {
  /**
   * Authentication type of the connection target
   */
  authType: ConnectionAuthType;

  /**
   * Category of the connection
   */
  category?: ConnectionCategory;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  createdByWorkspaceArmId?: Azure.Core.armResourceIdentifier;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  error?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  expiryTime?: utcDateTime;

  /**
   * Group based on connection category
   */
  @visibility(Lifecycle.Read)
  group?: ConnectionGroup;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  isSharedToAll?: boolean;

  /**
   * Store user metadata for this connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  metadata?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  peRequirement?: ManagedPERequirement;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  peStatus?: ManagedPEStatus;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  sharedUserList?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  target?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  useWorkspaceManagedIdentity?: boolean;
}

/**
 * The properties that the machine learning workspace connection will be updated with.
 */
model WorkspaceConnectionUpdateParameter {
  /**
   * The properties that the machine learning workspace connection will be updated with.
   */
  properties?: WorkspaceConnectionPropertiesV2;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EndpointDeploymentResourcePropertiesBasicResourceArmPaginatedResult
  is Azure.Core.Page<EndpointDeploymentResourcePropertiesBasicResource>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("type")
model EndpointDeploymentResourceProperties {
  /**
   * The failure reason if the creation failed.
   */
  failureReason?: string;

  /**
   * Read-only provision state status property.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DefaultResourceProvisioningState;

  /**
   * Kind of the deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "String discriminator used for polymorphic type"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Property intentionally duplicated for API compatibility"
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  type: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EndpointModels is Azure.Core.Page<EndpointModelProperties>;

/**
 * Endpoint Model properties.
 */
model EndpointModelProperties {
  /**
   * The capabilities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  capabilities?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  deprecation?: EndpointModelDeprecationProperties;

  /**
   * The capabilities for finetune models.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  finetuneCapabilities?: Record<string>;

  /**
   * Deployment model format.
   */
  format?: string;

  /**
   * If the model is default version.
   */
  isDefaultVersion?: boolean;

  /**
   * Model lifecycle status.
   */
  lifecycleStatus?: ModelLifecycleStatus;

  /**
   * The max capacity.
   */
  maxCapacity?: int32;

  /**
   * Deployment model name.
   */
  name?: string;

  /**
   * The list of Model Sku.
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  skus?: EndpointModelSkuProperties[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  systemData?: SystemData;

  /**
   * Optional. Deployment model version. If version is not specified, a default version will be assigned. The default version is different for different models and might change when there is new version available for a model. Default version for a model could be found from list models API.
   */
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EndpointModelDeprecationProperties {
  /**
   * The datetime of deprecation of the fineTune Model.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fineTune?: utcDateTime;

  /**
   * The datetime of deprecation of the inference Model.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  inference?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EndpointModelSkuProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  capacity?: EndpointModelSkuCapacityProperties;

  /**
   * The list of ARM id for the connection support this SKU.
   */
  connectionIds?: Azure.Core.armResourceIdentifier[];

  /**
   * The datetime of deprecation of the model SKU.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deprecationDate?: utcDateTime;

  /**
   * The name of the model SKU.
   */
  name?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Array items do not have stable identifiers"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  rateLimits?: EndpointModelSkuRateLimitProperties[];

  /**
   * The usage name of the model SKU.
   */
  usageName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EndpointModelSkuCapacityProperties {
  /**
   * The default capacity.
   */
  default?: int32;

  /**
   * The maximum capacity.
   */
  maximum?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EndpointModelSkuRateLimitProperties {
  /**
   * The count value of Call Rate Limit.
   */
  count?: float32;

  /**
   * The renewal period in seconds of Call Rate Limit.
   */
  renewalPeriod?: float32;

  /**
   * The call rate limit for the model.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Array items do not have stable identifiers"
  rules?: EndpointModelSkuRateLimitRuleProperties[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EndpointModelSkuRateLimitRuleProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  count?: float32;

  /**
   * If the dynamic throttling is enabled.
   */
  dynamicThrottlingEnabled?: boolean;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Array items do not have stable identifiers"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Array items do not have stable identifiers"
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Secret property is part of existing API contract"
  key?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Array items do not have stable identifiers"
  matchPatterns?: EndpointModelSkuRateLimitRulePatternProperties[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  minCount?: float32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  renewalPeriod?: float32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EndpointModelSkuRateLimitRulePatternProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  method?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  path?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model RaiBlocklistPropertiesBasicResourceArmPaginatedResult
  is Azure.Core.Page<RaiBlocklistPropertiesBasicResource>;

/**
 * RAI Custom Blocklist properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
model RaiBlocklistProperties {
  /**
   * Description of the block list.
   */
  description?: string;
}

/**
 * The list of Cognitive Services RaiBlocklist Items for batch add.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Empty model used as placeholder in API"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
@OpenAPI.extension("x-ms-identifiers", #["name"])
model RaiBlocklistItemsBulkAddRequest is RaiBlocklistItemBulkRequest[];

/**
 * The Cognitive Services RaiBlocklist Item request body.
 */
model RaiBlocklistItemBulkRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  name?: string;

  /**
   * Properties of Cognitive Services RaiBlocklist Item.
   */
  properties?: RaiBlocklistItemProperties;
}

/**
 * RAI Custom Blocklist Item properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
model RaiBlocklistItemProperties {
  /**
   * If the pattern is a regex pattern.
   */
  isRegex?: boolean;

  /**
   * Pattern to match against.
   */
  pattern?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model RaiBlocklistItemPropertiesBasicResourceArmPaginatedResult
  is Azure.Core.Page<RaiBlocklistItemPropertiesBasicResource>;

/**
 * Azure OpenAI Content Filters resource list.
 */
model RaiPolicyPropertiesBasicResourceArmPaginatedResult
  is Azure.Core.Page<RaiPolicyPropertiesBasicResource>;

/**
 * Azure OpenAI Content Filters properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Provisioning state is defined in base properties"
model RaiPolicyProperties {
  /**
   * Name of the base Content Filters.
   */
  basePolicyName?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Array items do not have stable identifiers"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  completionBlocklists?: RaiBlocklistConfig[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  contentFilters?: RaiPolicyContentFilter[];

  /**
   * Content Filters mode.
   */
  mode?: RaiPolicyMode;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Array items do not have stable identifiers"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  promptBlocklists?: RaiBlocklistConfig[];

  /**
   * Content Filters policy type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Property intentionally duplicated for API compatibility"
  type?: RaiPolicyType;
}

/**
 * Azure OpenAI blocklist config.
 */
model RaiBlocklistConfig {
  /**
   * If blocking would occur.
   */
  blocking?: boolean;

  /**
   * Name of ContentFilter.
   */
  blocklistName?: string;
}

/**
 * Azure OpenAI Content Filter.
 */
model RaiPolicyContentFilter {
  /**
   * Level at which content is filtered.
   */
  allowedContentLevel?: AllowedContentLevel;

  /**
   * If blocking would occur.
   */
  blocking?: boolean;

  /**
   * If the ContentFilter is enabled.
   */
  enabled?: boolean;

  /**
   * Name of ContentFilter.
   */
  name?: string;

  /**
   * Content source to apply the Content Filters.
   */
  source?: RaiPolicyContentSource;
}

/**
 * Parameters to diagnose a workspace
 */
model DiagnoseWorkspaceParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  value?: DiagnoseRequestProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DiagnoseRequestProperties {
  /**
   * Setting for diagnosing dependent application insights
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  applicationInsights?: Record<unknown>;

  /**
   * Setting for diagnosing dependent container registry
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  containerRegistry?: Record<unknown>;

  /**
   * Setting for diagnosing dns resolution
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  dnsResolution?: Record<unknown>;

  /**
   * Setting for diagnosing dependent key vault
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  keyVault?: Record<unknown>;

  /**
   * Setting for diagnosing network security group
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  nsg?: Record<unknown>;

  /**
   * Setting for diagnosing unclassified category of problems
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  others?: Record<unknown>;

  /**
   * Setting for diagnosing the presence of required resource providers in the workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  requiredResourceProviders?: Record<unknown>;

  /**
   * Setting for diagnosing resource lock
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  resourceLock?: Record<unknown>;

  /**
   * Setting for diagnosing dependent storage account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  storageAccount?: Record<unknown>;

  /**
   * Setting for diagnosing user defined routing
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  udr?: Record<unknown>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DiagnoseResponseResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  value?: DiagnoseResponseResultValue;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DiagnoseResponseResultValue {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["message"])
  userDefinedRouteResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["message"])
  networkSecurityRuleResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["message"])
  resourceLockResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["message"])
  dnsResolutionResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["message"])
  storageAccountResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["message"])
  keyVaultResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["message"])
  containerRegistryResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["message"])
  applicationInsightsResults?: DiagnoseResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["message"])
  otherResults?: DiagnoseResult[];
}

/**
 * Result of Diagnose
 */
model DiagnoseResult {
  /**
   * Code for workspace setup error
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Level of workspace setup error
   */
  @visibility(Lifecycle.Read)
  level?: DiagnoseResultLevel;

  /**
   * Message of workspace setup error
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EndpointResourcePropertiesBasicResourceArmPaginatedResult
  is Azure.Core.Page<EndpointResourcePropertiesBasicResource>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("endpointType")
model EndpointResourceProperties {
  /**
   * Byo resource id for creating the built-in model service endpoints.
   */
  associatedResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Deployments info.
   */
  @removed(Versions.v2025_12_01)
  deployments?: EndpointDeploymentResourcePropertiesBasicResource[];

  /**
   * Type of the endpoint.
   */
  endpointType: EndpointType;

  /**
   * Uri of the endpoint.
   */
  endpointUri?: url;

  /**
   * The failure reason if the creation failed.
   */
  failureReason?: string;

  /**
   * Location of the endpoint.
   * Since input dto and when parse endpoint resource share the same contract
   * this Location field is just for parse the endpoint resource info
   * we won't let customer specify the endpoint resource location since we will create it the same location as workspace
   */
  location?: string;

  /**
   * Name of the endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Property intentionally duplicated for API compatibility"
  name?: string;

  /**
   * Read-only provision state status property.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DefaultResourceProvisioningState;

  /**
   * Whether the proxy (non-byo) endpoint is a regular endpoint or a OneKeyV2 AI services account endpoint.
   */
  shouldCreateAiServicesEndpoint?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EndpointKeys {
  /**
   * Dictionary of Keys for the endpoint.
   */
  @secret
  keys?: AccountApiKeys;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model AccountApiKeys {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @secret
  key1?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @secret
  key2?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model RegenerateServiceAccountKeyContent {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  keyName?: ServiceAccountKeyName;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ListWorkspaceKeysResult {
  /**
   * The access key of the workspace app insights
   */
  @visibility(Lifecycle.Read)
  @secret
  appInsightsInstrumentationKey?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  containerRegistryCredentials?: RegistryListCredentialsResult;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  notebookAccessKeys?: ListNotebookKeysResult;

  /**
   * The arm Id key of the workspace storage
   */
  @visibility(Lifecycle.Read)
  userStorageArmId?: string;

  /**
   * The access key of the workspace storage
   */
  @visibility(Lifecycle.Read)
  @secret
  userStorageKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model RegistryListCredentialsResult {
  /**
   * The location of the workspace ACR
   */
  @visibility(Lifecycle.Read)
  location?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["name"])
  passwords?: Password[];

  /**
   * The username of the workspace ACR
   */
  @visibility(Lifecycle.Read)
  username?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model Password {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  @secret
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  @secret
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ListNotebookKeysResult {
  /**
   * The primary access key of the Notebook
   */
  @visibility(Lifecycle.Read)
  @secret
  primaryAccessKey?: string;

  /**
   * The secondary access key of the Notebook
   */
  @visibility(Lifecycle.Read)
  @secret
  secondaryAccessKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model NotebookAccessTokenResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  @secret
  accessToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  expiresIn?: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  hostName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  notebookResourceId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  publicDns?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  @secret
  refreshToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  scope?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  tokenType?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ListStorageAccountKeysResult {
  /**
   * The access key of the storage
   */
  @visibility(Lifecycle.Read)
  @secret
  userStorageKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model ExternalFQDNResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["/properties/category"])
  value?: FqdnEndpointsPropertyBag[];
}

/**
 * Property bag for FQDN endpoints result
 */
model FqdnEndpointsPropertyBag {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  properties?: FqdnEndpoints;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model FqdnEndpoints {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  category?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["domainName"])
  endpoints?: FqdnEndpoint[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model FqdnEndpoint {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  domainName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @identifiers(#["port"])
  endpointDetails?: FqdnEndpointDetail[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model FqdnEndpointDetail {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  port?: int32;
}

/**
 * List of private endpoint connection associated with the specified workspace
 */
model PrivateEndpointConnectionListResult {
  /**
   * Array of private endpoint connections
   */
  @pageItems
  value?: PrivateEndpointConnection[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @nextLink
  nextLink?: string;
}

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * A list of private link resources
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @pageItems
  value?: PrivateLinkResource[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @nextLink
  nextLink?: string;
}

/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model PrivateLinkResource extends Azure.ResourceManager.CommonTypes.Resource {
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Same as workspace location.
   */
  location?: string;

  /**
   * Properties of a private link resource.
   */
  properties?: PrivateLinkResourceProperties;

  /**
   * Optional. This field is required to be implemented by the RP because AML is supporting more than one tier
   */
  sku?: Azure.ResourceManager.CommonTypes.Sku;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  tags?: Record<string>;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Managed Network Provisioning options for managed network of a machine learning workspace.
 */
model ManagedNetworkProvisionOptions {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  includeSpark?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ManagedNetworkSettingsBasicResource
  extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Managed Network settings for a machine learning workspace.
   */
  properties?: ManagedNetworkSettings;
}

/**
 * The properties of the managed network settings of a machine learning workspace.
 */
model ManagedNetworkSettingsProperties {
  /**
   * Managed Network settings for a machine learning workspace.
   */
  managedNetwork?: ManagedNetworkSettingsEx;

  /**
   * The current deployment state of the managed network resource. The provisioningState is to indicate states for resource provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ManagedNetworkProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ManagedNetworkSettingsEx extends ManagedNetworkSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  changeableIsolationModes?: IsolationMode[];
}

/**
 * Represents a resource ID. For example, for a subnet, it is the resource URL for the subnet.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model ResourceId {
  /**
   * The ID of the resource
   */
  id: string;
}

/**
 * A Machine Learning compute based on AKS.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model AKS extends Compute {
  ...AKSSchema;

  /**
   * The type of compute
   */
  computeType: "AKS";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model AKSSchema {
  /**
   * AKS properties
   */
  properties?: AKSSchemaProperties;
}

/**
 * AKS properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model AKSSchemaProperties {
  /**
   * Cluster full qualified domain name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  clusterFqdn?: string | null;

  /**
   * System services
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["publicIpAddress"])
  systemServices?: SystemService[] | null;

  /**
   * Number of agents
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @minValue(0)
  agentCount?: int32 | null;

  /**
   * Agent virtual machine size
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  agentVmSize?: string | null;

  /**
   * Intended usage of the cluster
   */
  clusterPurpose?: ClusterPurpose = ClusterPurpose.FastProd;

  /**
   * SSL configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  sslConfiguration?: SslConfiguration | null;

  /**
   * AKS networking configuration for vnet
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  aksNetworkingConfiguration?: AksNetworkingConfiguration | null;

  /**
   * Load Balancer Type
   */
  loadBalancerType?: LoadBalancerType = LoadBalancerType.PublicIp;

  /**
   * Load Balancer Subnet
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  loadBalancerSubnet?: string | null;
}

/**
 * A system service running on a compute.
 */
model SystemService {
  /**
   * The type of this system service.
   */
  @visibility(Lifecycle.Read)
  systemServiceType?: string;

  /**
   * Public IP address
   */
  @visibility(Lifecycle.Read)
  publicIpAddress?: string;

  /**
   * The version for this type.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * The ssl configuration for scoring
 */
model SslConfiguration {
  /**
   * Enable or disable ssl for scoring
   */
  status?: SslConfigStatus;

  /**
   * Cert data
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @secret
  cert?: string | null;

  /**
   * Key data
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @secret
  key?: string | null;

  /**
   * CNAME of the cert
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  cname?: string | null;

  /**
   * Leaf domain label of public endpoint
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  leafDomainLabel?: string | null;

  /**
   * Indicates whether to overwrite existing domain label.
   */
  overwriteExistingDomain?: boolean;
}

/**
 * Advance configuration for AKS networking
 */
model AksNetworkingConfiguration {
  /**
   * Virtual network subnet resource ID the compute nodes belong to
   */
  subnetId?: string;

  /**
   * A CIDR notation IP range from which to assign service cluster IPs. It must not overlap with any Subnet IP ranges.
   */
  @pattern("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$")
  serviceCidr?: string;

  /**
   * An IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range specified in serviceCidr.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  @pattern("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
  dnsServiceIP?: string;

  /**
   * A CIDR notation IP range assigned to the Docker bridge network. It must not overlap with any Subnet IP ranges or the Kubernetes service address range.
   */
  @pattern("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$")
  dockerBridgeCidr?: string;
}

/**
 * A Machine Learning compute based on Kubernetes Compute.
 */
model Kubernetes extends Compute {
  ...KubernetesSchema;

  /**
   * The type of compute
   */
  computeType: "Kubernetes";
}

/**
 * Kubernetes Compute Schema
 */
model KubernetesSchema {
  /**
   * Properties of Kubernetes
   */
  properties?: KubernetesProperties;
}

/**
 * Kubernetes properties
 */
model KubernetesProperties {
  /**
   * Relay connection string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @secret
  relayConnectionString?: string | null;

  /**
   * ServiceBus connection string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @secret
  serviceBusConnectionString?: string | null;

  /**
   * Extension principal-id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  extensionPrincipalId?: string | null;

  /**
   * Extension instance release train.
   */
  extensionInstanceReleaseTrain?: string;

  /**
   * VC name.
   */
  vcName?: string;

  /**
   * Compute namespace
   */
  `namespace`?: string = "default";

  /**
   * Default instance type
   */
  defaultInstanceType?: string;

  /**
   * Instance Type Schema
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  instanceTypes?: Record<InstanceTypeSchema>;
}

/**
 * Instance type schema.
 */
model InstanceTypeSchema {
  /**
   * Node Selector
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  nodeSelector?: Record<string | null> | null;

  /**
   * Resource requests/limits for this instance type
   */
  resources?: InstanceTypeSchemaResources;
}

/**
 * Resource requests/limits for this instance type
 */
model InstanceTypeSchemaResources {
  /**
   * Resource requests for this instance type
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  requests?: Record<string>;

  /**
   * Resource limits for this instance type
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  limits?: Record<string>;
}

/**
 * AML Compute properties
 */
model AmlComputeProperties {
  /**
   * Compute OS Type
   */
  osType?: OsType = OsType.Linux;

  /**
   * Virtual Machine Size
   */
  vmSize?: string;

  /**
   * Virtual Machine priority
   */
  vmPriority?: VmPriority;

  /**
   * Virtual Machine image for AML Compute - windows only
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  virtualMachineImage?: VirtualMachineImage | null;

  /**
   * Network is isolated or not
   */
  isolatedNetwork?: boolean;

  /**
   * Scale settings for AML Compute
   */
  scaleSettings?: ScaleSettings;

  /**
   * Credentials for an administrator user account that will be created on each compute node.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @summary("User account credentials.")
  userAccountCredentials?: UserAccountCredentials | null;

  /**
   * Virtual network subnet resource ID the compute nodes belong to.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @summary("Subnet.")
  subnet?: ResourceId | null;

  /**
   * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on all nodes of the cluster. Enabled - Indicates that the public ssh port is open on all nodes of the cluster. NotSpecified - Indicates that the public ssh port is closed on all nodes of the cluster if VNet is defined, else is open all public nodes. It can be default only during cluster creation time, after creation it will be either enabled or disabled.
   */
  @summary("Close remote Login Access Port")
  remoteLoginPortPublicAccess?: RemoteLoginPortPublicAccess = RemoteLoginPortPublicAccess.NotSpecified;

  /**
   * Allocation state of the compute. Possible values are: steady - Indicates that the compute is not resizing. There are no changes to the number of compute nodes in the compute in progress. A compute enters this state when it is created and when no operations are being performed on the compute to change the number of compute nodes. resizing - Indicates that the compute is resizing; that is, compute nodes are being added to or removed from the compute.
   */
  @visibility(Lifecycle.Read)
  @summary("Allocation state.")
  allocationState?: AllocationState;

  /**
   * The time at which the compute entered its current allocation state.
   */
  @visibility(Lifecycle.Read)
  @summary("Allocation state transition time.")
  allocationStateTransitionTime?: utcDateTime;

  /**
   * Collection of errors encountered by various compute nodes during node setup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @visibility(Lifecycle.Read)
  @summary("Errors.")
  @OpenAPI.extension("x-ms-identifiers", #["/error/code"])
  errors?: ErrorResponse[] | null;

  /**
   * The number of compute nodes currently assigned to the compute.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  @summary("Current node count.")
  currentNodeCount?: int32 | null;

  /**
   * The target number of compute nodes for the compute. If the allocationState is resizing, this property denotes the target node count for the ongoing resize operation. If the allocationState is steady, this property denotes the target node count for the previous resize operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  @summary("Target node count.")
  targetNodeCount?: int32 | null;

  /**
   * Counts of various node states on the compute.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  @summary("Node state counts.")
  nodeStateCounts?: NodeStateCounts | null;

  /**
   * Enable or disable node public IP address provisioning. Possible values are: Possible values are: true - Indicates that the compute nodes will have public IPs provisioned. false - Indicates that the compute nodes will have a private endpoint and no public IPs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @summary("Enable node public IP.")
  enableNodePublicIp?: boolean | null = true;

  /**
   * A property bag containing additional properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  propertyBag?: unknown | null;
}

/**
 * Virtual Machine image for Windows AML Compute
 */
model VirtualMachineImage {
  /**
   * Virtual Machine image path
   */
  id: string;
}

/**
 * Settings for user account that gets created on each on the nodes of a compute.
 */
model UserAccountCredentials {
  /**
   * Name of the administrator user account which can be used to SSH to nodes.
   */
  @summary("User name.")
  adminUserName: string;

  /**
   * SSH public key of the administrator user account.
   */
  @summary("SSH public key.")
  @secret
  adminUserSshPublicKey?: string;

  /**
   * Password of the administrator user account.
   */
  @summary("Password.")
  @secret
  adminUserPassword?: string;
}

/**
 * Counts of various compute node states on the amlCompute.
 */
model NodeStateCounts {
  /**
   * Number of compute nodes in idle state.
   */
  @visibility(Lifecycle.Read)
  @summary("Idle node count.")
  idleNodeCount?: int32;

  /**
   * Number of compute nodes which are running jobs.
   */
  @visibility(Lifecycle.Read)
  @summary("Running node count.")
  runningNodeCount?: int32;

  /**
   * Number of compute nodes which are being prepared.
   */
  @visibility(Lifecycle.Read)
  @summary("Preparing node count.")
  preparingNodeCount?: int32;

  /**
   * Number of compute nodes which are in unusable state.
   */
  @visibility(Lifecycle.Read)
  @summary("Unusable node count.")
  unusableNodeCount?: int32;

  /**
   * Number of compute nodes which are leaving the amlCompute.
   */
  @visibility(Lifecycle.Read)
  @summary("Leaving node count.")
  leavingNodeCount?: int32;

  /**
   * Number of compute nodes which are in preempted state.
   */
  @visibility(Lifecycle.Read)
  @summary("Preempted node count.")
  preemptedNodeCount?: int32;
}

/**
 * An Azure Machine Learning compute.
 */
model AmlCompute extends Compute {
  ...AmlComputeSchema;

  /**
   * The type of compute
   */
  computeType: "AmlCompute";
}

/**
 * Properties(top level) of AmlCompute
 */
model AmlComputeSchema {
  /**
   * Properties of AmlCompute
   */
  properties?: AmlComputeProperties;
}

/**
 * Compute Instance properties
 */
model ComputeInstanceProperties {
  /**
   * Virtual Machine Size
   */
  vmSize?: string;

  /**
   * Virtual network subnet resource ID the compute nodes belong to.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @summary("Subnet.")
  subnet?: ResourceId | null;

  /**
   * Policy for sharing applications on this compute instance among users of parent workspace. If Personal, only the creator can access applications on this compute instance. When Shared, any workspace user can access applications on this instance depending on his/her assigned role.
   */
  @summary("Sharing policy for applications on this compute instance")
  applicationSharingPolicy?: ApplicationSharingPolicy = ApplicationSharingPolicy.Shared;

  /**
   * Specifies settings for autologger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @removed(Versions.v2025_12_01)
  autologgerSettings?: ComputeInstanceAutologgerSettings | null;

  /**
   * Specifies policy and settings for SSH access.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  sshSettings?: ComputeInstanceSshSettings | null;

  /**
   * List of Custom Services added to the compute.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  customServices?: CustomService[] | null;

  /**
   * Returns metadata about the operating system image for this compute instance.
   */
  @visibility(Lifecycle.Read)
  osImageMetadata?: ImageMetadata;

  /**
   * Describes all connectivity endpoints available for this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  connectivityEndpoints?: ComputeInstanceConnectivityEndpoints;

  /**
   * Describes available applications and their endpoints on this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["displayName"])
  applications?: ComputeInstanceApplication[];

  /**
   * Describes information on user who created this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  createdBy?: ComputeInstanceCreatedBy;

  /**
   * Collection of errors encountered on this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["/error/code"])
  @summary("Errors.")
  errors?: ErrorResponse[];

  /**
   * The current state of this ComputeInstance.
   */
  @visibility(Lifecycle.Read)
  state?: ComputeInstanceState;

  /**
   * The Compute Instance Authorization type. Available values are personal (default).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @summary("Compute Instance Authorization type.")
  computeInstanceAuthorizationType?: ComputeInstanceAuthorizationType | null = ComputeInstanceAuthorizationType.personal;

  /**
   * Enable Auto OS Patching. Possible values are: true, false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  @removed(Versions.v2025_12_01)
  @summary("Enable Auto OS Patching.")
  enableOSPatching?: boolean | null = false;

  /**
   * Enable root access. Possible values are: true, false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @removed(Versions.v2025_12_01)
  @summary("Enable root access.")
  enableRootAccess?: boolean | null = true;

  /**
   * Enable SSO (single sign on). Possible values are: true, false.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  @summary("Enable SSO (single sign on).")
  enableSSO?: boolean | null = true;

  /**
   * Release quota if compute instance stopped. Possible values are: true - release quota if compute instance stopped. false - don't release quota when compute instance stopped.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @removed(Versions.v2025_12_01)
  @summary("Release quota if compute instance stopped.")
  releaseQuotaOnStop?: boolean | null = false;

  /**
   * Settings for a personal compute instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @summary("Personal Compute Instance settings.")
  personalComputeInstanceSettings?: PersonalComputeInstanceSettings | null;

  /**
   * Details of customized scripts to execute for setting up the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  setupScripts?: SetupScripts | null;

  /**
   * The last operation on ComputeInstance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  lastOperation?: ComputeInstanceLastOperation | null;

  /**
   * The list of schedules to be applied on the computes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  schedules?: ComputeSchedules | null;

  /**
   * Stops compute instance after user defined period of inactivity. Time is defined in ISO8601 format. Minimum is 15 min, maximum is 3 days.
   */
  idleTimeBeforeShutdown?: string;

  /**
   * Enable or disable node public IP address provisioning. Possible values are: Possible values are: true - Indicates that the compute nodes will have public IPs provisioned. false - Indicates that the compute nodes will have a private endpoint and no public IPs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @summary("Enable node public IP.")
  enableNodePublicIp?: boolean | null;

  /**
   * Describes informations of containers on this ComputeInstance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  containers?: ComputeInstanceContainer[] | null;

  /**
   * Describes informations of dataDisks on this ComputeInstance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  dataDisks?: ComputeInstanceDataDisk[] | null;

  /**
   * Describes informations of dataMounts on this ComputeInstance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  dataMounts?: ComputeInstanceDataMount[] | null;

  /**
   * ComputeInstance version.
   */
  @visibility(Lifecycle.Read)
  versions?: ComputeInstanceVersion;
}

/**
 * Specifies settings for autologger.
 */
@removed(Versions.v2025_12_01)
model ComputeInstanceAutologgerSettings {
  /**
   * Indicates whether mlflow autologger is enabled for notebooks.
   */
  mlflowAutologger?: MlflowAutologger;
}

/**
 * Specifies policy and settings for SSH access.
 */
model ComputeInstanceSshSettings {
  /**
   * State of the public SSH port. Possible values are: Disabled - Indicates that the public ssh port is closed on this instance. Enabled - Indicates that the public ssh port is open and accessible according to the VNet/subnet policy if applicable.
   */
  @summary("Access policy for SSH")
  sshPublicAccess?: SshPublicAccess = SshPublicAccess.Disabled;

  /**
   * Describes the admin user name.
   */
  @visibility(Lifecycle.Read)
  adminUserName?: string;

  /**
   * Describes the port for connecting through SSH.
   */
  @visibility(Lifecycle.Read)
  sshPort?: int32;

  /**
   * Specifies the SSH rsa public key file as a string. Use "ssh-keygen -t rsa -b 2048" to generate your SSH key pairs.
   */
  adminPublicKey?: string;
}

/**
 * Returns metadata about the operating system image for this compute instance.
 */
model ImageMetadata {
  /**
   * Specifies the current operating system image version this compute instance is running on.
   */
  currentImageVersion?: string;

  /**
   * Specifies the latest available operating system image version.
   */
  latestImageVersion?: string;

  /**
   * Specifies whether this compute instance is running on the latest operating system image.
   */
  isLatestOsImageVersion?: boolean;

  /**
   * Metadata about the os patching.
   */
  @visibility(Lifecycle.Read)
  osPatchingStatus?: OsPatchingStatus;
}

/**
 * Returns metadata about the os patching.
 */
model OsPatchingStatus {
  /**
   * The os patching status.
   */
  patchStatus?: PatchStatus;

  /**
   * Time of the latest os patching.
   */
  latestPatchTime?: string;

  /**
   * Specifies whether this compute instance is pending for reboot to finish os patching.
   */
  rebootPending?: boolean;

  /**
   * Time of scheduled reboot.
   */
  scheduledRebootTime?: string;

  /**
   * Collection of errors encountered when doing os patching.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @OpenAPI.extension("x-ms-identifiers", #["/error/code"])
  osPatchingErrors?: ErrorResponse[] | null;
}

/**
 * Defines all connectivity endpoints and properties for an ComputeInstance.
 */
model ComputeInstanceConnectivityEndpoints {
  /**
   * Public IP Address of this ComputeInstance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  publicIpAddress?: string | null;

  /**
   * Private IP Address of this ComputeInstance (local to the VNET in which the compute instance is deployed).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  privateIpAddress?: string | null;
}

/**
 * Defines an Aml Instance application and its connectivity endpoint URI.
 */
model ComputeInstanceApplication {
  /**
   * Name of the ComputeInstance application.
   */
  displayName?: string;

  /**
   * Application' endpoint URI.
   */
  endpointUri?: string;
}

/**
 * Describes information on user who created this ComputeInstance.
 */
model ComputeInstanceCreatedBy {
  /**
   * Name of the user.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  userName?: string | null;

  /**
   * Uniquely identifies user' Azure Active Directory organization.
   */
  @visibility(Lifecycle.Read)
  userOrgId?: string;

  /**
   * Uniquely identifies the user within his/her organization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  userId?: string | null;
}

/**
 * Settings for a personal compute instance.
 */
model PersonalComputeInstanceSettings {
  /**
   * A user explicitly assigned to a personal compute instance.
   */
  @summary("Assigned User.")
  assignedUser?: AssignedUser;
}

/**
 * A user that can be assigned to a compute instance.
 */
model AssignedUser {
  /**
   * User’s AAD Object Id.
   */
  objectId: string;

  /**
   * User’s AAD Tenant Id.
   */
  tenantId: string;
}

/**
 * Details of customized scripts to execute for setting up the cluster.
 */
model SetupScripts {
  /**
   * Customized setup scripts
   */
  scripts?: ScriptsToExecute;
}

/**
 * Customized setup scripts
 */
model ScriptsToExecute {
  /**
   * Script that's run every time the machine starts.
   */
  startupScript?: ScriptReference;

  /**
   * Script that's run only once during provision of the compute.
   */
  creationScript?: ScriptReference;
}

/**
 * Script reference
 */
model ScriptReference {
  /**
   * The storage source of the script: inline, workspace.
   */
  scriptSource?: string;

  /**
   * The location of scripts in the mounted volume.
   */
  scriptData?: string;

  /**
   * Optional command line arguments passed to the script to run.
   */
  scriptArguments?: string;

  /**
   * Optional time period passed to timeout command.
   */
  timeout?: string;
}

/**
 * The last operation on ComputeInstance.
 */
model ComputeInstanceLastOperation {
  /**
   * Name of the last operation.
   */
  operationName?: OperationName;

  /**
   * Time of the last operation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  operationTime?: utcDateTime;

  /**
   * Operation status.
   */
  operationStatus?: OperationStatus;

  /**
   * Trigger of operation.
   */
  operationTrigger?: OperationTrigger;
}

/**
 * The list of schedules to be applied on the computes
 */
model ComputeSchedules {
  /**
   * The list of compute start stop schedules to be applied.
   */
  computeStartStop?: ComputeStartStopSchedule[];
}

/**
 * Compute start stop schedule properties
 */
model ComputeStartStopSchedule {
  /**
   * A system assigned id for the schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  id?: string | null;

  /**
   * The current deployment state of schedule.
   */
  @visibility(Lifecycle.Read)
  provisioningStatus?: ProvisioningStatus;

  /**
   * Is the schedule enabled or disabled?
   */
  status?: ScheduleStatus;

  /**
   * [Required] The compute power action.
   */
  action?: ComputePowerAction;

  /**
   * [Required] The schedule trigger type.
   */
  triggerType?: ComputeTriggerType;

  /**
   * Required if triggerType is Recurrence.
   */
  recurrence?: Recurrence;

  /**
   * Required if triggerType is Cron.
   */
  cron?: Cron;

  /**
   * [Deprecated] Not used any more.
   */
  schedule?: ScheduleBase;
}

/**
 * The workflow trigger recurrence for ComputeStartStop schedule type.
 */
model Recurrence {
  /**
   * [Required] The frequency to trigger schedule.
   */
  frequency?: ComputeRecurrenceFrequency;

  /**
   * [Required] Specifies schedule interval in conjunction with frequency
   */
  interval?: int32;

  /**
   * The start time in yyyy-MM-ddTHH:mm:ss format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  startTime?: string | null;

  /**
   * Specifies time zone in which the schedule runs.
   * TimeZone should follow Windows time zone format. Refer: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11
   */
  timeZone?: string = "UTC";

  /**
   * [Required] The recurrence schedule.
   */
  schedule?: ComputeRecurrenceSchedule;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ComputeRecurrenceSchedule {
  /**
   * [Required] List of hours for the schedule.
   */
  hours: int32[];

  /**
   * [Required] List of minutes for the schedule.
   */
  minutes: int32[];

  /**
   * List of month days for the schedule
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  monthDays?: int32[] | null;

  /**
   * List of days for the schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  weekDays?: ComputeWeekDay[] | null;
}

/**
 * The workflow trigger cron for ComputeStartStop schedule type.
 */
model Cron {
  /**
   * The start time in yyyy-MM-ddTHH:mm:ss format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  startTime?: string | null;

  /**
   * Specifies time zone in which the schedule runs.
   * TimeZone should follow Windows time zone format. Refer: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11
   */
  timeZone?: string = "UTC";

  /**
   * [Required] Specifies cron expression of schedule.
   * The expression should follow NCronTab format.
   */
  expression?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ScheduleBase {
  /**
   * A system assigned id for the schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  id?: string | null;

  /**
   * The current deployment state of schedule.
   */
  provisioningStatus?: ScheduleProvisioningState;

  /**
   * Is the schedule enabled or disabled?
   */
  status?: ScheduleStatus;
}

/**
 * Defines an Aml Instance container.
 */
model ComputeInstanceContainer {
  /**
   * Name of the ComputeInstance container.
   */
  name?: string;

  /**
   * Auto save settings.
   */
  autosave?: Autosave;

  /**
   * Information of GPU.
   */
  gpu?: string;

  /**
   * network of this container.
   */
  network?: Network;

  /**
   * Environment information of this container.
   */
  environment?: ComputeInstanceEnvironmentInfo;

  /**
   * services of this containers.
   */
  @visibility(Lifecycle.Read)
  services?: unknown[];
}

/**
 * Environment information
 */
model ComputeInstanceEnvironmentInfo {
  /**
   * name of environment.
   */
  name?: string;

  /**
   * version of environment.
   */
  version?: string;
}

/**
 * Defines an Aml Instance DataDisk.
 */
model ComputeInstanceDataDisk {
  /**
   * Caching type of Data Disk.
   */
  caching?: Caching;

  /**
   * The initial disk size in gigabytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  @summary("The initial disk size in gigabytes.")
  diskSizeGB?: int32;

  /**
   * The lun is used to uniquely identify each data disk. If attaching multiple disks, each should have a distinct lun.
   */
  @summary("The logical unit number.")
  lun?: int32;

  /**
   * type of this storage account.
   */
  storageAccountType?: StorageAccountType = StorageAccountType.Standard_LRS;
}

/**
 * Version of computeInstance.
 */
model ComputeInstanceVersion {
  /**
   * Runtime of compute instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  runtime?: string | null;
}

/**
 * An Azure Machine Learning compute instance.
 */
model ComputeInstance extends Compute {
  ...ComputeInstanceSchema;

  /**
   * The type of compute
   */
  computeType: "ComputeInstance";
}

/**
 * Properties(top level) of ComputeInstance
 */
model ComputeInstanceSchema {
  /**
   * Properties of ComputeInstance
   */
  properties?: ComputeInstanceProperties;
}

/**
 * A Machine Learning compute based on Azure Virtual Machines.
 */
model VirtualMachine extends Compute {
  ...VirtualMachineSchema;

  /**
   * The type of compute
   */
  computeType: "VirtualMachine";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model VirtualMachineSchema {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  properties?: VirtualMachineSchemaProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model VirtualMachineSchemaProperties {
  /**
   * Virtual Machine size
   */
  virtualMachineSize?: string;

  /**
   * Port open for ssh connections.
   */
  sshPort?: int32;

  /**
   * Notebook server port open for ssh connections.
   */
  notebookServerPort?: int32;

  /**
   * Public IP address of the virtual machine.
   */
  address?: string;

  /**
   * Admin credentials for virtual machine
   */
  administratorAccount?: VirtualMachineSshCredentials;

  /**
   * Indicates whether this compute will be used for running notebooks.
   */
  isNotebookInstanceCompute?: boolean;
}

/**
 * Admin credentials for virtual machine
 */
model VirtualMachineSshCredentials {
  /**
   * Username of admin account
   */
  username?: string;

  /**
   * Password of admin account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Secret property is part of existing API contract"
  password?: string;

  /**
   * Public key data
   */
  @secret
  publicKeyData?: string;

  /**
   * Private key data
   */
  @secret
  privateKeyData?: string;
}

/**
 * HDInsight compute properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model HDInsightProperties {
  /**
   * Port open for ssh connections on the master node of the cluster.
   */
  sshPort?: int32;

  /**
   * Public IP address of the master node of the cluster.
   */
  address?: string;

  /**
   * Admin credentials for master node of the cluster
   */
  administratorAccount?: VirtualMachineSshCredentials;
}

/**
 * A HDInsight compute.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model HDInsight extends Compute {
  ...HDInsightSchema;

  /**
   * The type of compute
   */
  computeType: "HDInsight";
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model HDInsightSchema {
  properties?: HDInsightProperties;
}

/**
 * A DataFactory compute.
 */
model DataFactory extends Compute {
  /**
   * The type of compute
   */
  computeType: "DataFactory";
}

/**
 * Properties of Databricks
 */
model DatabricksProperties {
  /**
   * Databricks access token
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Secret property is part of existing API contract"
  databricksAccessToken?: string;

  /**
   * Workspace Url
   */
  workspaceUrl?: string;
}

/**
 * A DataFactory compute.
 */
model Databricks extends Compute {
  ...DatabricksSchema;

  /**
   * The type of compute
   */
  computeType: "Databricks";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DatabricksSchema {
  properties?: DatabricksProperties;
}

/**
 * A DataLakeAnalytics compute.
 */
model DataLakeAnalytics extends Compute {
  ...DataLakeAnalyticsSchema;

  /**
   * The type of compute
   */
  computeType: "DataLakeAnalytics";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DataLakeAnalyticsSchema {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  properties?: DataLakeAnalyticsSchemaProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DataLakeAnalyticsSchemaProperties {
  /**
   * DataLake Store Account Name
   */
  dataLakeStoreAccountName?: string;
}

/**
 * A SynapseSpark compute.
 */
model SynapseSpark extends Compute {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  properties?: SynapseSparkProperties;

  /**
   * The type of compute
   */
  computeType: "SynapseSpark";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model SynapseSparkProperties {
  /**
   * Auto scale properties.
   */
  autoScaleProperties?: AutoScaleProperties;

  /**
   * Auto pause properties.
   */
  autoPauseProperties?: AutoPauseProperties;

  /**
   * Spark version.
   */
  sparkVersion?: string;

  /**
   * The number of compute nodes currently assigned to the compute.
   */
  nodeCount?: int32;

  /**
   * Node size.
   */
  nodeSize?: string;

  /**
   * Node size family.
   */
  nodeSizeFamily?: string;

  /**
   * Azure subscription identifier.
   */
  subscriptionId?: string;

  /**
   * Name of the resource group in which workspace is located.
   */
  resourceGroup?: string;

  /**
   * Name of Azure Machine Learning workspace.
   */
  workspaceName?: string;

  /**
   * Pool name.
   */
  poolName?: string;
}

/**
 * Auto scale properties
 */
model AutoScaleProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  minNodeCount?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  enabled?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  maxNodeCount?: int32;
}

/**
 * Auto pause properties
 */
model AutoPauseProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  delayInMinutes?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  enabled?: boolean;
}

/**
 * Properties of AksComputeSecrets
 */
model AksComputeSecretsProperties {
  /**
   * Content of kubeconfig file that can be used to connect to the Kubernetes cluster.
   */
  userKubeConfig?: string;

  /**
   * Content of kubeconfig file that can be used to connect to the Kubernetes cluster.
   */
  adminKubeConfig?: string;

  /**
   * Image registry pull secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  imagePullSecretName?: string | null;
}

/**
 * Secrets related to a Machine Learning compute based on AKS.
 */
model AksComputeSecrets extends ComputeSecrets {
  ...AksComputeSecretsProperties;

  /**
   * The type of compute
   */
  computeType: "AKS";
}

/**
 * Secrets related to a Machine Learning compute based on AKS.
 */
model VirtualMachineSecrets extends ComputeSecrets {
  ...VirtualMachineSecretsSchema;

  /**
   * The type of compute
   */
  computeType: "VirtualMachine";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model VirtualMachineSecretsSchema {
  /**
   * Admin credentials for virtual machine.
   */
  administratorAccount?: VirtualMachineSshCredentials;
}

/**
 * Properties of Databricks Compute Secrets
 */
model DatabricksComputeSecretsProperties {
  /**
   * access token for databricks account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Secret property is part of existing API contract"
  databricksAccessToken?: string;
}

/**
 * Secrets related to a Machine Learning compute based on Databricks.
 */
model DatabricksComputeSecrets extends ComputeSecrets {
  ...DatabricksComputeSecretsProperties;

  /**
   * The type of compute
   */
  computeType: "Databricks";
}

/**
 * Account key datastore credentials configuration.
 */
model AccountKeyDatastoreCredentials extends DatastoreCredentials {
  /**
   * [Required] Storage account secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  secrets: AccountKeyDatastoreSecrets;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: "AccountKey";
}

/**
 * Datastore account key secrets.
 */
model AccountKeyDatastoreSecrets extends DatastoreSecrets {
  /**
   * Storage account key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  key?: string | null;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  secretsType: "AccountKey";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model AllFeatures extends MonitoringFeatureFilterBase {
  /**
   * [Required] Specifies the feature filter to leverage when selecting features to calculate metrics over.
   */
  filterType: "AllFeatures";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("filterType")
model MonitoringFeatureFilterBase {
  /**
   * [Required] Specifies the feature filter to leverage when selecting features to calculate metrics over.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  filterType: MonitoringFeatureFilterType;
}

/**
 * All nodes means the service will be running on all of the nodes of the job
 */
model AllNodes extends Nodes {
  /**
   * [Required] Type of the Nodes value
   */
  nodesValueType: "All";
}

/**
 * AML Token identity configuration.
 */
model AmlToken extends IdentityConfiguration {
  /**
   * [Required] Specifies the type of identity framework.
   */
  identityType: "AMLToken";
}

/**
 * AML token compute identity definition.
 */
model AmlTokenComputeIdentity extends MonitorComputeIdentityBase {
  /**
   * [Required] Specifies the type of identity to use within the monitoring jobs.
   */
  computeIdentityType: "AmlToken";
}

/**
 * Monitor compute identity base definition.
 */
@discriminator("computeIdentityType")
model MonitorComputeIdentityBase {
  /**
   * [Required] Specifies the type of identity to use within the monitoring jobs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  computeIdentityType: MonitorComputeIdentityType;
}

/**
 * Access credential with no credentials
 */
model AnonymousAccessCredential extends DataReferenceCredential {
  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialType: "NoCredentials";
}

/**
 * Asset input type.
 */
model AssetJobInput {
  /**
   * Enum to determine the input data delivery mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode?: InputDeliveryMode = InputDeliveryMode.ReadOnlyMount;

  /**
   * [Required] Input Asset URI.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  uri: string;
}

/**
 * Asset output type.
 */
model AssetJobOutput {
  /**
   * Output Asset Name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  assetName?: string | null;

  /**
   * Output data delivery mode enums.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode?: OutputDeliveryMode = OutputDeliveryMode.ReadWriteMount;

  /**
   * Output Asset URI.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  uri?: string | null;
}

/**
 * Forecast horizon determined automatically by system.
 */
model AutoForecastHorizon extends ForecastHorizon {
  /**
   * [Required] Set forecast horizon value selection mode.
   */
  mode: "Auto";
}

/**
 * The desired maximum forecast horizon in units of time-series frequency.
 */
@discriminator("mode")
model ForecastHorizon {
  /**
   * [Required] Set forecast horizon value selection mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: ForecastHorizonMode;
}

/**
 * AutoMLJob class.
 * Use this class for executing AutoML tasks like Classification/Regression etc.
 * See TaskType enum for all the tasks supported.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model AutoMLJob extends JobBaseProperties {
  /**
   * The ARM resource ID of the Environment specification for the job.
   * This is optional value to provide, if not provided, AutoML will default this to Production AutoML curated environment version when running the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentId?: string | null;

  /**
   * Environment variables included in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentVariables?: Record<string | null> | null;

  /**
   * Mapping of output data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput | null> | null;

  /**
   * Queue settings for the job
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  queueSettings?: QueueSettings | null;

  /**
   * Compute Resource configuration for the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resources?: JobResourceConfiguration = #{};

  /**
   * [Required] This represents scenario which can be one of Tables/NLP/Image
   */
  taskDetails: AutoMLVertical;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "AutoML";
}

/**
 * Job output definition container information on where to find job output/logs.
 */
@discriminator("jobOutputType")
model JobOutput {
  /**
   * Description for the output.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  description?: string | null;

  /**
   * [Required] Specifies the type of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobOutputType: JobOutputType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model QueueSettings {
  /**
   * Enum to determine the job tier.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobTier?: JobTier = JobTier.Null;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model JobResourceConfiguration extends ResourceConfiguration {
  /**
   * Extra arguments to pass to the Docker run command. This would override any parameters that have already been set by the system, or in this section. This parameter is only supported for Azure ML compute types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dockerArgs?: string | null;

  /**
   * Extra arguments to pass to the Docker run command, as a collection. This would override any parameters that have already been set by the system, or in this section. This parameter is only supported for Azure ML compute types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dockerArgsList?: string[] | null;

  /**
   * Size of the docker container's shared memory block. This should be in the format of (number)(unit) where number as to be greater than 0 and the unit can be one of b(bytes), k(kilobytes), m(megabytes), or g(gigabytes).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("\\d+[bBkKmMgG]")
  shmSize?: string = "2g";
}

/**
 * AutoML vertical class.
 * Base class for AutoML verticals - TableVertical/ImageVertical/NLPVertical
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
@discriminator("taskType")
model AutoMLVertical {
  /**
   * Enum for setting log verbosity.
   */
  logVerbosity?: LogVerbosity = LogVerbosity.Info;

  /**
   * Target column name: This is prediction values column.
   * Also known as label column name in context of classification tasks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  targetColumnName?: string | null;

  /**
   * [Required] Task type for AutoMLJob.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  taskType: TaskType;

  /**
   * [Required] Training data input.
   */
  trainingData: MLTableJobInput;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model MLTableJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "mltable";
}

/**
 * Command job definition.
 */
@discriminator("jobInputType")
model JobInput {
  /**
   * Description for the input.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  description?: string | null;

  /**
   * [Required] Specifies the type of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobInputType: JobInputType;
}

/**
 * N-Cross validations determined automatically.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model AutoNCrossValidations extends NCrossValidations {
  /**
   * [Required] Mode for determining N-Cross validations.
   */
  mode: "Auto";
}

/**
 * N-Cross validations value.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
@discriminator("mode")
model NCrossValidations {
  /**
   * [Required] Mode for determining N-Cross validations.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: NCrossValidationsMode;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model AutoSeasonality extends Seasonality {
  /**
   * [Required] Seasonality mode.
   */
  mode: "Auto";
}

/**
 * Forecasting seasonality.
 */
@discriminator("mode")
model Seasonality {
  /**
   * [Required] Seasonality mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: SeasonalityMode;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model AutoTargetLags extends TargetLags {
  /**
   * [Required] Set target lags mode - Auto/Custom
   */
  mode: "Auto";
}

/**
 * The number of past periods to lag from the target column.
 */
@discriminator("mode")
model TargetLags {
  /**
   * [Required] Set target lags mode - Auto/Custom
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: TargetLagsMode;
}

/**
 * Target lags rolling window determined automatically.
 */
model AutoTargetRollingWindowSize extends TargetRollingWindowSize {
  /**
   * [Required] TargetRollingWindowSiz detection mode.
   */
  mode: "Auto";
}

/**
 * Forecasting target rolling window size.
 */
@discriminator("mode")
model TargetRollingWindowSize {
  /**
   * [Required] TargetRollingWindowSiz detection mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: TargetRollingWindowSizeMode;
}

/**
 * Azure Blob datastore configuration.
 */
model AzureBlobDatastore extends DatastoreProperties {
  ...AzureDatastore;

  /**
   * Storage account name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  accountName?: string | null;

  /**
   * Storage account container name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  containerName?: string | null;

  /**
   * Azure cloud endpoint for the storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string | null;

  /**
   * Protocol used to communicate with the storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  protocol?: string | null;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity = ServiceDataAccessAuthIdentity.None;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "AzureBlob";
}

/**
 * Base definition for Azure datastore contents configuration.
 */
model AzureDatastore {
  /**
   * Azure Resource Group name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  resourceGroup?: string | null;

  /**
   * Azure Subscription Id
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  subscriptionId?: string | null;
}

/**
 * Azure Data Lake Gen1 datastore configuration.
 */
model AzureDataLakeGen1Datastore extends DatastoreProperties {
  ...AzureDatastore;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity = ServiceDataAccessAuthIdentity.None;

  /**
   * [Required] Azure Data Lake store name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  storeName: string;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "AzureDataLakeGen1";
}

/**
 * Azure Data Lake Gen2 datastore configuration.
 */
model AzureDataLakeGen2Datastore extends DatastoreProperties {
  ...AzureDatastore;

  /**
   * [Required] Storage account name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  accountName: string;

  /**
   * Azure cloud endpoint for the storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string | null;

  /**
   * [Required] The name of the Data Lake Gen2 filesystem.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  filesystem: string;

  /**
   * Protocol used to communicate with the storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  protocol?: string | null;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity = ServiceDataAccessAuthIdentity.None;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "AzureDataLakeGen2";
}

/**
 * Webhook details specific for Azure DevOps
 */
model AzureDevOpsWebhook extends Webhook {
  /**
   * [Required] Specifies the type of service to send a callback
   */
  webhookType: "AzureDevOps";
}

/**
 * Azure File datastore configuration.
 */
model AzureFileDatastore extends DatastoreProperties {
  ...AzureDatastore;

  /**
   * [Required] Storage account name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  accountName: string;

  /**
   * Azure cloud endpoint for the storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string | null;

  /**
   * [Required] The name of the Azure file share that the datastore points to.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  fileShareName: string;

  /**
   * Protocol used to communicate with the storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  protocol?: string | null;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity = ServiceDataAccessAuthIdentity.None;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "AzureFile";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model AzureOpenAiFineTuning extends FineTuningVertical {
  /**
   * HyperParameters for fine tuning Azure Open AI model.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  hyperParameters?: AzureOpenAiHyperParameters | null;

  /**
   * [Required] Enum to determine the type of fine tuning.
   */
  modelProvider: "AzureOpenAI";
}

/**
 * Azure Open AI hyperparameters for fine tuning.
 */
model AzureOpenAiHyperParameters {
  /**
   * Number of examples in each batch. A larger batch size means that model parameters are updated less frequently, but with lower variance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  batchSize?: int32 | null;

  /**
   * Scaling factor for the learning rate. A smaller learning rate may be useful to avoid over fitting.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  learningRateMultiplier?: float64 | null;

  /**
   * The number of epochs to train the model for. An epoch refers to one full cycle through the training dataset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  nEpochs?: int32 | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@removed(Versions.v2025_12_01)
@discriminator("modelProvider")
model FineTuningVertical {
  /**
   * [Required] Input model for fine tuning.
   */
  `model`: JobInput;

  /**
   * [Required] Enum to determine the type of fine tuning.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  modelProvider: ModelProvider;

  /**
   * [Required] Fine tuning task type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  taskType: FineTuningTaskType;

  /**
   * [Required] Training data for fine tuning.
   */
  trainingData: JobInput;

  /**
   * Validation data for fine tuning.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationData?: JobInput | null;
}

/**
 * Defines an early termination policy based on slack criteria, and a frequency and delay interval for evaluation
 */
model BanditPolicy extends EarlyTerminationPolicy {
  /**
   * Absolute distance allowed from the best performing run.
   */
  slackAmount?: float32 = 0;

  /**
   * Ratio of the allowed distance from the best performing run.
   */
  slackFactor?: float32 = 0;

  /**
   * [Required] Name of policy configuration
   */
  policyType: "Bandit";
}

/**
 * Early termination policies enable canceling poor-performing runs before they complete
 */
@discriminator("policyType")
model EarlyTerminationPolicy {
  /**
   * Number of intervals by which to delay the first evaluation.
   */
  delayEvaluation?: int32 = 0;

  /**
   * Interval (number of runs) between policy evaluations.
   */
  evaluationInterval?: int32 = 0;

  /**
   * [Required] Name of policy configuration
   */
  policyType: EarlyTerminationPolicyType;
}

/**
 * Properties for a Batch Pipeline Component Deployment.
 */
model BatchPipelineComponentDeploymentConfiguration
  extends BatchDeploymentConfiguration {
  /**
   * The ARM id of the component to be run.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  componentId?: IdAssetReference | null;

  /**
   * The description which will be applied to the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  description?: string | null;

  /**
   * Run-time settings for the pipeline job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  settings?: Record<string | null> | null;

  /**
   * The tags which will be applied to the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  tags?: Record<string | null> | null;

  /**
   * [Required] The type of the deployment
   */
  deploymentConfigurationType: "PipelineComponent";
}

/**
 * Reference to an asset via its ARM resource ID.
 */
model IdAssetReference extends AssetReferenceBase {
  /**
   * [Required] ARM resource ID of the asset.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  assetId: string;

  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: "Id";
}

/**
 * Defines a Sampling Algorithm that generates values based on previous values
 */
model BayesianSamplingAlgorithm extends SamplingAlgorithm {
  /**
   * [Required] The algorithm used for generating hyperparameter values, along with configuration properties
   */
  samplingAlgorithmType: "Bayesian";
}

/**
 * The Sampling Algorithm used to generate hyperparameter values, along with properties to
 * configure the algorithm
 */
@discriminator("samplingAlgorithmType")
model SamplingAlgorithm {
  /**
   * [Required] The algorithm used for generating hyperparameter values, along with configuration properties
   */
  samplingAlgorithmType: SamplingAlgorithmType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CategoricalDataDriftMetricThreshold extends DataDriftMetricThresholdBase {
  /**
   * [Required] The categorical data drift metric to calculate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  metric: CategoricalDataDriftMetric;

  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  dataType: "Categorical";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("dataType")
model DataDriftMetricThresholdBase {
  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataType: MonitoringFeatureDataType;

  /**
   * The threshold value. If null, a default value will be set depending on the selected metric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  threshold?: MonitoringThreshold | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model MonitoringThreshold {
  /**
   * The threshold value. If null, the set default is dependent on the metric type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  value?: float64 | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CategoricalDataQualityMetricThreshold
  extends DataQualityMetricThresholdBase {
  /**
   * [Required] The categorical data quality metric to calculate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  metric: CategoricalDataQualityMetric;

  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  dataType: "Categorical";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("dataType")
model DataQualityMetricThresholdBase {
  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataType: MonitoringFeatureDataType;

  /**
   * The threshold value. If null, a default value will be set depending on the selected metric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  threshold?: MonitoringThreshold | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CategoricalPredictionDriftMetricThreshold
  extends PredictionDriftMetricThresholdBase {
  /**
   * [Required] The categorical prediction drift metric to calculate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  metric: CategoricalPredictionDriftMetric;

  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  dataType: "Categorical";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("dataType")
model PredictionDriftMetricThresholdBase {
  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataType: MonitoringFeatureDataType;

  /**
   * The threshold value. If null, a default value will be set depending on the selected metric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  threshold?: MonitoringThreshold | null;
}

/**
 * Certificate datastore credentials configuration.
 */
model CertificateDatastoreCredentials extends DatastoreCredentials {
  /**
   * Authority URL used for authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  authorityUrl?: string | null;

  /**
   * [Required] Service principal client ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Format not applicable for this property"
  clientId: Azure.Core.uuid;

  /**
   * Resource the service principal has access to.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  resourceUrl?: string | null;

  /**
   * [Required] Service principal secrets.
   */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secrets: CertificateDatastoreSecrets;

  /**
   * [Required] ID of the tenant to which the service principal belongs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Format not applicable for this property"
  tenantId: Azure.Core.uuid;

  /**
   * [Required] Thumbprint of the certificate used for authentication.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  thumbprint: string;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: "Certificate";
}

/**
 * Datastore certificate secrets.
 */
model CertificateDatastoreSecrets extends DatastoreSecrets {
  /**
   * Service principal certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  certificate?: string | null;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  secretsType: "Certificate";
}

/**
 * Classification task in AutoML Table vertical.
 */
model Classification extends AutoMLVertical {
  ...TableVertical;

  /**
   * Positive label for binary metrics calculation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  positiveLabel?: string | null;

  /**
   * Primary metrics for classification tasks.
   */
  primaryMetric?: ClassificationPrimaryMetrics = ClassificationPrimaryMetrics.AUCWeighted;

  /**
   * Inputs for training phase for an AutoML Job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  trainingSettings?: ClassificationTrainingSettings | null;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "Classification";
}

/**
 * Classification Training related configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model ClassificationTrainingSettings extends TrainingSettings {
  /**
   * Allowed models for classification task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  allowedTrainingAlgorithms?: ClassificationModels[] | null;

  /**
   * Blocked models for classification task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  blockedTrainingAlgorithms?: ClassificationModels[] | null;
}

/**
 * Training related configuration.
 */
model TrainingSettings {
  /**
   * Enable recommendation of DNN models.
   */
  enableDnnTraining?: boolean = false;

  /**
   * Flag to turn on explainability on best model.
   */
  enableModelExplainability?: boolean = true;

  /**
   * Flag for enabling onnx compatible models.
   */
  enableOnnxCompatibleModels?: boolean = false;

  /**
   * Enable stack ensemble run.
   */
  enableStackEnsemble?: boolean = true;

  /**
   * Enable voting ensemble run.
   */
  enableVoteEnsemble?: boolean = true;

  /**
   * During VotingEnsemble and StackEnsemble model generation, multiple fitted models from the previous child runs are downloaded.
   * Configure this parameter with a higher value than 300 secs, if more time is needed.
   */
  ensembleModelDownloadTimeout?: duration = duration.fromISO("PT5M");

  /**
   * Stack ensemble settings for stack ensemble run.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  stackEnsembleSettings?: StackEnsembleSettings | null;
}

/**
 * Advances setting to customize StackEnsemble run.
 */
model StackEnsembleSettings {
  /**
   * Optional parameters to pass to the initializer of the meta-learner.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  stackMetaLearnerKWargs?: unknown | null;

  /**
   * Specifies the proportion of the training set (when choosing train and validation type of training) to be reserved for training the meta-learner. Default value is 0.2.
   */
  stackMetaLearnerTrainPercentage?: float64 = 0.2;

  /**
   * The meta-learner is a model trained on the output of the individual heterogeneous models.\r\nDefault meta-learners are LogisticRegression for classification tasks (or LogisticRegressionCV if cross-validation is enabled) and ElasticNet for regression/forecasting tasks (or ElasticNetCV if cross-validation is enabled).\r\nThis parameter can be one of the following strings: LogisticRegression, LogisticRegressionCV, LightGBMClassifier, ElasticNet, ElasticNetCV, LightGBMRegressor, or LinearRegression
   */
  stackMetaLearnerType?: StackMetaLearnerType = StackMetaLearnerType.None;
}

/**
 * Abstract class for AutoML tasks that use table dataset as input - such as Classification/Regression/Forecasting.
 */
model TableVertical {
  /**
   * Columns to use for CVSplit data.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  cvSplitColumnNames?: string[] | null;

  /**
   * Featurization inputs needed for AutoML job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  featurizationSettings?: TableVerticalFeaturizationSettings | null;

  /**
   * Execution constraints for AutoMLJob.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  limitSettings?: TableVerticalLimitSettings | null;

  /**
   * Number of cross validation folds to be applied on training dataset
   * when validation dataset is not provided.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  nCrossValidations?: NCrossValidations | null;

  /**
   * Test data input.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  testData?: MLTableJobInput | null;

  /**
   * The fraction of test dataset that needs to be set aside for validation purpose.
   * Values between (0.0 , 1.0)
   * Applied when validation dataset is not provided.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  testDataSize?: float64 | null;

  /**
   * Validation data inputs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationData?: MLTableJobInput | null;

  /**
   * The fraction of training dataset that needs to be set aside for validation purpose.
   * Values between (0.0 , 1.0)
   * Applied when validation dataset is not provided.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationDataSize?: float64 | null;

  /**
   * The name of the sample weight column. Automated ML supports a weighted column as an input, causing rows in the data to be weighted up or down.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  weightColumnName?: string | null;
}

/**
 * Featurization Configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model TableVerticalFeaturizationSettings extends FeaturizationSettings {
  /**
   * These transformers shall not be used in featurization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  blockedTransformers?: BlockedTransformers[] | null;

  /**
   * Dictionary of column name and its type (int, float, string, datetime etc).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  columnNameAndTypes?: Record<string | null> | null;

  /**
   * Determines whether to use Dnn based featurizers for data featurization.
   */
  enableDnnFeaturization?: boolean = false;

  /**
   * Featurization mode - User can keep the default 'Auto' mode and AutoML will take care of necessary transformation of the data in featurization phase.
   * If 'Off' is selected then no featurization is done.
   * If 'Custom' is selected then user can specify additional inputs to customize how featurization is done.
   */
  mode?: FeaturizationMode = FeaturizationMode.Auto;

  /**
   * User can specify additional transformers to be used along with the columns to which it would be applied and parameters for the transformer constructor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @OpenAPI.extension("x-ms-identifiers", #[])
  transformerParams?: Record<ColumnTransformer[] | null> | null;
}

/**
 * Column transformer parameters.
 */
model ColumnTransformer {
  /**
   * Fields to apply transformer logic on.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  fields?: string[] | null;

  /**
   * Different properties to be passed to transformer.
   * Input expected is dictionary of key,value pairs in JSON format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  parameters?: unknown | null;
}

/**
 * Featurization Configuration.
 */
model FeaturizationSettings {
  /**
   * Dataset language, useful for the text data.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  datasetLanguage?: string | null;
}

/**
 * Job execution constraints.
 */
model TableVerticalLimitSettings {
  /**
   * Enable early termination, determines whether or not if AutoMLJob will terminate early if there is no score improvement in last 20 iterations.
   */
  enableEarlyTermination?: boolean = true;

  /**
   * Exit score for the AutoML job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  exitScore?: float64 | null;

  /**
   * Maximum Concurrent iterations.
   */
  maxConcurrentTrials?: int32 = 1;

  /**
   * Max cores per iteration.
   */
  maxCoresPerTrial?: int32 = -1;

  /**
   * Number of iterations.
   */
  maxTrials?: int32 = 1000;

  /**
   * AutoML job timeout.
   */
  timeout?: duration = duration.fromISO("PT6H");

  /**
   * Iteration timeout.
   */
  trialTimeout?: duration = duration.fromISO("PT30M");
}

/**
 * Command job definition.
 */
model CommandJob extends JobBaseProperties {
  /**
   * ARM resource ID of the code asset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  codeId?: string | null;

  /**
   * [Required] The command to execute on startup of the job. eg. "python train.py"
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  command: string;

  /**
   * Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  distribution?: DistributionConfiguration | null;

  /**
   * [Required] The ARM resource ID of the Environment specification for the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  environmentId: string;

  /**
   * Environment variables included in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentVariables?: Record<string | null> | null;

  /**
   * Mapping of input data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputs?: Record<JobInput | null> | null;

  /**
   * Command Job limit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  limits?: CommandJobLimits | null;

  /**
   * Mapping of output data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput | null> | null;

  /**
   * Input parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read)
  parameters?: unknown | null;

  /**
   * Queue settings for the job
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  queueSettings?: QueueSettings | null;

  /**
   * Compute Resource configuration for the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resources?: JobResourceConfiguration;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "Command";
}

/**
 * Base definition for job distribution configuration.
 */
@discriminator("distributionType")
model DistributionConfiguration {
  /**
   * [Required] Specifies the type of distribution framework.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  distributionType: DistributionType;
}

/**
 * Command Job limit class.
 */
model CommandJobLimits extends JobLimits {
  /**
   * [Required] JobLimit type.
   */
  jobLimitsType: "Command";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("jobLimitsType")
model JobLimits {
  /**
   * [Required] JobLimit type.
   */
  jobLimitsType: JobLimitsType;

  /**
   * The max run duration in ISO 8601 format, after which the job will be cancelled. Only supports duration with precision as low as Seconds.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  timeout?: duration | null;
}

/**
 * Resource requirements for each container instance within an online deployment.
 */
model ContainerResourceRequirements {
  /**
   * Container resource limit info:
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  containerResourceLimits?: ContainerResourceSettings | null;

  /**
   * Container resource request info:
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  containerResourceRequests?: ContainerResourceSettings | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ContainerResourceSettings {
  /**
   * Number of vCPUs request/limit for container. More info:
   * https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  cpu?: string | null;

  /**
   * Number of Nvidia GPU cards request/limit for container. More info:
   * https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  gpu?: string | null;

  /**
   * Memory size request/limit for container. More info:
   * https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  memory?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CreateMonitorAction extends ScheduleActionBase {
  /**
   * [Required] Defines the monitor.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  monitorDefinition: MonitorDefinition;

  /**
   * [Required] Specifies the action type of the schedule
   */
  actionType: "CreateMonitor";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model MonitorDefinition {
  /**
   * The monitor's notification settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  alertNotificationSettings?: MonitorNotificationSettings | null;

  /**
   * [Required] The ARM resource ID of the compute resource to run the monitoring job on.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  computeConfiguration: MonitorComputeConfigurationBase;

  /**
   * The entities targeted by the monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  monitoringTarget?: MonitoringTarget | null;

  /**
   * [Required] The signals to monitor.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  signals: Record<MonitoringSignalBase | null>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model MonitorNotificationSettings {
  /**
   * The AML notification email settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  emailNotificationSettings?: MonitorEmailNotificationSettings | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model MonitorEmailNotificationSettings {
  /**
   * The email recipient list which has a limitation of 499 characters in total.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @OpenAPI.extension("x-ms-identifiers", #[])
  emails?: string[] | null;
}

/**
 * Monitor compute configuration base definition.
 */
@discriminator("computeType")
model MonitorComputeConfigurationBase {
  /**
   * [Required] Specifies the type of signal to monitor.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  computeType: MonitorComputeType;
}

/**
 * Monitoring target definition.
 */
model MonitoringTarget {
  /**
   * Reference to the deployment asset targeted by this monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deploymentId?: string | null;

  /**
   * Reference to the model asset targeted by this monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  modelId?: string | null;

  /**
   * [Required] The machine learning task type of the monitored model.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  taskType: ModelTaskType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@discriminator("signalType")
model MonitoringSignalBase {
  /**
   * The current notification mode for this signal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @OpenAPI.extension("x-ms-identifiers", #[])
  notificationTypes?: MonitoringNotificationType[] | null;

  /**
   * Property dictionary. Properties can be added, but not removed or altered.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  properties?: Record<string | null> | null;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  signalType: MonitoringSignalType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CronTrigger extends TriggerBase {
  /**
   * [Required] Specifies cron expression of schedule.
   * The expression should follow NCronTab format.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  expression: string;

  /**
   * [Required]
   */
  triggerType: "Cron";
}

/**
 * The desired maximum forecast horizon in units of time-series frequency.
 */
model CustomForecastHorizon extends ForecastHorizon {
  /**
   * [Required] Forecast horizon value.
   */
  value: int32;

  /**
   * [Required] Set forecast horizon value selection mode.
   */
  mode: "Custom";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CustomMetricThreshold {
  /**
   * [Required] The user-defined metric to calculate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  metric: string;

  /**
   * The threshold value. If null, a default value will be set depending on the selected metric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  threshold?: MonitoringThreshold | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CustomModelFineTuning extends FineTuningVertical {
  /**
   * HyperParameters for fine tuning custom model.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  hyperParameters?: Record<string | null> | null;

  /**
   * [Required] Enum to determine the type of fine tuning.
   */
  modelProvider: "Custom";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CustomModelJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "custom_model";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CustomModelJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "custom_model";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CustomMonitoringSignal extends MonitoringSignalBase {
  /**
   * [Required] Reference to the component asset used to calculate the custom metrics.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  componentId: string;

  /**
   * Monitoring assets to take as input. Key is the component input port name, value is the data asset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputAssets?: Record<MonitoringInputDataBase | null> | null;

  /**
   * Extra component parameters to take as input. Key is the component literal input port name, value is the parameter value.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputs?: Record<JobInput | null> | null;

  /**
   * [Required] A list of metrics to calculate and their associated thresholds.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  metricThresholds: CustomMetricThreshold[];

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  signalType: "Custom";
}

/**
 * Monitoring input data base definition.
 */
@discriminator("inputDataType")
model MonitoringInputDataBase {
  /**
   * Mapping of column names to special uses.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  columns?: Record<string | null> | null;

  /**
   * The context metadata of the data source.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataContext?: string | null;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputDataType: MonitoringInputDataType;

  /**
   * [Required] Specifies the type of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobInputType: JobInputType;

  /**
   * [Required] Input Asset URI.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  uri: string;
}

/**
 * N-Cross validations are specified by user.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model CustomNCrossValidations extends NCrossValidations {
  /**
   * [Required] N-Cross validations value.
   */
  value: int32;

  /**
   * [Required] Mode for determining N-Cross validations.
   */
  mode: "Custom";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CustomSeasonality extends Seasonality {
  /**
   * [Required] Seasonality value.
   */
  value: int32;

  /**
   * [Required] Seasonality mode.
   */
  mode: "Custom";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CustomTargetLags extends TargetLags {
  /**
   * [Required] Set target lags values.
   */
  values: int32[];

  /**
   * [Required] Set target lags mode - Auto/Custom
   */
  mode: "Custom";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CustomTargetRollingWindowSize extends TargetRollingWindowSize {
  /**
   * [Required] TargetRollingWindowSize value.
   */
  value: int32;

  /**
   * [Required] TargetRollingWindowSiz detection mode.
   */
  mode: "Custom";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DataDriftMonitoringSignal extends MonitoringSignalBase {
  /**
   * A dictionary that maps feature names to their respective data types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  featureDataTypeOverride?: Record<MonitoringFeatureDataType> | null;

  /**
   * The settings for computing feature importance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  featureImportanceSettings?: FeatureImportanceSettings | null;

  /**
   * The feature filter which identifies which feature to calculate drift over.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  features?: MonitoringFeatureFilterBase | null;

  /**
   * [Required] A list of metrics to calculate and their associated thresholds.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  metricThresholds: DataDriftMetricThresholdBase[];

  /**
   * [Required] The data which drift will be calculated for.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  productionData: MonitoringInputDataBase;

  /**
   * [Required] The data to calculate drift against.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  referenceData: MonitoringInputDataBase;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  signalType: "DataDrift";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model FeatureImportanceSettings {
  /**
   * The mode of operation for computing feature importance.
   */
  mode?: FeatureImportanceMode = FeatureImportanceMode.Disabled;

  /**
   * The name of the target column within the input data asset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  targetColumn?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@removed(Versions.v2025_12_01)
@discriminator("dataGenerationType")
model DataGenerationVertical {
  /**
   * [Required] DataGeneration Task type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataGenerationTaskType: DataGenerationTaskType;

  /**
   * [Required] Enum to determine the type of Data Generation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataGenerationType: DataGenerationType;

  /**
   * Prompt Settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  promptSettings?: PromptSettings | null;

  /**
   * [Required] Teacher Model Endpoint Details.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  teacherModelEndpoint: TeacherModelEndpoint;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  teacherModelSettings?: TeacherModelSettings | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model PromptSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  enableChainOfDensity?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  enableChainOfThought?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  maxLenSummary?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
#suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
model TeacherModelEndpoint {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  endpointName?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model TeacherModelSettings {
  /**
   * Teacher Model Request Settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  teacherModelEndpointRequestSettings?: TeacherModelEndpointRequestSettings | null;

  /**
   * Teacher Model Inference Settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  teacherModelInferenceParameters?: Record<string | null> | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model TeacherModelEndpointRequestSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  minEndpointSuccessRatio?: float64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  requestBatchSize?: int32;
}

/**
 * Reference to an asset via its path in a datastore.
 */
model DataPathAssetReference extends AssetReferenceBase {
  /**
   * ARM resource ID of the datastore where the asset is located.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  datastoreId?: string | null;

  /**
   * The path of the file/directory in the datastore.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  path?: string | null;

  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: "DataPath";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DataQualityMonitoringSignal extends MonitoringSignalBase {
  /**
   * A dictionary that maps feature names to their respective data types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  featureDataTypeOverride?: Record<MonitoringFeatureDataType> | null;

  /**
   * The settings for computing feature importance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  featureImportanceSettings?: FeatureImportanceSettings | null;

  /**
   * The features to calculate drift over.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  features?: MonitoringFeatureFilterBase | null;

  /**
   * [Required] A list of metrics to calculate and their associated thresholds.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  metricThresholds: DataQualityMetricThresholdBase[];

  /**
   * [Required] The data produced by the production service which drift will be calculated for.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  productionData: MonitoringInputDataBase;

  /**
   * [Required] The data to calculate drift against.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  referenceData: MonitoringInputDataBase;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  signalType: "DataQuality";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model DefaultScaleSettings extends OnlineScaleSettings {
  /**
   * [Required] Type of deployment scaling algorithm
   */
  scaleType: "Default";
}

/**
 * Distillation Job definition.
 */
@removed(Versions.v2025_12_01)
model DistillationJob extends JobBaseProperties {
  /**
   * [Required]
   */
  dataGenerationDetails: DataGenerationVertical;

  /**
   * [Required]
   */
  finetuningDetails: FinetuningDetails;

  /**
   * [Required]
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs: Record<JobOutput | null>;

  /**
   * Queue settings for the job
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  queueSettings?: QueueSettings | null;

  /**
   * Instance types and other resources for the job
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resources?: JobResources;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "Distillation";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
@removed(Versions.v2025_12_01)
model FinetuningDetails {
  /**
   * Finetuning Hyperparameters
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  hyperParameters?: Record<string | null> | null;

  /**
   * [Required] Student model for fine tuning.
   */
  studentModel: JobInput;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model JobResources {
  /**
   * List of instance types to choose from.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  instanceTypes?: string[];
}

/**
 * Credential for docker with username and password
 */
model DockerCredential extends DataReferenceCredential {
  /**
   * DockerCredential user password
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @secret
  password?: string | null;

  /**
   * DockerCredential user name
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  userName?: string | null;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialType: "DockerCredentials";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EndpointScheduleAction extends ScheduleActionBase {
  /**
   * [Required] Defines Schedule action definition details.
   * <see href="TBD" />
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  endpointInvocationDefinition: Record<unknown>;

  /**
   * [Required] Specifies the action type of the schedule
   */
  actionType: "InvokeBatchEndpoint";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model FeatureAttributionDriftMonitoringSignal extends MonitoringSignalBase {
  /**
   * A dictionary that maps feature names to their respective data types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  featureDataTypeOverride?: Record<MonitoringFeatureDataType> | null;

  /**
   * [Required] The settings for computing feature importance.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  featureImportanceSettings: FeatureImportanceSettings;

  /**
   * [Required] A list of metrics to calculate and their associated thresholds.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  metricThreshold: FeatureAttributionMetricThreshold;

  /**
   * [Required] The data which drift will be calculated for.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  productionData: MonitoringInputDataBase[];

  /**
   * [Required] The data to calculate drift against.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  referenceData: MonitoringInputDataBase;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  signalType: "FeatureAttributionDrift";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model FeatureAttributionMetricThreshold {
  /**
   * [Required] The feature attribution metric to calculate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  metric: FeatureAttributionMetric;

  /**
   * The threshold value. If null, a default value will be set depending on the selected metric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  threshold?: MonitoringThreshold | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model FeatureSubset extends MonitoringFeatureFilterBase {
  /**
   * [Required] The list of features to include.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  features: string[];

  /**
   * [Required] Specifies the feature filter to leverage when selecting features to calculate metrics over.
   */
  filterType: "FeatureSubset";
}

/**
 * FineTuning Job definition.
 */
@removed(Versions.v2025_12_01)
model FineTuningJob extends JobBaseProperties {
  /**
   * [Required]
   */
  fineTuningDetails: FineTuningVertical;

  /**
   * [Required]
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs: Record<JobOutput | null>;

  /**
   * Queue settings for the job
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  queueSettings?: QueueSettings | null;

  /**
   * Instance types and other resources for the job
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resources?: JobResources;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "FineTuning";
}

/**
 * Fixed input data definition.
 */
model FixedInputData extends MonitoringInputDataBase {
  /**
   * [Required] Specifies the type of signal to monitor.
   */
  inputDataType: "Fixed";
}

/**
 * Forecasting task in AutoML Table vertical.
 */
model Forecasting extends AutoMLVertical {
  ...TableVertical;

  /**
   * Forecasting task specific inputs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  forecastingSettings?: ForecastingSettings | null;

  /**
   * Primary metrics for Forecasting task.
   */
  primaryMetric?: ForecastingPrimaryMetrics = ForecastingPrimaryMetrics.NormalizedRootMeanSquaredError;

  /**
   * Inputs for training phase for an AutoML Job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  trainingSettings?: ForecastingTrainingSettings | null;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "Forecasting";
}

/**
 * Forecasting specific parameters.
 */
model ForecastingSettings {
  /**
   * Country or region for holidays for forecasting tasks.
   * These should be ISO 3166 two-letter country/region codes, for example 'US' or 'GB'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  countryOrRegionForHolidays?: string | null;

  /**
   * Number of periods between the origin time of one CV fold and the next fold. For
   * example, if `CVStepSize` = 3 for daily data, the origin time for each fold will be
   * three days apart.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  cvStepSize?: int32 | null;

  /**
   * Flag for generating lags for the numeric features.
   */
  featureLags?: FeatureLags = FeatureLags.None;

  /**
   * The desired maximum forecast horizon in units of time-series frequency.
   */
  forecastHorizon?: ForecastHorizon = #{ mode: "Custom" };

  /**
   * When forecasting, this parameter represents the period with which the forecast is desired, for example daily, weekly, yearly, etc. The forecast frequency is dataset frequency by default.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  frequency?: string | null;

  /**
   * Set time series seasonality as an integer multiple of the series frequency.
   * If seasonality is set to 'auto', it will be inferred.
   */
  seasonality?: Seasonality;

  /**
   * The parameter defining how if AutoML should handle short time series.
   */
  shortSeriesHandlingConfig?: ShortSeriesHandlingConfiguration = ShortSeriesHandlingConfiguration.Auto;

  /**
   * Target aggregate function.
   */
  targetAggregateFunction?: TargetAggregationFunction = TargetAggregationFunction.None;

  /**
   * The number of past periods to lag from the target column.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  targetLags?: TargetLags | null;

  /**
   * The number of past periods used to create a rolling window average of the target column.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  targetRollingWindowSize?: TargetRollingWindowSize | null;

  /**
   * The name of the time column. This parameter is required when forecasting to specify the datetime column in the input data used for building the time series and inferring its frequency.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  timeColumnName?: string | null;

  /**
   * The names of columns used to group a timeseries. It can be used to create multiple series.
   * If grain is not defined, the data set is assumed to be one time-series. This parameter is used with task type forecasting.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  timeSeriesIdColumnNames?: string[] | null;

  /**
   * Configure STL Decomposition of the time-series target column.
   */
  useStl?: UseStl = UseStl.None;
}

/**
 * Forecasting Training related configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model ForecastingTrainingSettings extends TrainingSettings {
  /**
   * Allowed models for forecasting task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  allowedTrainingAlgorithms?: ForecastingModels[] | null;

  /**
   * Blocked models for forecasting task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  blockedTrainingAlgorithms?: ForecastingModels[] | null;
}

/**
 * Defines a Sampling Algorithm that exhaustively generates every value combination in the space
 */
model GridSamplingAlgorithm extends SamplingAlgorithm {
  /**
   * [Required] The algorithm used for generating hyperparameter values, along with configuration properties
   */
  samplingAlgorithmType: "Grid";
}

/**
 * Image Classification. Multi-class image classification is used when an image is classified with only a single label
 * from a set of classes - e.g. each image is classified as either an image of a 'cat' or a 'dog' or a 'duck'.
 */
model ImageClassification extends AutoMLVertical {
  ...ImageClassificationBase;

  /**
   * Primary metrics for classification tasks.
   */
  primaryMetric?: ClassificationPrimaryMetrics = ClassificationPrimaryMetrics.Accuracy;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "ImageClassification";
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ImageClassificationBase extends ImageVertical {
  /**
   * Settings used for training the model.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelSettings?: ImageModelSettingsClassification | null;

  /**
   * Search space for sampling different combinations of models and their hyperparameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @OpenAPI.extension("x-ms-identifiers", #[])
  searchSpace?: ImageModelDistributionSettingsClassification[] | null;
}

/**
 * Settings used for training the model.
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model ImageModelSettingsClassification extends ImageModelSettings {
  /**
   * Image crop size that is input to the neural network for the training dataset. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  trainingCropSize?: int32 | null;

  /**
   * Image crop size that is input to the neural network for the validation dataset. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationCropSize?: int32 | null;

  /**
   * Image size to which to resize before cropping for validation dataset. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationResizeSize?: int32 | null;

  /**
   * Weighted loss. The accepted values are 0 for no weighted loss.
   * 1 for weighted loss with sqrt.(class_weights). 2 for weighted loss with class_weights. Must be 0 or 1 or 2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  weightedLoss?: int32 | null;
}

/**
 * Settings used for training the model.
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
model ImageModelSettings {
  /**
   * Settings for advanced scenarios.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  advancedSettings?: string | null;

  /**
   * Enable AMSGrad when optimizer is 'adam' or 'adamw'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  amsGradient?: boolean | null;

  /**
   * Settings for using Augmentations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  augmentations?: string | null;

  /**
   * Value of 'beta1' when optimizer is 'adam' or 'adamw'. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  beta1?: float32 | null;

  /**
   * Value of 'beta2' when optimizer is 'adam' or 'adamw'. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  beta2?: float32 | null;

  /**
   * Frequency to store model checkpoints. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  checkpointFrequency?: int32 | null;

  /**
   * The pretrained checkpoint model for incremental training.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  checkpointModel?: MLFlowModelJobInput | null;

  /**
   * The id of a previous run that has a pretrained checkpoint for incremental training.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  checkpointRunId?: string | null;

  /**
   * Whether to use distributed training.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  distributed?: boolean | null;

  /**
   * Enable early stopping logic during training.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  earlyStopping?: boolean | null;

  /**
   * Minimum number of epochs or validation evaluations to wait before primary metric improvement
   * is tracked for early stopping. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  earlyStoppingDelay?: int32 | null;

  /**
   * Minimum number of epochs or validation evaluations with no primary metric improvement before
   * the run is stopped. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  earlyStoppingPatience?: int32 | null;

  /**
   * Enable normalization when exporting ONNX model.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  enableOnnxNormalization?: boolean | null;

  /**
   * Frequency to evaluate validation dataset to get metric scores. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  evaluationFrequency?: int32 | null;

  /**
   * Gradient accumulation means running a configured number of "GradAccumulationStep" steps without
   * updating the model weights while accumulating the gradients of those steps, and then using
   * the accumulated gradients to compute the weight updates. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  gradientAccumulationStep?: int32 | null;

  /**
   * Number of layers to freeze for the model. Must be a positive integer.
   * For instance, passing 2 as value for 'seresnext' means
   * freezing layer0 and layer1. For a full list of models supported and details on layer freeze, please
   * see: https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  layersToFreeze?: int32 | null;

  /**
   * Initial learning rate. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  learningRate?: float32 | null;

  /**
   * Learning rate scheduler enum.
   */
  learningRateScheduler?: LearningRateScheduler = LearningRateScheduler.None;

  /**
   * Name of the model to use for training.
   * For more information on the available models please visit the official documentation:
   * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelName?: string | null;

  /**
   * Value of momentum when optimizer is 'sgd'. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  momentum?: float32 | null;

  /**
   * Enable nesterov when optimizer is 'sgd'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  nesterov?: boolean | null;

  /**
   * Number of training epochs. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  numberOfEpochs?: int32 | null;

  /**
   * Number of data loader workers. Must be a non-negative integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  numberOfWorkers?: int32 | null;

  /**
   * Stochastic optimizer for image models.
   */
  optimizer?: StochasticOptimizer = StochasticOptimizer.None;

  /**
   * Random seed to be used when using deterministic training.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  randomSeed?: int32 | null;

  /**
   * Value of gamma when learning rate scheduler is 'step'. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  stepLRGamma?: float32 | null;

  /**
   * Value of step size when learning rate scheduler is 'step'. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  stepLRStepSize?: int32 | null;

  /**
   * Training batch size. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  trainingBatchSize?: int32 | null;

  /**
   * Validation batch size. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationBatchSize?: int32 | null;

  /**
   * Value of cosine cycle when learning rate scheduler is 'warmup_cosine'. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  warmupCosineLRCycles?: float32 | null;

  /**
   * Value of warmup epochs when learning rate scheduler is 'warmup_cosine'. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  warmupCosineLRWarmupEpochs?: int32 | null;

  /**
   * Value of weight decay when optimizer is 'sgd', 'adam', or 'adamw'. Must be a float in the range[0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  weightDecay?: float32 | null;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model MLFlowModelJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "mlflow_model";
}

/**
 * Distribution expressions to sweep over values of model settings.
 * <example>
 * Some examples are:
 * ```
 * ModelName = "choice('seresnext', 'resnest50')";
 * LearningRate = "uniform(0.001, 0.01)";
 * LayersToFreeze = "choice(0, 2)";
 * ```</example>
 * For more details on how to compose distribution expressions please check the documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model ImageModelDistributionSettingsClassification
  extends ImageModelDistributionSettings {
  /**
   * Image crop size that is input to the neural network for the training dataset. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  trainingCropSize?: string | null;

  /**
   * Image crop size that is input to the neural network for the validation dataset. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationCropSize?: string | null;

  /**
   * Image size to which to resize before cropping for validation dataset. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationResizeSize?: string | null;

  /**
   * Weighted loss. The accepted values are 0 for no weighted loss.
   * 1 for weighted loss with sqrt.(class_weights). 2 for weighted loss with class_weights. Must be 0 or 1 or 2.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  weightedLoss?: string | null;
}

/**
 * Distribution expressions to sweep over values of model settings.
 * <example>
 * Some examples are:
 * ```
 * ModelName = "choice('seresnext', 'resnest50')";
 * LearningRate = "uniform(0.001, 0.01)";
 * LayersToFreeze = "choice(0, 2)";
 * ```</example>
 * All distributions can be specified as distribution_name(min, max) or choice(val1, val2, ..., valn)
 * where distribution name can be: uniform, quniform, loguniform, etc
 * For more details on how to compose distribution expressions please check the documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
model ImageModelDistributionSettings {
  /**
   * Enable AMSGrad when optimizer is 'adam' or 'adamw'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  amsGradient?: string | null;

  /**
   * Settings for using Augmentations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  augmentations?: string | null;

  /**
   * Value of 'beta1' when optimizer is 'adam' or 'adamw'. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  beta1?: string | null;

  /**
   * Value of 'beta2' when optimizer is 'adam' or 'adamw'. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  beta2?: string | null;

  /**
   * Whether to use distributer training.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  distributed?: string | null;

  /**
   * Enable early stopping logic during training.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  earlyStopping?: string | null;

  /**
   * Minimum number of epochs or validation evaluations to wait before primary metric improvement
   * is tracked for early stopping. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  earlyStoppingDelay?: string | null;

  /**
   * Minimum number of epochs or validation evaluations with no primary metric improvement before
   * the run is stopped. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  earlyStoppingPatience?: string | null;

  /**
   * Enable normalization when exporting ONNX model.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  enableOnnxNormalization?: string | null;

  /**
   * Frequency to evaluate validation dataset to get metric scores. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  evaluationFrequency?: string | null;

  /**
   * Gradient accumulation means running a configured number of "GradAccumulationStep" steps without
   * updating the model weights while accumulating the gradients of those steps, and then using
   * the accumulated gradients to compute the weight updates. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  gradientAccumulationStep?: string | null;

  /**
   * Number of layers to freeze for the model. Must be a positive integer.
   * For instance, passing 2 as value for 'seresnext' means
   * freezing layer0 and layer1. For a full list of models supported and details on layer freeze, please
   * see: https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  layersToFreeze?: string | null;

  /**
   * Initial learning rate. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  learningRate?: string | null;

  /**
   * Type of learning rate scheduler. Must be 'warmup_cosine' or 'step'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  learningRateScheduler?: string | null;

  /**
   * Name of the model to use for training.
   * For more information on the available models please visit the official documentation:
   * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelName?: string | null;

  /**
   * Value of momentum when optimizer is 'sgd'. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  momentum?: string | null;

  /**
   * Enable nesterov when optimizer is 'sgd'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  nesterov?: string | null;

  /**
   * Number of training epochs. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  numberOfEpochs?: string | null;

  /**
   * Number of data loader workers. Must be a non-negative integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  numberOfWorkers?: string | null;

  /**
   * Type of optimizer. Must be either 'sgd', 'adam', or 'adamw'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  optimizer?: string | null;

  /**
   * Random seed to be used when using deterministic training.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  randomSeed?: string | null;

  /**
   * Value of gamma when learning rate scheduler is 'step'. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  stepLRGamma?: string | null;

  /**
   * Value of step size when learning rate scheduler is 'step'. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  stepLRStepSize?: string | null;

  /**
   * Training batch size. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  trainingBatchSize?: string | null;

  /**
   * Validation batch size. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationBatchSize?: string | null;

  /**
   * Value of cosine cycle when learning rate scheduler is 'warmup_cosine'. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  warmupCosineLRCycles?: string | null;

  /**
   * Value of warmup epochs when learning rate scheduler is 'warmup_cosine'. Must be a positive integer.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  warmupCosineLRWarmupEpochs?: string | null;

  /**
   * Value of weight decay when optimizer is 'sgd', 'adam', or 'adamw'. Must be a float in the range[0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  weightDecay?: string | null;
}

/**
 * Abstract class for AutoML tasks that train image (computer vision) models -
 * such as Image Classification / Image Classification Multilabel / Image Object Detection / Image Instance Segmentation.
 */
model ImageVertical {
  /**
   * [Required] Limit settings for the AutoML job.
   */
  limitSettings: ImageLimitSettings;

  /**
   * Model sweeping and hyperparameter sweeping related settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  sweepSettings?: ImageSweepSettings | null;

  /**
   * Validation data inputs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationData?: MLTableJobInput | null;

  /**
   * The fraction of training dataset that needs to be set aside for validation purpose.
   * Values between (0.0 , 1.0)
   * Applied when validation dataset is not provided.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationDataSize?: float64 | null;
}

/**
 * Limit settings for the AutoML job.
 */
model ImageLimitSettings {
  /**
   * Maximum number of concurrent AutoML iterations.
   */
  maxConcurrentTrials?: int32 = 1;

  /**
   * Maximum number of AutoML iterations.
   */
  maxTrials?: int32 = 1;

  /**
   * AutoML job timeout.
   */
  timeout?: duration = duration.fromISO("P7D");
}

/**
 * Model sweeping and hyperparameter sweeping related settings.
 */
model ImageSweepSettings {
  /**
   * Type of early termination policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  earlyTermination?: EarlyTerminationPolicy | null;

  /**
   * [Required] Type of the hyperparameter sampling algorithms.
   */
  samplingAlgorithm: SamplingAlgorithmType;
}

/**
 * Image Classification Multilabel. Multi-label image classification is used when an image could have one or more labels
 * from a set of labels - e.g. an image could be labeled with both 'cat' and 'dog'.
 */
model ImageClassificationMultilabel extends AutoMLVertical {
  ...ImageClassificationBase;

  /**
   * Primary metrics for classification multilabel tasks.
   */
  primaryMetric?: ClassificationMultilabelPrimaryMetrics = ClassificationMultilabelPrimaryMetrics.IOU;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "ImageClassificationMultilabel";
}

/**
 * Image Instance Segmentation. Instance segmentation is used to identify objects in an image at the pixel level,
 * drawing a polygon around each object in the image.
 */
model ImageInstanceSegmentation extends AutoMLVertical {
  ...ImageObjectDetectionBase;

  /**
   * Primary metrics for InstanceSegmentation tasks.
   */
  primaryMetric?: InstanceSegmentationPrimaryMetrics = InstanceSegmentationPrimaryMetrics.MeanAveragePrecision;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "ImageInstanceSegmentation";
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ImageObjectDetectionBase extends ImageVertical {
  /**
   * Settings used for training the model.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelSettings?: ImageModelSettingsObjectDetection | null;

  /**
   * Search space for sampling different combinations of models and their hyperparameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  searchSpace?: ImageModelDistributionSettingsObjectDetection[] | null;
}

/**
 * Settings used for training the model.
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model ImageModelSettingsObjectDetection extends ImageModelSettings {
  /**
   * Maximum number of detections per image, for all classes. Must be a positive integer.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  boxDetectionsPerImage?: int32 | null;

  /**
   * During inference, only return proposals with a classification score greater than
   * BoxScoreThreshold. Must be a float in the range[0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  boxScoreThreshold?: float32 | null;

  /**
   * Image size for train and validation. Must be a positive integer.
   * Note: The training run may get into CUDA OOM if the size is too big.
   * Note: This settings is only supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  imageSize?: int32 | null;

  /**
   * Maximum size of the image to be rescaled before feeding it to the backbone.
   * Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  maxSize?: int32 | null;

  /**
   * Minimum size of the image to be rescaled before feeding it to the backbone.
   * Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  minSize?: int32 | null;

  /**
   * Image model size.
   */
  modelSize?: ModelSize = ModelSize.None;

  /**
   * Enable multi-scale image by varying image size by +/- 50%.
   * Note: training run may get into CUDA OOM if no sufficient GPU memory.
   * Note: This settings is only supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  multiScale?: boolean | null;

  /**
   * IOU threshold used during inference in NMS post processing. Must be a float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  nmsIouThreshold?: float32 | null;

  /**
   * The grid size to use for tiling each image. Note: TileGridSize must not be
   * None to enable small object detection logic. A string containing two integers in mxn format.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tileGridSize?: string | null;

  /**
   * Overlap ratio between adjacent tiles in each dimension. Must be float in the range [0, 1).
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tileOverlapRatio?: float32 | null;

  /**
   * The IOU threshold to use to perform NMS while merging predictions from tiles and image.
   * Used in validation/ inference. Must be float in the range [0, 1].
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tilePredictionsNmsThreshold?: float32 | null;

  /**
   * IOU threshold to use when computing validation metric. Must be float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationIouThreshold?: float32 | null;

  /**
   * Metric computation method to use for validation metrics in image tasks.
   */
  validationMetricType?: ValidationMetricType = ValidationMetricType.None;
}

/**
 * Distribution expressions to sweep over values of model settings.
 * <example>
 * Some examples are:
 * ```
 * ModelName = "choice('seresnext', 'resnest50')";
 * LearningRate = "uniform(0.001, 0.01)";
 * LayersToFreeze = "choice(0, 2)";
 * ```</example>
 * For more details on how to compose distribution expressions please check the documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-tune-hyperparameters
 * For more information on the available settings please visit the official documentation:
 * https://docs.microsoft.com/en-us/azure/machine-learning/how-to-auto-train-image-models.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model ImageModelDistributionSettingsObjectDetection
  extends ImageModelDistributionSettings {
  /**
   * Maximum number of detections per image, for all classes. Must be a positive integer.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  boxDetectionsPerImage?: string | null;

  /**
   * During inference, only return proposals with a classification score greater than
   * BoxScoreThreshold. Must be a float in the range[0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  boxScoreThreshold?: string | null;

  /**
   * Image size for train and validation. Must be a positive integer.
   * Note: The training run may get into CUDA OOM if the size is too big.
   * Note: This settings is only supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  imageSize?: string | null;

  /**
   * Maximum size of the image to be rescaled before feeding it to the backbone.
   * Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  maxSize?: string | null;

  /**
   * Minimum size of the image to be rescaled before feeding it to the backbone.
   * Must be a positive integer. Note: training run may get into CUDA OOM if the size is too big.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  minSize?: string | null;

  /**
   * Model size. Must be 'small', 'medium', 'large', or 'xlarge'.
   * Note: training run may get into CUDA OOM if the model size is too big.
   * Note: This settings is only supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  modelSize?: string | null;

  /**
   * Enable multi-scale image by varying image size by +/- 50%.
   * Note: training run may get into CUDA OOM if no sufficient GPU memory.
   * Note: This settings is only supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  multiScale?: string | null;

  /**
   * IOU threshold used during inference in NMS post processing. Must be float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  nmsIouThreshold?: string | null;

  /**
   * The grid size to use for tiling each image. Note: TileGridSize must not be
   * None to enable small object detection logic. A string containing two integers in mxn format.
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tileGridSize?: string | null;

  /**
   * Overlap ratio between adjacent tiles in each dimension. Must be float in the range [0, 1).
   * Note: This settings is not supported for the 'yolov5' algorithm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tileOverlapRatio?: string | null;

  /**
   * The IOU threshold to use to perform NMS while merging predictions from tiles and image.
   * Used in validation/ inference. Must be float in the range [0, 1].
   * Note: This settings is not supported for the 'yolov5' algorithm.
   * NMS: Non-maximum suppression
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tilePredictionsNmsThreshold?: string | null;

  /**
   * IOU threshold to use when computing validation metric. Must be float in the range [0, 1].
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationIouThreshold?: string | null;

  /**
   * Metric computation method to use for validation metrics. Must be 'none', 'coco', 'voc', or 'coco_voc'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationMetricType?: string | null;
}

/**
 * Image Object Detection. Object detection is used to identify objects in an image and locate each object with a
 * bounding box e.g. locate all dogs and cats in an image and draw a bounding box around each.
 */
model ImageObjectDetection extends AutoMLVertical {
  ...ImageObjectDetectionBase;

  /**
   * Primary metrics for Image ObjectDetection task.
   */
  primaryMetric?: ObjectDetectionPrimaryMetrics = ObjectDetectionPrimaryMetrics.MeanAveragePrecision;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "ImageObjectDetection";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model JobScheduleAction extends ScheduleActionBase {
  /**
   * [Required] Defines Schedule action definition details.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  jobDefinition: JobBaseProperties;

  /**
   * [Required] Specifies the action type of the schedule
   */
  actionType: "CreateJob";
}

/**
 * Properties specific to a KubernetesOnlineDeployment.
 */
model KubernetesOnlineDeployment extends OnlineDeploymentProperties {
  /**
   * The resource requirements for the container (cpu and memory).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  containerResourceRequirements?: ContainerResourceRequirements | null;

  /**
   * [Required] The compute type of the endpoint.
   */
  endpointComputeType: "Kubernetes";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model LabelGeneration extends DataGenerationVertical {
  /**
   * Training data for fine tuning.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  trainingData?: JobInput | null;

  /**
   * Validation data for fine tuning.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationData?: JobInput | null;

  /**
   * [Required] Enum to determine the type of Data Generation.
   */
  dataGenerationType: "LabelGeneration";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model LakeHouseArtifact extends OneLakeArtifact {
  /**
   * [Required] OneLake artifact type
   */
  artifactType: "LakeHouse";
}

/**
 * OneLake artifact (data source) configuration.
 */
@discriminator("artifactType")
model OneLakeArtifact {
  /**
   * [Required] OneLake artifact name
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  artifactName: string;

  /**
   * [Required] OneLake artifact type
   */
  artifactType: OneLakeArtifactType;
}

/**
 * Literal input type.
 */
model LiteralJobInput extends JobInput {
  /**
   * [Required] Literal value for the input.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  value: string;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "literal";
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model MLFlowModelJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "mlflow_model";
}

/**
 * MLTable data definition
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model MLTableData extends DataVersionBaseProperties {
  /**
   * Uris referenced in the MLTable definition (required for lineage)
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  referencedUris?: string[] | null;

  /**
   * [Required] Specifies the type of data.
   */
  dataType: "mltable";
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model MLTableJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "mltable";
}

/**
 * Managed compute identity definition.
 */
model ManagedComputeIdentity extends MonitorComputeIdentityBase {
  /**
   * The identity which will be leveraged by the monitoring jobs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity | null;

  /**
   * [Required] Specifies the type of identity to use within the monitoring jobs.
   */
  computeIdentityType: "ManagedIdentity";
}

/**
 * Managed identity configuration.
 */
model ManagedIdentity extends IdentityConfiguration {
  /**
   * Specifies a user-assigned identity by client ID. For system-assigned, do not set this field.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Format not applicable for this property"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  clientId?: Azure.Core.uuid | null;

  /**
   * Specifies a user-assigned identity by object ID. For system-assigned, do not set this field.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Format not applicable for this property"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  objectId?: Azure.Core.uuid | null;

  /**
   * Specifies a user-assigned identity by ARM resource ID. For system-assigned, do not set this field.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resourceId?: string | null;

  /**
   * [Required] Specifies the type of identity framework.
   */
  identityType: "Managed";
}

/**
 * Credential for user managed identity
 */
model ManagedIdentityCredential extends DataReferenceCredential {
  /**
   * ManagedIdentityCredential identity type
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  managedIdentityType?: string | null;

  /**
   * ClientId for the UAMI. For ManagedIdentityType = SystemManaged, this field is null.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  userManagedIdentityClientId?: string | null;

  /**
   * PrincipalId for the UAMI. For ManagedIdentityType = SystemManaged, this field is null.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  userManagedIdentityPrincipalId?: string | null;

  /**
   * Full arm scope for the Id. For ManagedIdentityType = SystemManaged, this field is null.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  userManagedIdentityResourceId?: string | null;

  /**
   * TenantId for the UAMI. For ManagedIdentityType = SystemManaged, this field is null.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  userManagedIdentityTenantId?: string | null;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialType: "ManagedIdentity";
}

/**
 * Properties specific to a ManagedOnlineDeployment.
 */
model ManagedOnlineDeployment extends OnlineDeploymentProperties {
  /**
   * [Required] The compute type of the endpoint.
   */
  endpointComputeType: "Managed";
}

/**
 * Defines an early termination policy based on running averages of the primary metric of all runs
 */
model MedianStoppingPolicy extends EarlyTerminationPolicy {
  /**
   * [Required] Name of policy configuration
   */
  policyType: "MedianStopping";
}

/**
 * Monitor serverless spark compute definition.
 */
model MonitorServerlessSparkCompute extends MonitorComputeConfigurationBase {
  /**
   * [Required] The identity scheme leveraged to by the spark jobs running on serverless Spark.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  computeIdentity: MonitorComputeIdentityBase;

  /**
   * [Required] The instance type running the Spark job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  instanceType: string;

  /**
   * [Required] The Spark runtime version.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("^[0-9]+\\.[0-9]+$")
  runtimeVersion: string;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  computeType: "ServerlessSpark";
}

/**
 * MPI distribution configuration.
 */
model Mpi extends DistributionConfiguration {
  /**
   * Number of processes per MPI node.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  processCountPerInstance?: int32 | null;

  /**
   * [Required] Specifies the type of distribution framework.
   */
  distributionType: "Mpi";
}

/**
 * Abstract class for NLP related AutoML tasks.
 * NLP - Natural Language Processing.
 */
model NlpVertical {
  /**
   * Featurization inputs needed for AutoML job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  featurizationSettings?: NlpVerticalFeaturizationSettings | null;

  /**
   * Execution constraints for AutoMLJob.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  limitSettings?: NlpVerticalLimitSettings | null;

  /**
   * Validation data inputs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  validationData?: MLTableJobInput | null;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Empty model used as placeholder in API"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model NlpVerticalFeaturizationSettings extends FeaturizationSettings {}

/**
 * Job execution constraints.
 */
model NlpVerticalLimitSettings {
  /**
   * Maximum Concurrent AutoML iterations.
   */
  maxConcurrentTrials?: int32 = 1;

  /**
   * Number of AutoML iterations.
   */
  maxTrials?: int32 = 1;

  /**
   * AutoML job timeout.
   */
  timeout?: duration = duration.fromISO("P7D");
}

/**
 * Empty/none datastore credentials.
 */
model NoneDatastoreCredentials extends DatastoreCredentials {
  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: "None";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model NumericalDataDriftMetricThreshold extends DataDriftMetricThresholdBase {
  /**
   * [Required] The numerical data drift metric to calculate.
   */
  metric: NumericalDataDriftMetric;

  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  dataType: "Numerical";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model NumericalDataQualityMetricThreshold
  extends DataQualityMetricThresholdBase {
  /**
   * [Required] The numerical data quality metric to calculate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  metric: NumericalDataQualityMetric;

  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  dataType: "Numerical";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model NumericalPredictionDriftMetricThreshold
  extends PredictionDriftMetricThresholdBase {
  /**
   * [Required] The numerical prediction drift metric to calculate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  metric: NumericalPredictionDriftMetric;

  /**
   * [Required] Specifies the data type of the metric threshold.
   */
  dataType: "Numerical";
}

/**
 * Optimization objective.
 */
model Objective {
  /**
   * [Required] Defines supported metric goals for hyperparameter tuning
   */
  goal: Goal;

  /**
   * [Required] Name of the metric to optimize.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  primaryMetric: string;
}

/**
 * OneLake (Trident) datastore configuration.
 */
model OneLakeDatastore extends DatastoreProperties {
  /**
   * [Required] OneLake artifact backing the datastore.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  artifact: OneLakeArtifact;

  /**
   * OneLake endpoint to use for the datastore.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string | null;

  /**
   * [Required] OneLake workspace name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  oneLakeWorkspaceName: string;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity = ServiceDataAccessAuthIdentity.None;

  /**
   * [Required] Storage type backing the datastore.
   */
  datastoreType: "OneLake";
}

/**
 * Reference to an asset via its path in a job output.
 */
model OutputPathAssetReference extends AssetReferenceBase {
  /**
   * ARM resource ID of the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  jobId?: string | null;

  /**
   * The path of the file/directory in the job output.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  path?: string | null;

  /**
   * [Required] Specifies the type of asset reference.
   */
  referenceType: "OutputPath";
}

/**
 * Pipeline Job definition: defines generic to MFE attributes.
 */
model PipelineJob extends JobBaseProperties {
  /**
   * Inputs for the pipeline job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputs?: Record<JobInput | null> | null;

  /**
   * Jobs construct the Pipeline Job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobs?: Record<unknown | null> | null;

  /**
   * Outputs for the pipeline job
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput | null> | null;

  /**
   * Pipeline settings, for things like ContinueRunOnStepFailure etc.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  settings?: unknown | null;

  /**
   * ARM resource ID of source job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceJobId?: string | null;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "Pipeline";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model PredictionDriftMonitoringSignal extends MonitoringSignalBase {
  /**
   * A dictionary that maps feature names to their respective data types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  featureDataTypeOverride?: Record<MonitoringFeatureDataType> | null;

  /**
   * [Required] A list of metrics to calculate and their associated thresholds.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  metricThresholds: PredictionDriftMetricThresholdBase[];

  /**
   * [Required] The data which drift will be calculated for.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  productionData: MonitoringInputDataBase;

  /**
   * [Required] The data to calculate drift against.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  referenceData: MonitoringInputDataBase;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  signalType: "PredictionDrift";
}

/**
 * PyTorch distribution configuration.
 */
model PyTorch extends DistributionConfiguration {
  /**
   * Number of processes per node.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  processCountPerInstance?: int32 | null;

  /**
   * [Required] Specifies the type of distribution framework.
   */
  distributionType: "PyTorch";
}

/**
 * Defines a Sampling Algorithm that generates values randomly
 */
model RandomSamplingAlgorithm extends SamplingAlgorithm {
  /**
   * The specific type of random algorithm
   */
  rule?: RandomSamplingAlgorithmRule = RandomSamplingAlgorithmRule.Random;

  /**
   * An optional integer to use as the seed for random number generation
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  seed?: int32 | null;

  /**
   * [Required] The algorithm used for generating hyperparameter values, along with configuration properties
   */
  samplingAlgorithmType: "Random";
}

/**
 * Regression task in AutoML Table vertical.
 */
model Regression extends AutoMLVertical {
  ...TableVertical;

  /**
   * Primary metrics for Regression task.
   */
  primaryMetric?: RegressionPrimaryMetrics = RegressionPrimaryMetrics.NormalizedRootMeanSquaredError;

  /**
   * Inputs for training phase for an AutoML Job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  trainingSettings?: RegressionTrainingSettings | null;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "Regression";
}

/**
 * Regression Training related configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Existing API uses inheritance pattern"
model RegressionTrainingSettings extends TrainingSettings {
  /**
   * Allowed models for regression task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  allowedTrainingAlgorithms?: RegressionModels[] | null;

  /**
   * Blocked models for regression task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  blockedTrainingAlgorithms?: RegressionModels[] | null;
}

/**
 * Rolling input data definition.
 */
model RollingInputData extends MonitoringInputDataBase {
  /**
   * Reference to the component asset used to preprocess the data.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  preprocessingComponentId?: string | null;

  /**
   * [Required] The time offset between the end of the data window and the monitor's current run time.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  windowOffset: duration;

  /**
   * [Required] The size of the rolling data window.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  windowSize: duration;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  inputDataType: "Rolling";
}

/**
 * Access with full SAS uri
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model SASCredential extends DataReferenceCredential {
  /**
   * Full SAS Uri, including the storage, container/blob path and SAS token
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  sasUri?: url | null;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialType: "SAS";
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model SASCredentialDto extends PendingUploadCredentialDto {
  /**
   * Full SAS Uri, including the storage, container/blob path and SAS token
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @secret
  sasUri?: url | null;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialType: "SAS";
}

/**
 * SAS datastore credentials configuration.
 */
model SasDatastoreCredentials extends DatastoreCredentials {
  /**
   * [Required] Storage container secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  secrets: SasDatastoreSecrets;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: "Sas";
}

/**
 * Datastore SAS secrets.
 */
model SasDatastoreSecrets extends DatastoreSecrets {
  /**
   * Storage container SAS token.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  sasToken?: string | null;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  secretsType: "Sas";
}

/**
 * Service Principal datastore credentials configuration.
 */
model ServicePrincipalDatastoreCredentials extends DatastoreCredentials {
  /**
   * Authority URL used for authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  authorityUrl?: string | null;

  /**
   * [Required] Service principal client ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Format not applicable for this property"
  clientId: Azure.Core.uuid;

  /**
   * Resource the service principal has access to.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  resourceUrl?: string | null;

  /**
   * [Required] Service principal secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  secrets: ServicePrincipalDatastoreSecrets;

  /**
   * [Required] ID of the tenant to which the service principal belongs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Format not applicable for this property"
  tenantId: Azure.Core.uuid;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  credentialsType: "ServicePrincipal";
}

/**
 * Datastore Service Principal secrets.
 */
model ServicePrincipalDatastoreSecrets extends DatastoreSecrets {
  /**
   * Service principal secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  clientSecret?: string | null;

  /**
   * [Required] Credential type used to authentication with storage.
   */
  secretsType: "ServicePrincipal";
}

/**
 * Spark job definition.
 */
model SparkJob extends JobBaseProperties {
  /**
   * Archive files used in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  archives?: string[] | null;

  /**
   * Arguments for the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  args?: string | null;

  /**
   * [Required] arm-id of the code asset.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  codeId: Azure.Core.armResourceIdentifier;

  /**
   * Spark configured properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  conf?: Record<string | null> | null;

  /**
   * [Required] The entry to execute on startup of the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  entry: SparkJobEntry;

  /**
   * The ARM resource ID of the Environment specification for the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentId?: Azure.Core.armResourceIdentifier | null;

  /**
   * Environment variables included in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentVariables?: Record<string | null> | null;

  /**
   * Files used in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  files?: string[] | null;

  /**
   * Mapping of input data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputs?: Record<JobInput | null> | null;

  /**
   * Jar files used in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jars?: string[] | null;

  /**
   * Mapping of output data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput | null> | null;

  /**
   * Python files used in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  pyFiles?: string[] | null;

  /**
   * Queue settings for the job
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  queueSettings?: QueueSettings | null;

  /**
   * Compute Resource configuration for the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resources?: SparkResourceConfiguration | null;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "Spark";
}

/**
 * Spark job entry point definition.
 */
@discriminator("sparkJobEntryType")
model SparkJobEntry {
  /**
   * [Required] Type of the job's entry point.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sparkJobEntryType: SparkJobEntryType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model SparkResourceConfiguration {
  /**
   * Optional type of VM used as supported by the compute target.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  instanceType?: string | null;

  /**
   * Version of spark runtime used for the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  runtimeVersion?: string = "3.1";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model SparkJobPythonEntry extends SparkJobEntry {
  /**
   * [Required] Relative python file path for job entry point.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  file: string;

  /**
   * [Required] Type of the job's entry point.
   */
  sparkJobEntryType: "SparkJobPythonEntry";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model SparkJobScalaEntry extends SparkJobEntry {
  /**
   * [Required] Scala class name used as entry point.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  className: string;

  /**
   * [Required] Type of the job's entry point.
   */
  sparkJobEntryType: "SparkJobScalaEntry";
}

/**
 * Static input data definition.
 */
model StaticInputData extends MonitoringInputDataBase {
  /**
   * Reference to the component asset used to preprocess the data.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  preprocessingComponentId?: string | null;

  /**
   * [Required] The end date of the data window.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  windowEnd: utcDateTime;

  /**
   * [Required] The start date of the data window.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  windowStart: utcDateTime;

  /**
   * [Required] Specifies the type of signal to monitor.
   */
  inputDataType: "Static";
}

/**
 * Sweep job definition.
 */
model SweepJob extends JobBaseProperties {
  /**
   * Early termination policies enable canceling poor-performing runs before they complete
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  earlyTermination?: EarlyTerminationPolicy | null;

  /**
   * Mapping of input data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputs?: Record<JobInput | null> | null;

  /**
   * Sweep Job limit.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  limits?: SweepJobLimits;

  /**
   * [Required] Optimization objective.
   */
  objective: Objective;

  /**
   * Mapping of output data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput | null> | null;

  /**
   * Queue settings for the job
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  queueSettings?: QueueSettings | null;

  /**
   * [Required] The hyperparameter sampling algorithm
   */
  samplingAlgorithm: SamplingAlgorithm;

  /**
   * [Required] A dictionary containing each parameter and its distribution. The dictionary key is the name of the parameter
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is intentionally dynamic in existing API"
  searchSpace: unknown;

  /**
   * [Required] Trial component definition.
   */
  trial: TrialComponent;

  /**
   * [Required] Specifies the type of job.
   */
  jobType: "Sweep";
}

/**
 * Sweep Job limit class.
 */
model SweepJobLimits extends JobLimits {
  /**
   * Sweep Job max concurrent trials.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  maxConcurrentTrials?: int32 | null;

  /**
   * Sweep Job max total trials.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  maxTotalTrials?: int32 | null;

  /**
   * Sweep Job Trial timeout value.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  trialTimeout?: duration | null;

  /**
   * [Required] JobLimit type.
   */
  jobLimitsType: "Sweep";
}

/**
 * Trial component definition.
 */
model TrialComponent {
  /**
   * ARM resource ID of the code asset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  codeId?: string | null;

  /**
   * [Required] The command to execute on startup of the job. eg. "python train.py"
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  command: string;

  /**
   * Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  distribution?: DistributionConfiguration | null;

  /**
   * [Required] The ARM resource ID of the Environment specification for the job.
   */
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  environmentId: string;

  /**
   * Environment variables included in the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentVariables?: Record<string | null> | null;

  /**
   * Compute Resource configuration for the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resources?: JobResourceConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model TargetUtilizationScaleSettings extends OnlineScaleSettings {
  /**
   * The maximum number of instances that the deployment can scale to. The quota will be reserved for max_instances.
   */
  maxInstances?: int32 = 1;

  /**
   * The minimum number of instances to always be present.
   */
  minInstances?: int32 = 1;

  /**
   * The polling interval in ISO 8691 format. Only supports duration with precision as low as Seconds.
   */
  pollingInterval?: duration = duration.fromISO("PT1S");

  /**
   * Target CPU usage for the autoscaler.
   */
  targetUtilizationPercentage?: int32 = 70;

  /**
   * [Required] Type of deployment scaling algorithm
   */
  scaleType: "TargetUtilization";
}

/**
 * TensorFlow distribution configuration.
 */
model TensorFlow extends DistributionConfiguration {
  /**
   * Number of parameter server tasks.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  parameterServerCount?: int32 = 0;

  /**
   * Number of workers. If not specified, will default to the instance count.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  workerCount?: int32 | null;

  /**
   * [Required] Specifies the type of distribution framework.
   */
  distributionType: "TensorFlow";
}

/**
 * Text Classification task in AutoML NLP vertical.
 * NLP - Natural Language Processing.
 */
model TextClassification extends AutoMLVertical {
  ...NlpVertical;

  /**
   * Primary metrics for classification tasks.
   */
  primaryMetric?: ClassificationPrimaryMetrics = ClassificationPrimaryMetrics.Accuracy;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "TextClassification";
}

/**
 * Text Classification Multilabel task in AutoML NLP vertical.
 * NLP - Natural Language Processing.
 */
model TextClassificationMultilabel extends AutoMLVertical {
  ...NlpVertical;

  /**
   * Primary metric for Text-Classification-Multilabel task.
   * Currently only Accuracy is supported as primary metric, hence user need not set it explicitly.
   */
  @visibility(Lifecycle.Read)
  primaryMetric?: ClassificationMultilabelPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "TextClassificationMultilabel";
}

/**
 * Text-NER task in AutoML NLP vertical.
 * NER - Named Entity Recognition.
 * NLP - Natural Language Processing.
 */
model TextNer extends AutoMLVertical {
  ...NlpVertical;

  /**
   * Primary metric for Text-NER task.
   * Only 'Accuracy' is supported for Text-NER, so user need not set this explicitly.
   */
  @visibility(Lifecycle.Read)
  primaryMetric?: ClassificationPrimaryMetrics;

  /**
   * [Required] Task type for AutoMLJob.
   */
  taskType: "TextNER";
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model TopNFeaturesByAttribution extends MonitoringFeatureFilterBase {
  /**
   * The number of top features to include.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  top?: int32 = 10;

  /**
   * [Required] Specifies the feature filter to leverage when selecting features to calculate metrics over.
   */
  filterType: "TopNByAttribution";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model TritonModelJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "triton_model";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model TritonModelJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "triton_model";
}

/**
 * Defines an early termination policy that cancels a given percentage of runs at each evaluation interval.
 */
model TruncationSelectionPolicy extends EarlyTerminationPolicy {
  /**
   * The percentage of runs to cancel at each evaluation interval.
   */
  truncationPercentage?: int32 = 0;

  /**
   * [Required] Name of policy configuration
   */
  policyType: "TruncationSelection";
}

/**
 * uri-file data version entity
 */
model UriFileDataVersion extends DataVersionBaseProperties {
  /**
   * [Required] Specifies the type of data.
   */
  dataType: "uri_file";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model UriFileJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "uri_file";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model UriFileJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "uri_file";
}

/**
 * uri-folder data version entity
 */
model UriFolderDataVersion extends DataVersionBaseProperties {
  /**
   * [Required] Specifies the type of data.
   */
  dataType: "uri_folder";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model UriFolderJobInput extends JobInput {
  ...AssetJobInput;

  /**
   * [Required] Specifies the type of job.
   */
  jobInputType: "uri_folder";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model UriFolderJobOutput extends JobOutput {
  ...AssetJobOutput;

  /**
   * [Required] Specifies the type of job.
   */
  jobOutputType: "uri_folder";
}

/**
 * User identity configuration.
 */
model UserIdentity extends IdentityConfiguration {
  /**
   * [Required] Specifies the type of identity framework.
   */
  identityType: "UserIdentity";
}

/**
 * This connection type covers the AAD auth for any applicable Azure service
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model AADAuthTypeWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  /**
   * Authentication type of the connection target
   */
  authType: "AAD";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model AccessKeyAuthTypeWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  credentials?: WorkspaceConnectionAccessKey;

  /**
   * Authentication type of the connection target
   */
  authType: "AccessKey";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model WorkspaceConnectionAccessKey {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  accessKeyId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Secret property is part of existing API contract"
  secretAccessKey?: string;
}

/**
 * This connection type covers the account key connection for Azure storage
 */
model AccountKeyAuthTypeWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  /**
   * Account key object for workspace connection credential.
   */
  credentials?: WorkspaceConnectionAccountKey;

  /**
   * Authentication type of the connection target
   */
  authType: "AccountKey";
}

/**
 * Account key object for workspace connection credential.
 */
model WorkspaceConnectionAccountKey {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Secret property is part of existing API contract"
  key?: string;
}

/**
 * This connection type covers the generic ApiKey auth connection categories, for examples:
 * AzureOpenAI:
 *     Category:= AzureOpenAI
 *     AuthType:= ApiKey (as type discriminator)
 *     Credentials:= {ApiKey} as Microsoft.MachineLearning.AccountRP.Contracts.WorkspaceConnection.ApiKey
 *     Target:= {ApiBase}
 *
 * CognitiveService:
 *     Category:= CognitiveService
 *     AuthType:= ApiKey (as type discriminator)
 *     Credentials:= {SubscriptionKey} as Microsoft.MachineLearning.AccountRP.Contracts.WorkspaceConnection.ApiKey
 *     Target:= ServiceRegion={serviceRegion}
 *
 * CognitiveSearch:
 *     Category:= CognitiveSearch
 *     AuthType:= ApiKey (as type discriminator)
 *     Credentials:= {Key} as Microsoft.MachineLearning.AccountRP.Contracts.WorkspaceConnection.ApiKey
 *     Target:= {Endpoint}
 *
 * Use Metadata property bag for ApiType, ApiVersion, Kind and other metadata fields
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ApiKeyAuthWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  credentials?: WorkspaceConnectionApiKey;

  /**
   * Authentication type of the connection target
   */
  authType: "ApiKey";
}

/**
 * Api key object for workspace connection credential.
 */
model WorkspaceConnectionApiKey {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Secret property is part of existing API contract"
  key?: string;
}

/**
 * The capacity configuration.
 */
model CapacityConfig {
  /**
   * The minimum capacity.
   */
  minimum?: int32;

  /**
   * The maximum capacity.
   */
  maximum?: int32;

  /**
   * The minimal incremental between allowed values for capacity.
   */
  step?: int32;

  /**
   * The default capacity.
   */
  default?: int32;

  /**
   * The array of allowed values for capacity.
   */
  allowedValues?: int32[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CognitiveServiceEndpointDeploymentResourceProperties {
  /**
   * Model used for the endpoint deployment.
   */
  `model`: EndpointDeploymentModel;

  /**
   * The name of RAI policy.
   */
  raiPolicyName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  sku?: CognitiveServicesSku;

  /**
   * Deployment model version upgrade option.
   */
  versionUpgradeOption?: DeploymentModelVersionUpgradeOption;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model EndpointDeploymentModel {
  /**
   * Model format
   */
  format?: string;

  /**
   * Model name.
   */
  name?: string;

  /**
   * Optional. Deployment model source ARM resource ID.
   */
  source?: string;

  /**
   * Model version.
   */
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CognitiveServicesSku {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  capacity?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  family?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  size?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  tier?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ServerlessEndpointContentSafety {
  /**
   * Specifies the status of content safety.
   */
  contentSafetyStatus: ContentSafetyStatus;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ContentSafetyEndpointDeploymentResourceProperties
  extends EndpointDeploymentResourceProperties {
  ...CognitiveServiceEndpointDeploymentResourceProperties;

  /**
   * Kind of the deployment.
   */
  type: "Azure.ContentSafety";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ContentSafetyEndpointResourceProperties
  extends EndpointResourceProperties {
  /**
   * Type of the endpoint.
   */
  endpointType: "Azure.ContentSafety";
}

/**
 * Custom Keys credential object
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CustomKeys {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  keys?: Record<string>;
}

/**
 * Category:= CustomKeys
 * AuthType:= CustomKeys (as type discriminator)
 * Credentials:= {CustomKeys} as Microsoft.MachineLearning.AccountRP.Contracts.WorkspaceConnection.CustomKeys
 * Target:= {any value}
 * Use Metadata property bag for ApiVersion and other metadata fields
 */
model CustomKeysWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  /**
   * Custom Keys credential object
   */
  credentials?: CustomKeys;

  /**
   * Authentication type of the connection target
   */
  authType: "CustomKeys";
}

/**
 * FQDN Outbound Rule for the managed network of a machine learning workspace.
 */
model FqdnOutboundRule extends OutboundRule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  destination?: string;

  /**
   * Type of a managed network Outbound Rule of a machine learning workspace.
   */
  type: "FQDN";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ManagedIdentityAuthTypeWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  credentials?: WorkspaceConnectionManagedIdentity;

  /**
   * Authentication type of the connection target
   */
  authType: "ManagedIdentity";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model WorkspaceConnectionManagedIdentity {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  clientId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  resourceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ManagedOnlineEndpointDeploymentResourceProperties
  extends EndpointDeploymentResourceProperties {
  /**
   * Enum to determine endpoint compute type.
   */
  endpointComputeType?: EndpointComputeType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  `model`?: string;

  /**
   * Kind of the deployment.
   */
  type: "managedOnlineEndpoint";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ManagedOnlineEndpointResourceProperties
  extends EndpointResourceProperties {
  /**
   * Enum to determine endpoint authentication mode.
   */
  authMode?: EndpointAuthMode;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  compute?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  description?: string;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  mirrorTraffic?: Record<int32>;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  scoringUri?: url;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  traffic?: Record<int32>;

  /**
   * Type of the endpoint.
   */
  endpointType: "managedOnlineEndpoint";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ServerlessEndpointModelSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  modelId: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model NoneAuthTypeWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  /**
   * Authentication type of the connection target
   */
  authType: "None";
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model OAuth2AuthTypeWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  credentials?: WorkspaceConnectionOAuth2;

  /**
   * Authentication type of the connection target
   */
  authType: "OAuth2";
}

/**
 * ClientId and ClientSecret are required. Other properties are optional
 * depending on each OAuth2 provider's implementation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
model WorkspaceConnectionOAuth2 {
  /**
   * Required by Concur connection category
   */
  authUrl?: url;

  /**
   * Client id in the format of UUID
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Format not applicable for this property"
  clientId?: Azure.Core.uuid;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @secret
  clientSecret?: string;

  /**
   * Required by GoogleAdWords connection category
   */
  @secret
  developerToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @secret
  password?: string;

  /**
   * Required by GoogleBigQuery, GoogleAdWords, Hubspot, QuickBooks, Square, Xero, Zoho
   * where user needs to get RefreshToken offline
   */
  @secret
  refreshToken?: string;

  /**
   * Required by QuickBooks and Xero connection categories
   */
  tenantId?: string;

  /**
   * Concur, ServiceNow auth server AccessToken grant type is 'Password'
   * which requires UsernamePassword
   */
  username?: string;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model OpenAIEndpointDeploymentResourceProperties
  extends EndpointDeploymentResourceProperties {
  ...CognitiveServiceEndpointDeploymentResourceProperties;

  /**
   * Kind of the deployment.
   */
  type: "Azure.OpenAI";
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model OpenAIEndpointResourceProperties extends EndpointResourceProperties {
  /**
   * Type of the endpoint.
   */
  endpointType: "Azure.OpenAI";
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model PATAuthTypeWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  credentials?: WorkspaceConnectionPersonalAccessToken;

  /**
   * Authentication type of the connection target
   */
  authType: "PAT";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model WorkspaceConnectionPersonalAccessToken {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  pat?: string;
}

/**
 * Private Endpoint destination for a Private Endpoint Outbound Rule for the managed network of a machine learning workspace.
 */
model PrivateEndpointDestination {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  serviceResourceId?: Azure.Core.armResourceIdentifier;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  sparkEnabled?: boolean;

  /**
   * Type of a managed network Outbound Rule of a machine learning workspace.
   */
  sparkStatus?: RuleStatus;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  subresourceTarget?: string;
}

/**
 * Private Endpoint Outbound Rule for the managed network of a machine learning workspace.
 */
model PrivateEndpointOutboundRule extends OutboundRule {
  /**
   * Private Endpoint destination for a Private Endpoint Outbound Rule for the managed network of a machine learning workspace.
   */
  destination?: PrivateEndpointDestination;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  fqdns?: string[];

  /**
   * Type of a managed network Outbound Rule of a machine learning workspace.
   */
  type: "PrivateEndpoint";
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model SASAuthTypeWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  credentials?: WorkspaceConnectionSharedAccessSignature;

  /**
   * Authentication type of the connection target
   */
  authType: "SAS";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model WorkspaceConnectionSharedAccessSignature {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  sas?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ServerlessEndpointCapacityReservation {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  capacityReservationGroupId: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  endpointReservedCapacity?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ServerlessEndpointResourceProperties extends EndpointResourceProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  authMode?: ServerlessInferenceEndpointAuthMode;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  capacityReservation?: ServerlessEndpointCapacityReservation;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  contentSafety?: ServerlessEndpointContentSafety;

  /**
   * State of the Serverless Endpoint.
   */
  endpointState?: ServerlessEndpointState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  inferenceEndpoint?: ServerlessEndpointInferenceEndpoint;
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is intentionally dynamic in existing API"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is intentionally dynamic in existing API"
  marketplaceSubscriptionId?: string;
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Type is intentionally dynamic in existing API"
  metadata?: unknown;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  modelSettings?: ServerlessEndpointModelSettings;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  offer?: ServerlessOffer;

  /**
   * Type of the endpoint.
   */
  endpointType: "serverlessEndpoint";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ServerlessEndpointInferenceEndpoint {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  @visibility(Lifecycle.Read)
  headers?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @visibility(Lifecycle.Read)
  uri: url;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ServerlessOffer {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  offerName: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  publisher: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model ServicePrincipalAuthTypeWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  credentials?: WorkspaceConnectionServicePrincipal;

  /**
   * Authentication type of the connection target
   */
  authType: "ServicePrincipal";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model WorkspaceConnectionServicePrincipal {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  clientId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @secret
  clientSecret?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  tenantId?: string;
}

/**
 * Service Tag destination for a Service Tag Outbound Rule for the managed network of a machine learning workspace.
 */
model ServiceTagDestination {
  /**
   * The action enum for networking rule.
   */
  action?: RuleAction;

  /**
   * Optional, if provided, the ServiceTag property will be ignored.
   */
  addressPrefixes?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  portRanges?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  protocol?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  serviceTag?: string;
}

/**
 * Service Tag Outbound Rule for the managed network of a machine learning workspace.
 */
model ServiceTagOutboundRule extends OutboundRule {
  /**
   * Service Tag destination for a Service Tag Outbound Rule for the managed network of a machine learning workspace.
   */
  destination?: ServiceTagDestination;

  /**
   * Type of a managed network Outbound Rule of a machine learning workspace.
   */
  type: "ServiceTag";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model SpeechEndpointDeploymentResourceProperties
  extends EndpointDeploymentResourceProperties {
  ...CognitiveServiceEndpointDeploymentResourceProperties;

  /**
   * Kind of the deployment.
   */
  type: "Azure.Speech";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model SpeechEndpointResourceProperties extends EndpointResourceProperties {
  /**
   * Type of the endpoint.
   */
  endpointType: "Azure.Speech";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model UsernamePasswordAuthTypeWorkspaceConnectionProperties
  extends WorkspaceConnectionPropertiesV2 {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  credentials?: WorkspaceConnectionUsernamePassword;

  /**
   * Authentication type of the connection target
   */
  authType: "UsernamePassword";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model WorkspaceConnectionUsernamePassword {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @secret
  password?: string;

  /**
   * Optional, required by connections like SalesForce for extra security in addition to UsernamePassword
   */
  @secret
  securityToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  username?: string;
}
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
//Fix Me: Compile Error
model InferenceUpdateParameterProperties {
  description?: string;
}
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
//Fix Me: Compile Error
model InferenceUpdateParameter {
  properties: InferenceUpdateParameterProperties;
}

alias ReferenceSASParameters = {
  ...ResourceInstanceParameters<Registry>;

  /**
   * Data reference name.
   */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
  @path
  @segment("datareferences")
  name: string;

  /**
   * Version identifier.
   */
  @path
  @segment("versions")
  version: string;

  /**
   * Asset id and blob uri.
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @body
  body: GetBlobReferenceSASRequestDto;
};

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
model CustomLocationParameter {
  @path
  @segment("locations")
  @doc("The location name.")
  @pattern("^[-\\w\\._]+$")
  location: string;
}

model ManagedNetworkListResult
  is Azure.Core.Page<ManagedNetworkSettingsPropertiesBasicResource>;

model OutboundRuleListResult is Azure.Core.Page<OutboundRuleBasicResource>;

@@visibility(ListAmlUserFeatureResult.value, Lifecycle.Read);
@@visibility(ListUsagesResult.value, Lifecycle.Read);
@@visibility(ListWorkspaceQuotas.value, Lifecycle.Read);
