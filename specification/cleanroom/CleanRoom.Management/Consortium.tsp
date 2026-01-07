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
 * Defines the consortium.
 */
model Consortium
  is Azure.ResourceManager.TrackedResource<ConsortiumProperties, false> {
  ...ResourceNameParameter<
    Resource = Consortium,
    KeyName = "consortiumName",
    SegmentName = "consortiums",
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
interface Consortiums {
  /**
   * Get a consortium.
   */
  get is ArmResourceRead<Consortium>;

  /**
   * Create or update a consortium.
   */
  create is ArmResourceCreateOrReplaceAsync<Consortium>;

  /**
   * Updates tags on a consortium.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Consortium,
    PatchModel = ResourceTags,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a consortium.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Consortium,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List consortiums in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Consortium,
    Response = ArmResponse<ConsortiumsList>
  >;

  /**
   * List consortiums in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    Consortium,
    Response = ArmResponse<ConsortiumsList>
  >;

  /**
   * Pauses consortium.
   */
  pause is ArmResourceActionAsync<
    Consortium,
    void,
    ArmResponse<Consortium>,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Resumes consortium.
   */
  resume is ArmResourceActionAsync<
    Consortium,
    void,
    ArmResponse<Consortium>,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Recovers consortium.
   */
  @added(Versions.v2025_10_31_preview)
  recover is ArmResourceActionAsync<
    Consortium,
    RecoverConsortiumInput,
    ArmResponse<Consortium>,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(Consortium.name, "Name of the consortium.");
@@doc(Consortium.properties, "Resource properties.");
@@doc(Consortiums.create::parameters.resource,
  "The consortium to create or update."
);
@@doc(Consortiums.update::parameters.properties,
  "Resource properties to update."
);
