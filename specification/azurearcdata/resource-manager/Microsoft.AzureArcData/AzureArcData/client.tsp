import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AzureArcData;
using Azure.ResourceManager;
using TypeSpec.Http;

// SDK-only state types keep the wire contract's shared State union unchanged.
namespace Microsoft.AzureArcData {
  /** The activation state of the license. */
  union SqlServerEsuLicenseActivationState {
    string,

    /** Inactive. */
    Inactive: "Inactive",

    /** Active. */
    Active: "Active",

    /** Terminated. */
    Terminated: "Terminated",
  }

  /** The state of the background job. */
  union BackgroundJobState {
    string,

    /** Enabled. */
    Enabled: "Enabled",

    /** Disabled. */
    Disabled: "Disabled",

    /** Deleted. */
    Deleted: "Deleted",

    /** Completed. */
    Completed: "Completed",

    /** Faulted. */
    Faulted: "Faulted",

    /** Suspended. */
    Suspended: "Suspended",
  }
}

@@alternateType(BackgroundJob.state, BackgroundJobState, "csharp");
@@alternateType(
  SqlServerEsuLicenseProperties.activationState,
  SqlServerEsuLicenseActivationState,
  "csharp"
);
@@alternateType(
  SqlServerEsuLicenseUpdateProperties.activationState,
  SqlServerEsuLicenseActivationState,
  "csharp"
);

@@clientName(
  FailoverGroupSpec.partnerMirroringURL,
  "partnerMirroringUrl",
  "java"
);

@@clientName(
  SqlManagedInstanceK8sRaw,
  "SqlManagedInstanceK8SRaw",
  "java,python"
);

@@clientName(
  SqlManagedInstanceK8sSpec,
  "SqlManagedInstanceK8SSpec",
  "java,python"
);

@@clientName(SqlManagedInstanceProperties.k8sRaw, "k8SRaw", "java");

@@clientName(DataControllerProperties.k8sRaw, "k8SRaw", "java");

@@clientName(PostgresInstanceProperties.k8sRaw, "k8SRaw", "java");

@@clientName(K8sScheduling, "K8SScheduling", "java,python");

@@clientName(K8sSchedulingOptions, "K8SSchedulingOptions", "java,python");

@@clientName(K8sResourceRequirements, "K8SResourceRequirements", "java,python");

@@clientName(K8sSecurity, "K8SSecurity", "java,python");

@@clientName(K8sActiveDirectory, "K8SActiveDirectory", "java,python");

@@clientName(
  K8sActiveDirectoryConnector,
  "K8SActiveDirectoryConnector",
  "java,python"
);

@@clientName(
  k8stransparentDataEncryption,
  "K8STransparentDataEncryption",
  "java"
);

@@clientName(K8sSettings, "K8SSettings", "java,python");

@@clientName(K8sNetworkSettings, "K8SNetworkSettings", "java,python");

@@clientName(
  ActiveDirectoryConnectorDNSDetails.preferK8sDnsForPtrLookups,
  "preferK8SDnsForPtrLookups",
  "java"
);

@@clientName(
  Azure.ResourceManager.CommonTypes.Origin,
  "OperationOrigin",
  "java,python"
);
@@clientName(ArcSqlServerLicenseType.Hadr, "HADR", "go");

@@clientName(Microsoft.AzureArcData, "AzureArcDataManagementClient", "python");

@@clientName(DiscoverySource.DMSCLI, "DMS_CLI", "python");
@@clientName(DiscoverySource.DMSPS, "DMS_PS", "python");
@@clientName(DiscoverySource.DMSSDK, "DMS_SDK", "python");

@@clientName(initiatedFrom.DMSCLI, "DMS_CLI", "python");
@@clientName(initiatedFrom.DMSPS, "DMS_PS", "python");
@@clientName(initiatedFrom.DMSSDK, "DMS_SDK", "python");

@@clientName(DtcSupport.PERDB, "PER_DB", "python");

@@clientName(EncryptionAlgorithm.AESRC4, "AES_RC4", "python");
@@clientName(EncryptionAlgorithm.NoneAESRC4, "NONE_AES_RC4", "python");
@@clientName(EncryptionAlgorithm.RC4AES, "RC4_AES", "python");

