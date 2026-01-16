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
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

/**
 * InferencePool is a preview-only resource.
 */
@removed(Versions.v2025_12_01)
@parentResource(Workspace)
model InferencePool
  is Azure.ResourceManager.TrackedResource<InferencePoolProperties, false> {
  ...ResourceNameParameter<
    Resource = InferencePool,
    KeyName = "inferencePoolName",
    SegmentName = "inferencePools",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  ...Azure.ResourceManager.ResourceSkuProperty;
}

/**
 * InferencePools interface is preview-only.
 */
@removed(Versions.v2025_12_01)
@armResourceOperations
interface InferencePools {
  /**
   * Get InferencePool.
   */
  @summary("Get InferencePool.")
  get is ArmResourceRead<InferencePool>;

  /**
   * Create or update InferencePool (asynchronous).
   */
  @summary("Create or update InferencePool (asynchronous).")
  @useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InferencePool,
    Response = ArmResourceUpdatedResponse<InferencePool> | (ArmResourceCreatedResponse<
      InferencePool,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = InferencePool>
    > & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    })
  >;

  /**
   * Update InferencePool (asynchronous).
   */
  @summary("Update InferencePool (asynchronous).")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    InferencePool,
    PatchModel = PartialMinimalTrackedResourceWithSkuAndIdentity,
    Response = InferencePool | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = InferencePool>> &
      Azure.Core.Foundations.RetryAfterHeader & {
        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        @header("x-ms-async-operation-timeout")
        timeout: duration;
      })
  >;

  /**
   * Delete InferencePool (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete InferencePool (asynchronous).")
  delete is ArmResourceDeleteWithoutOkAsync<
    InferencePool,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List InferencePools.
   */
  @summary("List InferencePools.")
  list is ArmResourceListByParent<
    InferencePool,
    Parameters = {
      /**
       * Number of inferencePools to be retrieved in a page of results.
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
    Response = ArmResponse<InferencePoolTrackedResourceArmPaginatedResult>
  >;
}

@@doc(InferencePool.name, "Name of InferencePool");
@@doc(InferencePool.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(InferencePools.createOrUpdate::parameters.resource,
  "InferencePool entity to apply during operation."
);
@@doc(InferencePools.update::parameters.properties,
  "Inference Pool entity to apply during operation."
);
@@doc(InferencePool.identity,
  "Managed service identity (system assigned and/or user assigned identities)"
);
@@doc(InferencePool.sku,
  "Sku details required for ARM contract for Autoscaling."
);
