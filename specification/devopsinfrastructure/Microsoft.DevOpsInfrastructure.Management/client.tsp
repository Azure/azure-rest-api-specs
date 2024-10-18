import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DevOpsInfrastructure;

@@clientName(Microsoft.DevOpsInfrastructure,
  "DevOpsInfrastructureMgmt",
  "python"
);

@@access(Operations.list, Access.internal);

/* Rename models */
@@clientName(ImageVersion, "DevOpsImageVersion", "csharp");

@@clientName(ResourceSkuRestrictions.type, "RestrictionsType", "csharp");

@@clientName(StorageAccountType, "DevOpsStorageAccountType", "csharp");
@@clientName(StorageAccountType.StandardLRS, "StandardLrs", "csharp");
@@clientName(StorageAccountType.PremiumLRS, "PremiumLrs", "csharp");
@@clientName(StorageAccountType.StandardSSDLRS, "StandardSsdLrs", "csharp");
@@clientName(StorageAccountType.PremiumZRS, "PremiumZrs", "csharp");
@@clientName(StorageAccountType.StandardSSDZRS, "StandardSsdZrs", "csharp");

@@clientName(OsDiskStorageAccountType.StandardSSD, "StandardSsd", "csharp");

@@clientName(Pool, "DevOpsPool", "csharp");

@@clientName(PoolProperties, "DevOpsPoolProperties", "csharp");

@@clientName(AgentProfile, "DevOpsPoolAgentProfile", "csharp");

@@clientName(AzureDevOpsOrganizationProfile,
  "DevOpsAzureOrganizationProfile",
  "csharp"
);

@@clientName(AzureDevOpsPermissionProfile,
  "DevOpsAzurePermissionProfile",
  "csharp"
);

@@clientName(AzureDevOpsPermissionType, "DevOpsAzurePermissionType", "csharp");

@@clientName(CachingType, "DevOpsDataDiskCachingType", "csharp");

@@clientName(DataDisk, "DevOpsDataDisk", "csharp");

@@clientName(FabricProfile, "DevOpsFabricProfile", "csharp");

@@clientName(GitHubOrganization, "DevOpsGitHubOrganization", "csharp");

@@clientName(GitHubOrganizationProfile,
  "DevOpsGitHubOrganizationProfile",
  "csharp"
);

@@clientName(LogonType, "DevOpsLogonType", "csharp");

@@clientName(NetworkProfile, "DevOpsNetworkProfile", "csharp");

@@clientName(Organization, "DevOpsOrganization", "csharp");

@@clientName(OrganizationProfile, "DevOpsOrganizationProfile", "csharp");

@@clientName(OsProfile, "DevOpsOSProfile", "csharp");

@@clientName(PoolImage, "DevOpsPoolVmImage", "csharp");

@@clientName(ProvisioningState,
  "DevOpsInfrastructureProvisioningState",
  "csharp"
);

@@clientName(Quota, "DevOpsResourceQuota", "csharp");

@@clientName(QuotaName, "DevOpsResourceQuotaName", "csharp");

@@clientName(ResourceDetailsObject, "DevOpsResourceDetails", "csharp");

@@clientName(ResourceDetailsObjectProperties,
  "DevOpsResourceDetailsProperties",
  "csharp"
);

@@clientName(ResourceStatus, "DevOpsResourceStatus", "csharp");

@@clientName(ResourceSku, "DevOpsResourceSku", "csharp");

@@clientName(ResourceSkuProperties, "DevOpsResourceSkuProperties", "csharp");

@@clientName(Stateful, "DevOpsStateful", "csharp");

@@clientName(StatelessAgentProfile, "DevOpsStatelessAgentProfile", "csharp");

@@clientName(StorageProfile, "DevOpsStorageProfile", "csharp");

@@clientName(VmssFabricProfile, "DevOpsVmssFabricProfile", "csharp");

/* Rename opeartions */
@@clientName(SubscriptionUsages.usages, "GetUsages", "csharp");
