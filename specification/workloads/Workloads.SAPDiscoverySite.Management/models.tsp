import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
namespace Microsoft.Workloads;

/**
 * Defines the provisioning states.
 */
@Azure.Core.lroStatus
union ProvisioningState {
  string,

  /** The provisioning state Succeeded. */
  Succeeded: "Succeeded",

  /** The provisioning state Updating. */
  Updating: "Updating",

  /** The provisioning state Failed. */
  Failed: "Failed",

  /** The provisioning state Creating. */
  Creating: "Creating",

  /** The provisioning state Cancelled. */
  Canceled: "Canceled",

  /** The provisioning state Accepted. */
  Accepted: "Accepted",

  /** The provisioning state Deleting. */
  Deleting: "Deleting",

  /** The provisioning state Unknown. */
  Unknown: "Unknown",
}

/**
 * Defines the import entities operation status.
 */
@added(Versions.v2024_06_01_preview)
union ImportEntitiesOperationStatus {
  string,

  /** The import operation status - Accepted. */
  Accepted: "Accepted",

  /** The import operation status - AwaitingFile. */
  AwaitingFile: "AwaitingFile",

  /** The import operation status - ProcessingFile. */
  ProcessingFile: "ProcessingFile",

  /** The import operation status - Succeeded. */
  Succeeded: "Succeeded",

  /** The import operation status - UploadingErrorExcel. */
  UploadingErrorExcel: "UploadingErrorExcel",

  /** The import operation status - PartiallySucceeded. */
  PartiallySucceeded: "PartiallySucceeded",

  /** The import operation status - Failed. */
  Failed: "Failed",

  /** The import operation status - Canceled. */
  Canceled: "Canceled",
}

/**
 * The Environment; PRD, QA, DEV, etc to which SAP system belongs to. Select from the list of available dropdown values.
 */
union SapInstanceEnvironment {
  string,

  /** The type of Sap Instance Environment- Production. */
  Production: "Production",

  /** The type of Sap Instance Environment- PreProduction. */
  PreProduction: "PreProduction",

  /** The type of Sap Instance Environment- Test. */
  Test: "Test",

  /** The type of Sap Instance Environment- QualityAssurance. */
  QualityAssurance: "QualityAssurance",

  /** The type of Sap Instance Environment- Development. */
  Development: "Development",

  /** The type of Sap Instance Environment- Sandbox. */
  Sandbox: "Sandbox",

  /** The type of Sap Instance Environment- DisasterRecovery. */
  DisasterRecovery: "DisasterRecovery",

  /** The type of Sap Instance Environment- Training. */
  Training: "Training",
}

/**
 * The SAP instance type running on this machine, e.g., App, ASCS, DB, etc. Select from the list of available dropdown values. Only single server and distributed architectures are supported.
 */
union SapInstanceType {
  string,

  /** The type of Sap Instance- ASCS. */
  ASCS: "ASCS",

  /** The type of Sap Instance- DB. */
  DB: "DB",

  /** The type of Sap Instance- APP. */
  APP: "APP",

  /** The type of Sap Instance- SCS. */
  SCS: "SCS",

  /** The type of Sap Instance- WEBDISP. */
  WEBDISP: "WEBDISP",
}

/**
 * This is server type of the host server which is running.
 */
@added(Versions.v2024_06_01_preview)
union ServerType {
  string,

  /** The type of server- Physical. */
  Physical: "Physical",

  /** The type of server- Virtual. */
  Virtual: "Virtual",
}

/**
 * This is Hypervisor/virtualization type of the host server which is running.
 */
@added(Versions.v2024_06_01_preview)
union HyperVisorType {
  string,

  /** The type of hypervisor virtualization- VMware. */
  VMware: "VMware",

  /** The type of hypervisor virtualization- Hyper-V. */
  HyperV: "HyperV",

  /** The other type of hypervisor virtualization- not VMware and HyperV. */
  Other: "Other",
}

/**
 * This is Operating System on which the host server is running.
 */
union OperatingSystem {
  string,

