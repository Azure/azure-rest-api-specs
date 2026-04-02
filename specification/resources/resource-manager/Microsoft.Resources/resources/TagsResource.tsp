import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Resources;
/**
 * Wrapper resource for tags API requests and responses.
 */
@singleton("default")
@extensionResource
model TagsResource is Azure.ResourceManager.ExtensionResource<Tags, false> {
  ...ResourceNameParameter<
    Resource = TagsResource,
    KeyName = "tag",
    SegmentName = "tags",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TagsResources {
  /**
   * Gets the entire set of tags on a resource or subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tags_GetAtScope")
  getAtScope is Extension.Read<Extension.ScopeParameter, TagsResource>;

  /**
   * This operation allows adding or replacing the entire set of tags on the specified resource or subscription. The specified entity can have a maximum of 50 tags.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Tags_CreateOrUpdateAtScope")
  createOrUpdateAtScope is Extension.CreateOrReplaceAsync<
    Extension.ScopeParameter,
    TagsResource,
    Response = ArmResourceUpdatedResponse<TagsResource> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = TagsResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * This operation allows replacing, merging or selectively deleting tags on the specified resource or subscription. The specified entity can have a maximum of 50 tags at the end of the operation. The 'replace' option replaces the entire set of existing tags with a new set. The 'merge' option allows adding tags with new names and updating the values of tags with existing names. The 'delete' option allows selectively deleting tags based on given names or name/value pairs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tags_UpdateAtScope")
  @patch(#{ implicitOptionality: false })
  updateAtScope is Extension.CustomPatchAsync<
    Extension.ScopeParameter,
    TagsResource,
    PatchModel = TagsPatchResource
  >;

  /**
   * Deletes the entire set of tags on a resource or subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Tags_DeleteAtScope")
  deleteAtScope is Extension.DeleteWithoutOkAsync<
    Extension.ScopeParameter,
    TagsResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
  >;
}

@@doc(TagsResource.name, "");
@@doc(TagsResource.properties, "The set of tags.");
@@doc(TagsResources.createOrUpdateAtScope::parameters.resource, "");
@@doc(TagsResources.updateAtScope::parameters.properties, "");
