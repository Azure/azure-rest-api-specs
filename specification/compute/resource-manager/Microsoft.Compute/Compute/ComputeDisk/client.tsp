import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ComputeDisk;

@@clientName(DiskSecurityTypes.ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey,
  "ConfidentialVMVmguestStateOnlyEncryptedWithPlatformKey",
  "go,javascript"
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

// ── Os→OS property casing renames (C# backward compat) ──
@@clientName(DiskProperties.osType, "OSType", "csharp");
@@clientName(DiskUpdateProperties.osType, "OSType", "csharp");
@@clientName(DiskRestorePointProperties.osType, "OSType", "csharp");
@@clientName(SnapshotProperties.osType, "OSType", "csharp");
@@clientName(SnapshotUpdateProperties.osType, "OSType", "csharp");

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

// ── Property casing renames: acronym case normalization (C# backward compat) ──
@@clientName(AccessUri.accessSAS, "AccessSas", "csharp");
@@clientName(AccessUri.securityDataAccessSAS, "SecurityDataAccessSas", "csharp");
@@clientName(AccessUri.securityMetadataAccessSAS, "SecurityMetadataAccessSas", "csharp");
@@clientName(DiskSecurityProfile.secureVMDiskEncryptionSetId, "SecureVmDiskEncryptionSetId", "csharp");
@@clientName(GrantAccessData.getSecureVMGuestStateSAS, "GetSecureVmGuestStateSas", "csharp");
@@clientName(DiskProperties.diskIOPSReadOnly, "DiskIopsReadOnly", "csharp");
@@clientName(DiskProperties.diskIOPSReadWrite, "DiskIopsReadWrite", "csharp");
@@clientName(DiskUpdateProperties.diskIOPSReadOnly, "DiskIopsReadOnly", "csharp");
@@clientName(DiskUpdateProperties.diskIOPSReadWrite, "DiskIopsReadWrite", "csharp");

// ── Is* prefix property renames (C# backward compat) ──
@@clientName(CreationData.performancePlus, "IsPerformancePlusEnabled", "csharp");
@@clientName(DiskProperties.optimizedForFrequentAttach, "IsOptimizedForFrequentAttach", "csharp");
@@clientName(DiskUpdateProperties.optimizedForFrequentAttach, "IsOptimizedForFrequentAttach", "csharp");

// ── Qualified property name renames (C# backward compat) ──
@@clientName(Encryption.type, "EncryptionType", "csharp");

// ── Other property renames (C# backward compat) ──
@@clientName(DiskProperties.encryptionSettingsCollection, "EncryptionSettingsGroup", "csharp");
@@clientName(DiskUpdateProperties.encryptionSettingsCollection, "EncryptionSettingsGroup", "csharp");
@@clientName(SnapshotProperties.encryptionSettingsCollection, "EncryptionSettingsGroup", "csharp");
@@clientName(SnapshotUpdateProperties.encryptionSettingsCollection, "EncryptionSettingsGroup", "csharp");
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState, "ConnectionState", "csharp");

// ── alternateType overrides: string → armResourceIdentifier (C# backward compat) ──

// Wrapper model id properties → ResourceIdentifier
@@alternateType(SourceVault.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(ImageDiskReference.id, Azure.Core.armResourceIdentifier, "csharp");

// Disk
@@alternateType(Disk.managedBy, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Disk.managedByExtended,
  Azure.Core.armResourceIdentifier[],
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
// .NET back-compat: previously shipped DiskRestorePointData with a public ctor and
// settable properties. TypeSpec's default usage flags this as output-only, which
// removes both. Forcing Azure.ClientGenerator.Core.Usage.input restores the public ctor + property setters.
@@usage(DiskRestorePoint, Azure.ClientGenerator.Core.Usage.input, "csharp");
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

// ── alternateType: Identity → ManagedServiceIdentity for C# ──
@@alternateType(DiskEncryptionSet.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(DiskEncryptionSetUpdate.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);

// ── alternateType: string → Uri for C# (migration from AutoRest) ──
@@alternateType(CreationData.sourceUri, url, "csharp");
@@alternateType(CreationData.securityDataUri, url, "csharp");
@@alternateType(KeyForDiskEncryptionSet.keyUrl, url, "csharp");
@@alternateType(KeyVaultAndKeyReference.keyUrl, url, "csharp");
@@alternateType(KeyVaultAndSecretReference.secretUrl, url, "csharp");
@@alternateType(ShareInfoElement.vmUri, url, "csharp");

// Mark non-pageable list operations as pageable for backward compatibility
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(DiskAccesses.getPrivateLinkResources,
  "csharp"
);


// .NET back-compat: restore previously shipped acronym/casing for extensible-enum members.
@@clientName(DiskStorageAccountTypes.Standard_LRS, "StandardLrs", "csharp");
@@clientName(DiskStorageAccountTypes.Premium_LRS, "PremiumLrs", "csharp");
@@clientName(DiskStorageAccountTypes.StandardSSD_LRS, "StandardSsdLrs", "csharp");
@@clientName(DiskStorageAccountTypes.UltraSSD_LRS, "UltraSsdLrs", "csharp");
@@clientName(DiskStorageAccountTypes.Premium_ZRS, "PremiumZrs", "csharp");
@@clientName(DiskStorageAccountTypes.StandardSSD_ZRS, "StandardSsdZrs", "csharp");
@@clientName(DiskStorageAccountTypes.PremiumV2_LRS, "PremiumV2Lrs", "csharp");

@@clientName(SnapshotStorageAccountTypes.Standard_LRS, "StandardLrs", "csharp");
@@clientName(SnapshotStorageAccountTypes.Premium_LRS, "PremiumLrs", "csharp");
@@clientName(SnapshotStorageAccountTypes.Standard_ZRS, "StandardZrs", "csharp");

@@clientName(DiskSecurityTypes.ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey,
  "ConfidentialVmGuestStateOnlyEncryptedWithPlatformKey",
  "csharp"
);
@@clientName(DiskSecurityTypes.ConfidentialVM_DiskEncryptedWithPlatformKey,
  "ConfidentialVmDiskEncryptedWithPlatformKey",
  "csharp"
);
@@clientName(DiskSecurityTypes.ConfidentialVM_DiskEncryptedWithCustomerKey,
  "ConfidentialVmDiskEncryptedWithCustomerKey",
  "csharp"
);
@@clientName(DiskSecurityTypes.ConfidentialVM_NonPersistedTPM, "ConfidentialVmNonPersistedTPM", "csharp");

@@clientName(DiskState.ActiveSAS, "ActiveSas", "csharp");
@@clientName(DiskState.ActiveSASFrozen, "ActiveSasFrozen", "csharp");

@@clientName(FileFormat.VHD, "Vhd", "csharp");
@@clientName(FileFormat.VHDX, "Vhdx", "csharp");

@@clientName(SupportedSecurityOption.TrustedLaunchAndConfidentialVMSupported,
  "TrustedLaunchAndConfidentialVmSupported",
  "csharp"
);
