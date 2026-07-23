import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureArcData;

/**
 * A list of SqlManagedInstance.
 */
model SqlManagedInstanceListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlManagedInstance[];

  /**
   * Link to retrieve next page of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: url;
}

/**
 * Result of the request to list Azure Data Services on Azure Arc operations.
 */
model OperationListResult {
  /**
   * Array of results.
   */
  @identifiers(#["name"])
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Operation[];

  /**
   * Link to retrieve next page of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}
/**
 * A list of failover groups
 */
model FailoverGroupListResult {
  /**
   * Array of failover group results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: FailoverGroupResource[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * A list of active directory connectors
 */
model ActiveDirectoryConnectorListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ActiveDirectoryConnectorResource[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * A list of Arc Sql Server database.
 */
model ArcSqlServerDatabaseListResult {
  /**
   * Array of  Arc Sql Server database.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlServerDatabaseResource[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * A list of Arc Sql Server Availability Groups.
 */
model ArcSqlServerAvailabilityGroupListResult {
  /**
   * Array of Arc Sql Server Availability Groups.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlServerAvailabilityGroupResource[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * A list of SqlServerInstance.
 */
model SqlServerInstanceListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlServerInstance[];

  /**
   * Link to retrieve next page of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: url;
}

/**
 * A list of SQL Server licenses.
 */
model SqlServerLicenseListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlServerLicense[];

  /**
   * Link to retrieve next page of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: url;
}

/**
 * A list of SQL Server ESU licenses.
 */
model SqlServerEsuLicenseListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SqlServerEsuLicense[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * A list of PostgresInstance.
 */
model PostgresInstanceListResult {
  /**
   * Array of results.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: PostgresInstance[];

  /**
   * Link to retrieve next page of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: url;
}
/**
 * The intended executor of the operation.
 */
union OperationOrigin {
  string,

  /**
   * user
   */
  User: "user",

  /**
   * system
   */
  System: "system",
}

/**
 * The license type to apply for this managed instance.
 */
union ArcSqlManagedInstanceLicenseType {
  string,

  /**
   * BasePrice
   */
  BasePrice: "BasePrice",

  /**
   * LicenseIncluded
   */
  LicenseIncluded: "LicenseIncluded",

  /**
   * DisasterRecovery
   */
  DisasterRecovery: "DisasterRecovery",
}

/**
 * The type of extendedLocation.
 */
union ExtendedLocationTypes {
  string,

  /**
   * CustomLocation
   */
  CustomLocation: "CustomLocation",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * The provisioning state of the failover group resource.
 */
union ProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Accepted
   */
  Accepted: "Accepted",
}

/**
 * The partner sync mode of the SQL managed instance.
 */
union FailoverGroupPartnerSyncMode {
  string,

  /**
   * async
   */
  Async: "async",

  /**
   * sync
   */
  Sync: "sync",
}

/**
 * The role of the SQL managed instance in this failover group.
 */
union InstanceFailoverGroupRole {
  string,

  /**
   * primary
   */
  Primary: "primary",

  /**
   * secondary
   */
  Secondary: "secondary",

  /**
   * force-primary-allow-data-loss
   */
  ForcePrimaryAllowDataLoss: "force-primary-allow-data-loss",

  /**
   * force-secondary
   */
  ForceSecondary: "force-secondary",
}

/**
 * SQL Server version.
 */
union SqlVersion {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * SQL Server 2012
   */
  SQLServer2012: "SQL Server 2012",

  /**
   * SQL Server 2014
   */
  SQLServer2014: "SQL Server 2014",

  /**
   * SQL Server 2016
   */
  SQLServer2016: "SQL Server 2016",

  /**
   * SQL Server 2017
   */
  SQLServer2017: "SQL Server 2017",

  /**
   * SQL Server 2019
   */
  SQLServer2019: "SQL Server 2019",

  /**
   * SQL Server 2022
   */
  SQLServer2022: "SQL Server 2022",

  /**
   * SQL Server 2025
   */
  SQLServer2025: "SQL Server 2025",
}

/**
 * SQL Server edition.
 */
union EditionType {
  string,

  /**
   * Evaluation
   */
  Evaluation: "Evaluation",

  /**
   * Enterprise
   */
  Enterprise: "Enterprise",

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Web
   */
  Web: "Web",

  /**
   * Developer
   */
  Developer: "Developer",

  /**
   * Express
   */
  Express: "Express",

  /**
   * Business Intelligence
   */
  BusinessIntelligence: "Business Intelligence",

  /**
   * Standard Developer
   */
  StandardDeveloper: "Standard Developer",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * The cloud connectivity status.
 */
union ConnectionStatus {
  string,

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",

  /**
   * Registered
   */
  Registered: "Registered",

  /**
   * Discovered
   */
  Discovered: "Discovered",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Indicates the discovery agent or client for this instance.
 */
union DiscoverySource {
  string,

  /**
   * Instance is discovered by Azure Arc enabled agent/extensions.
   */
  AzureArc: "Azure Arc",

  /**
   * Instance is discovered by Azure Migrate agent.
   */
  AzureMigrate: "Azure Migrate",

  /**
   * Instance is discovered/registered from Azure Data Studio (ADS).
   */
  ADS: "ADS",

  /**
   * Instance is discovered/registered from SQL Server Management Studio (SSMS).
   */
  Ssms: "SSMS",

  /**
   * Instance is discovered/registered from SQL Server Migration Assistant (SSMA).
   */
  Ssma: "SSMA",

  /**
   * Instance is registered via Import.
   */
  Import: "Import",

  /**
   * Instance is discovered/registered from Azure Database Migration Service(DMS) Azure Portal.
   */
  DMSPortal: "DMS-Portal",

  /**
   * Instance is discovered/registered from DMS using PowerShell - Azure DataMigration Service Module.
   */
  DMSPS: "DMS-PS",

  /**
   * Instance is discovered/registered from DMS using datamigration extension for the Azure CLI
   */
  DMSCLI: "DMS-CLI",

  /**
   * Instance is discovered/registered from Azure Database Migration Service SDK like Python or .NET SDKs.
   */
  DMSSDK: "DMS-SDK",

  /**
   * Instance is discovered/registered from any other source not listed above.
   */
  Other: "Other",
}

/**
 * SQL Server license type.
 */
union ArcSqlServerLicenseType {
  string,

  /**
   * Undefined
   */
  Undefined: "Undefined",

  /**
   * Free
   */
  Free: "Free",

  /**
   * HADR
   */
  Hadr: "HADR",

  /**
   * ServerCAL
   */
  ServerCAL: "ServerCAL",

  /**
   * LicenseOnly
   */
  LicenseOnly: "LicenseOnly",

  /**
   * PAYG
   */
  Payg: "PAYG",

  /**
   * Paid
   */
  Paid: "Paid",

  /**
   * FabricCapacity
   */
  FabricCapacity: "FabricCapacity",
}

/**
 * Status of Azure Defender.
 */
union DefenderStatus {
  string,

  /**
   * Protected
   */
  Protected: "Protected",

  /**
   * Unprotected
   */
  Unprotected: "Unprotected",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Type of host for Azure Arc SQL Server
 */
union HostType {
  string,

  /**
   * Azure Virtual Machine
   */
  AzureVirtualMachine: "Azure Virtual Machine",

  /**
   * Azure VMWare Virtual Machine
   */
  AzureVMWareVirtualMachine: "Azure VMWare Virtual Machine",

  /**
   * Azure Kubernetes Service
   */
  AzureKubernetesService: "Azure Kubernetes Service",

  /**
   * AWS VMWare Virtual Machine
   */
  AWSVMWareVirtualMachine: "AWS VMWare Virtual Machine",

  /**
   * AWS Kubernetes Service
   */
  AWSKubernetesService: "AWS Kubernetes Service",

  /**
   * GCP VMWare Virtual Machine
   */
  GCPVMWareVirtualMachine: "GCP VMWare Virtual Machine",

  /**
   * GCP Kubernetes Service
   */
  GCPKubernetesService: "GCP Kubernetes Service",

  /**
   * Container
   */
  Container: "Container",

  /**
   * Virtual Machine
   */
  VirtualMachine: "Virtual Machine",

  /**
   * Physical Server
   */
  PhysicalServer: "Physical Server",

  /**
   * AWS Virtual Machine
   */
  AWSVirtualMachine: "AWS Virtual Machine",

  /**
   * GCP Virtual Machine
   */
  GCPVirtualMachine: "GCP Virtual Machine",

  /**
   * Hyper-V Virtual Machine
   */
  HyperVVirtualMachine: "Hyper-V Virtual Machine",

  /**
   * Other
   */
  Other: "Other",
}

/**
 * The role of the SQL Server, based on availability.
 */
union AlwaysOnRole {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * FailoverClusterInstance
   */
  FailoverClusterInstance: "FailoverClusterInstance",

  /**
   * FailoverClusterNode
   */
  FailoverClusterNode: "FailoverClusterNode",

  /**
   * AvailabilityGroupReplica
   */
  AvailabilityGroupReplica: "AvailabilityGroupReplica",
}

/**
 * Mirroring Role
 */
union Role {
  string,

  /**
   * NONE
   */
  None: "NONE",

  /**
   * PARTNER
   */
  Partner: "PARTNER",

  /**
   * WITNESS
   */
  Witness: "WITNESS",

  /**
   * ALL
   */
  ALL: "ALL",
}

/**
 * The encryption algorithm(s) used by the endpoint.
 */
union EncryptionAlgorithm {
  string,

  /**
   * NONE
   */
  None: "NONE",

  /**
   * RC4
   */
  RC4: "RC4",

  /**
   * AES
   */
  AES: "AES",

  /**
   * NONE, RC4
   */
  NoneRC4: "NONE, RC4",

  /**
   * NONE, AES
   */
  NoneAES: "NONE, AES",

  /**
   * RC4, AES
   */
  RC4AES: "RC4, AES",

  /**
   * AES, RC4
   */
  AESRC4: "AES, RC4",

  /**
   * NONE, RC4, AES
   */
  NoneRC4AES: "NONE, RC4, AES",

  /**
   * NONE, AES, RC4
   */
  NoneAESRC4: "NONE, AES, RC4",
}

/**
 * The endpoint connection authentication type(s).
 */
union ConnectionAuth {
  string,

  /**
   * Windows_NTLM
   */
  WindowsNtlm: "Windows_NTLM",

  /**
   * Windows_Kerberos
   */
  WindowsKerberos: "Windows_Kerberos",

  /**
   * Windows_Negotiate
   */
  WindowsNegotiate: "Windows_Negotiate",

  /**
   * Certificate
   */
  Certificate: "Certificate",

  /**
   * Windows_NTLM_Certificate
   */
  WindowsNtlmCertificate: "Windows_NTLM_Certificate",

  /**
   * Windows_Kerberos_Certificate
   */
  WindowsKerberosCertificate: "Windows_Kerberos_Certificate",

  /**
   * Windows_Negotiate_Certificate
   */
  WindowsNegotiateCertificate: "Windows_Negotiate_Certificate",

  /**
   * Certificate_Windows_NTLM
   */
  CertificateWindowsNtlm: "Certificate_Windows_NTLM",

  /**
   * Certificate_Windows_Kerberos
   */
  CertificateWindowsKerberos: "Certificate_Windows_Kerberos",

  /**
   * Certificate_Windows_Negotiate
   */
  CertificateWindowsNegotiate: "Certificate_Windows_Negotiate",
}

/**
 * The target recommendation Status for this database.
 */
union RecommendationStatus {
  string,

  /**
   * NotReady
   */
  NotReady: "NotReady",

  /**
   * Ready
   */
  Ready: "Ready",

  /**
   * ReadyWithConditions
   */
  ReadyWithConditions: "ReadyWithConditions",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Indicates if the resource represents a SQL Server engine or a SQL Server component service installed on the host.
 */
union ServiceType {
  string,

  /**
   * SQL Server Database Services.
   */
  Engine: "Engine",

  /**
   * SQL Server Reporting Services.
   */
  Ssrs: "SSRS",

  /**
   * SQL Server Analysis Services.
   */
  Ssas: "SSAS",

  /**
   * SQL Server Integration Services.
   */
  Ssis: "SSIS",

  /**
   * Power BI Report Server.
   */
  Pbirs: "PBIRS",
}

/**
 * Mode of authentication in SqlServer.
 */
union Mode {
  string,

  /**
   * Mixed mode authentication for SQL Server which includes windows and SQL Authentication.
   */
  Mixed: "Mixed",

  /**
   * Windows Authentication for SQL Server.
   */
  Windows: "Windows",

  /**
   * Used for scenarios were the mode cannot be determined.
   */
  Undefined: "Undefined",
}

/**
 * The method used for Entra authentication
 */
union IdentityType {
  string,

  /**
   * System Assigned Managed Identity
   */
  SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  /**
   * User Assigned Managed Identity
   */
  UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
}

/**
 * The aggregation type to use for the numerical columns in the dataset.
 */
union AggregationType {
  string,

  /**
   * Average
   */
  Average: "Average",

  /**
   * Minimum
   */
  Minimum: "Minimum",

  /**
   * Maximum
   */
  Maximum: "Maximum",

  /**
   * Sum
   */
  Sum: "Sum",

  /**
   * Count
   */
  Count: "Count",
}

/**
 * The type of the telemetry column.
 */
union SqlServerInstanceTelemetryColumnType {
  string,

  /**
   * bool
   */
  Bool: "bool",

  /**
   * datetime
   */
  Datetime: "datetime",

  /**
   * int
   */
  Int: "int",

  /**
   * long
   */
  Long: "long",

  /**
   * double
   */
  Double: "double",

  /**
   * string
   */
  String: "string",

  /**
   * guid
   */
  Guid: "guid",

  /**
   * timespan
   */
  Timespan: "timespan",
}

/**
 * The report type that needs to be fetched. If not specified, the default is AssessmentSummary.
 */
union SqlServerInstanceBpaReportType {
  string,

  /**
   * AssessmentDataPoint
   */
  AssessmentDataPoint: "AssessmentDataPoint",

  /**
   * AssessmentSummary
   */
  AssessmentSummary: "AssessmentSummary",
}

/**
 * The type of query to run for summarizing the best practices assessment results. If not specified, the default is 'Basic'.
 */
union SqlServerInstanceBpaQueryType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * HistoricalTrends
   */
  HistoricalTrends: "HistoricalTrends",
}

/**
 * The type of the result column.
 */
union SqlServerInstanceBpaColumnType {
  string,

  /**
   * bool
   */
  Bool: "bool",

  /**
   * datetime
   */
  Datetime: "datetime",

  /**
   * int
   */
  Int: "int",

  /**
   * long
   */
  Long: "long",

  /**
   * double
   */
  Double: "double",

  /**
   * string
   */
  String: "string",

  /**
   * guid
   */
  Guid: "guid",

  /**
   * timespan
   */
  Timespan: "timespan",
}

/**
 * Represents the current status of the target recommendation job.
 */
union JobStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The activation state of the license.
 */
union State {
  string,

  /**
   * Inactive
   */
  Inactive: "Inactive",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Terminated
   */
  Terminated: "Terminated",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Faulted
   */
  Faulted: "Faulted",

  /**
   * Suspended
   */
  Suspended: "Suspended",
}

/**
 * The execution state of the background job.
 */
union ExecutionState {
  string,

  /**
   * Waiting
   */
  Waiting: "Waiting",

  /**
   * Running
   */
  Running: "Running",
}

/**
 * The last execution status of the background job.
 */
union LastExecutionStatus {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Faulted
   */
  Faulted: "Faulted",

  /**
   * Postponed
   */
  Postponed: "Postponed",

  /**
   * Rescheduled
   */
  Rescheduled: "Rescheduled",
}

/**
 * The state of the sequencer action.
 */
union SequencerState {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * WaitingPredecessors
   */
  WaitingPredecessors: "WaitingPredecessors",

  /**
   * ExecutingAction
   */
  ExecutingAction: "ExecutingAction",

  /**
   * CreatingSuccessors
   */
  CreatingSuccessors: "CreatingSuccessors",

  /**
   * Completed
   */
  Completed: "Completed",
}

/**
 * The result of the sequencer action.
 */
union Result {
  string,

  /**
   * NotCompleted
   */
  NotCompleted: "NotCompleted",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * TimedOut
   */
  TimedOut: "TimedOut",

  /**
   * Skipped
   */
  Skipped: "Skipped",
}

/**
 * Controls whether the SQL Server instance resource is updated with the target recommendation details after the job completes.
 */
union ResourceUpdateMode {
  string,

  /**
   * Update the SQL Server instance resource with all target recommendation details, including SKU recommendations and cost estimates, upon job completion.
   */
  UpdateAllTargetRecommendationDetails: "UpdateAllTargetRecommendationDetails",

  /**
   * Do not update the SQL Server instance resource. The target recommendation results will only be available via the GetTargetRecommendationReports API.
   */
  SkipResourceUpdate: "SkipResourceUpdate",
}

/**
 * Filters the report to a specific section type. If not specified, all section types are returned. Section types are grouped into two categories: requirements sections contain performance and resource metrics collected from the source SQL Server, while recommendation sections contain suggested Azure target SKUs derived from those requirements.
 */
union SqlServerInstanceTargetRecommendationReportSectionType {
  string,

  /**
   * Aggregated performance and resource requirements for the entire SQL Server instance, including CPU, memory, IOPS, throughput, and storage metrics collected from the source server.
   */
  RequirementsPerInstance: "RequirementsPerInstance",

  /**
   * Performance and resource requirements broken down per database, including CPU, memory, IOPS, throughput, and storage metrics collected from the source server for each individual database.
   */
  RequirementsPerDatabase: "RequirementsPerDatabase",

  /**
   * File-level performance requirements per database, including IOPS and throughput metrics for individual data and log files. Only available when includeFileLevelRequirements is set to true in the RunTargetRecommendationJob request.
   */
  FileRequirementsPerDatabase: "FileRequirementsPerDatabase",

  /**
   * Recommended Azure SQL Virtual Machine SKU for the entire SQL Server instance, including VM size, compute, storage, and estimated monthly cost derived from the collected requirements.
   */
  SqlVmTargetRecommendationPerInstance: "SqlVmTargetRecommendationPerInstance",

  /**
   * Recommended Azure SQL Managed Instance SKU for the entire SQL Server instance, including service tier, compute, storage, and estimated monthly cost derived from the collected requirements.
   */
  SqlMiTargetRecommendationPerInstance: "SqlMiTargetRecommendationPerInstance",

  /**
   * Recommended Azure SQL Database SKU per database, including service tier, compute, storage, and estimated monthly cost derived from the collected requirements for each individual database.
   */
  SqlDbTargetRecommendationPerDatabase: "SqlDbTargetRecommendationPerDatabase",
}

/**
 * The role of managed instance in a distributed availability group, can be Primary or Secondary.
 */
union AzureManagedInstanceRole {
  string,

  /**
   * Primary
   */
  Primary: "Primary",

  /**
   * Secondary
   */
  Secondary: "Secondary",
}

/**
 * Validation category for the MI Link prerequisites assessment.
 */
union MiLinkAssessmentCategory {
  string,

  /**
   * Assessments of the given instance on the on-premise SQL Server (box).
   */
  SqlInstance: "SqlInstance",

  /**
   * Assessments of the database(s) on the given instance on the on-premise SQL Server (box).
   */
  SqlInstanceDatabase: "SqlInstanceDatabase",

  /**
   * Assessments of the Managed Instance.
   */
  ManagedInstance: "ManagedInstance",

  /**
   * Assessments of the database(s) on the Managed Instance.
   */
  ManagedInstanceDatabase: "ManagedInstanceDatabase",

  /**
   * Assessments that use data from both the Managed Instance and the given instance of the on-premise SQL Server (box) for the validations.
   */
  ManagedInstanceCrossValidation: "ManagedInstanceCrossValidation",

  /**
   * Assessments of the necessary certificates configuration.
   */
  Certificates: "Certificates",

  /**
   * Assessment of network connectivity from the on-premise SQL Server (box) to the Managed Instance.
   */
  BoxToMiNetworkConnectivity: "BoxToMiNetworkConnectivity",

  /**
   * Assessments of network connectivity from the Managed Instance to the on-premise SQL Server (box).
   */
  MiToBoxNetworkConnectivity: "MiToBoxNetworkConnectivity",

  /**
   * Assessments of the chosen Availability Group.
   */
  SqlInstanceAg: "SqlInstanceAg",

  /**
   * Assessments of the chosen Distributed Availability Group.
   */
  DagCrossValidation: "DagCrossValidation",
}

/**
 * The status of the requirement.
 */
union AssessmentStatus {
  string,

  /**
   * Success
   */
  Success: "Success",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Failure
   */
  Failure: "Failure",
}

/**
 * SQL Server ESU license type.
 */
union BillingPlan {
  string,

  /**
   * PAYG
   */
  Payg: "PAYG",

  /**
   * Paid
   */
  Paid: "Paid",
}

/**
 * This property represents the choice between SQL Server Core and ESU licenses.
 */
union LicenseCategory {
  string,

  /**
   * Core
   */
  Core: "Core",
}

/**
 * The activation state of the license.
 */
union ActivationState {
  string,

  /**
   * Activated
   */
  Activated: "Activated",

  /**
   * Deactivated
   */
  Deactivated: "Deactivated",
}

/**
 * The Azure scope to which the license will apply.
 */
union ScopeType {
  string,

  /**
   * Tenant
   */
  Tenant: "Tenant",

  /**
   * Subscription
   */
  Subscription: "Subscription",

  /**
   * ResourceGroup
   */
  ResourceGroup: "ResourceGroup",
}

/**
 * The service account provisioning mode for this Active Directory connector.
 */
union AccountProvisioningMode {
  string,

  /**
   * automatic
   */
  Automatic: "automatic",

  /**
   * manual
   */
  Manual: "manual",
}

/**
 * Property that determines whether a given availability replica can run in synchronous-commit mode
 */
union ArcSqlServerAvailabilityMode {
  string,

  /**
   * SYNCHRONOUS_COMMIT
   */
  SynchronousCommit: "SYNCHRONOUS_COMMIT",

  /**
   * ASYNCHRONOUS_COMMIT
   */
  AsynchronousCommit: "ASYNCHRONOUS_COMMIT",
}

/**
 * Property to set the failover mode of the availability group replica
 */
union ArcSqlServerFailoverMode {
  string,

  /**
   * AUTOMATIC
   */
  Automatic: "AUTOMATIC",

  /**
   * MANUAL
   */
  Manual: "MANUAL",

  /**
   * EXTERNAL
   */
  External: "EXTERNAL",

  /**
   * NONE
   */
  None: "NONE",
}

/**
 * Filter retrieval based on availability group type.
 */
union ArcSqlServerAvailabilityGroupTypeFilter {
  string,

  /**
   * Contained Availability Group (CAG).
   */
  Contained: "CONTAINED",

  /**
   * Distributed Availability Group (DAG)
   */
  Distributed: "DISTRIBUTED",

  /**
   * Default standard availability group that is not contained or distributed.
   */
  Default: "DEFAULT",
}

/**
 * State of the database.
 */
union DatabaseState {
  string,

  /**
   * Online
   */
  Online: "Online",

  /**
   * Restoring
   */
  Restoring: "Restoring",

  /**
   * Recovering
   */
  Recovering: "Recovering",

  /**
   * RecoveryPending
   */
  RecoveryPending: "RecoveryPending",

  /**
   * Suspect
   */
  Suspect: "Suspect",

  /**
   * Emergency
   */
  Emergency: "Emergency",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * Copying
   */
  Copying: "Copying",

  /**
   * OfflineSecondary
   */
  OfflineSecondary: "OfflineSecondary",
}

/**
 * Status of the database.
 */
union RecoveryMode {
  string,

  /**
   * Full
   */
  Full: "Full",

  /**
   * Bulk-logged
   */
  BulkLogged: "Bulk-logged",

  /**
   * Simple
   */
  Simple: "Simple",
}

/**
 * Database create mode. PointInTimeRestore: Create a database by restoring a point in time backup of an existing database. sourceDatabaseId and restorePointInTime must be specified.
 */
union DatabaseCreateMode {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * PointInTimeRestore
   */
  PointInTimeRestore: "PointInTimeRestore",
}

/**
 * Mode/type of migration.
 */
union MigrationMode {
  string,

  /**
   * Migration based on log-shipping technology like LRS (Log Replay Service).
   */
  LogShipping: "LogShipping",

  /**
   * Migration using managed instance link (MILink) that utilizes Always On availability group technology.
   */
  MILink: "MILink",

  /**
   * Logical migration refers to moving data at the logical level (schema and rows) rather than transferring physical database files or backups. Examples include migrating to Azure SQL Database, which does not support physical restore.
   */
  Logical: "Logical",

  /**
   * Other mode of migration not listed currently.
   */
  Other: "Other",

  /**
   * Mode of migration is not known.
   */
  Unknown: "Unknown",
}

/**
 * To indicate the client from which the migration is initiated from e.g. Azure Arc, DMS-Azure Portal/PS/CLI for additional tracking.
 */
union initiatedFrom {
  string,

  /**
   * Migration is initiated from Azure Arc enabled clients.
   */
  AzureArc: "Azure Arc",

  /**
   * Migration is initiated from Azure Data Studio (ADS).
   */
  ADS: "ADS",

  /**
   * Migration is initiated from SQL Server Management Studio (SSMS).
   */
  Ssms: "SSMS",

  /**
   * Migration is initiated from SQL Server Migration Assistant (SSMA).
   */
  Ssma: "SSMA",

  /**
   * Migration is initiated from Azure Database Migration Service(DMS) Azure Portal.
   */
  DMSPortal: "DMS-Portal",

  /**
   * Migration is initiated from DMS using PowerShell - Azure DataMigration Service Module.
   */
  DMSPS: "DMS-PS",

  /**
   * Migration is initiated from DMS using datamigration extension for the Azure CLI
   */
  DMSCLI: "DMS-CLI",

  /**
   * Migration is initiated from Azure Database Migration Service SDK like Python or .NET SDKs.
   */
  DMSSDK: "DMS-SDK",

  /**
   * Migration is initiated from any other client not listed above.
   */
  Other: "Other",
}

/**
 * Status of the migration job.
 */
union MigrationStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * InProgressWithWarnings
   */
  InProgressWithWarnings: "InProgressWithWarnings",

  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Successful
   */
  Successful: "Successful",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Type of target in Azure this database is being migrated to.
 */
union TargetType {
  string,

  /**
   * AzureSqlDatabase
   */
  AzureSqlDatabase: "AzureSqlDatabase",

  /**
   * AzureSqlManagedInstance
   */
  AzureSqlManagedInstance: "AzureSqlManagedInstance",

  /**
   * AzureSqlVirtualMachine
   */
  AzureSqlVirtualMachine: "AzureSqlVirtualMachine",
}

/**
 * The SQL Server version the license covers.
 */
union Version {
  string,

  /**
   * SQL Server 2012
   */
  SQLServer2012: "SQL Server 2012",

  /**
   * SQL Server 2014
   */
  SQLServer2014: "SQL Server 2014",

  /**
   * SQL Server 2016
   */
  SQLServer2016: "SQL Server 2016",
}

/**
 * The pricing tier for the instance.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SqlManagedInstanceSkuTier {
  /**
   * GeneralPurpose
   */
  GeneralPurpose,

  /**
   * BusinessCritical
   */
  BusinessCritical,
}

/**
 * The differential backup interval in hours.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DifferentialBackupHours {
  /**
   * 12
   */
  Twelve: 12,

  /**
   * 24
   */
  TwentyFour: 24,
}

/**
 * The infrastructure the data controller is running on.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum Infrastructure {
  /**
   * azure
   */
  Azure: "azure",

  /**
   * gcp
   */
  Gcp: "gcp",

  /**
   * aws
   */
  Aws: "aws",

  /**
   * alibaba
   */
  Alibaba: "alibaba",

  /**
   * onpremises
   */
  Onpremises: "onpremises",

  /**
   * other
   */
  Other: "other",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ReplicationPartnerType {
  /**
   * SQLServer
   */
  SQLServer,

  /**
   * AzureSQLVM
   */
  AzureSqlvm: "AzureSQLVM",

  /**
   * AzureSQLManagedInstance
   */
  AzureSQLManagedInstance,

  /**
   * Unknown
   */
  Unknown,
}

/**
 * Whether the primary replica should allow all connections or only READ_WRITE connections (disallowing ReadOnly connections)
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum PrimaryAllowConnections {
  /**
   * ALL
   */
  ALL,

  /**
   * READ_WRITE
   */
  ReadWrite: "READ_WRITE",
}

/**
 * Whether the secondary replica should allow all connections, no connections, or only ReadOnly connections.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SecondaryAllowConnections {
  /**
   * NO
   */
  NO,

  /**
   * ALL
   */
  ALL,

  /**
   * READ_ONLY
   */
  ReadOnly: "READ_ONLY",
}

/**
 * Specifies how the secondary replica will be initially seeded. AUTOMATIC enables direct seeding. This method will seed the secondary replica over the network. This method does not require you to backup and restore a copy of the primary database on the replica. MANUAL specifies manual seeding (default). This method requires you to create a backup of the database on the primary replica and manually restore that backup on the secondary replica.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SeedingMode {
  /**
   * AUTOMATIC
   */
  Automatic: "AUTOMATIC",

  /**
   * MANUAL
   */
  Manual: "MANUAL",
}

/**
 * Preferred replica for running automated backups.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutomatedBackupPreference {
  /**
   * PRIMARY
   */
  Primary: "PRIMARY",

  /**
   * SECONDARY_ONLY
   */
  SecondaryOnly: "SECONDARY_ONLY",

  /**
   * SECONDARY
   */
  Secondary: "SECONDARY",

  /**
   * NONE
   */
  None: "NONE",
}

/**
 * User-defined failure condition level under which an automatic failover must be triggered.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum FailureConditionLevel {
  /**
   * 1
   */
  One: 1,

  /**
   * 2
   */
  Two: 2,

  /**
   * 3
   */
  Three: 3,

  /**
   * 4
   */
  Four: 4,

  /**
   * 5
   */
  Five: 5,
}

/**
 * Specifies whether the availability group supports failover for database health conditions.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DbFailover {
  /**
   * ON
   */
  ON,

  /**
   * OFF
   */
  OFF,
}

/**
 * Specifies whether DTC support has been enabled for this availability group.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DtcSupport {
  /**
   * PER_DB
   */
  PERDB: "PER_DB",

  /**
   * NONE
   */
  None: "NONE",
}

/**
 * Set to WSFC when availability group is on a failover cluster instance on a Windows Server failover cluster. Set to NONE when availability group not using WSFC for cluster coordination.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ClusterType {
  /**
   * WSFC
   */
  Wsfc: "WSFC",

  /**
   * NONE
   */
  None: "NONE",
}

/**
 * Azure Data Services on Azure Arc operation definition.
 */
model Operation {
  /**
   * The name of the operation being performed on this particular object.
   */
  name: string;

  /**
   * The localized display information for this particular operation / action.
   */
  display: OperationDisplay;

  /**
   * The intended executor of the operation.
   */
  @visibility(Lifecycle.Read)
  origin?: OperationOrigin;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction: boolean;

  /**
   * Additional descriptions for the operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  properties?: Record<unknown>;
}

/**
 * Display metadata associated with the operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name.
   */
  provider: string;

  /**
   * The localized friendly form of the resource type related to this action/operation.
   */
  resource: string;

  /**
   * The localized friendly name for the operation.
   */
  operation: string;

  /**
   * The localized friendly description for the operation.
   */
  description: string;
}

/**
 * Properties of sqlManagedInstance.
 */
model SqlManagedInstanceProperties {
  /**
   * null
   */
  dataControllerId?: string;

  /**
   * The instance admin user
   */
  admin?: string;

  /**
   * The instance start time
   */
  startTime?: string;

  /**
   * The instance end time
   */
  endTime?: string;

  /**
   * The raw kubernetes information
   */
  k8sRaw?: SqlManagedInstanceK8sRaw;

  /**
   * Username and password for basic authentication.
   */
  basicLoginInformation?: BasicLoginInformation;

  /**
   * Last uploaded date from Kubernetes cluster. Defaults to current date time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUploadedDate?: utcDateTime;

  /**
   * The provisioning state of the Arc-enabled SQL Managed Instance resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Active Directory information related to this SQL Managed Instance.
   */
  activeDirectoryInformation?: ActiveDirectoryInformation;

  /**
   * The license type to apply for this managed instance.
   */
  licenseType?: ArcSqlManagedInstanceLicenseType = ArcSqlManagedInstanceLicenseType.BasePrice;

  /**
   * If a CustomLocation is provided, this contains the ARM id of the connected cluster the custom location belongs to.
   */
  clusterId?: string;

  /**
   * If a CustomLocation is provided, this contains the ARM id of the extension the custom location belongs to.
   */
  extensionId?: string;
}

/**
 * The raw kubernetes information.
 */
model SqlManagedInstanceK8sRaw {
  ...Record<unknown>;

  /**
   * The kubernetes spec information.
   */
  spec?: SqlManagedInstanceK8sSpec;
}

/**
 * The kubernetes spec information.
 */
model SqlManagedInstanceK8sSpec {
  ...Record<unknown>;

  /**
   * The kubernetes scheduling information.
   */
  scheduling?: K8sScheduling;

  /**
   * This option specifies the number of SQL Managed Instance replicas that will be deployed in your Kubernetes cluster for high availability purposes. If sku.tier is BusinessCritical, allowed values are '2' or '3' with default of '3'. If sku.tier is GeneralPurpose, replicas must be '1'.
   */
  replicas?: int32;

  /**
   * The kubernetes security information.
   */
  security?: K8sSecurity;

  /**
   * The kubernetes settings information.
   */
  settings?: K8sSettings;
}

/**
 * The kubernetes scheduling information.
 */
model K8sScheduling {
  ...Record<unknown>;

  /**
   * The kubernetes scheduling options. It describes restrictions used to help Kubernetes select appropriate nodes to host the database service
   */
  default?: K8sSchedulingOptions;
}

/**
 * The kubernetes scheduling options. It describes restrictions used to help Kubernetes select appropriate nodes to host the database service
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model K8sSchedulingOptions {
  ...Record<unknown>;

  /**
   * The kubernetes resource limits and requests used to restrict or reserve resource usage.
   */
  resources?: K8sResourceRequirements;
}

