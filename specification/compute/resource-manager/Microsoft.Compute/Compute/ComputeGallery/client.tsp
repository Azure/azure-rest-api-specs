import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ComputeGallery;

// ── Os→OS property casing renames (C# backward compat) ──
@@clientName(GalleryImageProperties.osType, "OSType", "csharp");
@@clientName(GalleryImageProperties.osState, "OSState", "csharp");
@@clientName(EncryptionImages.osDiskImage, "OSDiskImage", "csharp");
@@clientName(GalleryImageVersionStorageProfile.osDiskImage, "OSDiskImage", "csharp");
@@clientName(GalleryInVMAccessControlProfileProperties.osType, "OSType", "csharp");
@@clientName(SharedGalleryImageProperties.osType, "OSType", "csharp");
@@clientName(SharedGalleryImageProperties.osState, "OSState", "csharp");
@@clientName(SharedGalleryImageVersionStorageProfile.osDiskImage, "OSDiskImage", "csharp");
@@clientName(CommunityGalleryImageProperties.osType, "OSType", "csharp");
@@clientName(CommunityGalleryImageProperties.osState, "OSState", "csharp");

// C# enum singular←plural rename
@@clientName(SharedToValues, "SharedToValue", "csharp");

// C# renames for backward compatibility (migration from AutoRest)
@@clientName(UserArtifactManage, "UserArtifactManagement", "csharp");
@@clientName(ValidationsProfile, "GalleryImageValidationsProfile", "csharp");
@@clientName(PolicyViolation, "GalleryImageVersionPolicyViolation", "csharp");
@@clientName(ReplicationMode, "GalleryReplicationMode", "csharp");
@@clientName(StorageAccountType, "ImageStorageAccountType", "csharp");
@@clientName(PlatformAttribute, "ComputeGalleryPlatformAttribute", "csharp");
@@clientName(ExecutedValidation, "GalleryImageExecutedValidation", "csharp");
@@clientName(ValidationStatus, "ComputeGalleryValidationStatus", "csharp");
@@clientName(GallerySharingPermissionTypes,
  "GallerySharingPermissionType",
  "csharp"
);

// Accessibility overrides
@@access(CommunityGalleryIdentifier, Access.public, "csharp");
@@access(CommunityGalleryImageIdentifier, Access.public, "csharp");
@@access(SharedGalleryIdentifier, Access.public, "csharp");

// Resource type InVM→InVm casing renames (backward compat with AutoRest output)
@@clientName(GalleryInVMAccessControlProfile,
  "GalleryInVmAccessControlProfile",
  "csharp"
);
@@clientName(GalleryInVMAccessControlProfileVersion,
  "GalleryInVmAccessControlProfileVersion",
  "csharp"
);
@@clientName(GalleryInVMAccessControlProfileProperties,
  "GalleryInVmAccessControlProfileProperties",
  "csharp"
);
@@clientName(GalleryInVMAccessControlProfileUpdate,
  "GalleryInVmAccessControlProfilePatch",
  "csharp"
);
@@clientName(GalleryInVMAccessControlProfileVersionProperties,
  "GalleryInVmAccessControlProfileVersionProperties",
  "csharp"
);
@@clientName(GalleryInVMAccessControlProfileVersionUpdate,
  "GalleryInVmAccessControlProfileVersionPatch",
  "csharp"
);
@@clientName(GalleryInVMAccessControlProfileList,
  "GalleryInVmAccessControlProfileList",
  "csharp"
);
@@clientName(GalleryInVMAccessControlProfileVersionList,
  "GalleryInVmAccessControlProfileVersionList",
  "csharp"
);

