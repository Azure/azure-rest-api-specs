import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.ConnectedCache;

@@clientName(Microsoft.ConnectedCache, "ConnectedCacheMgmt", "python");
@@clientName(Microsoft.ConnectedCache,
  "ConnectedCacheManagementClient",
  "java"
);

// CSharp Client configuration
@@clientName(EnterpriseMccCacheNodeResource,
  "EnterpriseMccCacheNode",
  "csharp"
);
@@clientName(EnterpriseMccCustomerResource, "EnterpriseMccCustomer", "csharp");
@@clientName(IspCacheNodeResource, "IspCacheNode", "csharp");
@@clientName(IspCustomerResource, "IspCustomer", "csharp");
@@clientName(AdditionalCacheNodeProperties,
  "MccCacheNodeAdditionalProperties",
  "csharp"
);
@@clientName(AdditionalCustomerProperties,
  "MccCustomerAdditionalProperties",
  "csharp"
);
@@clientName(AdditionalCustomerProperties.peeringDbLastUpdateDate,
  "peeringDBLastUpdatedOn",
  "csharp"
);
@@clientName(AdditionalCustomerProperties.customerEntitlementExpiration,
  "customerEntitlementExpiryOn",
  "csharp"
);
@@clientName(BgpCidrsConfiguration,
  "MccCacheNodeBgpCidrsConfiguration",
  "csharp"
);
@@clientName(BgpConfiguration, "MccCacheNodeBgpConfiguration", "csharp");
@@clientName(BgpReviewStateEnum, "MccCacheNodeBgpReviewState", "csharp");
@@clientName(CacheNodeEntity, "MccCacheNodeEntity", "csharp");
@@alternateType(CacheNodeEntity.fullyQualifiedResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(CacheNodeEntity.cidrCsvLastUpdateTime,
  "cidrCsvLastUpdatedOn",
  "csharp"
);
@@clientName(CacheNodeEntity.lastSyncWithAzureTimestamp,
  "lastSyncedWithAzureOn",
  "csharp"
);
@@clientName(CacheNodeEntity.lastUpdatedTimestamp, "lastUpdatedOn", "csharp");
@@clientName(CacheNodeEntity.bgpCidrCsvLastUpdateTime,
  "bgpCidrCsvLastUpdatedOn",
  "csharp"
);
@@clientName(CacheNodeEntity.bgpLastReportedTime,
  "bgpLastReportedOn",
  "csharp"
);
@@clientName(CacheNodeEntity.workerConnectionsLastUpdatedDateTime,
  "workerConnectionsLastUpdatedOn",
  "csharp"
);
@@alternateType(CacheNodeEntity.imageUri, url, "csharp");
@@clientName(CacheNodeProperty, "MccCacheNodeProperty", "csharp");
@@clientName(CacheNodeInstallProperties,
  "MccCacheNodeInstallProperties",
  "csharp"
);
@@clientName(ConfigurationState, "MccCacheNodeConfigurationState", "csharp");
@@clientName(CustomerEntity, "MccCustomerEntity", "csharp");
@@alternateType(CustomerEntity.fullyQualifiedResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(CustomerEntity.lastSyncWithAzureTimestamp,
  "lastSyncedWithAzureOn",
  "csharp"
);
@@clientName(CustomerProperty, "MccCustomerProperty", "csharp");
@@clientName(MccCacheNodeAutoUpdateHistory,
  "MccCacheNodeAutoUpdateHistoryData",
  "csharp"
);
@@clientName(MccCacheNodeAutoUpdateInfo.movedToTerminalStateDateTime,
  "movedToTerminalStateOn",
  "csharp"
);
@@clientName(MccCacheNodeAutoUpdateInfo.createdDateTimeUtc,
  "createdOn",
  "csharp"
);
@@clientName(MccCacheNodeAutoUpdateInfo.updatedRegistryDateTimeUtc,
  "updatedRegistryOn",
  "csharp"
);
@@clientName(MccCacheNodeIssueHistory,
  "MccCacheNodeIssueHistoryData",
  "csharp"
);
@@clientName(MccCacheNodeTlsCertificateHistory,
  "MccCacheNodeTlsCertificateHistoryData",
  "csharp"
);
@@clientName(MccIssue, "MccCacheNodeIssue", "csharp");
@@clientName(OsType, "MccCacheNodeOSType", "csharp");
@@clientName(ProxyRequired, "MccCacheNodeProxyRequired", "csharp");
@@clientName(ProxyUrlConfiguration,
  "MccCacheNodeProxyUriConfiguration",
  "csharp"
);
@@alternateType(ProxyUrlConfiguration.proxyUrl, url, "csharp");
@@clientName(ProvisioningState, "ConnectedCacheProvisioningState", "csharp");
