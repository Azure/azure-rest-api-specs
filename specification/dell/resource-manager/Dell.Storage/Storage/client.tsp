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
  "DellFileSystemEncryptionProperties",
  "csharp"
);
@@clientName(EncryptionUpdateProperties,
  "DellFileSystemEncryptionPatchProperties",
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
@@clientName(ResourceEncryptionType.`Microsoft-managed keys (MMK)`,
  "MicrosoftManagedKeysMmk",
  "csharp"
);
@@clientName(ResourceEncryptionType.`Customer-managed keys (CMK)`,
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
@@alternateType(FileSystemResourceProperties.delegatedSubnetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(FileSystemResourceUpdateProperties.delegatedSubnetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(FileSystemResourceProperties.oneFsUrl, url, "csharp");
@@alternateType(FileSystemResourceUpdateProperties.delegatedSubnetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(FileSystemResourceUpdate.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
