import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Purview, "PurviewManagementClient", "javascript,python");
@@clientName(Microsoft.Purview.AccountSkuName, "Name", "java");
@@clientName(Microsoft.Purview.PrivateEndpointConnectionStatus,
  "Status",
  "java"
);
@@clientName(Microsoft.Purview.ManagedIdentityType, "Type", "java");

// csharp renames to preserve backward compatibility
@@clientName(Microsoft.Purview.AccountEndpoints,
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
@@clientName(Microsoft.Purview.ManagedResources,
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
@@clientName(Microsoft.Purview.AccountStatus,
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