// AccessControlRules and EndpointAccess renames (backward compat with AutoRest RP-prefix)
@@clientName(AccessControlRules, "GalleryInVmAccessControlRules", "csharp");
@@clientName(AccessControlRulesMode,
  "GalleryInVmAccessControlRulesMode",
  "csharp"
);
@@clientName(AccessControlRulesPrivilege,
  "GalleryInVmAccessControlRulesPrivilege",
  "csharp"
);
@@clientName(AccessControlRulesRole,
  "GalleryInVmAccessControlRulesRole",
  "csharp"
);
@@clientName(AccessControlRulesIdentity,
  "GalleryInVmAccessControlRulesIdentity",
  "csharp"
);
@@clientName(AccessControlRulesRoleAssignment,
  "GalleryInVmAccessControlRulesRoleAssignment",
  "csharp"
);
@@clientName(EndpointAccess, "ComputeGalleryEndpointAccess", "csharp");

// Rename child identifier properties to avoid CS0108 hiding conflict with base class Identifier
@@clientName(CommunityGalleryImageProperties.identifier,
  "ImageIdentifier",
  "csharp"
);
@@clientName(SharedGalleryImageProperties.identifier,
  "ImageIdentifier",
  "csharp"
);

// Rename raw gallery operations to match old SDK method names
@@clientName(SharedGalleries.get, "GetSharedGallery", "csharp");
@@clientName(SharedGalleries.list, "GetSharedGalleries", "csharp");
@@clientName(SharedGalleryImages.get, "GetSharedGalleryImage", "csharp");
@@clientName(SharedGalleryImages.list, "GetSharedGalleryImages", "csharp");
@@clientName(SharedGalleryImageVersions.get,
  "GetSharedGalleryImageVersion",
  "csharp"
);
@@clientName(SharedGalleryImageVersions.list,
  "GetSharedGalleryImageVersions",
  "csharp"
);
@@clientName(CommunityGalleries.get, "GetCommunityGallery", "csharp");
@@clientName(CommunityGalleryImages.get, "GetCommunityGalleryImage", "csharp");
@@clientName(CommunityGalleryImages.list,
  "GetCommunityGalleryImages",
  "csharp"
);
@@clientName(CommunityGalleryImageVersions.get,
  "GetCommunityGalleryImageVersion",
  "csharp"
);
@@clientName(CommunityGalleryImageVersions.list,
  "GetCommunityGalleryImageVersions",
  "csharp"
);

// Type renames for backward compatibility
@@clientName(EndpointTypes, "ComputeGalleryEndpointType", "csharp");
@@clientName(GallerySoftDeletedResource, "GallerySoftDeletedResourceDetails", "csharp");
@@clientName(PirResource, "PirResourceData", "csharp");
@@clientName(PirSharedGalleryResource, "PirSharedGalleryResourceData", "csharp");
@@clientName(PirCommunityGalleryResource, "PirCommunityGalleryResourceData", "csharp");

// Rename gallery models to *Data for backward compatibility (they were ARM resources before)
@@clientName(SharedGallery, "SharedGalleryData", "csharp");
@@clientName(SharedGalleryImage, "SharedGalleryImageData", "csharp");
@@clientName(SharedGalleryImageVersion, "SharedGalleryImageVersionData", "csharp");
@@clientName(CommunityGallery, "CommunityGalleryData", "csharp");
@@clientName(CommunityGalleryImage, "CommunityGalleryImageData", "csharp");
@@clientName(CommunityGalleryImageVersion, "CommunityGalleryImageVersionData", "csharp");

// ── Plural→singular enum renames (C# backward compat) ──
@@clientName(ReplicationStatusTypes, "ReplicationStatusType", "csharp");
@@clientName(SelectPermissions, "SelectPermission", "csharp");
@@clientName(SharingProfileGroupTypes, "SharingProfileGroupType", "csharp");
@@clientName(SharingUpdateOperationTypes, "SharingUpdateOperationType", "csharp");
@@clientName(SoftDeletedArtifactTypes, "GallerySoftDeletedArtifactType", "csharp");