/**
 * The kubernetes resource limits and requests used to restrict or reserve resource usage.
 */
model K8sResourceRequirements {
  ...Record<unknown>;

  /**
   * Requests for a kubernetes resource type (e.g 'cpu', 'memory'). The 'cpu' request must be less than or equal to 'cpu' limit. Default 'cpu' is 2, minimum is 1. Default 'memory' is '4Gi', minimum is '2Gi. If sku.tier is GeneralPurpose, maximum 'cpu' is 24 and maximum 'memory' is '128Gi'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requests?: Record<string>;

  /**
   * Limits for a kubernetes resource type (e.g 'cpu', 'memory'). The 'cpu' request must be less than or equal to 'cpu' limit. Default 'cpu' is 2, minimum is 1. Default 'memory' is '4Gi', minimum is '2Gi. If sku.tier is GeneralPurpose, maximum 'cpu' is 24 and maximum 'memory' is '128Gi'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  limits?: Record<string>;
}

/**
 * The kubernetes security information.
 */
model K8sSecurity {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...Record<unknown>;

  /**
   * Admin login secret key
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  adminLoginSecret?: string;

  /**
   * Service certificate secret used
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceCertificateSecret?: string;

  /**
   * The kubernetes active directory information.
   */
  activeDirectory?: K8sActiveDirectory;

  /**
   * Transparent data encryption information.
   */
  transparentDataEncryption?: k8stransparentDataEncryption;
}

/**
 * The kubernetes active directory information.
 */
model K8sActiveDirectory {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connector?: K8sActiveDirectoryConnector;

  /**
   * Account name for AAD
   */
  accountName?: string;

  /**
   * Keytab secret used to authenticate with Active Directory.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keytabSecret?: string;

  /**
   * An array of encryption types
   */
  encryptionTypes?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model K8sActiveDirectoryConnector {
  /**
   * Name of the connector
   */
  name?: string;

  /**
   * Name space of the connector
   */
  `namespace`?: string;
}

/**
 * Transparent data encryption information.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model k8stransparentDataEncryption {
  /**
   * Transparent data encryption mode. Can be Service Managed, Customer managed or disabled
   */
  mode?: string;

  /**
   * Protector secret for customer managed Transparent data encryption mode
   */
  protectorSecret?: string;
}

/**
 * The kubernetes settings information.
 */
model K8sSettings {
  ...Record<unknown>;

  /**
   * The kubernetes network settings information.
   */
  network?: K8sNetworkSettings;
}

/**
 * The kubernetes network settings information.
 */
model K8sNetworkSettings {
  /**
   * If 1, then SQL Server forces all connections to be encrypted. By default, this option is 0
   */
  forceencryption?: int32;

  /**
   * Specifies which ciphers are allowed by SQL Server for TLS
   */
  tlsciphers?: string;

  /**
   * A comma-separated list of which TLS protocols are allowed by SQL Server
   */
  tlsprotocols?: string;
}

/**
 * Username and password for basic login authentication.
 */
model BasicLoginInformation {
  /**
   * Login username.
   */
  username?: string;

  /**
   * Login password.
   */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  password?: string;
}

/**
 * Active Directory information that related to the resource.
 */
model ActiveDirectoryInformation {
  /**
   * Keytab information that is used for the Sql Managed Instance when Active Directory authentication is used.
   */
  keytabInformation?: KeytabInformation;
}

/**
 * Keytab used for authenticate with Active Directory.
 */
model KeytabInformation {
  /**
   * A base64-encoded keytab.
   */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  keytab?: string;
}

/**
 * The complex type of the extended location.
 */
model ExtendedLocation {
  /**
   * The name of the extended location.
   */
  name?: string;

  /**
   * The type of the extended location.
   */
  type?: ExtendedLocationTypes;
}

/**
 * The resource model definition representing SKU for Azure Managed Instance - Azure Arc
 */
model SqlManagedInstanceSku {
  /**
   * The name of the SKU.
   */
  name: "vCore";

  /**
   * The pricing tier for the instance.
   */
  tier?: SqlManagedInstanceSkuTier = SqlManagedInstanceSkuTier.GeneralPurpose;

  /**
   * Whether dev/test is enabled. When the dev field is set to true, the resource is used for dev/test purpose.
   */
  dev?: boolean = true;

  /**
   * The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.
   */
  size?: string;

  /**
   * The SKU family
   */
  family?: string;

  /**
   * The SKU capacity
   */
  capacity?: int32;
}

/**
 * An update to a SQL Managed Instance.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlManagedInstanceUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * The properties of a failover group resource.
 */
model FailoverGroupProperties {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...Record<unknown>;

  /**
   * The provisioning state of the failover group resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resource ID of the partner SQL managed instance.
   */
  partnerManagedInstanceId: string;

  /**
   * The specifications of the failover group resource.
   */
  spec: FailoverGroupSpec;

  /**
   * The status of the failover group custom resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  status?: unknown;
}

/**
 * The specifications of the failover group resource.
 */
model FailoverGroupSpec {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...Record<unknown>;

  /**
   * The shared name of the failover group for this SQL managed instance. Both SQL managed instance and its partner have to use the same shared name.
   */
  sharedName?: string;

  /**
   * The name of the SQL managed instance with this failover group role.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceMI?: string;

  /**
   * The name of the partner SQL managed instance.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partnerMI?: string;

  /**
   * The mirroring endpoint URL of the partner SQL managed instance.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  partnerMirroringURL?: string;

  /**
   * The mirroring endpoint public certificate for the partner SQL managed instance. Only PEM format is supported.
   */
  partnerMirroringCert?: string;

  /**
   * The partner sync mode of the SQL managed instance.
   */
  partnerSyncMode?: FailoverGroupPartnerSyncMode = FailoverGroupPartnerSyncMode.Async;

  /**
   * The role of the SQL managed instance in this failover group.
   */
  role: InstanceFailoverGroupRole = InstanceFailoverGroupRole.Primary;
}

/**
 * Properties of SqlServerInstance.
 */
model SqlServerInstanceProperties {
  /**
   * SQL Server version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: SqlVersion;

  /**
   * SQL Server edition.
   */
  edition?: EditionType;

  /**
   * ARM Resource id of the container resource (Azure Arc for Servers).
   */
  @visibility(Lifecycle.Read)
  containerResourceId?: string;

  /**
   * The unique ID of the hybrid machine that this resource belongs to.
   */
  @visibility(Lifecycle.Read)
  vmId?: string;

  /**
   * The time when the resource was created.
   */
  @visibility(Lifecycle.Read)
  createTime?: string;

  /**
   * The number of logical processors used by the SQL Server instance.
   */
  @visibility(Lifecycle.Read)
  vCore?: string;

  /**
   * The number of total cores of the Operating System Environment (OSE) hosting the SQL Server instance.
   */
  cores?: string;

  /**
   * The cloud connectivity status.
   */
  @visibility(Lifecycle.Read)
  status?: ConnectionStatus;

  /**
   * Indicates the discovery agent or client for this instance.
   */
  discoverySource?: DiscoverySource;

  /**
   * SQL Server update level.
   */
  @visibility(Lifecycle.Read)
  patchLevel?: string;

  /**
   * SQL Server collation.
   */
  @visibility(Lifecycle.Read)
  collation?: string;

  /**
   * Indicates whether database master key exists in SQL Server.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @visibility(Lifecycle.Read)
  dbMasterKeyExists?: boolean;

  /**
   * Indicates whether always On availability groups is enabled in SQL Server.
   */
  @visibility(Lifecycle.Read)
  isHadrEnabled?: boolean;

  /**
   * An array of integers, where each value represents the enabled trace flags in SQL Server.
   */
  @visibility(Lifecycle.Read)
  traceFlags?: int32[];

  /**
   * SQL Server current version.
   */
  @visibility(Lifecycle.Read)
  currentVersion?: string;

  /**
   * SQL Server instance name.
   */
  instanceName?: string;

  /**
   * Dynamic TCP ports used by SQL Server.
   */
  @visibility(Lifecycle.Read)
  tcpDynamicPorts?: string;

  /**
   * Static TCP ports used by SQL Server.
   */
  @visibility(Lifecycle.Read)
  tcpStaticPorts?: string;

  /**
   * SQL Server product ID.
   */
  @visibility(Lifecycle.Read)
  productId?: string;

  /**
   * SQL Server license type.
   */
  @visibility(Lifecycle.Read)
  licenseType?: ArcSqlServerLicenseType;

  /**
   * Timestamp of last Azure Defender status update.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  azureDefenderStatusLastUpdated?: utcDateTime;

  /**
   * Status of Azure Defender.
   */
  @visibility(Lifecycle.Read)
  azureDefenderStatus?: DefenderStatus;

  /**
   * The provisioning state of the Arc-enabled SQL Server resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The time when last successful inventory upload was performed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastInventoryUploadTime?: utcDateTime;

  /**
   * The time when last successful usage upload was performed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUsageUploadTime?: utcDateTime;

  /**
   * Type of host for Azure Arc SQL Server
   */
  hostType?: HostType;

  /**
   * The role of the SQL Server, based on availability.
   */
  @visibility(Lifecycle.Read)
  alwaysOnRole?: AlwaysOnRole;

  /**
   * Database mirroring endpoint related properties.
   */
  databaseMirroringEndpoint?: DBMEndpoint;

  /**
   * Failover Cluster Instance properties.
   */
  failoverCluster?: FailoverCluster;

  /**
   * The backup profile for the SQL server.
   */
  backupPolicy?: BackupPolicy;

  /**
   * Upgrade Action for this resource is locked until it expires. The Expiration time indicated by this value. It is not locked when it is empty.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradeLockedUntil?: utcDateTime;

  /**
   * The monitoring configuration.
   */
  monitoring?: Monitoring;

  /**
   * Migration related configuration and status.
   */
  migration?: Migration;

  /**
   * The configuration related to SQL best practices assessment.
   */
  bestPracticesAssessment?: BestPracticesAssessment;

  /**
   * Client connection related configuration.
   */
  clientConnection?: ClientConnection;

  /**
   * Indicates if the resource represents a SQL Server engine or a SQL Server component service installed on the host.
   */
  serviceType?: ServiceType;

  /**
   * maximum server memory (MB) value configured for this instance.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  maxServerMemoryMB?: int64;

  /**
   * Indicates whether Microsoft PKI root-authority certificate (trusted by Azure) exists in SQL Server and trusted for Azure database.windows.net domains.
   */
  @visibility(Lifecycle.Read)
  isMicrosoftPkiCertTrustConfigured?: boolean;

  /**
   * Indicates whether DigiCert PKI root-authority certificate (trusted by Azure) exists in SQL Server and trusted for Azure database.windows.net domains.
   */
  @visibility(Lifecycle.Read)
  isDigiCertPkiCertTrustConfigured?: boolean;

  /**
   * Authentication related configuration for the SQL Server Instance.
   */
  authentication?: Authentication;
}

/**
 * Database mirroring endpoint related properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DBMEndpoint {
  /**
   * Name of the database mirroring endpoint.
   */
  @visibility(Lifecycle.Read)
  endpointName?: string;

  /**
   * Mirroring Role
   */
  @visibility(Lifecycle.Read)
  role?: Role;

  /**
   * Is Encryption enabled
   */
  @visibility(Lifecycle.Read)
  isEncryptionEnabled?: boolean;

  /**
   * Encryption Algorithm
   */
  @visibility(Lifecycle.Read)
  encryptionAlgorithm?: EncryptionAlgorithm;

  /**
   * The type of connection authentication required for connections to this endpoint
   */
  @visibility(Lifecycle.Read)
  connectionAuth?: ConnectionAuth;

  /**
   * The port number that the endpoint is listening on.
   */
  @visibility(Lifecycle.Read)
  port?: int32;

  /**
   * Is the port number dynamically assigned.
   */
  @visibility(Lifecycle.Read)
  isDynamicPort?: boolean;

  /**
   * Listener IP address.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @visibility(Lifecycle.Read)
  ipAddress?: string;

  /**
   * Name of the certificate.
   */
  @visibility(Lifecycle.Read)
  certificateName?: string;

  /**
   * The certificate expiry date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  certificateExpiryDate?: utcDateTime;
}

/**
 * Failover Cluster Instance properties.
 */
model FailoverCluster {
  /**
   * The GUID of the SQL Server's underlying Failover Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The network name to connect to the SQL FCI.
   */
  @visibility(Lifecycle.Read)
  networkName?: string;

  /**
   * The ARM IDs of the Arc SQL Server resources, belonging to the current server's Failover cluster.
   */
  @visibility(Lifecycle.Read)
  sqlInstanceIds?: string[];

  /**
   * The host names which are part of the SQL FCI resource group.
   */
  @visibility(Lifecycle.Read)
  hostNames?: string[];

  /**
   * The IP addresses and subnet masks associated with the SQL Failover Cluster Instance on this host.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  hostIPAddresses?: hostIPAddressInformation[];
}

/**
 * IP address and subnet mask.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model hostIPAddressInformation {
  /**
   * IP address
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @visibility(Lifecycle.Read)
  ipAddress?: string;

  /**
   * Subnet mask
   */
  @visibility(Lifecycle.Read)
  subnetMask?: string;
}

/**
 * The backup profile for the SQL server.
 */
model BackupPolicy {
  /**
   * The retention period for all the databases in this managed instance.
   */
  @maxValue(35)
  @minValue(0)
  retentionPeriodDays?: int32;

  /**
   * The value indicating days between full backups.
   */
  @maxValue(7)
  @minValue(0)
  fullBackupDays?: int32;

  /**
   * The differential backup interval in hours.
   */
  differentialBackupHours?: DifferentialBackupHours;

  /**
   * The value indicating minutes between transaction log backups.
   */
  @maxValue(60)
  @minValue(0)
  transactionLogBackupMinutes?: int32;
}

/**
 * The monitoring configuration.
 */
model Monitoring {
  /**
   * Indicates if monitoring is enabled for this SQL Server instance.
   */
  enabled?: boolean;
}

/**
 * Migration related configuration.
 */
model Migration {
  /**
   * Migration assessments related configuration.
   */
  assessment?: MigrationAssessment;

  /**
   * The last time when the target resource was selected for migration.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  targetSelectedTime?: utcDateTime;

  /**
   * Resource Id of the created or selected target SQL resource for migration.
   */
  targetResourceId?: string;
}

/**
 * The migration assessment related configuration.
 */
model MigrationAssessment {
  /**
   * Indicates if migration assessment is enabled for this SQL Server instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enabled?: boolean;

  /**
   * The time when Migration Assessment Report upload was last performed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  assessmentUploadTime?: utcDateTime;

  /**
   * The time when this migration assessment was last viewed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  assessmentViewedTime?: utcDateTime;

  /**
   * The UTC timestamp in ISO 8601 format indicating when the latest target recommendations were generated for this SQL Server instance. This value is set as part of a successful RunTargetRecommendation job and is independent of when the migration readiness results were uploaded (assessmentUploadTime).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  targetRecommendationGenerationTime?: utcDateTime;

  /**
   * version of this migration assessment report - to be passed by the migration assessment engine.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Settings impacting the migration assessment computation - configurable with some default values if not set.
   */
  settings?: MigrationAssessmentSettings;

  /**
   * Issues and warnings impacting the migration of SQL Server instance to particular Azure Migration Target.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  serverAssessments?: ServerAssessmentsItem[];

  /**
   * SKU Recommendation results for Azure migration targets for SQL Server.
   */
  @visibility(Lifecycle.Read)
  skuRecommendationResults?: SkuRecommendationResults;

  /**
   * Represents a summary of migration readiness issues/warnings per feature type for Azure SQL DB and SQL MI targets
   */
  impactedObjectsSummary?: ImpactedObjectsSuitabilitySummary;
}

/**
 * Settings impacting the migration assessment computation - configurable with some default values if not set.
 */
model MigrationAssessmentSettings {
  /**
   * The target location for Azure SQL SKU for migration. Default is West US.
   */
  targetLocation?: string;

  /**
   * Indicate the percentile value for the performance sample. Default is 95th percentile.
   */
  percentile?: float32;

  /**
   * How far back to check the performance data - Default is 30 (days).
   */
  lookbackPeriodInDays?: int32;

  /**
   * Buffer (percentage) to consider while SKU sizing to account for issues such as seasonal usage, short performance history, and likely increases in future usage - This buffer is applied on top of the performance metrics. Default is 100 (percent).
   */
  comfortFactor?: int32;

  /**
   * Minimize cost or Migrate to PaaS. - to evaluate based on the recommended strategy. Default is Migrate to PaaS
   */
  strategy?: string;

  /**
   * currency to calculate prices - Default is USD.
   */
  currency?: string;

  /**
   * flat discount percentage to apply for the price - Default is 0
   */
  discountPercentage?: float32;

  /**
   * Selected cost option value.
   */
  costOptions?: CostOptionSelectedValues;
}

/**
 * Cost option value for the different cost factors selected.
 */
model CostOptionSelectedValues {
  /**
   * selected cost saving option e.g. With1YearASPAndDevTest.
   */
  computeAndStorageCostOption?: string;

  /**
   * With Azure Hybrid Benefit(AHB) or not for SQL.
   */
  sqlLicenseCostOption?: string;

  /**
   * With Azure Hybrid Benefit(AHB) or not for Windows.
   */
  windowsLicenseCostOption?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerAssessmentsItem {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  appliesToMigrationTargetPlatform?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  featureId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  impactedObjects?: ServerAssessmentsPropertiesItemsItem[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  issueCategory?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  moreInformation?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerAssessmentsPropertiesItemsItem {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  impactDetail?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  objectType?: string;
}

/**
 * SKU Recommendation results for Azure migration targets for SQL Server.
 */
model SkuRecommendationResults {
  /**
   * SKU Recommendation results for Azure SQL Database.
   */
  azureSqlDatabase?: SkuRecommendationResultsAzureSqlDatabase;

  /**
   * SKU Recommendation results for Azure SQL Managed Instance.
   */
  azureSqlManagedInstance?: SkuRecommendationResultsAzureSqlManagedInstance;

  /**
   * SKU Recommendation results for Azure SQL Virtual Machine.
   */
  azureSqlVirtualMachine?: SkuRecommendationResultsAzureSqlVirtualMachine;
}

/**
 * SKU Recommendation results for Azure SQL Database.
 */
model SkuRecommendationResultsAzureSqlDatabase {
  /**
   * The target recommendation Status for this database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recommendationStatus?: RecommendationStatus;

  /**
   * Number of blocker issues to fix before migrating to the target platform.
   */
  numberOfServerBlockerIssues?: int32;

  /**
   * The monthly cost of the particular SKU.
   */
  monthlyCost?: SkuRecommendationResultsMonthlyCost;

  /**
   * The monthly cost for all different savings options applicable for the particular SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  monthlyCostOptions?: SkuRecommendationResultsMonthlyCostOptionItem[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetSku?: SkuRecommendationResultsAzureSqlDatabaseTargetSku;
}

/**
 * The monthly cost of the particular SKU.
 */
model SkuRecommendationResultsMonthlyCost {
  /**
   * Represents the Cost of Compute.
   */
  computeCost?: float32;

  /**
   * Represents the Cost of Storage.
   */
  storageCost?: float32;

  /**
   * Represents the Cost of IOPS.
   */
  iopsCost?: float32;

  /**
   * Represents the Cost of SQL license.
   */
  sqlLicenseCost?: float32;

  /**
   * Represents the Cost of Windows license.
   */
  windowsLicenseCost?: float32;

  /**
   * Represents the Total Cost.
   */
  totalCost?: float32;
}

/**
 * The monthly cost values for this saving option combination for the particular SKU.
 */
model SkuRecommendationResultsMonthlyCostOptionItem {
  /**
   * The unique combination of saving options for a price e.g. With1YearASPAndProd.
   */
  keyName?: string;

  /**
   * The Monthly cost of the particular SKU.
   */
  keyValue?: CostTypeValues;
}

/**
 * The Monthly cost of the particular SKU.
 */
model CostTypeValues {
  /**
   * Represents the Cost of Compute.
   */
  computeCost?: float32;

  /**
   * Represents the Cost of Storage.
   */
  storageCost?: float32;

  /**
   * Represents the Cost of IOPS.
   */
  iopsCost?: float32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SkuRecommendationResultsAzureSqlDatabaseTargetSku {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  category?: SkuRecommendationResultsAzureSqlDatabaseTargetSkuCategory;

  /**
   * Compute Size in vCores.
   */
  computeSize?: int32;

  /**
   * maximum storage for this particular SKU, in MB.
   */
  storageMaxSizeInMb?: float32;

  /**
   * The predicted data size in MB in Azure SQL, will impact the billing cost.
   */
  predictedDataSizeInMb?: float32;

  /**
   * The predicted log size in MB in Azure SQL, will impact the billing cost.
   */
  predictedLogSizeInMb?: float32;

  /**
   * The maximum storage IOPS in Azure SQL, will impact the billing cost.
   */
  maxStorageIops?: float32;

  /**
   * The maximum throughput in Azure SQL, will impact the billing cost.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxThroughputMBps?: float32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SkuRecommendationResultsAzureSqlDatabaseTargetSkuCategory {
  /**
   * The compute tier of the target SKU.
   */
  computeTier?: string;

  /**
   * The hardware type of the target SKU.
   */
  hardwareType?: string;

  /**
   * The SQL purchasing model of the target SKU.
   */
  sqlPurchasingModel?: string;

  /**
   * The SQL service tier of the target SKU.
   */
  sqlServiceTier?: string;

  /**
   * Indicates if zone redundancy is available for the target SKU.
   */
  zoneRedundancyAvailable?: boolean;
}

/**
 * SKU Recommendation results for Azure SQL Managed Instance.
 */
model SkuRecommendationResultsAzureSqlManagedInstance {
  /**
   * The target recommendation Status for this database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recommendationStatus?: RecommendationStatus;

  /**
   * Number of blocker issues to fix before migrating to the target platform.
   */
  numberOfServerBlockerIssues?: int32;

  /**
   * The monthly cost of the particular SKU.
   */
  monthlyCost?: SkuRecommendationResultsMonthlyCost;

  /**
   * The monthly cost for all different savings options applicable for the particular SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  monthlyCostOptions?: SkuRecommendationResultsMonthlyCostOptionItem[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetSku?: SkuRecommendationResultsAzureSqlManagedInstanceTargetSku;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SkuRecommendationResultsAzureSqlManagedInstanceTargetSku {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  category?: SkuRecommendationResultsAzureSqlManagedInstanceTargetSkuCategory;

  /**
   * Compute Size in vCores.
   */
  computeSize?: int32;

  /**
   * maximum storage for this particular SKU, in MB.
   */
  storageMaxSizeInMb?: float32;

  /**
   * The predicted data size in MB in Azure SQL, will impact the billing cost.
   */
  predictedDataSizeInMb?: float32;

  /**
   * The predicted log size in MB in Azure SQL, will impact the billing cost.
   */
  predictedLogSizeInMb?: float32;

  /**
   * The maximum storage IOPS in Azure SQL, will impact the billing cost.
   */
  maxStorageIops?: float32;

  /**
   * The maximum throughput in Azure SQL, will impact the billing cost.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxThroughputMBps?: float32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SkuRecommendationResultsAzureSqlManagedInstanceTargetSkuCategory {
  /**
   * The compute tier of the target SKU.
   */
  computeTier?: string;

  /**
   * The hardware type of the target SKU.
   */
  hardwareType?: string;

  /**
   * The SQL purchasing model of the target SKU.
   */
  sqlPurchasingModel?: string;

  /**
   * The SQL service tier of the target SKU.
   */
  sqlServiceTier?: string;

  /**
   * Indicates if zone redundancy is available for the target SKU.
   */
  zoneRedundancyAvailable?: boolean;
}

/**
 * SKU Recommendation results for Azure SQL Virtual Machine.
 */
model SkuRecommendationResultsAzureSqlVirtualMachine {
  /**
   * The target recommendation Status for this database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recommendationStatus?: RecommendationStatus;

  /**
   * Number of blocker issues to fix before migrating to the target platform.
   */
  numberOfServerBlockerIssues?: int32;

  /**
   * The monthly cost of the particular SKU.
   */
  monthlyCost?: SkuRecommendationResultsMonthlyCost;

  /**
   * The monthly cost for all different savings options applicable for the particular SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  monthlyCostOptions?: SkuRecommendationResultsMonthlyCostOptionItem[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetSku?: SkuRecommendationResultsAzureSqlVirtualMachineTargetSku;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SkuRecommendationResultsAzureSqlVirtualMachineTargetSku {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  category?: SkuRecommendationResultsAzureSqlVirtualMachineTargetSkuCategory;

  /**
   * Compute Size in vCores.
   */
  computeSize?: int32;

  /**
   * The predicted data size in MB in Azure SQL, will impact the billing cost.
   */
  predictedDataSizeInMb?: float32;

  /**
   * The predicted log size in MB in Azure SQL, will impact the billing cost.
   */
  predictedLogSizeInMb?: float32;

  /**
   * size parameters for VM size.
   */
  virtualMachineSize?: SkuRecommendationResultsAzureSqlVirtualMachineTargetSkuVirtualMachineSize;

  /**
   * Data disk sizes.
   */
  @identifiers(#[])
  dataDiskSizes?: DiskSizes[];

  /**
   * Log disk sizes.
   */
  @identifiers(#[])
  logDiskSizes?: DiskSizes[];

  /**
   * temp db disk sizes.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @identifiers(#[])
  tempDbDiskSizes?: DiskSizes[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SkuRecommendationResultsAzureSqlVirtualMachineTargetSkuCategory {
  /**
   * Available VM SKUs for the Azure SQL Virtual Machine.
   */
  availableVmSkus?: string[];

  /**
   * The virtual machine family of the target SKU.
   */
  virtualMachineFamily?: string;
}

/**
 * size parameters for VM size.
 */
model SkuRecommendationResultsAzureSqlVirtualMachineTargetSkuVirtualMachineSize {
  /**
   * Virtual Machine Family, for example : standardMSFamily
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  virtualMachineFamily?: string;

  /**
   * VM Size, for example : M64ls
   */
  sizeName?: string;

  /**
   * Compute Size in vCores.
   */
  computeSize?: int32;

  /**
   * Virtual Machine SKU name,: Eg : Standard_F16s.
   */
  azureSkuName?: string;

  /**
   * Available vCores. This can be less than the vCores in the Constrained vCPU VM Sizes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vCPUsAvailable?: int32;

  /**
   * maximum network interfaces.
   */
  maxNetworkInterfaces?: int32;
}

/**
 * disk size values
 */
model DiskSizes {
  /**
   * Type of managed disk.
   */
  diskType?: string;

  /**
   * Redundancy option.
   */
  redundancy?: string;

  /**
   * Size of the managed disk - e.g. P30, P40.
   */
  size?: string;

  /**
   * Caching configuration - e.g. read only caching
   */
  caching?: string;

  /**
   * maximum disk size in GiB.
   */
  maxSizeInGib?: float32;

  /**
   * maximum throughput in MB/s.
   */
  maxThroughputInMbps?: float32;

  /**
   * maximum IO requirements/s (IOPS).
   */
  maxIops?: float32;
}

/**
 * Represents a summary of migration readiness issues/warnings per feature type for Azure SQL DB and SQL MI targets
 */
model ImpactedObjectsSuitabilitySummary {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  azureSqlDatabase?: ImpactedObjectsInfo[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  azureSqlManagedInstance?: ImpactedObjectsInfo[];
}

/**
 * summary information about the incompatible feature id, number of objects impacted  and category of issue (warning/error)
 */
model ImpactedObjectsInfo {
  /**
   * Represents the feature id from https://learn.microsoft.com/en-us/data-migration/sql-server/database/assessment-rules?view=azuresql. OR https://learn.microsoft.com/en-us/data-migration/sql-server/managed-instance/assessment-rules?view=azuresql
   */
  featureId?: string;

  /**
   * Represents the number of issues/warnings.
   */
  numberImpacted?: int32;

  /**
   * Issue or Warning
   */
  issueCategory?: string;
}

/**
 * The configuration related to SQL best practices assessment.
 */
model BestPracticesAssessment {
  /**
   * Indicates if SQL best practices assessment is enabled for the SQL Server instance.
   */
  enabled?: boolean;

  /**
   * The scheduling configuration.
   */
  schedule?: Schedule;
}

/**
 * The scheduling configuration.
 */
model Schedule {
  /**
   * Indicates whether scheduling is enabled.
   */
  enabled?: boolean;

  /**
   * The cron trigger configuration.
   */
  cronTrigger?: CronTrigger;
}

/**
 * The cron trigger configuration.
 */
model CronTrigger {
  /**
   * Indicates the start time for the trigger. The default value is the time at which the trigger was created.
   */
  startTime?: string;

  /**
   * The time zone in which the trigger is scheduled.
   */
  timeZone?: string;

  /**
   * A cron string representing a CronTab expression. A crontab expression is a very compact way to express a recurring schedule with the following format: '{minutes} {hours} {days} {months} {days-of-week}'.
   */
  expression?: string;
}

/**
 * Client connection related configuration.
 */
model ClientConnection {
  /**
   * Indicates if client connection is enabled for this SQL Server instance.
   */
  enabled?: boolean;
}

/**
 * Authentication related configuration for the SQL Server Instance.
 */
model Authentication {
  /**
   * Mode of authentication in SqlServer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mode?: Mode;

  /**
   * Entra Authentication configuration for the SQL Server Instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sqlServerEntraIdentity?: EntraAuthentication[];
}

/**
 * Entra Authentication configuration.
 */
model EntraAuthentication {
  /**
   * The method used for Entra authentication
   */
  identityType?: IdentityType;

  /**
   * The client Id of the Managed Identity to query Microsoft Graph API. An empty string must be used for the system assigned Managed Identity.
   */
  clientId?: string;
}

/**
 * An update to a SQL Server Instance.
 */
model SqlServerInstanceUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * null
   */
  properties?: SqlServerInstanceUpdateProperties;
}

/**
 * Properties of update SqlServerInstance.
 */
model SqlServerInstanceUpdateProperties {
  /**
   * SQL Server version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: SqlVersion;

  /**
   * SQL Server edition.
   */
  edition?: EditionType;

  /**
   * ARM Resource id of the container resource (Azure Arc for Servers).
   */
  @visibility(Lifecycle.Read)
  containerResourceId?: string;

  /**
   * The unique ID of the hybrid machine that this resource belongs to.
   */
  @visibility(Lifecycle.Read)
  vmId?: string;

  /**
   * The time when the resource was created.
   */
  @visibility(Lifecycle.Read)
  createTime?: string;

  /**
   * The number of logical processors used by the SQL Server instance.
   */
  @visibility(Lifecycle.Read)
  vCore?: string;

  /**
   * The number of total cores of the Operating System Environment (OSE) hosting the SQL Server instance.
   */
  cores?: string;

  /**
   * The cloud connectivity status.
   */
  @visibility(Lifecycle.Read)
  status?: ConnectionStatus;

  /**
   * Indicates the discovery agent or client for this instance. Default is Azure Arc.
   */
  discoverySource?: DiscoverySource;

  /**
   * SQL Server update level.
   */
  @visibility(Lifecycle.Read)
  patchLevel?: string;

  /**
   * SQL Server collation.
   */
  @visibility(Lifecycle.Read)
  collation?: string;

  /**
   * Indicates whether database master key exists in SQL Server.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @visibility(Lifecycle.Read)
  dbMasterKeyExists?: boolean;

  /**
   * Indicates whether always On availability groups is enabled in SQL Server.
   */
  @visibility(Lifecycle.Read)
  isHadrEnabled?: boolean;

  /**
   * An array of integers, where each value represents the enabled trace flags in SQL Server.
   */
  @visibility(Lifecycle.Read)
  traceFlags?: int32[];

  /**
   * SQL Server current version.
   */
  @visibility(Lifecycle.Read)
  currentVersion?: string;

  /**
   * SQL Server instance name.
   */
  instanceName?: string;

  /**
   * Dynamic TCP ports used by SQL Server.
   */
  @visibility(Lifecycle.Read)
  tcpDynamicPorts?: string;

  /**
   * Static TCP ports used by SQL Server.
   */
  @visibility(Lifecycle.Read)
  tcpStaticPorts?: string;

  /**
   * SQL Server product ID.
   */
  @visibility(Lifecycle.Read)
  productId?: string;

  /**
   * SQL Server license type.
   */
  @visibility(Lifecycle.Read)
  licenseType?: ArcSqlServerLicenseType;

  /**
   * Timestamp of last Azure Defender status update.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  azureDefenderStatusLastUpdated?: utcDateTime;

  /**
   * Status of Azure Defender.
   */
  @visibility(Lifecycle.Read)
  azureDefenderStatus?: DefenderStatus;

  /**
   * The provisioning state of the Arc-enabled SQL Server resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The time when last successful inventory upload was performed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastInventoryUploadTime?: utcDateTime;

  /**
   * The time when last successful usage upload was performed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUsageUploadTime?: utcDateTime;

  /**
   * Type of host for Azure Arc SQL Server
   */
  hostType?: HostType;

  /**
   * The role of the SQL Server, based on availability.
   */
  @visibility(Lifecycle.Read)
  alwaysOnRole?: AlwaysOnRole;

  /**
   * Failover Cluster Instance properties.
   */
  failoverCluster?: FailoverCluster;

  /**
   * The backup profile for the SQL server.
   */
  backupPolicy?: BackupPolicy;

  /**
   * Upgrade Action for this resource is locked until it expires. The Expiration time indicated by this value. It is not locked when it is empty.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradeLockedUntil?: utcDateTime;

  /**
   * The monitoring configuration.
   */
  monitoring?: Monitoring;

  /**
   * Migration related configuration.
   */
  migration?: Migration;

  /**
   * The configuration related to SQL best practices assessment.
   */
  bestPracticesAssessment?: BestPracticesAssessment;

  /**
   * Client connection related configuration.
   */
  clientConnection?: ClientConnection;

  /**
   * Indicates if the resource represents a SQL Server engine or a SQL Server component service installed on the host.
   */
  serviceType?: ServiceType;

  /**
   * Authentication related configuration for the SQL Server Instance.
   */
  authentication?: Authentication;

  /**
   * Database mirroring endpoint related properties.
   */
  databaseMirroringEndpoint?: DBMEndpoint;

  /**
   * Indicates whether Microsoft PKI root-authority certificate (trusted by Azure) exists in SQL Server and trusted for Azure database.windows.net domains.
   */
  isMicrosoftPkiCertTrustConfigured?: boolean;

  /**
   * Indicates whether DigiCert PKI root-authority certificate (trusted by Azure) exists in SQL Server and trusted for Azure database.windows.net domains.
   */
  isDigiCertPkiCertTrustConfigured?: boolean;

  /**
   * maximum server memory (MB) value configured for this instance.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxServerMemoryMB?: int64;
}

/**
 * The Arc SQL Server instance telemetry retrieval request.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceTelemetryRequest {
  /**
   * The name of the telemetry dataset to retrieve.
   */
  datasetName: string;

  /**
   * The start time for the time range to fetch telemetry for. If not specified, the current time minus 1 hour is used.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time for the time range to fetch telemetry for. If not specified, the current time is used.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The time granularity to fetch telemetry for. This is an ISO8601 duration. Examples: PT15M, PT1H, P1D
   */
  interval?: duration = duration.fromISO("PT1H");

  /**
   * The aggregation type to use for the numerical columns in the dataset.
   */
  aggregationType?: AggregationType = AggregationType.Average;

  /**
   * The list of database names to return telemetry for. If not specified, telemetry for all databases will be aggregated and returned.
   */
  databaseNames?: string[];
}

/**
 * A section of the telemetry response for the SQL Server instance.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceTelemetryResponse {
  /**
   * The columns of the result telemetry table for the SQL Server instance.
   */
  @identifiers(#["name"])
  columns: SqlServerInstanceTelemetryColumn[];

  /**
   * A list of rows from the result telemetry table for the SQL Server instance.
   */
  @pageItems
  @identifiers(#[])
  rows: string[][];

  /**
   * The link to the next section of rows of the telemetry response for the SQL Server instance. Null if no more sections are available.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

/**
 * The telemetry column for the SQL Server instance.
 */
model SqlServerInstanceTelemetryColumn {
  /**
   * The name of the telemetry column.
   */
  name?: string;

  /**
   * The type of the telemetry column.
   */
  type?: SqlServerInstanceTelemetryColumnType;
}

/**
 * The request for retrieving SQL best practices assessment results.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceBpaRequest {
  /**
   * The report type that needs to be fetched. If not specified, the default is AssessmentSummary.
   */
  reportType?: SqlServerInstanceBpaReportType;

  /**
   * The GUID of the report to return best practices assessment results for. If not specified, summaries for all reports will be returned.
   */
  reportId?: string;

  /**
   * The opaque token to use to skip to a specific page of the report. If not specified, the first page will be returned.
   */
  skipToken?: string;

  /**
   * The type of query to run for summarizing the best practices assessment results. If not specified, the default is 'Basic'.
   */
  queryType?: SqlServerInstanceBpaQueryType;
}

/**
 * A section of the SQL best practices assessment response.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceBpaResponse {
  /**
   * The SQL best practices assessment response columns.
   */
  @identifiers(#["name"])
  columns: SqlServerInstanceBpaColumn[];

  /**
   * An array of results of the SQL best practices assessment response.
   */
  @pageItems
  @identifiers(#[])
  rows: string[][];

  /**
   * The link to the next page of the best practices assessment response for the SQL Server instance. Null, if no more pages are available.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The SQL best practices assessment result column.
 */
model SqlServerInstanceBpaColumn {
  /**
   * The name of the result column.
   */
  name?: string;

  /**
   * The type of the result column.
   */
  type?: SqlServerInstanceBpaColumnType;
}

/**
 * The response for running migration assessment on the SQL Server instance.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceRunMigrationAssessmentResponse {
  /**
   * The unique identifier of the job.
   */
  id?: string;

  /**
   * The name of the SQL Server instance.
   */
  instanceName?: string;

  /**
   * The status of the job.
   */
  jobStatus?: JobStatus;

  /**
   * The exception message if the job failed.
   */
  jobException?: string;

  /**
   * The background job details.
   */
  backgroundJob?: BackgroundJob;

  /**
   * The list of sequencer actions.
   */
  @identifiers(#["actionId"])
  sequencerActions?: SequencerAction[];
}

/**
 * The background job details.
 */
model BackgroundJob {
  /**
   * The state of the background job.
   */
  state?: State;

  /**
   * The execution state of the background job.
   */
  executionState?: ExecutionState;

  /**
   * The start time of the background job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the background job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The last execution status of the background job.
   */
  lastExecutionStatus?: LastExecutionStatus;

  /**
   * The last execution time of the background job in ISO 8601 date-time format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastExecutionTime?: utcDateTime;

  /**
   * The next execution time of the background job in ISO 8601 date-time format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextExecutionTime?: utcDateTime;
}

/**
 * The sequencer action details.
 */
model SequencerAction {
  /**
   * The unique identifier of the sequencer action.
   */
  actionId?: string;

  /**
   * The state of the sequencer action.
   */
  state?: SequencerState;

  /**
   * The result of the sequencer action.
   */
  result?: Result;
}

/**
 * The request for running a SQL Server Instance target recommendation job.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceRunTargetRecommendationJobRequest {
  /**
   * Controls whether the SQL Server instance resource is updated with the target recommendation details after the job completes.
   */
  resourceUpdateMode?: ResourceUpdateMode = ResourceUpdateMode.UpdateAllTargetRecommendationDetails;

  /**
   * Specifies whether to include file-level requirements in the target recommendation report.
   */
  includeFileLevelRequirements?: boolean = false;

  /**
   * The Azure region used for target SKU pricing and availability (e.g., 'westus', 'eastus2', 'westeurope').
   */
  targetLocation?: string = "westus";

  /**
   * The percentile of performance data points used for aggregation (Range: 1-100).
   */
  @maxValue(100)
  @minValue(1)
  percentile?: int32 = 95;

  /**
   * The lookback period in days for performance data used in the target recommendation.
   */
  @maxValue(30)
  @minValue(7)
  lookbackPeriodInDays?: int32 = 30;
}

/**
 * Represents the response of a SQL Server Instance target recommendation job execution.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceRunTargetRecommendationJobResponse {
  /**
   * Represents the current status of the target recommendation job.
   */
  @visibility(Lifecycle.Read)
  jobStatus?: JobStatus;
}

/**
 * The request for retrieving SQL Server Instance target recommendation reports.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceTargetRecommendationReportsRequest {
  /**
   * Zero-based offset indicating where to continue reading reports in the overall list of reports. Defaults to 0 if not provided. This value must be used together with the corresponding sectionOffset to resume pagination. The reportOffset advances only after all sections of the current report have been retrieved. To retrieve subsequent pages, use the nextReportOffset and nextSectionOffset values from the previous response.
   */
  @minValue(0)
  reportOffset?: int32;

  /**
   * Zero-based offset indicating where to continue reading sections within the current report. Defaults to 0 if not provided. This value must be used together with the corresponding reportOffset to resume pagination. To retrieve subsequent pages, use the nextReportOffset and nextSectionOffset values from the previous response.
   */
  @minValue(0)
  sectionOffset?: int32;

  /**
   * Filters the report to a specific section type. If not specified, all section types are returned. Section types are grouped into two categories: requirements sections contain performance and resource metrics collected from the source SQL Server, while recommendation sections contain suggested Azure target SKUs derived from those requirements.
   */
  sectionType?: SqlServerInstanceTargetRecommendationReportSectionType;

  /**
   * The list of database names to filter the report sections by. If not specified, sections for all databases are returned.
   */
  databaseNames?: string[];
}

/**
 * Represents the response containing SQL Server Instance target recommendation reports.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceTargetRecommendationReportsResponse {
  /**
   * Represents the status of the latest target recommendation job. Report records are returned only when the job status is Succeeded.
   */
  @visibility(Lifecycle.Read)
  jobStatus?: JobStatus;

  /**
   * A collection of target recommendation reports. Returned only when the job status is Succeeded.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["reportId"])
  reports?: SqlServerInstanceTargetRecommendationReport[];

  /**
   * The total number of target recommendation reports available for retrieval. Currently, only the latest report is returned, so this value is always 1.
   */
  @visibility(Lifecycle.Read)
  totalReportCount?: int32;

  /**
   * The report offset to use in the next request along with nextSectionOffset to continue retrieving data. This value remains the same until all sections of the current report have been retrieved. Present only when there is more data to retrieve. When both nextReportOffset and nextSectionOffset are absent, all data has been returned.
   */
  @visibility(Lifecycle.Read)
  nextReportOffset?: int32;

  /**
   * The section offset to use in the next request along with nextReportOffset to continue retrieving sections of the current report. Present only when there is more data to retrieve. When both nextReportOffset and nextSectionOffset are absent, all data has been returned.
   */
  @visibility(Lifecycle.Read)
  nextSectionOffset?: int32;
}

/**
 * Represents a target recommendation report for a SQL Server instance.
 */
model SqlServerInstanceTargetRecommendationReport {
  /**
   * The identifier of the target recommendation report.
   */
  @visibility(Lifecycle.Read)
  reportId?: string;

  /**
   * The UTC timestamp in ISO 8601 format indicating when the target recommendation report was generated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Collection of sections included in the report.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  sections?: SqlServerInstanceTargetRecommendationReportSection[];
}

/**
 * Represents a section within a target recommendation report.
 */
model SqlServerInstanceTargetRecommendationReportSection {
  /**
   * Serialized JSON representation of the section data. If isCompressed is true, the value contains base64-encoded GZip-compressed JSON.
   */
  @visibility(Lifecycle.Read)
  data?: string;

  /**
   * The type of this section. Requirements sections contain source server performance metrics, while recommendation sections contain suggested Azure target SKUs.
   */
  @visibility(Lifecycle.Read)
  type?: SqlServerInstanceTargetRecommendationReportSectionType;

  /**
   * The name of the database to which this section applies. An empty string indicates that the section contains instance-level data rather than database-level data.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * Indicates whether the data field contains base64-encoded GZip-compressed JSON.
   */
  @visibility(Lifecycle.Read)
  isCompressed?: boolean;
}

/**
 * Represents the response containing the SQL Server Instance Migration Readiness report.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceMigrationReadinessReportResponse {
  /**
   * The migration readiness report as a serialized JSON string. When isCompressed is true, the value is base64-encoded GZip-compressed and must be decoded and decompressed before parsing.
   */
  @visibility(Lifecycle.Read)
  report?: string;

  /**
   * Indicates whether the report field contains base64-encoded GZip-compressed JSON.
   */
  @visibility(Lifecycle.Read)
  isCompressed?: boolean;

  /**
   * The UTC timestamp in ISO 8601 format indicating when the migration readiness report was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;
}

/**
 * The response object for the request to run SQL best practices assessment.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceRunBestPracticesAssessmentResponse {
  /**
   * The unique identifier of the job.
   */
  id?: string;

  /**
   * The name of the SQL Server instance.
   */
  instanceName?: string;

  /**
   * The status of the job.
   */
  jobStatus?: JobStatus;

  /**
   * The exception message if the job failed.
   */
  jobException?: string;

  /**
   * The background job details.
   */
  backgroundJob?: BackgroundJob;

  /**
   * The list of sequencer actions.
   */
  @identifiers(#["actionId"])
  sequencerActions?: SequencerAction[];
}

/**
 * The response object for the request to run migration readiness assessment.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceRunMigrationReadinessAssessmentResponse {
  /**
   * The unique identifier of the job.
   */
  id?: string;

  /**
   * The name of the SQL Server instance.
   */
  instanceName?: string;

  /**
   * The status of the job.
   */
  jobStatus?: JobStatus;

  /**
   * The exception message if the job failed.
   */
  jobException?: string;

  /**
   * The background job details.
   */
  backgroundJob?: BackgroundJob;

  /**
   * The list of sequencer actions.
   */
  @identifiers(#["actionId"])
  sequencerActions?: SequencerAction[];
}

/**
 * The request for the status of the jobs running on the SQL Server instance.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceJobsStatusRequest {
  /**
   * The name of the feature to retrieve the job status for.
   */
  featureName?: string;

  /**
   * The type of the job to retrieve the status for.
   */
  jobType?: string;
}

/**
 * The response for the status of the jobs running on the SQL Server instance.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceJobsStatusResponse {
  /**
   * The list of jobs status running on the SQL Server instance.
   */
  @identifiers(#["id"])
  jobsStatus?: SqlServerInstanceJobStatus[];
}

/**
 * The status of the job running on the SQL Server instance.
 */
model SqlServerInstanceJobStatus {
  /**
   * The unique identifier of the job.
   */
  id?: string;

  /**
   * The name of the SQL Server instance.
   */
  instanceName?: string;

  /**
   * The status of the job.
   */
  jobStatus?: JobStatus;

  /**
   * The exception message if the job failed.
   */
  jobException?: string;

  /**
   * The background job details.
   */
  backgroundJob?: BackgroundJob;

  /**
   * The list of sequencer actions.
   */
  @identifiers(#["actionId"])
  sequencerActions?: SequencerAction[];
}

/**
 * The request for the jobs running on the SQL Server instance.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceJobsRequest {
  /**
   * The name of the feature to retrieve the jobs for.
   */
  featureName?: string;

  /**
   * The type of the job to retrieve the jobs for.
   */
  jobType?: string;
}

/**
 * The response for the jobs running on the SQL Server instance.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceJobsResponse {
  /**
   * The list of jobs running on the SQL Server instance.
   */
  @identifiers(#["id"])
  jobs?: SqlServerInstanceJob[];
}

/**
 * The job running on the SQL Server instance.
 */
model SqlServerInstanceJob {
  /**
   * The unique identifier of the job.
   */
  id?: string;

  /**
   * The name of the SQL Server instance.
   */
  instanceName?: string;

  /**
   * The status of the job.
   */
  jobStatus?: JobStatus;

  /**
   * The exception message if the job failed.
   */
  jobException?: string;

  /**
   * The background job details.
   */
  backgroundJob?: BackgroundJob;

  /**
   * The list of sequencer actions.
   */
  @identifiers(#["actionId"])
  sequencerActions?: SequencerAction[];
}

/**
 * The MI Link assessment request for the SQL Server instance.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceManagedInstanceLinkAssessmentRequest {
  /**
   * The Azure SQL Managed Instance resource ID to link with the SQL Server instance.
   */
  azureManagedInstanceResourceId: Azure.Core.armResourceIdentifier;

  /**
   * The role of managed instance in a distributed availability group, can be Primary or Secondary.
   */
  azureManagedInstanceRole?: AzureManagedInstanceRole;

  /**
   * An array of strings, where each value represents the name of a database to be replicated to the Azure SQL Managed Instance.
   */
  databaseNames: string[];

  /**
   * The name of the availability group to be used for the database replication.
   */
  availabilityGroupName: string;

  /**
   * The name of the DAG to be used for the database replication. Also referred to as Link Name.
   */
  distributedAvailabilityGroupName: string;

  /**
   * An array of strings, where each value represents the category of the assessment to be run. If this field is not provided, all assessment categories will be run.
   */
  assessmentCategories?: MiLinkAssessmentCategory[];

  /**
   * The IP address of the SQL Server instance.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  sqlServerIpAddress?: string;
}

/**
 * The response containing the results of the MI Link assessment.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerInstanceManagedInstanceLinkAssessmentResponse {
  /**
   * The list of the results for MI Link assessment.
   */
  @identifiers(#["name"])
  assessments?: SqlServerInstanceManagedInstanceLinkAssessment[];
}

/**
 * The status of an individual requirement for MI Link.
 */
model SqlServerInstanceManagedInstanceLinkAssessment {
  /**
   * The name of the requirement.
   */
  name?: string;

  /**
   * Validation category for the MI Link prerequisites assessment.
   */
  category?: MiLinkAssessmentCategory;

  /**
   * The status of the requirement.
   */
  status?: AssessmentStatus;

  /**
   * The information text about requirement.
   */
  information?: string;

  /**
   * Additional details about the check, including any recommended actions.
   */
  additionalInformation?: string;

  /**
   * List of names of databases that are failing the given assessment.
   */
  failingDbs?: string[];
}

/**
 * Properties of SQL Server License.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlServerLicenseProperties {
  /**
   * SQL Server license type.
   */
  billingPlan: BillingPlan;

  /**
   * The number of total cores of the license covers.
   */
  @minValue(16)
  physicalCores: int32;

  /**
   * This property represents the choice between SQL Server Core and ESU licenses.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  licenseCategory: LicenseCategory;

  /**
   * The activation state of the license.
   */
  activationState: ActivationState;

  /**
   * The Azure scope to which the license will apply.
   */
  scopeType: ScopeType;

  /**
   * The timestamp of the most recent activation of the SqlServerLicense.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActivatedAt?: utcDateTime;

  /**
   * The timestamp of the most recent deactivation of the SqlServerLicense.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastDeactivatedAt?: utcDateTime;

  /**
   * The tenantId the SQL Server license resource subscription resides in.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * An update to a SQL Server license resource.
 */
model SqlServerLicenseUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * null
   */
  properties?: SqlServerLicenseUpdateProperties;
}

/**
 * Properties of update SqlServerLicense.
 */
model SqlServerLicenseUpdateProperties {
  /**
   * SQL Server license type.
   */
  billingPlan?: BillingPlan;

  /**
   * The number of total cores of the license covers.
   */
  @minValue(16)
  physicalCores?: int32;

  /**
   * This property represents the choice between SQL Server Core and ESU licenses.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  licenseCategory?: LicenseCategory;

  /**
   * The activation state of the license.
   */
  activationState?: ActivationState;

  /**
   * The Azure scope to which the license will apply.
   */
  scopeType?: ScopeType;

  /**
   * The timestamp of the most recent activation of the SqlServerLicense.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActivatedAt?: utcDateTime;

  /**
   * The timestamp of the most recent deactivation of the SqlServerLicense.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastDeactivatedAt?: utcDateTime;

  /**
   * The tenantId the SQL Server license resource subscription resides in.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * A list of data controllers.
 */
model PageOfDataControllerResource {
  /**
   * Array of results.
   */
  @pageItems
  value?: DataControllerResource[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  nextLink?: url;
}

/**
 * The data controller properties.
 */
model DataControllerProperties {
  /**
   * The infrastructure the data controller is running on.
   */
  infrastructure?: Infrastructure = Infrastructure.Other;

  /**
   * Properties from the Kubernetes data controller
   */
  onPremiseProperty?: OnPremiseProperty;

  /**
   * The raw kubernetes information
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  k8sRaw?: unknown;

  /**
   * Properties on upload watermark.  Mostly timestamp for each upload data type
   */
  uploadWatermark?: UploadWatermark;

  /**
   * Last uploaded date from Kubernetes cluster. Defaults to current date time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUploadedDate?: utcDateTime;

  /**
   * Deprecated. Azure Arc Data Services data controller no longer expose any endpoint. All traffic are exposed through Kubernetes native API.
   */
  basicLoginInformation?: BasicLoginInformation;

  /**
   * Login credential for metrics dashboard on the Kubernetes cluster.
   */
  metricsDashboardCredential?: BasicLoginInformation;

  /**
   * Login credential for logs dashboard on the Kubernetes cluster.
   */
  logsDashboardCredential?: BasicLoginInformation;

  /**
   * Log analytics workspace id and primary key
   */
  logAnalyticsWorkspaceConfig?: LogAnalyticsWorkspaceConfig;

  /**
   * Deprecated. Service principal is deprecated in favor of Arc Kubernetes service extension managed identity.
   */
  uploadServicePrincipal?: UploadServicePrincipal;

  /**
   * The provisioning state of the Arc Data Controller resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * If a CustomLocation is provided, this contains the ARM id of the connected cluster the custom location belongs to.
   */
  clusterId?: string;

  /**
   * If a CustomLocation is provided, this contains the ARM id of the extension the custom location belongs to.
   */
  extensionId?: string;
}

/**
 * Properties from the Kubernetes data controller
 */
model OnPremiseProperty {
  /**
   * A globally unique ID identifying the associated Kubernetes cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  id: string;

  /**
   * Certificate that contains the Kubernetes cluster public key used to verify signing
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicSigningKey: string;

  /**
   * Unique thumbprint returned to customer to verify the certificate being uploaded
   */
  signingCertificateThumbprint?: string;
}

/**
 * Properties on upload watermark.  Mostly timestamp for each upload data type
 */
model UploadWatermark {
  /**
   * Last uploaded date for metrics from kubernetes cluster. Defaults to current date time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  metrics?: utcDateTime;

  /**
   * Last uploaded date for logs from kubernetes cluster. Defaults to current date time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  logs?: utcDateTime;

  /**
   * Last uploaded date for usages from kubernetes cluster. Defaults to current date time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usages?: utcDateTime;
}

/**
 * Log analytics workspace id and primary key
 */
model LogAnalyticsWorkspaceConfig {
  /**
   * Azure Log Analytics workspace ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  workspaceId?: string;

  /**
   * Primary key of the workspace
   */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  primaryKey?: string;
}

/**
 * Service principal for uploading billing, metrics and logs.
 */
model UploadServicePrincipal {
  /**
   * Client ID of the service principal for uploading data.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  clientId?: string;

  /**
   * Tenant ID of the service principal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  tenantId?: string;

  /**
   * Authority for the service principal. Example: https://login.microsoftonline.com/
   */
  authority?: string;

  /**
   * Secret of the service principal
   */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  clientSecret?: string;
}

/**
 * Used for updating a data controller resource.
 */
model DataControllerUpdate {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The data controller's properties
   */
  properties?: DataControllerProperties;
}

/**
 * The properties of an Active Directory connector resource
 */
model ActiveDirectoryConnectorProperties {
  /**
   * Username and password for domain service account authentication.
   */
  domainServiceAccountLoginInformation?: BasicLoginInformation;

  /**
   * The provisioning state of the Active Directory connector resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * null
   */
  spec: ActiveDirectoryConnectorSpec;

  /**
   * null
   */
  status?: ActiveDirectoryConnectorStatus;
}

/**
 * The specifications of the AD Kubernetes resource.
 */
model ActiveDirectoryConnectorSpec {
  /**
   * null
   */
  activeDirectory: ActiveDirectoryConnectorDomainDetails;

  /**
   * null
   */
  dns: ActiveDirectoryConnectorDNSDetails;
}

/**
 * Active Directory domain details
 */
model ActiveDirectoryConnectorDomainDetails {
  /**
   * Name (uppercase) of the Active Directory domain that this AD connector will be associated with.
   */
  realm: string;

  /**
   * NETBIOS name of the Active Directory domain.
   */
  netbiosDomainName?: string;

  /**
   * The service account provisioning mode for this Active Directory connector.
   */
  serviceAccountProvisioning?: AccountProvisioningMode = AccountProvisioningMode.Manual;

  /**
   * The distinguished name of the Active Directory Organizational Unit.
   */
  ouDistinguishedName?: string;

  /**
   * null
   */
  domainControllers?: ActiveDirectoryDomainControllers;
}

/**
 * Details about the Active Directory domain controllers associated with this AD connector instance
 */
model ActiveDirectoryDomainControllers {
  /**
   * Information about the Primary Domain Controller (PDC) in the AD domain.
   */
  primaryDomainController?: ActiveDirectoryDomainController;

  /**
   * null
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["hostname"])
  secondaryDomainControllers?: ActiveDirectoryDomainController[];
}

/**
 * Information about a domain controller in the AD domain.
 */
model ActiveDirectoryDomainController {
  /**
   * Fully-qualified domain name of a domain controller in the AD domain.
   */
  hostname: string;
}

/**
 * DNS server details
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ActiveDirectoryConnectorDNSDetails {
  /**
   * DNS domain name for which DNS lookups should be forwarded to the Active Directory DNS servers.
   */
  domainName?: string;

  /**
   * List of Active Directory DNS server IP addresses.
   */
  nameserverIPAddresses: string[];

  /**
   * Replica count for DNS proxy service. Default value is 1.
   */
  replicas?: int64 = 1;

  /**
   * Flag indicating whether to prefer Kubernetes DNS server response over AD DNS server response for IP address lookups.
   */
  preferK8sDnsForPtrLookups?: boolean = true;
}

/**
 * The status of the Kubernetes custom resource.
 */
model ActiveDirectoryConnectorStatus {
  ...Record<unknown>;

  /**
   * The time that the custom resource was last updated.
   */
  lastUpdateTime?: string;

  /**
   * The version of the replicaSet associated with the AD connector custom resource.
   */
  observedGeneration?: int64;

  /**
   * The state of the AD connector custom resource.
   */
  state?: string;
}

/**
 * Postgres Instance properties.
 */
model PostgresInstanceProperties {
  /**
   * The data controller id
   */
  dataControllerId?: string;

  /**
   * The instance admin
   */
  admin?: string;

  /**
   * Username and password for basic authentication.
   */
  basicLoginInformation?: BasicLoginInformation;

  /**
   * The raw kubernetes information
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  k8sRaw?: unknown;

  /**
   * Last uploaded date from Kubernetes cluster. Defaults to current date time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUploadedDate?: utcDateTime;

  /**
   * The provisioning state of the Azure Arc-enabled PostgreSQL instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * The resource model definition representing SKU for Azure Database for PostgresSQL - Azure Arc
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PostgresInstanceSku extends CommonSku {
  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier.
   */
  tier?: "Hyperscale" = "Hyperscale";
}

/**
 * The resource model definition representing SKU for ARM resources
 */
model CommonSku {
  /**
   * The name of the SKU.  It is typically a letter+number code
   */
  name: string;

  /**
   * Whether dev/test is enabled. When the dev field is set to true, the resource is used for dev/test purpose.
   */
  dev?: boolean = true;

  /**
   * The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.
   */
  size?: string;

  /**
   * If the service has different generations of hardware, for the same SKU, then that can be captured here.
   */
  family?: string;

  /**
   * If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
   */
  capacity?: int32;
}

/**
 * An update to a Postgres Instance.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PostgresInstanceUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Postgres Instance properties.
   */
  properties?: PostgresInstanceProperties;
}

/**
 * The properties of Arc Sql Server availability group resource
 */
model SqlServerAvailabilityGroupResourceProperties {
  /**
   * ID GUID of the availability group.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[A-Za-z0-9]{8}-([A-Za-z0-9]{4}-){3}[A-Za-z0-9]{12}$")
  availabilityGroupId?: string;

  /**
   * the SQL server name.
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * the SQL Server Instance name.
   */
  @visibility(Lifecycle.Read)
  instanceName?: string;

  /**
   * The unique ID of the hybrid machine that this resource belongs to.
   */
  @visibility(Lifecycle.Read)
  vmId?: string;

  /**
   * Timestamp for when the data was collected from the client machine.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  collectionTimestamp?: utcDateTime;

  /**
   * Availability Group Info
   */
  info?: AvailabilityGroupInfo;

  /**
   * A list of Availability Group Replicas.
   */
  replicas?: SqlServerAvailabilityGroupResourcePropertiesReplicas;

  /**
   * A list of Availability Group Database Replicas.
   */
  databases?: SqlServerAvailabilityGroupResourcePropertiesDatabases;

  /**
   * The provisioning state of the Arc-enabled SQL Server availability group resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * The specifications of the availability group state
 */
model AvailabilityGroupInfo {
  /**
   * User-defined failure condition level under which an automatic failover must be triggered.
   */
  failureConditionLevel?: int32;

  /**
   * Wait time (in milliseconds) for the sp_server_diagnostics system stored procedure to return server-health information, before the server instance is assumed to be slow or not responding.
   */
  healthCheckTimeout?: int32;

  /**
   * Preferred location for performing backups on the availability databases in this availability group.
   */
  @visibility(Lifecycle.Read)
  automatedBackupPreferenceDescription?: string;

  /**
   * SQL Server availability group current version.
   */
  @visibility(Lifecycle.Read)
  version?: int32;

  /**
   * Specifies whether this is a basic availability group.
   */
  basicFeatures?: boolean;

  /**
   * Specifies whether DTC support has been enabled for this availability group.
   */
  dtcSupport?: boolean;

  /**
   * Specifies whether the availability group supports failover for database health conditions.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  dbFailover?: boolean;

  /**
   * Specifies whether this is a distributed availability group.
   */
  isDistributed?: boolean;

  /**
   * SQL Server availability group cluster type description
   */
  @visibility(Lifecycle.Read)
  clusterTypeDescription?: string;

  /**
   * The number of secondary replicas that must be in a synchronized state for a commit to complete.
   */
  requiredSynchronizedSecondariesToCommit?: int32;

  /**
   * SQL Server availability group contained system databases.
   */
  isContained?: boolean;

  /**
   * Name of the server instance that is hosting the current primary replica.
   */
  @visibility(Lifecycle.Read)
  primaryReplica?: string;

  /**
   * Indicates the recovery health of the primary replica.
   */
  @visibility(Lifecycle.Read)
  primaryRecoveryHealthDescription?: string;

  /**
   * Indicates the recovery health of a secondary replica.
   */
  @visibility(Lifecycle.Read)
  secondaryRecoveryHealthDescription?: string;

  /**
   * Reflects a roll-up of the synchronization health of all availability replicas in the availability group.
   */
  @visibility(Lifecycle.Read)
  synchronizationHealthDescription?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  replicationPartnerType?: ReplicationPartnerType;

  /**
   * The listener for the sql server availability group
   */
  listener?: SqlAvailabilityGroupStaticIPListenerProperties;
}

/**
 * The properties of a static IP Arc Sql availability group listener
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlAvailabilityGroupStaticIPListenerProperties {
  /**
   * the DNS name for the listener.
   */
  dnsName?: string;

  /**
   * IP V4 Addresses and masks for the listener.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @identifiers(#["ipAddress"])
  ipV4AddressesAndMasks?: SqlAvailabilityGroupIpV4AddressesAndMasksPropertiesItem[];

  /**
   * IP V6 Addresses for the listener
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  ipV6Addresses?: string[];

  /**
   * Network port for the listener. Default is 1433.
   */
  port?: int32;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlAvailabilityGroupIpV4AddressesAndMasksPropertiesItem {
  /**
   * IPV4 address
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  ipAddress?: string;

  /**
   * IPV4 netmask
   */
  mask?: string;
}

/**
 * A list of Availability Group Replicas.
 */
model SqlServerAvailabilityGroupResourcePropertiesReplicas {
  /**
   * Array of Availability Group Replicas.
   */
  @pageItems
  @identifiers(#[])
  value?: SqlAvailabilityGroupReplicaResourceProperties[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * The properties of Arc Sql availability group replica resource
 */
model SqlAvailabilityGroupReplicaResourceProperties {
  /**
   * ID GUID of the availability group.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[A-Za-z0-9]{8}-([A-Za-z0-9]{4}-){3}[A-Za-z0-9]{12}$")
  replicaId?: string;

  /**
   * The replica name.
   */
  replicaName?: string;

  /**
   * Resource id of this replica. This is required for a distributed availability group, in which case it describes the location of the availability group that hosts one replica in the DAG. In a non-distributed availability group this field is optional but can be used to store the Azure resource id for AG.
   */
  replicaResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * null
   */
  configure?: AvailabilityGroupConfigure;

  /**
   * null
   */
  state?: AvailabilityGroupState;
}

/**
 * The specifications of the availability group replica configuration
 */
model AvailabilityGroupConfigure {
  /**
   * Name of the mirroring endpoint URL
   */
  endpointName?: string;

  /**
   * Mirroring endpoint URL of availability group replica
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  endpointUrl?: string;

  /**
   * Permitted authentication modes for the mirroring endpoint.
   */
  endpointAuthenticationMode?: ConnectionAuth;

  /**
   * Name of certificate to use for authentication. Required if any CERTIFICATE authentication modes are specified.
   */
  certificateName?: string;

  /**
   * The login which will connect to the mirroring endpoint.
   */
  endpointConnectLogin?: string;

  /**
   * Property that determines whether a given availability replica can run in synchronous-commit mode
   */
  availabilityMode?: ArcSqlServerAvailabilityMode;

  /**
   * The Availability Synchronization mode of the availability group replica.
   */
  @visibility(Lifecycle.Read)
  availabilityModeDescription?: string;

  /**
   * Property to set the failover mode of the availability group replica
   */
  failoverMode?: ArcSqlServerFailoverMode;

  /**
   * The failover mode of the availability group replica.
   */
  @visibility(Lifecycle.Read)
  failoverModeDescription?: string;

  /**
   * The time-out period of availability group session replica, in seconds.
   */
  sessionTimeout?: int32;

  /**
   * Whether the primary replica should allow all connections or only READ_WRITE connections (disallowing ReadOnly connections)
   */
  primaryAllowConnections?: PrimaryAllowConnections;

  /**
   * Whether the availability allows all connections or only read-write connections.
   */
  @visibility(Lifecycle.Read)
  primaryRoleAllowConnectionsDescription?: string;

  /**
   * Whether the secondary replica should allow all connections, no connections, or only ReadOnly connections.
   */
  secondaryAllowConnections?: SecondaryAllowConnections;

  /**
   * Whether an availability replica that is performing the secondary role (that is, a secondary replica) can accept connections from clients.
   */
  @visibility(Lifecycle.Read)
  secondaryRoleAllowConnectionsDescription?: string;

  /**
   * Date that the replica was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  replicaCreateDate?: utcDateTime;

  /**
   * Date that the replica was modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  replicaModifyDate?: utcDateTime;

  /**
   * Represents the user-specified priority for performing backups on this replica relative to the other replicas in the same availability group.
   */
  backupPriority?: int32;

  /**
   * Connectivity endpoint (URL) of the read only availability replica.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  readOnlyRoutingUrl?: string;

  /**
   * Connectivity endpoint (URL) of the read write availability replica.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  readWriteRoutingUrl?: string;

  /**
   * Specifies how the secondary replica will be initially seeded. AUTOMATIC enables direct seeding. This method will seed the secondary replica over the network. This method does not require you to backup and restore a copy of the primary database on the replica. MANUAL specifies manual seeding (default). This method requires you to create a backup of the database on the primary replica and manually restore that backup on the secondary replica.
   */
  seedingMode?: SeedingMode;

  /**
   * Describes seeding mode.
   */
  @visibility(Lifecycle.Read)
  seedingModeDescription?: string;
}

/**
 * The specifications of the availability group state
 */
model AvailabilityGroupState {
  /**
   * Current Always On availability groups role of the availability group replica.
   */
  @visibility(Lifecycle.Read)
  availabilityGroupReplicaRole?: string;

  /**
   * Current operational state of the availability group replica
   */
  @visibility(Lifecycle.Read)
  operationalStateDescription?: string;

  /**
   * Recovery health of the availability group replica.
   */
  @visibility(Lifecycle.Read)
  recoveryHealthDescription?: string;

  /**
   * Reflects a rollup of the database synchronization state (synchronization_state) of all joined availability databases (also known as replicas) and the availability mode of the replica (synchronous-commit or asynchronous-commit mode). The rollup will reflect the least healthy accumulated state the databases on the replica.
   */
  @visibility(Lifecycle.Read)
  synchronizationHealthDescription?: string;

  /**
   * Whether a secondary replica is currently connected to the primary replica.
   */
  @visibility(Lifecycle.Read)
  connectedStateDescription?: string;

  /**
   * Text description of the last connection error of the availability group replica.
   */
  @visibility(Lifecycle.Read)
  lastConnectErrorDescription?: string;

  /**
   * Date and time timestamp indicating when the last connect error occurred.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConnectErrorTimestamp?: utcDateTime;
}

/**
 * A list of Availability Group Database Replicas.
 */
model SqlServerAvailabilityGroupResourcePropertiesDatabases {
  /**
   * Array of Availability Group Database Replicas.
   */
  @pageItems
  @identifiers(#[])
  value?: SqlAvailabilityGroupDatabaseReplicaResourceProperties[];

  /**
   * Link to retrieve next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}
/**
 * The properties of Arc Sql availability group database replica resource
 */
model SqlAvailabilityGroupDatabaseReplicaResourceProperties {
  /**
   * the database name.
   */
  databaseName?: string;

  /**
   * the database replica name.
   */
  @visibility(Lifecycle.Read)
  replicaName?: string;

  /**
   * Whether the availability database is local.
   */
  @visibility(Lifecycle.Read)
  isLocal?: boolean;

  /**
   * Returns 1 if the replica is primary, or 0 if it is a secondary replica.
   */
  @visibility(Lifecycle.Read)
  isPrimaryReplica?: boolean;

  /**
   * Description of the data-movement state.
   */
  @visibility(Lifecycle.Read)
  synchronizationStateDescription?: string;

  /**
   * Whether this replica is transaction committer.
   */
  @visibility(Lifecycle.Read)
  isCommitParticipant?: boolean;

  /**
   * Description of the health of database.
   */
  @visibility(Lifecycle.Read)
  synchronizationHealthDescription?: string;

  /**
   * Description of the database state of the availability replica.
   */
  @visibility(Lifecycle.Read)
  databaseStateDescription?: string;

  /**
   * Whether this data movement is suspended.
   */
  @visibility(Lifecycle.Read)
  isSuspended?: boolean;

  /**
   * Description of the database suspended state reason.
   */
  @visibility(Lifecycle.Read)
  suspendReasonDescription?: string;
}

/**
 * An update to availability group resource.
 */
model SqlServerAvailabilityGroupUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The Server Availability Group's properties
   */
  properties?: SqlServerAvailabilityGroupResourceProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AvailabilityGroupRetrievalFilters {
  /**
   * Filter retrieval based on availability group type.
   */
  availabilityGroupTypeFilter?: ArcSqlServerAvailabilityGroupTypeFilter;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  replicationPartnerTypeFilter?: ReplicationPartnerType;
}

/**
 * Options used in creating an availability group
 */
model AvailabilityGroupCreateUpdateConfiguration {
  /**
   * Name of the availability group.
   */
  availabilityGroupName?: string;

  /**
   * List of availability group replicas.
   */
  @identifiers(#["serverInstance"])
  replicas?: AvailabilityGroupCreateUpdateReplicaConfiguration[];

  /**
   * List of databases to include in the availability group.
   */
  databases?: string[];

  /**
   * Preferred replica for running automated backups.
   */
  automatedBackupPreference?: AutomatedBackupPreference;

  /**
   * User-defined failure condition level under which an automatic failover must be triggered.
   */
  failureConditionLevel?: FailureConditionLevel;

  /**
   * Wait time (in milliseconds) for the sp_server_diagnostics system stored procedure to return server-health information, before the server instance is assumed to be slow or not responding.
   */
  healthCheckTimeout?: int32;

  /**
   * Specifies whether the availability group supports failover for database health conditions.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  dbFailover?: DbFailover;

  /**
   * Specifies whether DTC support has been enabled for this availability group.
   */
  dtcSupport?: DtcSupport;

  /**
   * The number of secondary replicas that must be in a synchronized state for a commit to complete.
   */
  requiredSynchronizedSecondariesToCommit?: int32;

  /**
   * Set to WSFC when availability group is on a failover cluster instance on a Windows Server failover cluster. Set to NONE when availability group not using WSFC for cluster coordination.
   */
  clusterType?: ClusterType;

  /**
   * The listener for the sql server availability group
   */
  listener?: SqlAvailabilityGroupStaticIPListenerProperties;
}

/**
 * The specifications of the availability group replica configuration
 */
model AvailabilityGroupCreateUpdateReplicaConfiguration {
  /**
   * the server instance hosting the replica.
   */
  serverInstance?: string;

  /**
   * Name of the database mirroring endpoint URL for the availability group replica
   */
  endpointName?: string;

  /**
   * Database mirroring endpoint URL of availability group replica
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  endpointUrl?: string;

  /**
   * Permitted authentication modes for the mirroring endpoint.
   */
  endpointAuthenticationMode?: ConnectionAuth;

  /**
   * Name of certificate to use for authentication. Required if any CERTIFICATE authentication modes are specified.
   */
  certificateName?: string;

  /**
   * The login which will connect to the mirroring endpoint
   */
  endpointConnectLogin?: string;

  /**
   * Property that determines whether a given availability replica can run in synchronous-commit mode
   */
  availabilityMode?: ArcSqlServerAvailabilityMode;

  /**
   * Property to set the failover mode of the availability group replica
   */
  failoverMode?: ArcSqlServerFailoverMode;

  /**
   * Specifies how the secondary replica will be initially seeded. AUTOMATIC enables direct seeding. This method will seed the secondary replica over the network. This method does not require you to backup and restore a copy of the primary database on the replica. MANUAL specifies manual seeding (default). This method requires you to create a backup of the database on the primary replica and manually restore that backup on the secondary replica.
   */
  seedingMode?: SeedingMode;

  /**
   * Represents the user-specified priority for performing backups on this replica relative to the other replicas in the same availability group.
   */
  backupPriority?: int32;

  /**
   * Whether the secondary replica should allow all connections, no connections, or only ReadOnly connections.
   */
  secondaryRoleAllowConnections?: SecondaryAllowConnections;

  /**
   * Connectivity endpoint (URL) of the read only availability replica.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  secondaryRoleReadOnlyRoutingUrl?: string;

  /**
   * Whether the primary replica should allow all connections or only READ_WRITE connections (disallowing ReadOnly connections)
   */
  primaryRoleAllowConnections?: PrimaryAllowConnections;

  /**
   * List of read only routing URLs.
   */
  primaryRoleReadOnlyRoutingList?: string[];

  /**
   * The time-out period of availability group session replica, in seconds.
   */
  sessionTimeout?: int32;
}

/**
 * Options used in creating a distributed availability group.
 */
model DistributedAvailabilityGroupCreateUpdateConfiguration {
  /**
   * Name of the availability group.
   */
  availabilityGroupName?: string;

  /**
   * The initial primary availability group for the distributed availability group.
   */
  primaryAvailabilityGroup?: DistributedAvailabilityGroupCreateUpdateAvailabilityGroupConfiguration;

  /**
   * The initial secondary availability group for the distributed availability group.
   */
  secondaryAvailabilityGroup?: DistributedAvailabilityGroupCreateUpdateAvailabilityGroupConfiguration;
}

/**
 * The availability group configuration specification for a distributed availability group.
 */
model DistributedAvailabilityGroupCreateUpdateAvailabilityGroupConfiguration {
  /**
   * The azure resource identifier for the availability group.
   */
  availabilityGroup?: Azure.Core.armResourceIdentifier;

  /**
   * The listener URL of the availability group.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  listenerUrl?: url;

  /**
   * The availability mode of the availability group.
   */
  availabilityMode?: ArcSqlServerAvailabilityMode;

  /**
   * The failover mode of the availability group.
   */
  failoverMode?: ArcSqlServerFailoverMode;

  /**
   * The seeding mode of the availability group.
   */
  seedingMode?: SeedingMode;

  /**
   * The certificate configuration for the availability group.
   */
  certificateConfiguration?: DistributedAvailabilityGroupCreateUpdateAvailabilityGroupCertificateConfiguration;
}

/**
 * The availability group certificate configuration.
 */
model DistributedAvailabilityGroupCreateUpdateAvailabilityGroupCertificateConfiguration {
  /**
   * Name of the certificate.
   */
  certificateName?: string;
}

/**
 * The configuration for the new Managed Instance Link resource.
 */
model ManagedInstanceLinkCreateUpdateConfiguration {
  /**
   * The configuration for the SQL Server availability group resource.
   */
  availabilityGroup?: AvailabilityGroupCreateUpdateConfiguration;

  /**
   * The distributed availability group configuration for the MI link.
   */
  distributedAvailabilityGroup?: DistributedAvailabilityGroupCreateUpdateConfiguration;

  /**
   * The MI Link specific distributed availability group configuration.
   */
  miLinkConfiguration?: MiLinkCreateUpdateConfiguration;
}

/**
 * The MI Link specific configuration.
 */
model MiLinkCreateUpdateConfiguration {
  /**
   * The name of the availability group to be created on the Managed Instance.
   */
  instanceAvailabilityGroupName?: string;
}

/**
 * List of database names.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model databases {
  /**
   * List of database names.
   */
  values?: string[];
}

/**
 * The azure resource identifier for the Sql Managed Instance.
 */
model FailoverMiLinkResourceId {
  /**
   * Azure resource id for the sql managed instance.
   */
  managedInstanceId?: Azure.Core.armResourceIdentifier;

  /**
   * Whether to perform a Force Failover as opposed to just a regular Failover.
   */
  force?: boolean;
}

/**
 * The properties of Arc Sql Server database resource
 */
model SqlServerDatabaseResourceProperties {
  /**
   * Collation of the database.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  collationName?: string;

  /**
   * Creation date of the database.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  databaseCreationDate?: utcDateTime;

  /**
   * Compatibility level of the database
   */
  @maxValue(200)
  @minValue(80)
  compatibilityLevel?: int32;

  /**
   * Size of the database.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sizeMB?: float32;

  /**
   * Total size in MB for the log (ldf) files for this database.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logFileSizeMB?: float32;

  /**
   * Total size in MB for the data (mdf and ndf) files for this database.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataFileSizeMB?: float32;

  /**
   * Space left of the database.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  spaceAvailableMB?: float32;

  /**
   * State of the database.
   */
  state?: DatabaseState;

  /**
   * Whether the database is read only or not.
   */
  isReadOnly?: boolean;

  /**
   * Status of the database.
   */
  recoveryMode?: RecoveryMode;

  /**
   * List of features that are enabled for the database
   */
  databaseOptions?: SqlServerDatabaseResourcePropertiesDatabaseOptions;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  backupInformation?: SqlServerDatabaseResourcePropertiesBackupInformation;

  /**
   * The backup profile for the SQL server.
   */
  backupPolicy?: BackupPolicy;

  /**
   * This records the earliest start date and time that restore is available for this database (ISO8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;

  /**
   * Database create mode. PointInTimeRestore: Create a database by restoring a point in time backup of an existing database. sourceDatabaseId and restorePointInTime must be specified.
   */
  createMode?: DatabaseCreateMode;

  /**
   * The name of the source database associated with create operation of this database.
   */
  sourceDatabaseId?: string;

  /**
   * The unique ID of the hybrid machine that this resource belongs to.
   */
  @visibility(Lifecycle.Read)
  vmId?: string;

  /**
   * Conditional. If createMode is PointInTimeRestore, this value is required. Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restorePointInTime?: utcDateTime;

  /**
   * The provisioning state of the Arc-enabled SQL Server database resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The time when last successful database upload was performed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastDatabaseUploadTime?: utcDateTime;

  /**
   * Migration related configuration.
   */
  migration?: DataBaseMigration;
}

/**
 * List of features that are enabled for the database
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model SqlServerDatabaseResourcePropertiesDatabaseOptions {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isAutoCloseOn?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isAutoShrinkOn?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isAutoCreateStatsOn?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isAutoUpdateStatsOn?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isRemoteDataArchiveEnabled?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isMemoryOptimizationEnabled?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isEncrypted?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isTrustworthyOn?: boolean;

  /**
   * Whether the database uses the In-Memory OLTP feature for storing in-memory objects.
   */
  isHekatonFilesOn?: boolean;

  /**
   * How many Hekaton files the DB has on disk, if it uses in-memory OLTP objects.
   */
  numberOfHekatonFiles?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlServerDatabaseResourcePropertiesBackupInformation {
  /**
   * Date time of last full backup.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastFullBackup?: utcDateTime;

  /**
   * Date time of last log backup.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLogBackup?: utcDateTime;
}

/**
 * Migration related configuration.
 */
model DataBaseMigration {
  /**
   * Migration assessments related configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  assessment?: DataBaseMigrationAssessment;

  /**
   * Migration jobs/actual data movement/data migrations associated with this database related information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  jobs?: DatabaseMigrationJobsItem[];
}

/**
 * The migration assessment related configuration.
 */
model DataBaseMigrationAssessment {
  /**
   * The time when Migration Assessment Report upload was last performed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  assessmentUploadTime?: utcDateTime;

  /**
   * The UTC timestamp in ISO 8601 format indicating when the latest target recommendations were generated for this database. This value is set as part of a successful RunTargetRecommendation job and is independent of when the migration readiness results were uploaded (assessmentUploadTime).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  targetRecommendationGenerationTime?: utcDateTime;

  /**
   * Issues and warnings impacting the migration of Database to particular Azure Migration Target.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  databaseAssessments?: DatabaseAssessmentsItem[];

  /**
   * The target readiness for migration for this database.
   */
  @visibility(Lifecycle.Read)
  targetReadiness?: TargetReadiness;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseAssessmentsItem {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  appliesToMigrationTargetPlatform?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  featureId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  issueCategory?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  moreInformation?: string;
}

/**
 * The target readiness for migration for this database.
 */
model TargetReadiness {
  /**
   * The SKU recommendation summary.
   */
  azureSqlDatabase?: SkuRecommendationSummary;

  /**
   * The SKU recommendation summary.
   */
  azureSqlManagedInstance?: SkuRecommendationSummary;

  /**
   * The SKU recommendation summary.
   */
  azureSqlVirtualMachine?: SkuRecommendationSummary;
}

/**
 * The SKU recommendation summary.
 */
model SkuRecommendationSummary {
  /**
   * Number of blocker issues to fix before migrating this database to the target platform.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  numOfBlockerIssues?: int32;

  /**
   * The target recommendation Status for this database.
   */
  recommendationStatus?: RecommendationStatus;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  impactedObjectsSummary?: ImpactedObjectsInfo[];

  /**
   * The monthly cost of the particular SKU.
   */
  monthlyCost?: SkuRecommendationResultsMonthlyCost;

  /**
   * The monthly cost for all different savings options applicable for the particular SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  monthlyCostOptions?: SkuRecommendationResultsMonthlyCostOptionItem[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetSku?: SkuRecommendationSummaryTargetSku;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SkuRecommendationSummaryTargetSku {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  category?: SkuRecommendationSummaryTargetSkuCategory;

  /**
   * Compute Size in vCores.
   */
  computeSize?: int32;

  /**
   * max storage for this particular SKU, in MB.
   */
  storageMaxSizeInMb?: float32;

  /**
   * The predicted data size in MB in Azure SQL, will impact the billing cost.
   */
  predictedDataSizeInMb?: float32;

  /**
   * The predicted log size in MB in Azure SQL, will impact the billing cost.
   */
  predictedLogSizeInMb?: float32;

  /**
   * The max storage IOPS in Azure SQL, will impact the billing cost.
   */
  maxStorageIops?: float32;

  /**
   * The max throughput in Azure SQL, will impact the billing cost.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxThroughputMBps?: float32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SkuRecommendationSummaryTargetSkuCategory {
  /**
   * The compute tier of the target SKU.
   */
  computeTier?: string;

  /**
   * The hardware type of the target SKU.
   */
  hardwareType?: string;

  /**
   * The SQL purchasing model of the target SKU.
   */
  sqlPurchasingModel?: string;

  /**
   * The SQL service tier of the target SKU.
   */
  sqlServiceTier?: string;

  /**
   * Indicates if zone redundancy is available for the target SKU.
   */
  zoneRedundancyAvailable?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseMigrationJobsItem {
  /**
   * Reference identifier for tracking purposes/optional link to system initiating this migration. e.g. Arc MI link job id, DMS resource id.
   */
  migrationTrackingId?: string;

  /**
   * Mode/type of migration.
   */
  migrationMode?: MigrationMode;

  /**
   * To indicate the client from which the migration is initiated from e.g. Azure Arc, DMS-Azure Portal/PS/CLI for additional tracking.
   */
  initiatedFrom?: initiatedFrom;

  /**
   * Status of the migration job.
   */
  status?: MigrationStatus;

  /**
   * Last error if any associated with this migration job.
   */
  lastError?: string;

  /**
   * Type of target in Azure this database is being migrated to.
   */
  targetType?: TargetType;

  /**
   * Resource Id of the target SQL resource for this migration job.
   */
  targetResourceId?: string;

  /**
   * Time when migration job was started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Time when migration job reached terminal state.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  additionalAttributes?: AdditionalMigrationJobAttributes[];
}

/**
 * Any other migration type specific attributes to associate with this job.
 */
model AdditionalMigrationJobAttributes {
  /**
   * Unique attribute name.
   */
  keyName?: string;

  /**
   * Attribute value.
   */
  keyValue?: string;
}

/**
 * An update to database resource.
 */
model SqlServerDatabaseUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The data controller's properties
   */
  properties?: SqlServerDatabaseResourceProperties;
}

/**
 * Properties of SQL Server ESU license.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlServerEsuLicenseProperties {
  /**
   * SQL Server ESU license type.
   */
  billingPlan: BillingPlan;

  /**
   * The SQL Server version the license covers.
   */
  version: Version;

  /**
   * The unique ID of this license. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
   */
  @visibility(Lifecycle.Read)
  @pattern("^[A-Za-z0-9]{8}-([A-Za-z0-9]{4}-){3}[A-Za-z0-9]{12}$")
  uniqueId?: string;

  /**
   * The number of total cores of the license covers.
   */
  @minValue(16)
  physicalCores: int32;

  /**
   * The activation state of the license.
   */
  activationState: State;

  /**
   * The Azure scope to which the license will apply.
   */
  scopeType: ScopeType;

  /**
   * The timestamp of the activation of the SqlServerEsuLicense in ISO 8601 date-time format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activatedAt?: utcDateTime;

  /**
   * The timestamp of the termination of the SqlServerEsuLicense in ISO 8601 date-time format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  terminatedAt?: utcDateTime;

  /**
   * The tenantId the SQL Server ESU license resource subscription resides in.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * The resource model definition for an Azure Resource Manager tracked top level resource which has 'tags' and a 'location'
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TrackedResourceAutoGenerated extends ResourceAutoGenerated {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model ResourceAutoGenerated {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * An update to a SQL Server ESU license resource.
 */
model SqlServerEsuLicenseUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * null
   */
  properties?: SqlServerEsuLicenseUpdateProperties;
}

/**
 * Properties of update SqlServerEsuLicense.
 */
model SqlServerEsuLicenseUpdateProperties {
  /**
   * SQL Server ESU license type.
   */
  billingPlan?: BillingPlan;

  /**
   * The SQL Server version the license covers.
   */
  version?: Version;

  /**
   * The unique ID of this license. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
   */
  @visibility(Lifecycle.Read)
  @pattern("^[A-Za-z0-9]{8}-([A-Za-z0-9]{4}-){3}[A-Za-z0-9]{12}$")
  uniqueId?: string;

  /**
   * The number of total cores of the license covers.
   */
  @minValue(16)
  physicalCores?: int32;

  /**
   * The activation state of the license.
   */
  activationState?: State;

  /**
   * The Azure scope to which the license will apply.
   */
  scopeType?: ScopeType;

  /**
   * The timestamp of the activation of the SqlServerEsuLicense in ISO 8601 date-time format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activatedAt?: utcDateTime;

  /**
   * The timestamp of the termination of the SqlServerEsuLicense in ISO 8601 date-time format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  terminatedAt?: utcDateTime;

  /**
   * The tenantId the SQL Server ESU license resource subscription resides in.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * The properties of a DHCP Arc Sql availability group listener
 */
model SqlAvailabilityGroupDhcpListenerProperties {
  /**
   * the DNS name for the listener.
   */
  dnsName?: string;

  /**
   * The IPV4 subnet for the listener.
   */
  subnet?: string;

  /**
   * The netmask for the listener.
   */
  mask?: string;

  /**
   * Network port for the listener. Default is 1433.
   */
  port?: int32;
}
