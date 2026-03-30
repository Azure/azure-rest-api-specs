import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.Purview;

@@clientName(Microsoft.Purview, "PurviewManagementClient", "javascript,python");

// java renames
@@clientName(AccountSkuName, "Name", "java");
@@clientName(PrivateEndpointConnectionStatus, "Status", "java");
@@clientName(ManagedIdentityType, "Type", "java");

// C# customizations: renames, access/usage overrides, type overrides, and legacy transforms
// to preserve backward compatibility with the existing Azure.ResourceManager.Purview SDK.
@@clientName(AccessKeys, "PurviewAccountAccessKey", "csharp");
@@clientName(AccountEndpoints, "PurviewAccountEndpoint", "csharp");
@@clientName(AccountMergeInfo, "PurviewAccountMergeInfo", "csharp");
@@clientName(AccountProperties, "PurviewAccountProperties", "csharp");
@@clientName(AccountProvisioningState,
  "PurviewAccountProvisioningState",
  "csharp"
);
@@clientName(AccountSku, "PurviewAccountSku", "csharp");
@@clientName(AccountSkuName, "PurviewAccountSkuName", "csharp");
@@clientName(AccountStatus, "PurviewAccountStatus", "csharp");
@@clientName(AccountStatusErrorDetails,
  "PurviewAccountStatusErrorDetails",
  "csharp"
);
@@clientName(AccountUpdateParameters, "PurviewAccountPatch", "csharp");
@@clientName(BatchFeatureRequest, "PurviewBatchFeatureContent", "csharp");
@@clientName(BatchFeatureStatus, "PurviewBatchFeatureStatus", "csharp");
@@clientName(CheckNameAvailabilityRequest,
  "PurviewAccountNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityResult,
  "PurviewAccountNameAvailabilityResult",
  "csharp"
);
@@clientName(CollectionAdminUpdate, "CollectionAdminUpdateContent", "csharp");
@@clientName(Credentials, "PurviewCredentials", "csharp");
@@clientName(DefaultAccountPayload, "DefaultPurviewAccountPayload", "csharp");
@@clientName(EventHubType, "PurviewKafkaEventHubType", "csharp");
@@clientName(EventStreamingState, "PurviewEventStreamingState", "csharp");
@@clientName(EventStreamingType, "PurviewEventStreamingType", "csharp");
@@clientName(IngestionStorage, "PurviewIngestionStorage", "csharp");
@@clientName(KafkaConfiguration, "PurviewKafkaConfiguration", "csharp");
@@clientName(KafkaConfigurationIdentityType,
  "PurviewCredentialsType",
  "csharp"
);
@@clientName(ManagedEventHubState, "PurviewManagedEventHubState", "csharp");
@@clientName(ManagedResources, "PurviewManagedResource", "csharp");
@@clientName(MergeAccountType, "PurviewMergeAccountType", "csharp");
@@clientName(MergeStatus, "PurviewMergeStatus", "csharp");
@@clientName(Microsoft.Purview.PrivateEndpointConnection,
  "PurviewPrivateEndpointConnection",
  "csharp"
);
@@clientName(PrivateEndpointConnectionStatus,
  "PurviewPrivateLinkServiceStatus",
  "csharp"
);
@@clientName(PrivateEndpointConnectionStatusUpdateRequest,
  "PrivateEndpointConnectionStatusUpdateContent",
  "csharp"
);
@@clientName(PrivateEndpointConnectionStatusUpdateResponse,
  "PrivateEndpointConnectionStatusUpdateResult",
  "csharp"
);
@@clientName(Microsoft.Purview.PrivateLinkResource,
  "PurviewPrivateLinkResource",
  "csharp"
);
@@clientName(Microsoft.Purview.PrivateLinkServiceConnectionState,
  "PurviewPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(ProvisioningState, "PurviewProvisioningState", "csharp");
@@clientName(PublicNetworkAccess, "PurviewPublicNetworkAccess", "csharp");
@@clientName(QuotaName, "PurviewQuotaName", "csharp");
@@clientName(Reason, "PurviewAccountNameUnavailableReason", "csharp");
@@clientName(ScopeType, "PurviewAccountScopeType", "csharp");
@@clientName(TenantEndpointState, "PurviewTenantEndpointState", "csharp");
@@clientName(UsageName, "PurviewUsageName", "csharp");
// Rename spec's UserAssignedIdentity to avoid conflict with ARM common-types UserAssignedIdentity
// brought in via @@alternateType(...ManagedServiceIdentity)
@@clientName(UserAssignedIdentity, "PurviewUserAssignedIdentity", "csharp");

// --- clientName: property renames ---
@@clientName(AccountProperties.createdAt, "CreatedOn", "csharp");
@@clientName(AccountStatus.errorDetails, "Error", "csharp");
@@clientName(CheckNameAvailabilityRequest.type, "ResourceType", "csharp");
@@clientName(CheckNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(CloudConnectors.awsExternalId,
  "CloudConnectorsAwsExternalId",
  "csharp"
);
@@clientName(CollectionAdminUpdate.objectId, "AdminObjectId", "csharp");
@@clientName(Credentials.type, "CredentialsType", "csharp");
@@clientName(Microsoft.Purview.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.ErrorResponse.error,
  "ErrorDetails",
  "csharp"
);

// --- clientName: operation renames ---
@@clientName(Accounts.accountGet, "AccountGetFeature", "csharp");
@@clientName(Accounts.list, "GetIngestionPrivateEndpointConnections", "csharp");
@@clientName(Accounts.updateStatus,
  "UpdateStatusIngestionPrivateEndpointConnection",
  "csharp"
);
@@clientName(AccountsOperationGroup.checkNameAvailability,
  "CheckPurviewAccountNameAvailability",
  "csharp"
);
@@clientName(DefaultAccountsOperationGroup.get, "GetDefaultAccount", "csharp");
@@clientName(DefaultAccountsOperationGroup.remove,
  "RemoveDefaultAccount",
  "csharp"
);
@@clientName(DefaultAccountsOperationGroup.set, "SetDefaultAccount", "csharp");
@@clientName(FeaturesOperationGroup.subscriptionGet,
  "SubscriptionGetFeature",
  "csharp"
);
@@clientName(UsagesOperationGroup.get, "GetUsages", "csharp");
// --- alternateType overrides ---
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(Account, "PurviewAccount", "csharp");
@@alternateType(AccountProperties.accountStatus, AccountStatus, "csharp");
@@alternateType(AccountProperties.endpoints, AccountEndpoints, "csharp");
@@alternateType(AccountProperties.managedResources, ManagedResources, "csharp");
@@alternateType(AccountProperties.managedResourcesPublicNetworkAccess,
  ManagedResourcesPublicNetworkAccess,
  "csharp"
);
@@alternateType(AccountStatus.errorDetails,
  Azure.ResourceManager.CommonTypes.ErrorResponse,
  "csharp"
);
@@alternateType(Account.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(AccountUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(DefaultAccountPayload.scopeTenantId, Azure.Core.uuid, "csharp");
@@alternateType(ScopeTenantIdParameters.scopeTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ManagedResources.eventHubNamespace,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ManagedResources.resourceGroup,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ManagedResources.storageAccount,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.Purview.PrivateEndpoint.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// --- Legacy transforms ---
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AccountProperties.cloudConnectors,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(UsagesOperationGroup.get,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Account,
  Azure.ResourceManager.CommonTypes.TrackedResource,
  "csharp"
);

/**
 * Gets or sets the public network access for managed resources.
 */
union ManagedResourcesPublicNetworkAccess {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}