  /** The type of Operating system- IBMAIX. */
  IBMAIX: "IBMAIX",

  /** The type of Operating system- RedHat. */
  RedHat: "RedHat",

  /** The type of Operating system- SUSE. */
  SUSE: "SUSE",

  /** The type of Operating system- Solaris. */
  Solaris: "Solaris",

  /** The type of Operating system- Unix. */
  Unix: "Unix",

  /** The type of Operating system- WindowsServer. */
  WindowsServer: "WindowsServer",
}

/**
 * This is the type of the Operating System on which the host server is running.
 */
@added(Versions.v2024_06_01_preview)
union OperatingSystemType {
  string,

  /** The type of Operating system- Linux. */
  Linux: "Linux",

  /** The type of Operating system- Windows. */
  Windows: "Windows",

  /** The type of Operating system- Other. */
  Other: "Other",
}

/**
 * Select the database if this is a database server. Leave blank or add Not Applicable for all other instances except the Database Instance.
 */
union DatabaseType {
  string,

  /** The type of Database- Adabas. */
  Adabas: "Adabas",

  /** The type of Database- Oracle. */
  Oracle: "Oracle",

  /** The type of Database- SAPMaxDB. */
  SAPMaxDB: "SAPMaxDB",

  /** The type of Database- Db2. */
  Db2: "Db2",

  /** The type of Database- SAPASE. */
  SAPASE: "SAPASE",

  /** The type of Database- SQLServer. */
  SQLServer: "SQLServer",

  /** The type of Database- Informix. */
  Informix: "Informix",

  /** The type of Database- SAPDB. */
  SAPDB: "SAPDB",

  /** The type of Database- HANA. */
  HANA: "HANA",
}

/**
 * The data source for this resource.
 */
union DataSource {
  string,

  /** The type of DataSource- Excel. */
  Excel: "Excel",

  /** The type of DataSource- Native. */
  Native: "Native",
}

/**
 * Defines the SAP Migration discovery site resource properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
model SAPDiscoverySiteProperties {
  /**
   * The master site ID from Azure Migrate.
   */
  masterSiteId?: string;

  /**
   * The migrate project ID from Azure Migrate.
   */
  migrateProjectId?: string;

  /**
   * Defines the provisioning states.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Indicates any errors on the SAP Migration discovery site resource.
   */
  @visibility(Lifecycle.Read)
  errors?: SAPMigrateError;
}

/**
 * An error response from the SAP migrate resources.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
model SAPMigrateError {
  /**
   * The SAP Discovery site resource error body.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ErrorDefinition;
}

/**
 * Error definition.
 */
model ErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Description of the error.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Description of the recommendation.
   */
  @visibility(Lifecycle.Read)
  recommendation?: string;

  /**
   * Internal error details.
   */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  details?: ErrorDefinition[];
}

/**
 * The extended location definition.
 */
model ExtendedLocation {
  /**
   * The extended location type.
   */
  type: string;

  /**
   * The extended location name.
   */
  name: string;
}

/**
 * Defines the SAP Instance properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
model SAPInstanceProperties {
  /**
   * This is the SID of SAP System. Keeping this not equal to ID as different landscapes can have repeated System SID IDs.
   */
  @visibility(Lifecycle.Read)
  systemSid?: string;

  /**
   * The Environment; PRD, QA, DEV, etc to which SAP system belongs to. Select from the list of available dropdown values.
   */
  @visibility(Lifecycle.Read)
  environment?: SapInstanceEnvironment;

  /**
   * This is the SID of the production system in a landscape.  An SAP system could itself be a production SID or a part of a landscape with a different Production SID. This field can be used to relate non-prod SIDs, other components, SID (WEBDISP) to the prod SID. Enter the value of Production SID.
   */
  @visibility(Lifecycle.Read)
  landscapeSid?: string;

  /**
   * Enter a business function/department identifier to group multiple SIDs.
   */
  @visibility(Lifecycle.Read)
  application?: string;

  /**
   * Defines the provisioning states.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Defines the errors related to SAP Instance resource.
   */
  @visibility(Lifecycle.Read)
  errors?: SAPMigrateError;
}

