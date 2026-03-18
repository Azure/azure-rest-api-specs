import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

// TrackedResource wrapper for C# backward compatibility (old SDK used TrackedResourceData base)
namespace Microsoft.Purview {
  @doc("Account resource.")
  model PurviewAccountModel
    is Azure.ResourceManager.TrackedResource<AccountProperties> {
    ...Azure.ResourceManager.ResourceNameParameter<
      Resource = Account,
      KeyName = "accountName",
      SegmentName = "accounts",
      NamePattern = "^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$"
    >;
    identity?: Identity;
    sku?: AccountSku;
  }
}

@@clientName(Microsoft.Purview, "PurviewManagementClient", "javascript,python");
@@clientName(Microsoft.Purview.AccountSkuName, "Name", "java");
@@clientName(Microsoft.Purview.PrivateEndpointConnectionStatus,
  "Status",
  "java"
);
@@clientName(Microsoft.Purview.ManagedIdentityType, "Type", "java");

// csharp renames to preserve backward compatibility
// Rename sub-types (not base types) to match old SDK naming
@@clientName(Microsoft.Purview.AccountPropertiesEndpoints,
  "PurviewAccountEndpoint",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountProperties,
  "PurviewAccountProperties",
  "csharp"
);
@@clientName(Microsoft.Purview.AccessKeys,
  "PurviewAccountAccessKey",
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
@@clientName(Microsoft.Purview.DefaultAccountPayload,
  "DefaultPurviewAccountPayload",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountPropertiesManagedResources,
  "PurviewManagedResource",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountSkuName,
  "PurviewAccountSkuName",
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
@@clientName(Microsoft.Purview.Reason,
  "PurviewAccountNameUnavailableReason",
  "csharp"
);
@@clientName(Microsoft.Purview.ScopeType,
  "PurviewAccountScopeType",
  "csharp"
);
@@clientName(Microsoft.Purview.PrivateEndpointConnectionStatus,
  "PurviewPrivateLinkServiceStatus",
  "csharp"
);
@@clientName(Microsoft.Purview.PrivateEndpointConnectionStatusUpdateResponse,
  "PrivateEndpointConnectionStatusUpdateResult",
  "csharp"
);
@@clientName(Microsoft.Purview.PrivateEndpointConnectionStatusUpdateRequest,
  "PrivateEndpointConnectionStatusUpdateContent",
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
@@clientName(Microsoft.Purview.EventHubType,
  "PurviewKafkaEventHubType",
  "csharp"
);

// prepend-rp-prefix equivalents
@@clientName(Microsoft.Purview.Credentials,
  "PurviewCredentials",
  "csharp"
);
@@clientName(Microsoft.Purview.KafkaConfigurationIdentityType,
  "PurviewCredentialsType",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountProvisioningState,
  "PurviewAccountProvisioningState",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountPropertiesAccountStatus,
  "PurviewAccountStatus",
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
@@clientName(Microsoft.Purview.ManagedEventHubState,
  "PurviewManagedEventHubState",
  "csharp"
);
@@clientName(Microsoft.Purview.UsageName,
  "PurviewUsageName",
  "csharp"
);
@@clientName(Microsoft.Purview.QuotaName,
  "PurviewQuotaName",
  "csharp"
);

// property renames
@@clientName(Microsoft.Purview.CheckNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(Microsoft.Purview.CollectionAdminUpdate.objectId,
  "AdminObjectId",
  "csharp"
);

// accessibility fix
@@access(Microsoft.Purview.PrivateLinkResourceProperties, Access.public, "csharp");

// fix common types v3 Resource.id type for C# (v3 emits string instead of armResourceIdentifier)
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Replace Account with TrackedResource-based model for C# (ensures TrackedResourceData base)
@@alternateType(Microsoft.Purview.Account, Microsoft.Purview.PurviewAccountModel, "csharp");
@@clientName(Microsoft.Purview.PurviewAccountModel, "PurviewAccount", "csharp");
@@clientName(Microsoft.Purview.KafkaConfiguration, "PurviewKafkaConfiguration", "csharp");
@@clientName(Microsoft.Purview.PrivateEndpointConnection,
  "PurviewPrivateEndpointConnection",
  "csharp"
);
@@clientName(Microsoft.Purview.PrivateLinkResource,
  "PurviewPrivateLinkResource",
  "csharp"
);

// Additional model renames for backward compat
@@clientName(Microsoft.Purview.AccountSku, "PurviewAccountSku", "csharp");
@@clientName(Microsoft.Purview.AccountUpdateParameters, "PurviewAccountPatch", "csharp");
@@clientName(Microsoft.Purview.PrivateLinkServiceConnectionState,
  "PurviewPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(Microsoft.Purview.AccountMergeInfo, "PurviewAccountMergeInfo", "csharp");

// Property rename for backward compat (createdAt → CreatedOn)
@@clientName(Microsoft.Purview.AccountProperties.createdAt, "CreatedOn", "csharp");

// Identity type override to use ARM common type instead of custom Identity model
@@alternateType(
  Microsoft.Purview.PurviewAccountModel.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  Microsoft.Purview.AccountUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);

// Flatten PurviewAccountModel.properties for C#
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Purview.PurviewAccountModel.properties,
  "csharp"
);

// Flatten Account.properties is already done in back-compatible.tsp for all languages

// Flatten CloudConnectors for C# (old SDK had CloudConnectorsAwsExternalId as direct property)
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Purview.AccountProperties.cloudConnectors,
  "csharp"
);

// Rename flattened CloudConnectors property to match old SDK naming
@@clientName(Microsoft.Purview.CloudConnectors.awsExternalId,
  "CloudConnectorsAwsExternalId",
  "csharp"
);

// Make AccountProperties public (old SDK exposed it in PurviewAccountPatch.Properties)
@@access(Microsoft.Purview.AccountProperties, Access.public, "csharp");
@@usage(Microsoft.Purview.AccountProperties, Usage.input | Usage.output, "csharp");

// Property type fixes: string → ResourceIdentifier for ManagedResources
@@alternateType(
  Microsoft.Purview.ManagedResources.eventHubNamespace,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Purview.ManagedResources.resourceGroup,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Purview.ManagedResources.storageAccount,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Property type fix: PrivateEndpoint.id → ResourceIdentifier
@@alternateType(
  Microsoft.Purview.PrivateEndpoint.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Property type fix: DefaultAccountPayload.scopeTenantId → Guid
@@alternateType(
  Microsoft.Purview.DefaultAccountPayload.scopeTenantId,
  Azure.Core.uuid,
  "csharp"
);

// Property rename: PrivateEndpointConnectionProperties.privateLinkServiceConnectionState → ConnectionState
@@clientName(
  Microsoft.Purview.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);

// Rename error-related sub-types
@@clientName(Microsoft.Purview.AccountStatusErrorDetails,
  "PurviewAccountStatusErrorDetails",
  "csharp"
);

// Operation renames for backward compatibility with old extension method names
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
@@clientName(Microsoft.Purview.AccountsOperationGroup.checkNameAvailability,
  "CheckPurviewAccountNameAvailability",
  "csharp"
);

// Property rename: CheckNameAvailabilityRequest.type → ResourceType
@@clientName(Microsoft.Purview.CheckNameAvailabilityRequest.type,
  "ResourceType",
  "csharp"
);

// Note: scopeTenantId Guid type is handled via custom code overloads
