import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AzureArcData;
using Azure.ResourceManager;
using TypeSpec.Http;

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
  "ActiveDirectoryConnector",
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
