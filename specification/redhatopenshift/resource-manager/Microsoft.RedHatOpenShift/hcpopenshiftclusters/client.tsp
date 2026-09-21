import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.RedHatOpenShift;

// Client name overrides for azure-sdk-for-net
namespace Microsoft.RedHatOpenShift {
  // request-body model names must not end with 'Request'
  @@clientName(
    HcpOpenShiftClusterAdminCredentialRequest,
    "HcpOpenShiftClusterAdminCredentialRequestContent",
    "csharp"
  );

  // boolean property missing an "Is/Has/Should/Can" prefix
  @@clientName(NodePoolProperties.autoRepair, "canAutoRepair", "csharp");

  // DateTimeOffset properties must end in "On"
  @@clientName(
    HcpOpenShiftClusterAdminCredential.expirationTimestamp,
    "expirationTimestampOn",
    "csharp"
  );
  @@clientName(
    HcpOpenShiftVersionProperties.endOfLifeTimestamp,
    "endOfLifeTimestampOn",
    "csharp"
  );

  // Add top-level resource name prefix to cluster model and type names
  @@clientName(ApiProfile, "HcpOpenShiftClusterApiProfile", "csharp");
  @@clientName(
    ClusterAutoscalingProfile,
    "HcpOpenShiftClusterAutoscalingProfile",
    "csharp"
  );
  @@clientName(
    ClusterImageRegistryProfile,
    "HcpOpenShiftClusterImageRegistryProfile",
    "csharp"
  );
  @@clientName(
    ClusterImageRegistryState,
    "HcpOpenShiftClusterImageRegistryState",
    "csharp"
  );
  @@clientName(Condition, "HcpOpenShiftClusterCondition", "csharp");
  @@clientName(ConditionType, "HcpOpenShiftClusterConditionType", "csharp");
  @@clientName(ConsoleProfile, "HcpOpenShiftClusterConsoleProfile", "csharp");
  @@clientName(
    CustomerManagedEncryptionProfile,
    "HcpOpenShiftClusterCustomerManagedEncryptionProfile",
    "csharp"
  );
  @@clientName(
    CustomerManagedEncryptionType,
    "HcpOpenShiftClusterCustomerManagedEncryptionType",
    "csharp"
  );
  @@clientName(DnsProfile, "HcpOpenShiftClusterDnsProfile", "csharp");
  @@clientName(
    EtcdDataEncryptionKeyManagementModeType,
    "HcpOpenShiftClusterEtcdDataEncryptionKeyManagementModeType",
    "csharp"
  );
  @@clientName(
    EtcdDataEncryptionProfile,
    "HcpOpenShiftClusterEtcdDataEncryptionProfile",
    "csharp"
  );
  @@clientName(EtcdProfile, "HcpOpenShiftClusterEtcdProfile", "csharp");
  @@clientName(
    ImageDigestMirror,
    "HcpOpenShiftClusterImageDigestMirror",
    "csharp"
  );
  @@clientName(ImageRepository, "HcpOpenShiftClusterImageRepository", "csharp");
  @@clientName(IngressProfile, "HcpOpenShiftClusterIngressProfile", "csharp");
  @@clientName(IngressType, "HcpOpenShiftClusterIngressType", "csharp");
  @@clientName(
    KeyVaultVisibility,
    "HcpOpenShiftClusterKeyVaultVisibility",
    "csharp"
  );
  @@clientName(
    KmsEncryptionProfile,
    "HcpOpenShiftClusterKmsEncryptionProfile",
    "csharp"
  );
  @@clientName(KmsKey, "HcpOpenShiftClusterKmsKey", "csharp");
  @@clientName(NetworkProfile, "HcpOpenShiftClusterNetworkProfile", "csharp");
  @@clientName(NetworkType, "HcpOpenShiftClusterNetworkType", "csharp");
  @@clientName(
    OperatorsAuthenticationProfile,
    "HcpOpenShiftClusterOperatorsAuthenticationProfile",
    "csharp"
  );
  @@clientName(OutboundType, "HcpOpenShiftClusterOutboundType", "csharp");
  @@clientName(PlatformProfile, "HcpOpenShiftClusterPlatformProfile", "csharp");
  @@clientName(ResourceStatus, "HcpOpenShiftClusterResourceStatus", "csharp");
  @@clientName(StatusType, "HcpOpenShiftClusterConditionStatusType", "csharp");
  @@clientName(
    UserAssignedIdentitiesProfile,
    "HcpOpenShiftClusterUserAssignedIdentitiesProfile",
    "csharp"
  );
  @@clientName(VersionProfile, "HcpOpenShiftClusterVersionProfile", "csharp");
  @@clientName(Visibility, "HcpOpenShiftClusterApiVisibility", "csharp");

