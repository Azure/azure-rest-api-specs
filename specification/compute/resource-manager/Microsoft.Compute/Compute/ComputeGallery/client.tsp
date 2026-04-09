import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ComputeGallery;

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
