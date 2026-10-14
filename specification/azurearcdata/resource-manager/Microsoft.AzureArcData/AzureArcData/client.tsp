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
  "NameserverIpAddresses",
  "csharp"
);
@@clientName(Authentication, "SqlServerAuthentication", "csharp");
@@clientName(DbFailover, "DbFailover", "csharp");
@@clientName(DbFailover.ON, "On", "csharp");
@@clientName(DbFailover.OFF, "Off", "csharp");
@@clientName(DBMEndpoint, "DbmEndpoint", "csharp");
@@clientName(DBMEndpoint.ipAddress, "IpAddress", "csharp");
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