// ── VM→Vm casing renames (C# backward compat) ──
@@clientName(ConfidentialVMEncryptionType, "ConfidentialVmEncryptionType", "csharp");

// ── Other renames (C# backward compat) ──
@@clientName(GalleryExpandParams, "GalleryExpand", "csharp");
@@clientName(PolicyViolationCategory, "GalleryImageVersionPolicyViolationCategory", "csharp");
@@clientName(ReplicationState, "RegionalReplicationState", "csharp");

// ── Property casing renames: acronym case normalization (C# backward compat) ──
@@clientName(OSDiskImageSecurityProfile.confidentialVMEncryptionType, "ConfidentialVmEncryptionType", "csharp");
@@clientName(OSDiskImageSecurityProfile.secureVMDiskEncryptionSetId, "SecureVmDiskEncryptionSetId", "csharp");
@@clientName(RecommendedMachineConfiguration.vCPUs, "VCpus", "csharp");

// ── Is* prefix property renames (C# backward compat) ──
@@clientName(GalleryApplicationCustomActionParameter.required, "IsRequired", "csharp");
@@clientName(GalleryImageVersionSafetyProfile.blockDeletionBeforeEndOfLife, "IsBlockedDeletionBeforeEndOfLife", "csharp");
@@clientName(GalleryImageVersionSafetyProfile.reportedForPolicyViolation, "IsReportedForPolicyViolation", "csharp");
@@clientName(TargetRegion.excludeFromLatest, "IsExcludedFromLatest", "csharp");
@@clientName(GalleryImageVersionProperties.restore, "IsRestoreEnabled", "csharp");

// ── Qualified property name renames (C# backward compat) ──
@@clientName(GalleryApplicationCustomActionParameter.type, "ParameterType", "csharp");
@@clientName(GalleryExtendedLocation.type, "ExtendedLocationType", "csharp");
@@clientName(ExecutedValidation.type, "ExecutedValidationType", "csharp");
@@clientName(GalleryScriptParameter.type, "ParameterType", "csharp");
@@clientName(SharingProfileGroup.type, "GroupType", "csharp");
@@clientName(UefiKey.type, "KeyType", "csharp");

// ── Other property renames (C# backward compat) ──
@@clientName(ValidationsProfile.validationEtag, "ValidationETag", "csharp");
@@clientName(SharingProfile.permissions, "Permission", "csharp");

// ── alternateType: string → Uri for C# (migration from AutoRest) ──
@@alternateType(GalleryImageProperties.privacyStatementUri, url, "csharp");
@@alternateType(GalleryImageProperties.releaseNoteUri, url, "csharp");
@@alternateType(GalleryApplicationProperties.privacyStatementUri, url, "csharp");
@@alternateType(GalleryApplicationProperties.releaseNoteUri, url, "csharp");
@@alternateType(GalleryScriptProperties.privacyStatementUri, url, "csharp");
@@alternateType(GalleryScriptProperties.releaseNoteUri, url, "csharp");
@@alternateType(SharedGalleryImageProperties.privacyStatementUri, url, "csharp");
@@alternateType(CommunityGalleryInfo.publisherUri, url, "csharp");
@@alternateType(CommunityGalleryMetadata.privacyStatementUri, url, "csharp");
@@alternateType(CommunityGalleryImageProperties.privacyStatementUri, url, "csharp");
@@alternateType(GalleryDiskImageSource.uri, url, "csharp");

// ── alternateType: string → ResourceIdentifier for C# (migration from AutoRest) ──

// Wrapper model id properties → ResourceIdentifier
@@alternateType(GalleryArtifactVersionSource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Direct string properties → ResourceIdentifier
@@alternateType(GalleryArtifactVersionFullSource.virtualMachineId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(GalleryDiskImageSource.storageAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DiskImageEncryption.diskEncryptionSetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// ── alternateType: Identity → ManagedServiceIdentity for C# ──
@@alternateType(Gallery.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(GalleryUpdate.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
