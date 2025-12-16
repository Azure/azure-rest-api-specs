import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CleanRoom;
/**
 * Defines the consortium view.
 */
@added(Versions.v2025_10_31_preview)
model ConsortiumView
  is Azure.ResourceManager.TrackedResource<ConsortiumViewProperties, false> {
  ...ResourceNameParameter<
    Resource = ConsortiumView,
    KeyName = "consortiumViewName",
    SegmentName = "consortiumViews",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[-\\w\\._,\\(\\)]+$")
  kind?: string;
}

@armResourceOperations
@added(Versions.v2025_10_31_preview)
interface ConsortiumViews {
  /**
   * Get a consortium view.
   */
  get is ArmResourceRead<ConsortiumView>;
  /**
   * Create or update a consortium view.
   */
  create is ArmResourceCreateOrReplaceAsync<ConsortiumView>;
  /**
   * Updates tags on a consortium view.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ConsortiumView,
    PatchModel = ResourceTags,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a consortium view.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ConsortiumView,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List consortium views in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ConsortiumView,
    Response = ArmResponse<ConsortiumViewsList>
  >;

  /**
   * List consortium views in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    ConsortiumView,
    Response = ArmResponse<ConsortiumViewsList>
  >;
}

@@doc(ConsortiumView.name, "Name of the consortium view.");
@@doc(ConsortiumView.properties, "Resource properties.");
@@doc(ConsortiumViews.create::parameters.resource,
  "The consortium view to create or update."
);
@@doc(ConsortiumViews.update::parameters.properties,
  "Resource properties to update."
);
