import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ComputeDisk;

@@clientName(DiskSecurityTypes.ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey,
  "ConfidentialVMVmguestStateOnlyEncryptedWithPlatformKey",
  "go"
);

// Property name changes - diskIOPS properties should be lowercase "iops" for Java compatibility
@@clientName(DiskProperties.diskIOPSReadWrite, "diskIopsReadWrite", "java");
@@clientName(DiskProperties.diskIOPSReadOnly, "diskIopsReadOnly", "java");
@@clientName(DiskUpdateProperties.diskIOPSReadWrite,
  "diskIopsReadWrite",
  "java"
);
@@clientName(DiskUpdateProperties.diskIOPSReadOnly, "diskIopsReadOnly", "java");

// Property name changes - AccessUri SAS properties should be lowercase "sas" for Java compatibility
@@clientName(AccessUri.accessSAS, "accessSas", "java");
@@clientName(AccessUri.securityDataAccessSAS, "securityDataAccessSas", "java");
@@clientName(AccessUri.securityMetadataAccessSAS,
  "securityMetadataAccessSas",
  "java"
);

// Property name changes - GrantAccessData SAS property should be lowercase "sas" for Java compatibility
@@clientName(GrantAccessData.getSecureVMGuestStateSAS,
  "getSecureVMGuestStateSas",
  "java"
);

// C# renames for backward compatibility (migration from AutoRest)
@@clientName(CreationData, "DiskCreationData", "csharp");
@@clientName(FileFormat, "DiskImageFileFormat", "csharp");
@@clientName(PublicNetworkAccess, "DiskPublicNetworkAccess", "csharp");
@@clientName(EncryptionSettingsCollection, "EncryptionSettingsGroup", "csharp");
@@clientName(Encryption, "DiskEncryption", "csharp");

// ARM resource renames for backward compatibility
// Disk → ManagedDisk (old: ManagedDiskResource, ManagedDiskData, ManagedDiskCollection)
@@clientName(Disk, "ManagedDisk", "csharp");

// PrivateEndpointConnection → ComputePrivateEndpointConnection (old RP-prefix convention)
@@clientName(PrivateEndpointConnection,
  "ComputePrivateEndpointConnection",
  "csharp"
);

// Type rename for backward compatibility
@@clientName(PrivateLinkResource, "ComputePrivateLinkResourceData", "csharp");

// ── Plural→singular enum renames (C# backward compat) ──
@@clientName(DiskSecurityTypes, "DiskSecurityType", "csharp");
@@clientName(DiskStorageAccountTypes, "DiskStorageAccountType", "csharp");
@@clientName(SnapshotStorageAccountTypes, "SnapshotStorageAccountType", "csharp");

// ── RP-prefix renames (C# backward compat) ──
@@clientName(EncryptionType, "ComputeEncryptionType", "csharp");

// ── alternateType overrides: string → armResourceIdentifier (C# backward compat) ──

// Wrapper model id properties → ResourceIdentifier
@@alternateType(SourceVault.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(ImageDiskReference.id, Azure.Core.armResourceIdentifier, "csharp");

// Disk
@@alternateType(Disk.managedBy, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Disk.managedByExtended,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DiskProperties.diskAccessId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// DiskUpdate
@@alternateType(DiskUpdateProperties.diskAccessId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// DiskRestorePoint
@@alternateType(DiskRestorePointProperties.diskAccessId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DiskRestorePointProperties.sourceResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Snapshot
@@alternateType(SnapshotProperties.diskAccessId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// SnapshotUpdate
@@alternateType(SnapshotUpdateProperties.diskAccessId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// CreationData
@@alternateType(CreationData.sourceResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(CreationData.storageAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(CreationData.elasticSanResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Encryption
@@alternateType(Encryption.diskEncryptionSetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// DiskSecurityProfile
@@alternateType(DiskSecurityProfile.secureVMDiskEncryptionSetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// PrivateLinkResource
@@alternateType(PrivateLinkResourceProperties.groupId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
