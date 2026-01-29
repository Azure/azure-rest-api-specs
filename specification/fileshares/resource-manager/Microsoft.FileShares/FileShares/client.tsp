import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.Foundations;
using Microsoft.FileShares;

@@clientName(Microsoft.FileShares, "FileSharesManagementClient", "java");

@@scope(Operations.list, "!csharp");
@@clientName(Microsoft.FileShares.FileShares, "FileSharesInterface", "csharp");
@@clientName(CheckNameAvailabilityRequest,
  "FileShareNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityResponse,
  "FileShareNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(CheckNameAvailabilityReason,
  "FileShareNameUnavailableReason",
  "csharp"
);
@@clientName(FileShares.checkNameAvailability,
  "CheckFileShareNameAvailability",
  "csharp"
);
@@clientName(FileShareLimitsResponse, "FileShareLimitsResult", "csharp");
@@clientName(FileShareProvisioningRecommendationResponse,
  "FileShareProvisioningRecommendationResult",
  "csharp"
);
@@clientName(FileShareProvisioningRecommendationOutput,
  "FileShareProvisioningRecommendationOutputProperties",
  "csharp"
);
@@clientName(FileShareUsageDataResponse, "FileShareUsageDataResult", "csharp");
@@clientName(FileShareUsageDataOutput,
  "FileShareUsageDataProperties",
  "csharp"
);
@@clientName(FileShareProperties.provisionedStorageGiB,
  "ProvisionedStorageInGiB",
  "csharp"
);
@@clientName(FileShareProperties.provisionedStorageNextAllowedDowngrade,
  "ProvisionedStorageNextAllowedDowngradeOn",
  "csharp"
);
@@clientName(FileShareProperties.provisionedIOPerSecNextAllowedDowngrade,
  "ProvisionedIOPerSecNextAllowedDowngradeOn",
  "csharp"
);
@@clientName(FileShareProperties.provisionedThroughputNextAllowedDowngrade,
  "ProvisionedThroughputNextAllowedDowngradeOn",
  "csharp"
);
@@clientName(FileShareProvisioningRecommendationRequest,
  "FileShareProvisioningRecommendationContent",
  "csharp"
);
@@clientName(FileShareProvisioningRecommendationInput,
  "FileShareProvisioningRecommendationInputProperties",
  "csharp"
);
@@clientName(FileShareProvisioningRecommendationInput.provisionedStorageGiB,
  "ProvisionedStorageInGiB",
  "csharp"
);
@@clientName(PublicNetworkAccess, "FileSharePublicNetworkAccess", "csharp");
@@clientName(MediaTier, "FileShareMediaTier", "csharp");
@@clientName(MediaTier.SSD, "Ssd", "csharp");
@@clientName(Redundancy, "FileShareRedundancyLevel", "csharp");
@@clientName(Protocol, "FileShareProtocol", "csharp");
@@clientName(Protocol.NFS, "Nfs", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties,
  "FileSharePrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateLinkServiceConnectionState,
  "FileSharePrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProvisioningState,
  "FileSharePrivateEndpointConnectionProvisioningState",
  "csharp"
);
@@clientName(Azure.ResourceManager.PrivateEndpointConnection,
  "FileSharePrivateEndpointConnection",
  "csharp"
);