@@clientName(
  HostType.AWSVMWareVirtualMachine,
  "AWS_VM_WARE_VIRTUAL_MACHINE",
  "python"
);
@@clientName(
  HostType.GCPVMWareVirtualMachine,
  "GCP_VM_WARE_VIRTUAL_MACHINE",
  "python"
);

@@clientName(
  k8stransparentDataEncryption,
  "K8StransparentDataEncryption",
  "python"
);

@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@clientName(
  SqlServerInstanceManagedInstanceLinkAssessmentRequest,
  "ArcDataSqlServerInstanceManagedInstanceLinkAssessmentRequestContent",
  "csharp"
);
@@clientName(
  SqlServerInstanceRunTargetRecommendationJobRequest,
  "ArcDataSqlServerInstanceRunTargetRecommendationJobRequestContent",
  "csharp"
);
@@clientName(
  SqlServerInstanceTargetRecommendationReportsRequest,
  "ArcDataSqlServerInstanceTargetRecommendationReportsRequestContent",
  "csharp"
);
@@clientName(
  SqlServerInstanceJobsRequest,
  "ArcDataSqlServerInstanceJobsRequestContent",
  "csharp"
);
@@clientName(
  SqlServerInstanceJobsStatusRequest,
  "ArcDataSqlServerInstanceJobsStatusRequestContent",
  "csharp"
);

