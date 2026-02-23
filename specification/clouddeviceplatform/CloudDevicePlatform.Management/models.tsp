import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.CloudDevicePlatform;

@added(Versions.v2024_06_01_preview)
@doc("Represents a CloudDevicePlatform delegated identity resource.")
model DelegatedIdentity is TrackedResource<DelegatedIdentityProperties> {
  ...ResourceNameParameter<
    Resource = DelegatedIdentity,
    NamePattern = "^[a-zA-Z0-9-]{3,128}$"
  >;
  ...Microsoft.ManagedServiceCommonTypes.ManagedServiceIdentityWithDelegationProperty;
}

@added(Versions.v2024_06_01_preview)
@doc("Represents the properties of a CloudDevicePlatform delegated identity resource.")
model DelegatedIdentityProperties {
  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2024_06_01_preview)
@doc("Represents the properties of a DelegatedIdentity resource that can be updated.")
model DelegatedIdentityUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("Updatable managed service identity")
  identity?: Microsoft.ManagedServiceCommonTypes.ManagedServiceIdentityWithDelegationUpdate;
}

/*
 * Currently, the ManagedIdentityWithDelegation common type is not available to use. Below is a workaround provided by
 * the follow stack overflow post: https://stackoverflow.microsoft.com/questions/406446/407138#407138
 *
 * An issue tracking availability of the type is here: https://github.com/Azure/typespec-azure/issues/944
 */
namespace Microsoft.ManagedServiceCommonTypes {
  /** Managed service identity (system assigned and/or user assigned identities and/or delegated identities) - internal use only. */
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "common type"
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
  @Azure.ResourceManager.CommonTypes.Private.armCommonDefinition(
    "ManagedServiceIdentityWithDelegation",
    Azure.ResourceManager.CommonTypes.Versions.v5,
    "managedidentitywithdelegation.json"
  )
  @added(Versions.v2024_06_01_preview)
  model ManagedServiceIdentityWithDelegation
    extends Azure.ResourceManager.Foundations.ManagedServiceIdentity {
    /** The set of delegated resources. The delegated resources dictionary keys will be source resource internal ids - internal use only. */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "common type"
    delegatedResources?: Record<DelegatedResource>;
  }

  /** Delegated resource properties - internal use only. */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
  @Azure.ResourceManager.CommonTypes.Private.armCommonDefinition(
    "DelegatedResource",
    Azure.ResourceManager.CommonTypes.Versions.v5,
    "managedidentitywithdelegation.json"
  )
  model DelegatedResource {
    /** The ARM resource id of the delegated resource - internal use only. */
    resourceId?: string;

    /** The tenant id of the delegated resource - internal use only. */
    tenantId?: Azure.Core.uuid;

    /** The delegation id of the referral delegation (optional) - internal use only. */
    referralResource?: string;

    /** The source resource location - internal use only. */
    location?: string;
  }

  /** Mix-in envelope property for ManagedServiceIdentityWithDelegation */
  alias ManagedServiceIdentityWithDelegationProperty = {
    /** The set of delegated resources. The delegated resources dictionary keys will be source resource internal ids */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "common type"
    identity?: ManagedServiceIdentityWithDelegation;
  };

  /** Model defining updatable properties of a ManagedServiceIdentityWithDelegation */
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
  @added(Versions.v2024_06_01_preview)
  model ManagedServiceIdentityWithDelegationUpdate
    extends OptionalProperties<UpdateableProperties<Azure.ResourceManager.Legacy.ManagedServiceIdentityV4>> {
    /** The set of delegated resources. The delegated resources dictionary keys will be source resource internal ids */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "required for patch operations"
    delegatedResources?: Record<DelegatedResource>;
  }
}
