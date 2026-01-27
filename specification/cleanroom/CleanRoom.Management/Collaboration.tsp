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
 * Defines the collaboration.
 */
model Collaboration
  is Azure.ResourceManager.TrackedResource<CollaborationProperties, false> {
  ...ResourceNameParameter<
    Resource = Collaboration,
    KeyName = "collaborationName",
    SegmentName = "collaborations",
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
interface Collaborations {
  /**
   * Get a collaboration.
   */
  get is ArmResourceRead<Collaboration>;

  /**
   * Create or update a collaboration.
   */
  create is ArmResourceCreateOrReplaceAsync<Collaboration>;

  /**
   * Updates tags on a collaboration.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Collaboration,
    PatchModel = ResourceTags,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a collaboration.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Collaboration,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List collaborations in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Collaboration,
    Response = ArmResponse<CollaborationsList>
  >;

  /**
   * List collaborations in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    Collaboration,
    Response = ArmResponse<CollaborationsList>
  >;

  /**
   * Enables a workload on a collaboration.
   */
  @added(Versions.v2025_10_31_preview)
  enableWorkload is ArmResourceActionAsync<
    Collaboration,
    EnableWorkloadInput,
    ArmResponse<Collaboration>,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Adds a collaborator to a collaboration.
   */
  @added(Versions.v2025_10_31_preview)
  addCollaborator is ArmResourceActionAsync<
    Collaboration,
    AddCollaboratorInput,
    ArmResponse<Collaboration>,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Pauses collaboration.
   */
  @added(Versions.v2025_10_31_preview)
  pause is ArmResourceActionAsync<
    Collaboration,
    void,
    ArmResponse<Collaboration>,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Resumes collaboration.
   */
  @added(Versions.v2025_10_31_preview)
  resume is ArmResourceActionAsync<
    Collaboration,
    void,
    ArmResponse<Collaboration>,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Recovers collaboration.
   */
  @added(Versions.v2025_10_31_preview)
  recover is ArmResourceActionAsync<
    Collaboration,
    RecoverCollaborationInput,
    ArmResponse<Collaboration>,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(Collaboration.name, "Name of the collaboration.");
@@doc(Collaboration.properties, "Resource properties.");
@@doc(Collaborations.create::parameters.resource,
  "The collaboration to create or update."
);
@@doc(Collaborations.update::parameters.properties,
  "Resource properties to update."
);
