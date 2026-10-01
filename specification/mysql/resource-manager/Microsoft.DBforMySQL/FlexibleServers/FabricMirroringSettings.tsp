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

namespace Microsoft.DBforMySQL;

/**
 * State of Fabric Mirroring.
 * Extensible string-based union per Azure guidelines.
 */
@added(Versions.v2025_12_01_preview)
union FabricMirroringState {
  /** Fabric Mirroring is enabled. */
  Enabled: "Enabled",

  /** Fabric Mirroring is disabled. */
  Disabled: "Disabled",

  /** Future/unknown values. */
  string,
}

/**
 * Provisioning state of Fabric Mirroring.
 * Extends the standard Azure.ResourceManager.ResourceProvisioningState with the
 * non-terminal `Updating` state used by this resource.
 */
@added(Versions.v2025_12_01_preview)
union FabricMirroringProvisioningState {
  Azure.ResourceManager.ResourceProvisioningState,

  /** Provisioning is in progress. */
  Updating: "Updating",
}

/**
 * Properties of the Fabric Mirroring settings resource.
 */
@added(Versions.v2025_12_01_preview)
model FabricMirroringSettingsProperties {
  /** State of Fabric Mirroring (Enabled or Disabled). */
  state?: FabricMirroringState;

  /** Resource ID of the user-assigned managed identity used for Fabric Mirroring. Required when state is Enabled. */
  identityResourceId?: armResourceIdentifier;

  /** Provisioning state of Fabric Mirroring. */
  @visibility(Lifecycle.Read)
  provisioningState?: FabricMirroringProvisioningState;
}

/**
 * The name of the Fabric Mirroring settings resource (singleton: only "default" is allowed).
 */
@added(Versions.v2025_12_01_preview)
union FabricMirroringSettingsName {
  /** The default Fabric Mirroring settings instance. */
  Default: "Default",

  string,
}

/**
 * Fabric Mirroring settings proxy resource.
 */
@parentResource(Server)
model FabricMirroringSetting
  is ProxyResource<FabricMirroringSettingsProperties> {
  ...ResourceNameParameter<
    Resource = FabricMirroringSetting,
    KeyName = "fabricMirroringSettingsName",
    SegmentName = "fabricMirroringSettings",
    NamePattern = "",
    Type = FabricMirroringSettingsName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FabricMirroringSettings is a server-intrinsic singleton whose lifecycle is tied to the parent server. Settings are toggled via PUT with state Enabled/Disabled rather than created or deleted independently."
@armResourceOperations
@added(Versions.v2025_12_01_preview)
interface FabricMirroringSettings {
  @doc("Get Fabric Mirroring settings.")
  get is ArmResourceRead<FabricMirroringSetting>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The live service returns 202 Accepted for async PUT operations using both Location and Azure-AsyncOperation polling headers. This is the established pattern for this resource provider."
  @doc("Create or update Fabric Mirroring settings.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FabricMirroringSetting,
    Response =
      | ArmResourceUpdatedResponse<FabricMirroringSetting>
      | ArmResourceCreatedResponse<
          FabricMirroringSetting,
          ArmAsyncOperationHeader<FinalResult = FabricMirroringSetting> &
            Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmAcceptedLroResponse
  >;

  @doc("List Fabric Mirroring settings by server.")
  listByServer is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<FabricMirroringSetting>;
}
