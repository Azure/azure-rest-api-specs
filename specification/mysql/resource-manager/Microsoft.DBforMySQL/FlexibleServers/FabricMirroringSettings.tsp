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
using TypeSpec.OpenAPI;

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
 * Extensible string-based union per Azure guidelines.
 */
@added(Versions.v2025_12_01_preview)
union FabricMirroringProvisioningState {
  /** Provisioning has succeeded. */
  Succeeded: "Succeeded",

  /** Provisioning is in progress. */
  Updating: "Updating",

  /** Provisioning was canceled. */
  Canceled: "Canceled",

  /** Provisioning has failed. */
  Failed: "Failed",

  /** Future/unknown values. */
  string,
}

/**
 * Properties of the Fabric Mirroring settings resource.
 */
@added(Versions.v2025_12_01_preview)
model FabricMirroringSettingsProperties {
  /** State of Fabric Mirroring (Enabled or Disabled). */
  state?: FabricMirroringState;

  /** Resource ID of the user-assigned managed identity used for Fabric Mirroring. */
  identityResourceId?: armResourceIdentifier;

  /** Provisioning state of Fabric Mirroring. */
  @visibility(Lifecycle.Read)
  provisioningState?: FabricMirroringProvisioningState;
}

/**
 * Fabric Mirroring settings proxy resource.
 */
@parentResource(Server)
model FabricMirroringSettings is ProxyResource<FabricMirroringSettingsProperties> {
  ...ResourceNameParameter<
    Resource = FabricMirroringSettings,
    KeyName = "fabricMirroringSettingsName",
    SegmentName = "fabricMirroringSettings",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@added(Versions.v2025_12_01_preview)
interface FabricMirroringSettingsOperations {
  @doc("Get Fabric Mirroring settings.")
  @operationId("FabricMirroringSettings_Get")
  get is ArmResourceRead<FabricMirroringSettings>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Async PUT returns 202 Accepted for long-running operations"
  @doc("Create or update Fabric Mirroring settings.")
  @operationId("FabricMirroringSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FabricMirroringSettings,
    Response = ArmResourceUpdatedResponse<FabricMirroringSettings> | ArmResourceCreatedResponse<
      FabricMirroringSettings,
      ArmAsyncOperationHeader<FinalResult = FabricMirroringSettings> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  @doc("List Fabric Mirroring settings by server.")
  @operationId("FabricMirroringSettings_ListByServer")
  listByServer is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<FabricMirroringSettings>;
}