@@clientName(
  ActiveDirectoryConnectorDNSDetails,
  "ActiveDirectoryConnectorDnsDetails",
  "csharp"
);
@@clientName(
  ActiveDirectoryConnectorDNSDetails.nameserverIPAddresses,
  Azure.ClientGenerator.Core.exact("NameserverIpAddresses"),
  "csharp"
);
@@clientName(Authentication, "SqlServerAuthentication", "csharp");
@@clientName(
  DbFailover,
  Azure.ClientGenerator.Core.exact("DbFailover"),
  "csharp"
);
@@clientName(DbFailover.ON, "On", "csharp");
@@clientName(DbFailover.OFF, "Off", "csharp");
@@clientName(DBMEndpoint, "DbmEndpoint", "csharp");
@@clientName(
  DBMEndpoint.ipAddress,
  Azure.ClientGenerator.Core.exact("IpAddress"),
  "csharp"
);
@@clientName(DataBaseMigration, "DatabaseMigration", "csharp");
@@clientName(
  DataBaseMigrationAssessment,
  "DatabaseMigrationAssessment",
  "csharp"
);
@@clientName(Infrastructure, "DataControllerInfrastructure", "csharp");
@@clientName(
  k8stransparentDataEncryption,
  "K8sTransparentDataEncryption",
  "csharp"
);
@@clientName(Migration, "SqlServerInstanceMigration", "csharp");
@@clientName(Mode, "SqlServerAuthenticationMode", "csharp");
@@clientName(ReplicationPartnerType.SQLServer, "SqlServer", "csharp");
@@clientName(ReplicationPartnerType.AzureSqlvm, "AzureSqlVm", "csharp");
@@clientName(
  ReplicationPartnerType.AzureSQLManagedInstance,
  "AzureSqlManagedInstance",
  "csharp"
);
@@clientName(Result, "SequencerActionResult", "csharp");
@@clientName(Role, "DatabaseMirroringRole", "csharp");
@@clientName(Role.ALL, "All", "csharp");
@@clientName(Schedule, "BestPracticesAssessmentSchedule", "csharp");
@@clientName(SecondaryAllowConnections.NO, "No", "csharp");
@@clientName(SecondaryAllowConnections.ALL, "All", "csharp");
@@clientName(Version, "SqlServerEsuLicenseVersion", "csharp");
@@clientName(Version.SQLServer2012, "SqlServer2012", "csharp");
@@clientName(Version.SQLServer2014, "SqlServer2014", "csharp");
@@clientName(Version.SQLServer2016, "SqlServer2016", "csharp");
@@clientName(SqlVersion.SQLServer2012, "SqlServer2012", "csharp");
@@clientName(SqlVersion.SQLServer2014, "SqlServer2014", "csharp");
@@clientName(SqlVersion.SQLServer2016, "SqlServer2016", "csharp");
@@clientName(SqlVersion.SQLServer2017, "SqlServer2017", "csharp");
@@clientName(SqlVersion.SQLServer2019, "SqlServer2019", "csharp");
@@clientName(SqlVersion.SQLServer2022, "SqlServer2022", "csharp");
@@clientName(SqlVersion.SQLServer2025, "SqlServer2025", "csharp");
@@clientName(EncryptionAlgorithm.AES, "Aes", "csharp");
@@clientName(EncryptionAlgorithm.NoneAES, "NoneAes", "csharp");
@@clientName(EncryptionAlgorithm.RC4AES, "Rc4Aes", "csharp");
@@clientName(EncryptionAlgorithm.AESRC4, "AesRc4", "csharp");
@@clientName(EncryptionAlgorithm.NoneRC4AES, "NoneRc4Aes", "csharp");
@@clientName(EncryptionAlgorithm.NoneAESRC4, "NoneAesRc4", "csharp");
@@clientName(
  DtcSupport.PERDB,
  Azure.ClientGenerator.Core.exact("PerDb"),
  "csharp"
);
@@clientName(K8sSchedulingOptions, "K8sSchedulingConfig", "csharp");
@@clientName(
  SqlServerDatabaseResourcePropertiesDatabaseOptions,
  "SqlServerDatabaseConfig",
  "csharp"
);
@@clientName(
  FailoverGroupSpec.partnerMirroringURL,
  "PartnerMirroringUri",
  "csharp"
);
@@clientName(DataControllerResource, "DataController", "csharp");
@@clientName(
  ActiveDirectoryConnectorResource,
  "ArcDataActiveDirectoryConnector",
  "csharp"
);
@@clientName(FailoverGroupResource, "FailoverGroup", "csharp");
@@clientName(
  SqlServerAvailabilityGroupResource,
  "SqlServerAvailabilityGroup",
  "csharp"
);
@@clientName(SqlServerDatabaseResource, "SqlServerDatabase", "csharp");
@@clientName(
  ActiveDirectoryConnectorDNSDetails.preferK8sDnsForPtrLookups,
  "ShouldPreferK8sDnsForPtrLookups",
  "csharp"
);
@@clientName(
  SqlServerInstanceRunTargetRecommendationJobRequest.includeFileLevelRequirements,
  "ShouldIncludeFileLevelRequirements",
  "csharp"
);
@@clientName(AvailabilityGroupInfo.basicFeatures, "HasBasicFeatures", "csharp");
@@clientName(
  AvailabilityGroupInfo.dbFailover,
  Azure.ClientGenerator.Core.exact("IsDbFailoverSupported"),
  "csharp"
);
@@clientName(
  AvailabilityGroupCreateUpdateConfiguration.dbFailover,
  Azure.ClientGenerator.Core.exact("DbFailover"),
  "csharp"
);
@@clientName(CommonSku.dev, "IsDevTestEnabled", "csharp");
@@clientName(SqlManagedInstanceSku.dev, "IsDevTestEnabled", "csharp");
@@clientName(FailoverMiLinkResourceId.force, "ShouldForce", "csharp");
@@clientName(
  SkuRecommendationResultsAzureSqlDatabaseTargetSkuCategory.zoneRedundancyAvailable,
  "IsZoneRedundancyAvailable",
  "csharp"
);
@@clientName(
  SkuRecommendationResultsAzureSqlManagedInstanceTargetSkuCategory.zoneRedundancyAvailable,
  "IsZoneRedundancyAvailable",
  "csharp"
);
@@clientName(
  SkuRecommendationSummaryTargetSkuCategory.zoneRedundancyAvailable,
  "IsZoneRedundancyAvailable",
  "csharp"
);
@@clientName(
  SqlServerInstanceProperties.dbMasterKeyExists,
  Azure.ClientGenerator.Core.exact("HasDbMasterKey"),
  "csharp"
);
@@clientName(
  SqlServerInstanceUpdateProperties.dbMasterKeyExists,
  Azure.ClientGenerator.Core.exact("HasDbMasterKey"),
  "csharp"
);
@@clientName(SqlServerInstanceProperties.monitoring, "IsMonitoring", "csharp");
@@clientName(
  SqlServerInstanceUpdateProperties.monitoring,
  "IsMonitoring",
  "csharp"
);
@@clientName(
  SqlServerInstanceProperties.clientConnection,
  "IsClientConnection",
  "csharp"
);
@@clientName(
  SqlServerInstanceUpdateProperties.clientConnection,
  "IsClientConnection",
  "csharp"
);