  // Add top-level resource name prefix to node pool model and type names
  @@clientName(
    DiskStorageAccountType,
    "HcpOpenShiftClusterNodePoolDiskStorageAccountType",
    "csharp"
  );
  @@clientName(Effect, "HcpOpenShiftClusterNodePoolTaintEffect", "csharp");
  @@clientName(Label, "HcpOpenShiftClusterNodePoolLabel", "csharp");
  @@clientName(NodePool, "HcpOpenShiftClusterNodePool", "csharp");
  @@clientName(
    NodePoolAutoScaling,
    "HcpOpenShiftClusterNodePoolAutoScaling",
    "csharp"
  );
  @@clientName(
    NodePoolPlatformProfile,
    "HcpOpenShiftClusterNodePoolPlatformProfile",
    "csharp"
  );
  @@clientName(
    NodePoolProperties,
    "HcpOpenShiftClusterNodePoolProperties",
    "csharp"
  );
  @@clientName(
    NodePoolVersionProfile,
    "HcpOpenShiftClusterNodePoolVersionProfile",
    "csharp"
  );
  @@clientName(NodePools, "HcpOpenShiftClusterNodePools", "csharp");
  @@clientName(
    OsDiskProfile,
    "HcpOpenShiftClusterNodePoolOsDiskProfile",
    "csharp"
  );
  @@clientName(OsDiskType, "HcpOpenShiftClusterNodePoolOsDiskType", "csharp");
  @@clientName(Taint, "HcpOpenShiftClusterNodePoolTaint", "csharp");

  // Add top-level resource name prefix to external auth model and type names
  @@clientName(ExternalAuth, "HcpOpenShiftClusterExternalAuth", "csharp");
  @@clientName(
    ExternalAuthClaimProfile,
    "HcpOpenShiftClusterExternalAuthClaimProfile",
    "csharp"
  );
  @@clientName(
    ExternalAuthClientComponentProfile,
    "HcpOpenShiftClusterExternalAuthClientComponentProfile",
    "csharp"
  );
  @@clientName(
    ExternalAuthClientProfile,
    "HcpOpenShiftClusterExternalAuthClientProfile",
    "csharp"
  );
  @@clientName(
    ExternalAuthClientType,
    "HcpOpenShiftClusterExternalAuthClientType",
    "csharp"
  );
  @@clientName(
    ExternalAuthCondition,
    "HcpOpenShiftClusterExternalAuthCondition",
    "csharp"
  );
  @@clientName(
    ExternalAuthConditionType,
    "HcpOpenShiftClusterExternalAuthConditionType",
    "csharp"
  );
  @@clientName(
    ExternalAuthProperties,
    "HcpOpenShiftClusterExternalAuthProperties",
    "csharp"
  );
  @@clientName(ExternalAuths, "HcpOpenShiftClusterExternalAuths", "csharp");
  @@clientName(
    GroupClaimProfile,
    "HcpOpenShiftClusterExternalAuthGroupClaimProfile",
    "csharp"
  );
  @@clientName(
    TokenClaimMappingsProfile,
    "HcpOpenShiftClusterExternalAuthTokenClaimMappingsProfile",
    "csharp"
  );
  @@clientName(
    TokenClaimValidationRule,
    "HcpOpenShiftClusterExternalAuthTokenClaimValidationRule",
    "csharp"
  );
  @@clientName(
    TokenIssuerProfile,
    "HcpOpenShiftClusterExternalAuthTokenIssuerProfile",
    "csharp"
  );
  @@clientName(
    TokenRequiredClaim,
    "HcpOpenShiftClusterExternalAuthTokenRequiredClaim",
    "csharp"
  );
  @@clientName(
    TokenValidationRuleType,
    "HcpOpenShiftClusterExternalAuthTokenValidationRuleType",
    "csharp"
  );
  @@clientName(
    UsernameClaimPrefixPolicy,
    "HcpOpenShiftClusterExternalAuthUsernameClaimPrefixPolicy",
    "csharp"
  );
  @@clientName(
    UsernameClaimProfile,
    "HcpOpenShiftClusterExternalAuthUsernameClaimProfile",
    "csharp"
  );
}

@@clientName(
  Microsoft.RedHatOpenShift,
  "RedHatOpenShiftHcpMgmtClient",
  "python"
);