/**
 * Defines the SAP Instance properties.
 */
model ServerInstanceProperties {
  /**
   * This is the Virtual Machine Name of the SAP system. Add all the virtual machines attached to an SAP system which you wish to migrate to Azure. Keeping this not equal to ID as for single tier all InstanceTypes would be on same server, leading to multiple resources with same servername.
   */
  @visibility(Lifecycle.Read)
  serverName?: string;

  /**
   * Defines the type SAP instance on this server instance.
   */
  @visibility(Lifecycle.Read)
  sapInstanceType?: SapInstanceType;

  /**
   * This is the Instance SID for ASCS/AP/DB instance.  An SAP system with HANA database for example could have a different SID for database Instance than that of ASCS instance.
   */
  @visibility(Lifecycle.Read)
  instanceSid?: string;

  /**
   * This is the SAP Application Component; e.g. SAP S/4HANA 2022, SAP ERP ENHANCE PACKAGE.
   */
  @visibility(Lifecycle.Read)
  sapProduct?: string;

  /**
   * Provide the product version of the SAP product.
   */
  @visibility(Lifecycle.Read)
  sapProductVersion?: string;

  /**
   * This is name of the Operating System on which the host server is running.
   */
  @visibility(Lifecycle.Read)
  operatingSystem?: OperatingSystem;

  /**
   * This is the version of the Operating System on which the host server is running.
   */
  @added(Versions.v2024_06_01_preview)
  @visibility(Lifecycle.Read)
  operatingSystemVersion?: string;

  /**
   * This is the type of the Operating System on which the host server is running.
   */
  @added(Versions.v2024_06_01_preview)
  @visibility(Lifecycle.Read)
  operatingSystemType?: OperatingSystemType;

  /**
   * Configuration data for this server instance.
   */
  @visibility(Lifecycle.Read)
  configurationData?: ConfigurationData;

  /**
   * Configuration data for this server instance.
   */
  @visibility(Lifecycle.Read)
  performanceData?: PerformanceData;

  /**
   * Defines the provisioning states.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Defines the errors related to SAP Instance resource.
   */
  @visibility(Lifecycle.Read)
  errors?: SAPMigrateError;
}

/**
 * Defines the request body for updating Server Instances resource.
 */
model UpdateServerInstanceRequest {
  /**
   * Server instances properties.
   */
  properties?: ServerInstanceProperties;
}

/**
 * The SAP instance specific configuration data.
 */
