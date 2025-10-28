import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

@parentResource(Workspace)
model InferenceGroup
  is Azure.ResourceManager.TrackedResource<InferenceGroupProperties, false> {
  ...ResourceNameParameter<
    Resource = InferenceGroup,
    KeyName = "groupName",
    SegmentName = "groups",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
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
interface InferenceGroups {
  /**
   * Get InferenceGroup.
   */
  get is ArmResourceRead<InferenceGroup>;

  /**
   * Create or update InferenceGroup (asynchronous).
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<InferenceGroup>;

  /**
   * Update InferenceGroup (asynchronous).
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    InferenceGroup,
    PatchModel = PartialMinimalTrackedResourceWithSku
  >;

  /**
   * Delete InferenceGroup (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    InferenceGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List Inference Groups.
   */
  list is ArmResourceListByParent<
    InferenceGroup,
    Parameters = {
      /**
       * Number of InferenceGroup to be retrieved in a page of results.
       */
      @query("count")
      count?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * A set of tags with which to filter the returned models. It is a comma separated string of tags key or tags key=value. Example: tagKey1,tagKey2,tagKey3=value3 .
       */
      @query("tags")
      tags?: string;

      /**
       * A set of properties with which to filter the returned models. It is a comma separated string of properties key and/or properties key=value Example: propKey1,propKey2,propKey3=value3 .
       */
      @query("properties")
      properties?: string;

      /**
       * The option to order the response.
       */
      @query("orderBy")
      orderBy?: OrderString;
    },
    Response = ArmResponse<InferenceGroupTrackedResourceArmPaginatedResult>
  >;

  /**
   * Retrieve status of delta models associated with the InferenceGroup and the target base model.
   */
  @action("getStatus")
  getDeltaModelsStatusAsync is ArmResourceActionSync<
    InferenceGroup,
    DeltaModelStatusRequest,
    ArmResponse<DeltaModelStatusResponse>
  >;

  /**
   * List delta models associated with the InferenceGroup and the target base model.
   */
  @list
  @action("list")
  listDeltaModelsAsync is ArmResourceActionSync<
    InferenceGroup,
    DeltaModelListRequest,
    ArmResponse<StringArmPaginatedResult>
  >;

  /**
   * Modify delta models associated with the InferenceGroup and the target base model.
   */
  @action("modify")
  modifyDeltaModelsAsync is ArmResourceActionAsyncBase<
    InferenceGroup,
    DeltaModelModifyRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<InferenceGroup>
  >;

  /**
   * Retrieve inference group status.
   */
  getStatus is ArmResourceActionSync<
    InferenceGroup,
    void,
    ArmResponse<GroupStatus>
  >;

  /**
   * List Inference Group Skus.
   */
  @list
  @get
  @action("skus")
  listSkus is ArmResourceActionSync<
    InferenceGroup,
    void,
    ArmResponse<SkuResourceArmPaginatedResult>,
    Parameters = {
      /**
       * Number of Skus to be retrieved in a page of results.
       */
      @query("count")
      count?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    }
  >;
}

@@doc(InferenceGroup.name, "InferenceGroup name.");
@@doc(InferenceGroup.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(InferenceGroups.createOrUpdate::parameters.resource,
  "InferenceGroup entity to apply during operation."
);
@@doc(InferenceGroups.update::parameters.properties,
  "Online Endpoint entity to apply during operation."
);
@@doc(InferenceGroups.getDeltaModelsStatusAsync::parameters.body,
  "DeltaModelBaseRequest."
);
@@doc(InferenceGroups.listDeltaModelsAsync::parameters.body,
  "DeltaModelBaseRequest."
);
@@doc(InferenceGroups.modifyDeltaModelsAsync::parameters.body,
  "DeltaModelModifyRequest."
);