// Review feedback: make public API names contextual and preserve the wire names.
@@clientName(AvailabilityGroupInfo.dtcSupport, "IsDtcSupportEnabled", "csharp");
@@clientName(
  AvailabilityGroupConfigure.sessionTimeout,
  "SessionTimeoutInSeconds",
  "csharp"
);
@@clientName(
  AvailabilityGroupCreateUpdateReplicaConfiguration.sessionTimeout,
  "SessionTimeoutInSeconds",
  "csharp"
);
@@clientName(
  AvailabilityGroupInfo.healthCheckTimeout,
  "HealthCheckTimeoutInMilliseconds",
  "csharp"
);
@@clientName(
  AvailabilityGroupCreateUpdateConfiguration.healthCheckTimeout,
  "HealthCheckTimeoutInMilliseconds",
  "csharp"
);
@@clientName(K8sNetworkSettings.forceencryption, "ForceEncryption", "csharp");
@@clientName(K8sNetworkSettings.tlsciphers, "TlsCiphers", "csharp");
@@clientName(K8sNetworkSettings.tlsprotocols, "TlsProtocols", "csharp");

@@clientName(HostType, "ArcSqlServerHostType", "csharp");
@@clientName(
  HostType.AzureVMWareVirtualMachine,
  "AzureVmwareVirtualMachine",
  "csharp"
);
@@clientName(
  HostType.AWSVMWareVirtualMachine,
  "AwsVmwareVirtualMachine",
  "csharp"
);
@@clientName(HostType.AWSKubernetesService, "AwsKubernetesService", "csharp");
@@clientName(
  HostType.GCPVMWareVirtualMachine,
  "GcpVmwareVirtualMachine",
  "csharp"
);
@@clientName(HostType.GCPKubernetesService, "GcpKubernetesService", "csharp");
@@clientName(HostType.AWSVirtualMachine, "AwsVirtualMachine", "csharp");
@@clientName(HostType.GCPVirtualMachine, "GcpVirtualMachine", "csharp");
@@clientName(DiscoverySource.ADS, "Ads", "csharp");
@@clientName(DiscoverySource.DMSPortal, "DmsPortal", "csharp");
@@clientName(DiscoverySource.DMSPS, "DmsPs", "csharp");
@@clientName(DiscoverySource.DMSCLI, "DmsCli", "csharp");
@@clientName(DiscoverySource.DMSSDK, "DmsSdk", "csharp");
@@clientName(initiatedFrom.ADS, "Ads", "csharp");
@@clientName(initiatedFrom.DMSPortal, "DmsPortal", "csharp");
@@clientName(initiatedFrom.DMSPS, "DmsPs", "csharp");
@@clientName(initiatedFrom.DMSCLI, "DmsCli", "csharp");
@@clientName(initiatedFrom.DMSSDK, "DmsSdk", "csharp");
@@clientName(ArcSqlServerLicenseType.ServerCAL, "ServerCal", "csharp");
@@clientName(MigrationMode.MILink, "MiLink", "csharp");
@@clientName(
  SqlServerInstanceTargetRecommendationReportSectionType.SqlDbTargetRecommendationPerDatabase,
  Azure.ClientGenerator.Core.exact("SqlDbTargetRecommendationPerDatabase"),
  "csharp"
);
@@clientName(
  SkuRecommendationResultsAzureSqlVirtualMachineTargetSku.tempDbDiskSizes,
  Azure.ClientGenerator.Core.exact("TempDbDiskSizes"),
  "csharp"
);
@@clientName(PrimaryAllowConnections.ALL, "All", "csharp");

