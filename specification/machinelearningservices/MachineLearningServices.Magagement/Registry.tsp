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
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{2,32}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  ...Azure.ResourceManager.ResourceSkuProperty;
}

@armResourceOperations
interface Registries {
  /**
   * Get registry
   */
  @summary("Get registry")
  get is ArmResourceRead<Registry>;

  /**
   * Create or update registry
   */
  @summary("Create or update registry")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Registry>;

  /**
   * Update tags
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update tags")
  update is ArmCustomPatchSync<
    Registry,
    PatchModel = PartialRegistryPartialTrackedResource
  >;

  /**
   * Delete registry
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete registry")
  delete is ArmResourceDeleteWithoutOkAsync<
    Registry,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List registries
   */
  @summary("List registries")
  list is ArmResourceListByParent<
    Registry,
    Response = ArmResponse<RegistryTrackedResourceArmPaginatedResult>
  >;

  /**
   * List registries by subscription
   */
  @summary("List registries by subscription")
  listBySubscription is ArmListBySubscription<
    Registry,
    Response = ArmResponse<RegistryTrackedResourceArmPaginatedResult>
  >;

  /**
   * Get blob reference SAS Uri.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get blob reference SAS Uri.")
  @post
  getBlobReferenceSAS(
    ...ReferenceSASParameters,
  ): ArmResponse<GetBlobReferenceSASResponseDto> | ErrorResponse;

  /**
   * Remove regions from registry
   */
  @summary("Remove regions from registry")
  removeRegions is ArmResourceActionAsyncBase<
    Registry,
    Registry,
    Response = ArmResponse<Registry> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Registry>> &
      Azure.Core.Foundations.RetryAfterHeader & {
        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        @header("x-ms-async-operation-timeout")
        timeout: duration;
      }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Registry>,
    Error = ErrorResponse
  >;
}

@@doc(Registry.name,
  "Name of Azure Machine Learning registry. This is case-insensitive"
);
@@doc(Registry.properties, "[Required] Additional attributes of the entity.");
@@doc(Registries.createOrUpdate::parameters.resource,
  "Details required to create the registry."
);
@@doc(Registries.update::parameters.properties,
  "Details required to create the registry."
);
// @@doc(Registries.getBlobReferenceSAS::parameters.body,
//   "Asset id and blob uri."
// );
@@doc(Registries.removeRegions::parameters.body,
  "Details required to create the registry."
);
@@doc(Registry.identity,
  "Managed service identity (system assigned and/or user assigned identities)"
);
@@doc(Registry.sku, "Sku details required for ARM contract for Autoscaling.");
