import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Maps, "AzureMapsManagementClient", "javascript,python");

// Preserve legacy Java names for renamed encryption identity models.
@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentity,
  "CustomerManagedKeyEncryptionKeyIdentity",
  "java,javascript,python"
);
@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentityType,
  "IdentityType",
  "java,javascript"
);

// C# backward-compatible renames to match existing GA SDK surface.
// Fix namespace conflict (client "Maps" vs namespace "Azure.ResourceManager.Maps").
@@clientName(Microsoft.Maps, "AzureMapsManagement", "csharp");

// Resource type rename: Creator -> MapsCreator
@@clientName(Microsoft.Maps.Creator, "MapsCreator", "csharp");

// Model renames (prepend RP prefix "Maps")
@@clientName(Microsoft.Maps.CreatorProperties,
  "MapsCreatorProperties",
  "csharp"
);
@@clientName(Microsoft.Maps.CreatorUpdateParameters,
  "MapsCreatorPatch",
  "csharp"
);
@@clientName(Microsoft.Maps.CreatorList, "MapsCreatorListResult", "csharp");
@@clientName(Microsoft.Maps.AccountSasParameters,
  "MapsAccountSasContent",
  "csharp"
);
@@clientName(Microsoft.Maps.Kind, "MapsAccountKind", "csharp");
@@clientName(Microsoft.Maps.Name, "MapsSkuName", "csharp");
@@clientName(Microsoft.Maps.Sku, "MapsSku", "csharp");
@@clientName(Microsoft.Maps.InfrastructureEncryption,
  "MapsInfrastructureEncryption",
  "csharp"
);
@@clientName(Microsoft.Maps.SigningKey, "MapsSigningKey", "csharp");
@@clientName(Microsoft.Maps.KeyType, "MapsKeyType", "csharp");
@@clientName(Microsoft.Maps.LinkedResource, "MapsLinkedResource", "csharp");
@@clientName(Microsoft.Maps.CorsRule, "MapsCorsRule", "csharp");
@@clientName(Microsoft.Maps.CorsRules, "MapsCorsRules", "csharp");
@@clientName(Microsoft.Maps.PublicNetworkAccess,
  "MapsPublicNetworkAccess",
  "csharp"
);
@@clientName(Microsoft.Maps.PrivateEndpointConnection,
  "MapsPrivateEndpointConnection",
  "csharp"
);
@@clientName(Microsoft.Maps.PrivateLinkResource,
  "MapsPrivateLinkResource",
  "csharp"
);
@@clientName(Microsoft.Maps.LocationsItem, "MapsLocationItem", "csharp");

// Common type renames for C#
@@clientName(Azure.ResourceManager.CommonTypes.Encryption,
  "MapsEncryption",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentity,
  "CustomerManagedKeyEncryptionKeyIdentity",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentityType,
  "MapsIdentityType",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.InfrastructureEncryption,
  "MapsInfrastructureEncryption",
  "csharp"
);

// Remove OperationResult/OperationStatus LRO polling operations from C# generation
@@scope(Microsoft.Maps.OperationResultOperationGroup.get, "!csharp");
@@scope(Microsoft.Maps.OperationStatusOperationGroup.get, "!csharp");

// Override clientLocation for Operations.list to avoid C# namespace conflict
// (back-compatible.tsp sets it to "Maps" for all languages, which conflicts with
// the C# namespace Azure.ResourceManager.Maps)
@@clientLocation(Microsoft.Maps.Operations.list, "MapsOperations", "csharp");

// Format: uniqueId should be uuid (Guid) for backward compatibility
#suppress "@azure-tools/typespec-azure-core/no-format" "uuid format required for backward compat"
@@alternateType(Microsoft.Maps.MapsAccountProperties.uniqueId,
  Azure.Core.uuid,
  "csharp"
);

// Property renames for backward compatibility
@@clientName(Microsoft.Maps.MapsAccountKeys.primaryKeyLastUpdated,
  "PrimaryKeyLastUpdatedOn",
  "csharp"
);
@@clientName(Microsoft.Maps.MapsAccountKeys.secondaryKeyLastUpdated,
  "SecondaryKeyLastUpdatedOn",
  "csharp"
);

// DateTimeOffset format for key timestamps
@@alternateType(Microsoft.Maps.MapsAccountKeys.primaryKeyLastUpdated,
  utcDateTime,
  "csharp"
);
@@alternateType(Microsoft.Maps.MapsAccountKeys.secondaryKeyLastUpdated,
  utcDateTime,
  "csharp"
);

// URI format for key encryption key URL (target common type, not local model)
@@alternateType(Azure.ResourceManager.CommonTypes.CustomerManagedKeyEncryption.keyEncryptionKeyUrl,
  url,
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CustomerManagedKeyEncryption.keyEncryptionKeyUrl,
  "KeyEncryptionKeyUri",
  "csharp"
);