@@clientName(ScopeType, "SqlServerLicenseScopeType", "csharp");
@@clientName(ActivationState, "SqlServerLicenseActivationState", "csharp");
@@clientName(BillingPlan, "SqlServerLicenseBillingPlan", "csharp");
@@clientName(LicenseCategory, "SqlServerLicenseCategory", "csharp");
@@clientName(EditionType, "SqlServerEditionType", "csharp");
@@clientName(ConnectionStatus, "SqlServerConnectionStatus", "csharp");
@@clientName(ServiceType, "SqlServerServiceType", "csharp");
@@clientName(IdentityType, "SqlServerEntraIdentityType", "csharp");
@@clientName(ClusterType, "SqlAvailabilityGroupClusterType", "csharp");
@@clientName(
  ConnectionAuth,
  "SqlMirroringEndpointAuthenticationType",
  "csharp"
);
@@clientName(
  EncryptionAlgorithm,
  "SqlMirroringEndpointEncryptionAlgorithm",
  "csharp"
);
@@clientName(ProvisioningState, "ArcDataProvisioningState", "csharp");

@@clientName(BackgroundJob, "SqlServerBackgroundJob", "csharp");
@@clientName(BackgroundJobState, "SqlServerBackgroundJobState", "csharp");
@@clientName(ExecutionState, "SqlServerBackgroundJobExecutionState", "csharp");
@@clientName(
  LastExecutionStatus,
  "SqlServerBackgroundJobLastExecutionStatus",
  "csharp"
);
@@clientName(JobStatus, "SqlServerJobStatus", "csharp");
@@clientName(
  AssessmentStatus,
  "SqlManagedInstanceLinkAssessmentStatus",
  "csharp"
);
@@clientName(
  CostOptionSelectedValues,
  "SqlSkuRecommendationCostOptions",
  "csharp"
);
@@clientName(CostTypeValues, "SqlSkuRecommendationCostBreakdown", "csharp");
@@clientName(initiatedFrom, "SqlMigrationInitiationSource", "csharp");
@@clientName(RecommendationStatus, "SqlSkuRecommendationStatus", "csharp");
@@clientName(
  ResourceUpdateMode,
  "SqlServerRecommendationResourceUpdateMode",
  "csharp"
);
@@clientName(TargetReadiness, "SqlMigrationTargetReadiness", "csharp");
@@clientName(TargetType, "SqlMigrationTargetType", "csharp");
@@clientName(ImpactedObjectsInfo, "SqlMigrationImpactedObjectInfo", "csharp");
@@clientName(
  ImpactedObjectsSuitabilitySummary,
  "SqlMigrationImpactedObjectsSuitabilitySummary",
  "csharp"
);
@@clientName(BackupPolicy, "SqlServerBackupPolicy", "csharp");
@@clientName(CommonSku, "ArcDataSku", "csharp");
@@clientName(BasicLoginInformation, "ArcDataBasicLoginInformation", "csharp");
@@clientName(
  AccountProvisioningMode,
  "ActiveDirectoryServiceAccountProvisioningMode",
  "csharp"
);
@@clientName(OnPremiseProperty, "DataControllerOnPremisesConfig", "csharp");
@@clientName(UploadWatermark, "DataControllerUploadWatermark", "csharp");

@@clientName(
  FailoverMiLinkResourceId,
  "SqlManagedInstanceLinkFailoverContent",
  "csharp"
);
@@clientName(databases, "SqlAvailabilityGroupDatabasesContent", "csharp");
@@clientName(
  AvailabilityGroupCreateUpdateConfiguration,
  "SqlAvailabilityGroupContent",
  "csharp"
);
@@clientName(
  DistributedAvailabilityGroupCreateUpdateConfiguration,
  "SqlDistributedAvailabilityGroupContent",
  "csharp"
);
@@clientName(
  ManagedInstanceLinkCreateUpdateConfiguration,
  "SqlManagedInstanceLinkContent",
  "csharp"
);

@@alternateType(
  FailoverGroupProperties.partnerManagedInstanceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Reuse the shared ARM C# model rather than emitting a duplicate local pair.
@@alternateType(
  DataControllerResource.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  PostgresInstance.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  SqlManagedInstance.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