model ConfigurationData {
  /**
   * Provide the SAPS for each server of the SAP system. This should be a non-zero value. For example, 1000.
   */
  @visibility(Lifecycle.Read)
  saps?: int32;

  /**
   * Provide the cores per cpu for each server of the SAP system. This should be a non-zero value. For example, 4.
   */
  @added(Versions.v2024_06_01_preview)
  @visibility(Lifecycle.Read)
  @minValue(0)
  coresPerCpu?: int32;

  /**
   * Provide the CPU value of the server. For example, 16, 32 etc.
   */
  @visibility(Lifecycle.Read)
  cpu?: int32;

  /**
   * Provide the CPU architecture type of the server. For example, Xeon Platinum 8171M, Xeon E5-2673 v3.
   */
  @visibility(Lifecycle.Read)
  cpuType?: string;

  /**
   * Provide the hypervisor/virtualization type for each server of the SAP system. For example, VMware, Hyper-V.
   */
  @added(Versions.v2024_06_01_preview)
  @visibility(Lifecycle.Read)
  hyperVisorType?: HyperVisorType;

  /**
   * Provide the CPU clock speed of the server in MHz. This should be a non-zero value. For example, 2100.
   */
  @visibility(Lifecycle.Read)
  cpuInMhz?: int32;

  /**
   * Provide the RAM of the server. This should be a non-zero value. For example, 256.
   */
  @visibility(Lifecycle.Read)
  ram?: int32;

  /**
   * Provide the HW manufacturer company of the server.  For example, Microsoft Corporation.
   */
  @visibility(Lifecycle.Read)
  hardwareManufacturer?: string;

  /**
   * Specify if the Hardware is a physical server or virtual machine.
   * For example, Physical, Virtual.
   */
  @renamedFrom(Versions.v2024_06_01_preview, "model")
  @typeChangedFrom(Versions.v2024_06_01_preview, string)
  @visibility(Lifecycle.Read)
  serverType?: ServerType;

  /**
   * Provide the total disk volume capacity in GB. Add the disk volume for each individual disks and provide the total sum in this field.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is short for Gigabytes."
  @visibility(Lifecycle.Read)
  totalDiskSizeGB?: int32;

  /**
   * Provide the total disk IOPS capacity. Add the disk volume for each individual disk and provide the sum total in this field.
   */
  @visibility(Lifecycle.Read)
  totalDiskIops?: int32;

  /**
   * The database of this is a server instance. Applicable only if SAP instance type for this server instance is 'DB'.
   */
  @visibility(Lifecycle.Read)
  databaseType?: DatabaseType;

  /**
   *  Provide the target HANA database size you need. Applicable only if SAP instance type for this server instance is 'DB' and you are migrating an AnyDb database to SAP S/4HANA.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is short for Gigabytes."
  @visibility(Lifecycle.Read)
  targetHanaRamSizeGB?: int32;
}

/**
 * The SAP instance specific performance data.
 */
@discriminator("dataSource")
model PerformanceData {
  /** The data source of the performance data. */
  dataSource: DataSource;
}

/**
 * The SAP instance specific performance data for Excel import.
 */
model ExcelPerformanceData extends PerformanceData {
  /**
   * Provide the max CPU percentage load on the server. Omit the percentage symbol while filling this value.
   */
  @visibility(Lifecycle.Read)
  maxCpuLoad?: int32;

  /**
   * Provide the source Database size in GB. Applicable only if SAP instance type for this server instance is 'DB'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is short for Gigabytes."
  @visibility(Lifecycle.Read)
  totalSourceDbSizeGB?: int32;

  /**
   * The data source for this resource.
   */
  dataSource: DataSource.Excel;
}

/**
 * The SAP instance specific performance data for native discovery.
 */
model NativePerformanceData extends PerformanceData {
  /**
   * The data source for this resource.
   */
  dataSource: DataSource.Native;
}

@doc("Import entities Operation Status Result model by extending OperationStatusResult as per SAP Discovery.")
@added(Versions.v2024_06_01_preview)
model ImportOperationStatusResult {
  /** Fully qualified ID for the async operation. */
  id?: string;

  /** Name of the async operation. */
  name?: string;

  /** Operation status. */
  status: string;

  /** Percent of the operation that is complete. */
  @minValue(0)
  @maxValue(100)
  percentComplete?: float64;

  /** The start time of the operation. */
  startTime?: utcDateTime;

  /** The end time of the operation. */
  endTime?: utcDateTime;

  /** The operations list. */
  operations?: Azure.ResourceManager.Foundations.OperationStatusResult[];

  /** If present, details of the operation error. */
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  @doc("The resource ID of the SAP Discovery site.")
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Workloads/sapDiscoverySites";
    }
  ]>;

  @doc("Additional properties applicable for SAP Discovery import entities operation status result")
  properties?: ImportOperationStatusProperties;
}

@doc("Import Entities operation status properties as per SAP Discovery.")
@added(Versions.v2024_06_01_preview)
model ImportOperationStatusProperties {
  @doc("The SAS URI of the Excel file containing the discovery data.")
  discoveryExcelSasUri?: url;

  @doc("Import status of the discovery request.")
  status?: ImportEntitiesOperationStatus;

  @doc("The SAS URI of the Excel file containing the error data.")
  errorExcelSasUri?: url;

  @doc("The number of rows imported.")
  @minValue(0)
  rowsImported?: int32;

  @doc("The total number of rows.")
  @minValue(0)
  totalRows?: int32;
}
