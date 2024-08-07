import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.DevOpsInfrastructure,
  "DevOpsInfrastructureMgmt",
  "python"
);

namespace Microsoft.DevOpsInfrastructure {
  @@access(Operations.list, Access.internal);

  /* Modify the usage to ensure backward compatibility with the SDK generated from Swagger. */
  @@usage(ResourceSkuProperties,
      Usage.input | Usage.output,
      "csharp");
  @@usage(ResourceSku,
      Usage.input | Usage.output,
      "csharp");
  @@usage(ResourceSkuZoneDetails,
      Usage.input | Usage.output,
      "csharp");
  @@usage(ResourceSkuRestrictions,
      Usage.input | Usage.output,
      "csharp");
  @@usage(ResourceSkuRestrictionInfo,
      Usage.input | Usage.output,
      "csharp");
  @@usage(ResourceSkuCapabilities,
      Usage.input | Usage.output,
      "csharp");
  @@usage(ResourceSkuLocationInfo,
      Usage.input | Usage.output,
      "csharp");
  @@usage(ResourceDetailsObjectProperties,
      Usage.input | Usage.output,
      "csharp");
  @@usage(ResourceDetailsObject,
      Usage.input | Usage.output,
      "csharp");
  @@usage(ImageVersion,
      Usage.input | Usage.output,
      "csharp");

  /* Rename models */
  @@clientName(ImageVersion,
      "DevOpsImageVersion",
      "csharp");

  @@clientName(Organization.url,
      "OrganizationUri",
      "csharp");
    
  @@clientName(GitHubOrganization.url,
      "OrganizationUri",
      "csharp");

  @@clientName(ResourceSkuRestrictions.type,
      "RestrictionsType",
      "csharp");
    
  @@clientName(StorageAccountType,
      "DevOpsStorageAccountType",
      "csharp");
  @@clientName(StorageAccountType.StandardLRS,
      "StandardLrs",
      "csharp");
  @@clientName(StorageAccountType.PremiumLRS,
      "PremiumLrs",
      "csharp");
  @@clientName(StorageAccountType.StandardSSDLRS,
      "StandardSsdLrs",
      "csharp");
  @@clientName(StorageAccountType.PremiumZRS,
      "PremiumZrs",
      "csharp");
  @@clientName(StorageAccountType.StandardSSDZRS,
      "StandardSsdZrs",
      "csharp");

  @@clientName(OsDiskStorageAccountType.StandardSSD,
      "StandardSsd",
      "csharp");

  @@clientName(Pool,
      "DevOpsPool",
      "csharp");

  @@clientName(PoolProperties,
      "DevOpsPoolProperties",
      "csharp");

  @@clientName(AgentProfile,
      "DevOpsPoolAgentProfile",
      "csharp");

  @@clientName(AzureDevOpsOrganizationProfile,
      "DevOpsAzureOrganizationProfile",
      "csharp");

  @@clientName(AzureDevOpsPermissionProfile,
      "DevOpsAzurePermissionProfile",
      "csharp");

  @@clientName(AzureDevOpsPermissionType,
      "DevOpsAzurePermissionType",
      "csharp");

  @@clientName(CachingType,
      "DevOpsDataDiskCachingType",
      "csharp");

  @@clientName(DataDisk,
      "DevOpsDataDisk",
      "csharp");

  @@clientName(FabricProfile,
      "DevOpsFabricProfile",
      "csharp");

  @@clientName(GitHubOrganization,
      "DevOpsGitHubOrganization",
      "csharp");

  @@clientName(GitHubOrganizationProfile,
      "DevOpsGitHubOrganizationProfile",
      "csharp");

  @@clientName(LogonType,
      "DevOpsLogonType",
      "csharp");

  @@clientName(NetworkProfile,
      "DevOpsNetworkProfile",
      "csharp");

  @@clientName(Organization,
      "DevOpsOrganization",
      "csharp");

  @@clientName(OrganizationProfile,
      "DevOpsOrganizationProfile",
      "csharp");

  @@clientName(OsProfile,
      "DevOpsOSProfile",
      "csharp");

  @@clientName(PoolImage,
      "DevOpsPoolVmImage",
      "csharp");

  @@clientName(ProvisioningState,
      "DevOpsInfrastructureProvisioningState",
      "csharp");

  @@clientName(Quota,
      "DevOpsResourceQuota",
      "csharp");

  @@clientName(QuotaName,
      "DevOpsResourceQuotaName",
      "csharp");

  @@clientName(ResourceDetailsObject,
      "DevOpsResourceDetails",
      "csharp");

  @@clientName(ResourceDetailsObjectProperties,
      "DevOpsResourceDetailsProperties",
      "csharp");

  @@clientName(ResourceStatus,
      "DevOpsResourceStatus",
      "csharp");

  @@clientName(ResourceSku,
      "DevOpsResourceSku",
      "csharp");

  @@clientName(ResourceSkuProperties,
      "DevOpsResourceSkuProperties",
      "csharp");

  @@clientName(Stateful,
      "DevOpsStateful",
      "csharp");

  @@clientName(StatelessAgentProfile,
      "DevOpsStatelessAgentProfile",
      "csharp");

  @@clientName(StorageProfile,
      "DevOpsStorageProfile",
      "csharp");
  
  @@clientName(VmssFabricProfile,
      "DevOpsVmssFabricProfile",
      "csharp");

  /* Rename opeartions */
  @@clientName(SubscriptionUsages.usages,
      "GetUsages",
      "csharp");
}