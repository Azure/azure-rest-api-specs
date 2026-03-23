import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

@@clientName(Microsoft.Purview, "PurviewManagementClient", "javascript,python");

// java renames
@@clientName(Microsoft.Purview.AccountSkuName, "Name", "java");
@@clientName(Microsoft.Purview.PrivateEndpointConnectionStatus,
  "Status",
  "java"
);
@@clientName(Microsoft.Purview.ManagedIdentityType, "Type", "java");

// C# customizations: renames, access/usage overrides, type overrides, and legacy transforms
// to preserve backward compatibility with the existing Azure.ResourceManager.Purview SDK.
@@clientName(Microsoft.Purview.AccessKeys, "PurviewAccountAccessKey", "csharp");
@@clientName(Microsoft.Purview.AccountEndpoints,
  "PurviewAccountEndpoint",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountMergeInfo,
  "PurviewAccountMergeInfo",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountProperties,
  "PurviewAccountProperties",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountProvisioningState,
  "PurviewAccountProvisioningState",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountSku, "PurviewAccountSku", "csharp");
@@clientName(Microsoft.Purview.AccountSkuName,
  "PurviewAccountSkuName",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountStatus, "PurviewAccountStatus", "csharp");
@@clientName(Microsoft.Purview.AccountStatusErrorDetails,
  "PurviewAccountStatusErrorDetails",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountUpdateParameters,
  "PurviewAccountPatch",
  "csharp"
);
@@clientName(Microsoft.Purview.BatchFeatureRequest,
  "PurviewBatchFeatureContent",
  "csharp"
);
@@clientName(Microsoft.Purview.BatchFeatureStatus,
  "PurviewBatchFeatureStatus",
  "csharp"
);
@@clientName(Microsoft.Purview.CheckNameAvailabilityRequest,
  "PurviewAccountNameAvailabilityContent",
  "csharp"
);
@@clientName(Microsoft.Purview.CheckNameAvailabilityResult,
  "PurviewAccountNameAvailabilityResult",
  "csharp"
);
@@clientName(Microsoft.Purview.CollectionAdminUpdate,
  "CollectionAdminUpdateContent",
  "csharp"
);
@@clientName(Microsoft.Purview.Credentials, "PurviewCredentials", "csharp");
@@clientName(Microsoft.Purview.DefaultAccountPayload,
  "DefaultPurviewAccountPayload",
  "csharp"
);
@@clientName(Microsoft.Purview.EventHubType,
  "PurviewKafkaEventHubType",
  "csharp"
);
@@clientName(Microsoft.Purview.EventStreamingState,
  "PurviewEventStreamingState",
  "csharp"
);
@@clientName(Microsoft.Purview.EventStreamingType,
  "PurviewEventStreamingType",
  "csharp"
);
@@clientName(Microsoft.Purview.IngestionStorage,
  "PurviewIngestionStorage",
  "csharp"
);
@@clientName(Microsoft.Purview.KafkaConfiguration,
  "PurviewKafkaConfiguration",
  "csharp"
);
@@clientName(Microsoft.Purview.KafkaConfigurationIdentityType,
  "PurviewCredentialsType",
  "csharp"
);
@@clientName(Microsoft.Purview.ManagedEventHubState,
  "PurviewManagedEventHubState",
  "csharp"
);
@@clientName(Microsoft.Purview.ManagedResources,
  "PurviewManagedResource",
  "csharp"
);
@@clientName(Microsoft.Purview.MergeAccountType,
  "PurviewMergeAccountType",
  "csharp"
);
@@clientName(Microsoft.Purview.MergeStatus, "PurviewMergeStatus", "csharp");
@@clientName(Microsoft.Purview.PrivateEndpointConnection,
  "PurviewPrivateEndpointConnection",
  "csharp"
);
@@clientName(Microsoft.Purview.PrivateEndpointConnectionStatus,
  "PurviewPrivateLinkServiceStatus",
  "csharp"
);
@@clientName(Microsoft.Purview.PrivateEndpointConnectionStatusUpdateRequest,
  "PrivateEndpointConnectionStatusUpdateContent",
  "csharp"
);
@@clientName(Microsoft.Purview.PrivateEndpointConnectionStatusUpdateResponse,
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
@@clientName(Microsoft.Purview.ProvisioningState,
  "PurviewProvisioningState",
  "csharp"
);
@@clientName(Microsoft.Purview.PublicNetworkAccess,
  "PurviewPublicNetworkAccess",
  "csharp"
);
@@clientName(Microsoft.Purview.QuotaName, "PurviewQuotaName", "csharp");
@@clientName(Microsoft.Purview.Reason,
  "PurviewAccountNameUnavailableReason",
  "csharp"
);
@@clientName(Microsoft.Purview.ScopeType, "PurviewAccountScopeType", "csharp");
@@clientName(Microsoft.Purview.TenantEndpointState,
  "PurviewTenantEndpointState",
  "csharp"
);
@@clientName(Microsoft.Purview.UsageName, "PurviewUsageName", "csharp");

// --- clientName: property renames ---
@@clientName(Microsoft.Purview.AccountProperties.createdAt,
  "CreatedOn",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountStatus.errorDetails, "Error", "csharp");
@@clientName(Microsoft.Purview.CheckNameAvailabilityRequest.type,
  "ResourceType",
  "csharp"
);
@@clientName(Microsoft.Purview.CheckNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(Microsoft.Purview.CloudConnectors.awsExternalId,
  "CloudConnectorsAwsExternalId",
  "csharp"
);
@@clientName(Microsoft.Purview.CollectionAdminUpdate.objectId,
  "AdminObjectId",
  "csharp"
);
@@clientName(Microsoft.Purview.Credentials.type, "CredentialsType", "csharp");
@@clientName(Microsoft.Purview.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.ErrorResponse.error,
  "ErrorDetails",
  "csharp"
);

// --- clientName: operation renames ---
@@clientName(Microsoft.Purview.Accounts.accountGet,
  "AccountGetFeature",
  "csharp"
);
@@clientName(Microsoft.Purview.Accounts.list,
  "GetIngestionPrivateEndpointConnections",
  "csharp"
);
@@clientName(Microsoft.Purview.Accounts.updateStatus,
  "UpdateStatusIngestionPrivateEndpointConnection",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountsOperationGroup.checkNameAvailability,
  "CheckPurviewAccountNameAvailability",
  "csharp"
);
@@clientName(Microsoft.Purview.DefaultAccountsOperationGroup.get,
  "GetDefaultAccount",
  "csharp"
);
@@clientName(Microsoft.Purview.DefaultAccountsOperationGroup.remove,
  "RemoveDefaultAccount",
  "csharp"
);
@@clientName(Microsoft.Purview.DefaultAccountsOperationGroup.set,
  "SetDefaultAccount",
  "csharp"
);
@@clientName(Microsoft.Purview.FeaturesOperationGroup.subscriptionGet,
  "SubscriptionGetFeature",
  "csharp"
);
@@clientName(Microsoft.Purview.UsagesOperationGroup.get, "GetUsages", "csharp");

// --- access / usage overrides ---
// AccountProperties: public class, input+output (exposed in PurviewAccountPatch.Properties)
@@access(Microsoft.Purview.AccountProperties, Access.public, "csharp");
@@usage(Microsoft.Purview.AccountProperties,
  Usage.input | Usage.output,
  "csharp"
);
// AccountSku: public class, output-only (internal constructor, get-only properties)
@@access(Microsoft.Purview.AccountSku, Access.public, "csharp");
@@usage(Microsoft.Purview.AccountSku, Usage.output, "csharp");

// --- alternateType overrides ---
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.Purview.Account,
  Microsoft.Purview.PurviewAccount,
  "csharp"
);
@@alternateType(Microsoft.Purview.AccountProperties.accountStatus,
  Microsoft.Purview.AccountStatus,
  "csharp"
);
@@alternateType(Microsoft.Purview.AccountProperties.endpoints,
  Microsoft.Purview.AccountEndpoints,
  "csharp"
);
@@alternateType(Microsoft.Purview.AccountProperties.managedResources,
  Microsoft.Purview.ManagedResources,
  "csharp"
);
@@alternateType(Microsoft.Purview.AccountProperties.managedResourcesPublicNetworkAccess,
  Microsoft.Purview.ManagedResourcesPublicNetworkAccess,
  "csharp"
);
@@alternateType(Microsoft.Purview.AccountStatus.errorDetails,
  Azure.ResourceManager.CommonTypes.ErrorResponse,
  "csharp"
);
@@alternateType(Microsoft.Purview.AccountUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(Microsoft.Purview.DefaultAccountPayload.scopeTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.Purview.ManagedResources.eventHubNamespace,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.Purview.ManagedResources.resourceGroup,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.Purview.ManagedResources.storageAccount,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.Purview.PrivateEndpoint.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// --- Legacy transforms ---
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Microsoft.Purview.PurviewAccount.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Microsoft.Purview.AccountProperties.cloudConnectors,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(Microsoft.Purview.UsagesOperationGroup.get,
  "csharp"
);

namespace Microsoft.Purview {
  // Custom TrackedResource model to fix base class inheritance
  // (Legacy.TrackedResourceWithOptionalLocation generates ResourceData base, but old SDK used TrackedResourceData)
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility"
  model PurviewAccount
    is Azure.ResourceManager.TrackedResource<AccountProperties> {
    ...Azure.ResourceManager.ResourceNameParameter<
      Resource = Account,
      KeyName = "accountName",
      SegmentName = "accounts",
      NamePattern = "^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$"
    >;

    /** The Managed Identity of the resource. */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required for backward compatibility"
    identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

    /** Gets or sets the Sku. */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required for backward compatibility"
    @visibility(Lifecycle.Read)
    sku?: AccountSku;
  }

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
}
