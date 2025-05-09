import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using LiftrBase;
using LiftrBase.Storage;

@@clientName(Dell.Storage, "DellStorageMgmt", "python");
@@clientName(Dell.Storage, "DellStorageMgmtClient", "java");

// CSharp
@@clientName(FileSystemResource, "DellFileSystem", "csharp");
@@clientName(FileSystemResourceProperties,
  "DellFileSystemProperties",
  "csharp"
);
@@clientName(Capacity, "DellFileSystemCapacity", "csharp");
@@clientName(EncryptionIdentityProperties,
  "DellFileSystemEncryptionIdentityProperties",
  "csharp"
);
@@clientName(EncryptionIdentityType,
  "DellFileSystemEncryptionIdentityType",
  "csharp"
);
@@clientName(EncryptionIdentityUpdateProperties,
  "DellFileSystemEncryptionIdentityPatchProperties",
  "csharp"
);
@@clientName(EncryptionProperties,
  "DellFileSystemEncryptionPropertiess",
  "csharp"
);
@@clientName(EncryptionUpdateProperties,
  "DellFileSystemEncryptionPatchPropertiess",
  "csharp"
);
@@clientName(MarketplaceDetails, "DellFileSystemMarketplaceDetails", "csharp");
@@clientName(MarketplaceSubscriptionStatus,
  "DellFileSystemMarketplaceSubscriptionStatus",
  "csharp"
);
@@clientName(ProvisioningState, "DellFileSystemProvisioningState", "csharp");
@@clientName(UserDetails, "DellFileSystemUserDetails", "csharp");
@@clientName(ResourceEncryptionType, "DellFileSystemEncryptionType", "csharp");
@@clientName(ResourceEncryptionType.MicrosoftManagedKeysMMK,
  "MicrosoftManagedKeysMmk",
  "csharp"
);
@@clientName(ResourceEncryptionType.CustomerManagedKeysCMK,
  "CustomerManagedKeysCmk",
  "csharp"
);
@@alternateType(EncryptionIdentityProperties.identityResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(EncryptionIdentityUpdateProperties.identityResourceId,
  armResourceIdentifier,
  "csharp"
);
