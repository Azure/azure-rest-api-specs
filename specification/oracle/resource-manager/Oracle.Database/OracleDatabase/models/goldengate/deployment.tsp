using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Oracle.Database;

@added(Versions.v20260301_preview)
@doc("GoldenGate Deployment resource definition.")
model GoldenGateDeployment is TrackedResource<DeploymentProperties> {
  ...ResourceNameParameter<GoldenGateDeployment, NamePattern = ".*">;
  ...AvailabilityZonesProperty;
}

@added(Versions.v20260301_preview)
@doc("GoldenGate Deployment resource model.")
model DeploymentProperties {
  @doc("Backup schedule.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  backupSchedule?: BackupScheduleType;

  @doc("OCI compartment.")
  @visibility(Lifecycle.Read)
  compartment?: Ocid;

  @doc("The OCID of the deployment being referenced.")
  @visibility(Lifecycle.Read)
  ocid?: Ocid;

  @doc("The minimum number of OCPUs to be made available for this deployment.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @minValue(1)
  @maxValue(24)
  cpuCoreCount?: int32;

  @doc("Display name.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  displayName: string;

  @doc("The deployment category.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  category?: CategoryType = CategoryType.DataReplication;

  @doc("The type of deployment.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  deploymentType?: DeploymentType = DeploymentType.DatabaseOracle;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("HTTPS link to OCI resource exposed to Azure Customer via Azure Interface.")
  @visibility(Lifecycle.Read)
  deploymentUrl?: url;

  @doc("Environment type.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  environmentType?: SetupType;

  @doc("Indicates if auto scaling is enabled for the deployment's CPU core count.")
  @visibility(Lifecycle.Create)
  isAutoScalingEnabled?: boolean;

  @doc("Connection IP address.")
  @visibility(Lifecycle.Read)
  ingressIps?: string[];

  @doc("True if this object is publicly available.")
  @visibility(Lifecycle.Create)
  isPublic?: boolean;

  @doc("The Oracle license model that applies to a Deployment.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  licenseModel?: LicenseModel;

  @doc("Describes the object's current state in detail.")
  @visibility(Lifecycle.Read)
  lifecycleDetails?: string;

  @doc("Possible lifecycle states.")
  @visibility(Lifecycle.Read)
  lifecycleState?: DeploymentLifecycleState;

  @doc("The date time the resource was created in OCI.")
  @visibility(Lifecycle.Read)
  timeCreated?: string;

  @doc("The date time the resource was last updated in OCI.")
  @visibility(Lifecycle.Read)
  timeUpdated?: string;

  @doc("Maintenance configuration.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  maintenanceConfiguration?: MaintenanceConfigurationType;

  @doc("Maintenance window.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  maintenanceWindow?: MaintenanceWindowType;

  @doc("Azure network anchor ID.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  networkAnchorId: NetworkAnchorResourceId;

  @doc("Deployment data for creating an OGG deployment.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  oggData?: OggDeploymentDetails;

  @doc("The private IP address of VCN representing the access point for the associated endpoint service in the GoldenGate service VCN")
  @visibility(Lifecycle.Read)
  privateIpAddress?: string;

  @doc("Deployment provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("Corresponding Azure resource anchor ID.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  resourceAnchorId: ResourceAnchorResourceId;

  @doc("Storage utilization in bytes.")
  @visibility(Lifecycle.Read)
  storageUtilizationInBytes?: int32;

  @doc("The time zone of the deployment, for example, UTC.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  timeZone?: string;

  @doc("The current version.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  version?: string;
}

@added(Versions.v20260301_preview)
@doc("Category.")
union CategoryType {
  @doc("Data replication.")
  DataReplication: "DataReplication",

  @doc("Stream analytics.")
  StreamAnalytics: "StreamAnalytics",

  @doc("Data transforms.")
  DataTransforms: "DataTransforms",

  string,
}

@added(Versions.v20260301_preview)
@doc("Credential type.")
union CredentialType {
  @doc("The GoldenGate credential.")
  GoldenGate: "GoldenGate",

  @doc("The IAM credential.")
  Iam: "IAM",

  string,
}

@added(Versions.v20260301_preview)
@doc("Deployment type enum.")
union DeploymentType {
  @doc("The OGG deployment.")
  Ogg: "Ogg",

  @doc("The Oracle database deployment.")
  DatabaseOracle: "DatabaseOracle",

  @doc("The big data deployment.")
  BigData: "BigData",

  @doc("The Microsoft SQL Server database deployment.")
  DatabaseMicrosoftSqlServer: "DatabaseMicrosoftSQLServer",

  @doc("The MySQL database deployment.")
  DatabaseMySql: "DatabaseMySQL",

  @doc("The PostgreSQL database deployment.")
  DatabasePostGreSql: "DatabasePostGreSQL",

  @doc("The DB2 z/OS database deployment.")
  DatabaseDB2ZOS: "DatabaseDB2ZOS",

  @doc("The DB2 i database deployment.")
  DatabaseDB2I: "DATABASE_DB2I",

  @doc("The GGSA deployment.")
  Ggsa: "GGSA",

  @doc("The data transforms deployment.")
  DataTransforms: "DataTransforms",

  string,
}

@added(Versions.v20260301_preview)
@doc("Deployment lifecycle state enum.")
union DeploymentLifecycleState {
  @doc("Indicates that the resource is in creating state.")
  Creating: "Creating",

  @doc("Indicates that the resource is in updating state.")
  Updating: "Updating",

  @doc("Indicates that the resource is in active state.")
  Active: "Active",

  @doc("Indicates that the resource is in inactive state.")
  InActive: "InActive",

  @doc("Indicates that the resource is in deleting state.")
  Deleting: "Deleting",

  @doc("Indicates that the resource is in deleted state.")
  Deleted: "Deleted",

  @doc("Indicates that the resource is in failed state.")
  Failed: "Failed",

  @doc("Indicates that the resource is in needs-attention state.")
  NeedsAttention: "Needs Attention",

  @doc("Indicates that the resource is in in-progress state.")
  InProgress: "In Progress",

  @doc("Indicates that the resource is in canceling state.")
  Canceling: "Canceling",

  @doc("Indicates that the resource is in canceled state.")
  Canceled: "Canceled",

  @doc("Indicates that the resource is in succeeded state.")
  Succeeded: "Succeeded",

  @doc("Indicates that the resource is in waiting state.")
  Waiting: "Waiting",

  string,
}

@added(Versions.v20260301_preview)
@doc("Setup type enum.")
union SetupType {
  @doc("Production setup.")
  Production: "Production",

  @doc("Development or testing setup.")
  DevelopmentOrTesting: "DevelopmentOrTesting",

  string,
}

@added(Versions.v20260301_preview)
@doc("Frequency type enum.")
union FrequencyType {
  @doc("The daily frequency.")
  Daily: "Daily",

  @doc("The weekly frequency.")
  Weekly: "Weekly",

  @doc("The monthly frequency.")
  Monthly: "Monthly",

  string,
}

@added(Versions.v20260301_preview)
@doc("Backup schedule type.")
model BackupScheduleType {
  @doc("Bucket name.")
  bucketName?: string;

  @doc("Compartment ID.")
  compartmentId?: Ocid;

  @doc("Backup schedule frequency.")
  frequencyBackupScheduled?: FrequencyType;

  @doc("Indicates whether the backup contains metadata only.")
  isMetadataOnly?: boolean;

  @doc("Namespace.")
  namespaceName?: string;

  @doc("Scheduled backup time.")
  timeBackupScheduled?: string;
}

@added(Versions.v20260301_preview)
@doc("Group-to-roles mapping properties.")
model GroupToRolesMappingDetails {
  @doc("The OCID of the IDP group which will be mapped to goldengate role administratorGroup.It grants full access to the user, including the ability to alter general, non-security related operational parameters and profiles of the server.")
  @minLength(0)
  @maxLength(255)
  administratorGroupId?: string;

  @doc("The OCID of the IDP group which will be mapped to goldengate role operatorGroup.It allows users to perform only operational actions, like starting and stopping resources. Operators cannot alter the operational parameters or profiles of the MA server.")
  @minLength(0)
  @maxLength(255)
  operatorGroupId?: string;

  @doc("The OCID of the IDP group which will be mapped to goldengate role securityGroup.It grants administration of security related objects and invoke security related service requests. This role has full privileges.")
  @minLength(0)
  @maxLength(255)
  securityGroupId?: string;

  @doc("The OCID of the IDP group which will be mapped to goldengate role userGroup. It allows information-only service requests, which do not alter or affect the operation of either the MA. Examples of query and read-only information include performance metric information and resource status and monitoring information")
  @minLength(0)
  @maxLength(255)
  userGroupId?: string;

  @doc("The OCID of the Identity Domain when IAM credential store is used.")
  @minLength(1)
  @maxLength(255)
  identityDomainId?: string;

  @doc("The base64 encoded content of the PEM file containing the private key.")
  @minLength(0)
  @maxLength(8192)
  @secret
  key?: string;

  @removed(Versions.v20260301_preview)
  @doc("OGG version.")
  @minLength(1)
  oggVersion?: string;

  @removed(Versions.v20260301_preview)
  @doc("The OCID of the Secret where the deployment password is stored.")
  @minLength(1)
  @maxLength(255)
  passwordSecretId?: string;
}

@added(Versions.v20260301_preview)
@doc("OGG deployment details.")
model OggDeploymentDetails {
  @doc("The password associated with the GoldenGate deployment console username. The password must be 8 to 30 characters long and must contain at least 1 uppercase, 1 lowercase, 1 numeric, and 1 special character. Special characters such as '$', '^', or '?' are not allowed.")
  @minLength(1)
  @maxLength(30)
  @secret
  adminPassword?: string;

  @doc("The GoldenGate deployment console username.")
  @minLength(0)
  @maxLength(512)
  adminUsername?: string;

  @doc("The base64 encoded content of the PEM file containing the SSL certificate.")
  @minLength(0)
  @maxLength(65536)
  certificate?: string;

  @doc("The type of credential store for OGG.")
  credentialStore?: CredentialType;

  @doc("The name given to the GoldenGate service deployment.")
  @minLength(1)
  @maxLength(32)
  deploymentName: string;

  @doc("Defines the IDP Groups to GoldenGate roles mapping.")
  groupToRolesMapping?: GroupToRolesMappingDetails;

  @added(Versions.v20260301_preview)
  @doc("OGG version.")
  @minLength(1)
  oggVersion?: string;

  @added(Versions.v20260301_preview)
  @doc("The OCID of the Secret where the deployment password is stored.")
  @minLength(1)
  @maxLength(255)
  passwordSecretId?: string;
}

@added(Versions.v20260301_preview)
@doc("Maintenance configuration type.")
model MaintenanceConfigurationType {
  @doc("Bundle release period.")
  bundleReleaseUpgradePeriodInDays?: int32;

  @doc("Interim release upgrade period in days.")
  interimReleaseUpgradePeriodInDays?: int32;

  @doc("Indicates whether interim release auto-upgrade is enabled.")
  isInterimReleaseAutoUpgradeEnabled?: boolean;

  @doc("Major release upgrade period in days.")
  majorReleaseUpgradePeriodInDays?: int32;

  @doc("Security patch upgrade period in days.")
  securityPatchUpgradePeriodInDays?: int32;
}

@added(Versions.v20260301_preview)
@doc("Maintenance window.")
model MaintenanceWindowType {
  @doc("The day of week.")
  day?: DayOfWeekName;

  @doc("Start time in UTC.")
  startHour?: int32;
}
