import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

model Registry
  is Azure.ResourceManager.TrackedResource<RegistryProperties, false> {
  ...ResourceNameParameter<
    Resource = Registry,
    KeyName = "registryName",
    SegmentName = "registries",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  ...Azure.ResourceManager.ResourceSkuProperty;
}

@armResourceOperations
interface Registries {
  /**
   * Get registry
   */
  get is ArmResourceRead<Registry>;

  /**
   * Create or update registry
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Registry,
    LroHeaders = ArmLroLocationHeader<FinalResult = Registry> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update tags
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Registry,
    PatchModel = PartialRegistryPartialTrackedResource
  >;

  /**
   * Delete registry.
   */
  delete is ArmResourceDeleteSync<Registry>;

  /**
   * List registries
   */
  list is ArmResourceListByParent<
    Registry,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    },
    Response = ArmResponse<RegistryTrackedResourceArmPaginatedResult>
  >;

  /**
   * List registries by subscription
   */
  listBySubscription is ArmListBySubscription<
    Registry,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    },
    Response = ArmResponse<RegistryTrackedResourceArmPaginatedResult>
  >;
}

@@doc(Registry.name, "Name of registry. This is case-insensitive");
@@doc(Registry.properties, "[Required] Additional attributes of the entity.");
@@doc(
  Registries.createOrUpdate::parameters.resource,
  "Details required to create the registry."
);
@@doc(
  Registries.update::parameters.properties,
  "Details required to create the registry."
);
