import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

/**
 * InferenceGroup is a preview-only resource.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API includes additional envelope properties"
  kind?: string;

  ...Azure.ResourceManager.ResourceSkuProperty;
}

/**
 * InferenceGroupOps is preview-only.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@armResourceOperations
interface InferenceGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of Azure Machine Learning workspace. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        workspaceName: string,

        /** Pool name. */
        @path
        @segment("inferencePools")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        poolName: string,
      },
      {
        /** Inference Group name. */
        @path
        @segment("groups")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        groupName: string,
      }
    > {}

/**
 * InferenceGroups is preview-only.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@armResourceOperations
interface InferenceGroups {
  /**
   * Get InferenceGroup.
   */
  @summary("Get InferenceGroup.")
  get is InferenceGroupOps.Read<InferenceGroup>;

  /**
   * Create or update InferenceGroup (asynchronous).
   */
  @Azure.Core.useFinalStateVia("original-uri")
  @summary("Create or update InferenceGroup (asynchronous).")
  createOrUpdate is InferenceGroupOps.CreateOrUpdateAsync<
    InferenceGroup,
    Response = ArmResourceUpdatedResponse<InferenceGroup> | (ArmResourceCreatedResponse<
      InferenceGroup,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = InferenceGroup>
    > & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    })
  >;

  /**
   * Update InferenceGroup (asynchronous).
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update InferenceGroup (asynchronous).")
  update is InferenceGroupOps.CustomPatchAsync<
    InferenceGroup,
    PatchModel = PartialMinimalTrackedResourceWithSku,
    Response = ArmResourceUpdatedResponse<InferenceGroup> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = InferenceGroup>> &
      Azure.Core.Foundations.RetryAfterHeader & {
        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        @header("x-ms-async-operation-timeout")
        timeout: duration;
      })
  >;

  /**
   * Delete InferenceGroup (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns additional response codes for LRO delete"
  @summary("Delete InferenceGroup (asynchronous).")
  delete is InferenceGroupOps.DeleteWithoutOkAsync<
    InferenceGroup,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List Inference Groups.
   */
  @summary("List Inference Groups.")
  list is InferenceGroupOps.List<
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
  @action("deltaModels/getStatus")
  @summary("Retrieve status of delta models associated with the InferenceGroup and the target base model.")
  getDeltaModelsStatusAsync is InferenceGroupOps.ActionSync<
    InferenceGroup,
    DeltaModelStatusRequest,
    ArmResponse<DeltaModelStatusResponse>
  >;

  /**
   * List delta models associated with the InferenceGroup and the target base model.
   */
  @list
  @action("deltaModels/list")
  @summary("List delta models associated with the InferenceGroup and the target base model.")
  listDeltaModelsAsync is InferenceGroupOps.ActionSync<
    InferenceGroup,
    DeltaModelListRequest,
    ArmResponse<StringArmPaginatedResult>
  >;

  /**
   * Modify delta models associated with the InferenceGroup and the target base model.
   */
  @action("deltaModels/modify")
  @summary("Modify delta models associated with the InferenceGroup and the target base model.")
  modifyDeltaModelsAsync is InferenceGroupOps.ActionSync<
    InferenceGroup,
    DeltaModelModifyRequest,
    ArmAcceptedLroResponse
  >;

  /**
   * Retrieve inference group status.
   */
  @summary("Retrieve inference group status.")
  getStatus is InferenceGroupOps.ActionSync<
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
  @summary("List Inference Group Skus.")
  listSkus is InferenceGroupOps.ActionSync<
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
@@doc(InferenceGroup.identity,
  "Managed service identity (system assigned and/or user assigned identities)"
);
@@doc(InferenceGroup.sku,
  "Sku details required for ARM contract for Autoscaling."
);
