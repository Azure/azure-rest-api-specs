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
 * InferenceEndpoint is a preview-only resource.
 */
@removed(Versions.v2025_12_01)
@parentResource(Workspace)
model InferenceEndpoint
  is Azure.ResourceManager.TrackedResource<InferenceEndpointProperties, false> {
  ...ResourceNameParameter<
    Resource = InferenceEndpoint,
    KeyName = "endpointName",
    SegmentName = "endpoints",
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
 * InferenceEndpointOps is preview-only.
 */
@removed(Versions.v2025_12_01)
@armResourceOperations
interface InferenceEndpointOps
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
        /** Inference Endpoint name. */
        @path
        @segment("endpoints")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        endpointName: string,
      }
    > {}

/**
 * InferenceEndpoints is preview-only.
 */
@removed(Versions.v2025_12_01)
@armResourceOperations
interface InferenceEndpoints {
  /**
   * Get InferenceEndpoint.
   */
  @summary("Get InferenceEndpoint.")
  get is InferenceEndpointOps.Read<InferenceEndpoint>;

  /**
   * Create or update InferenceEndpoint (asynchronous).
   */
  @Azure.Core.useFinalStateVia("original-uri")
  @summary("Create or update InferenceEndpoint (asynchronous).")
  createOrUpdate is InferenceEndpointOps.CreateOrUpdateAsync<
    InferenceEndpoint,
    Response = ArmResourceUpdatedResponse<InferenceEndpoint> | (ArmResourceCreatedResponse<
      InferenceEndpoint,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = InferenceEndpoint>
    > & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    })
  >;

  /**
   * Update InferenceEndpoint (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @summary("Update InferenceEndpoint (asynchronous).")
  update is InferenceEndpointOps.CustomPatchAsync<
    InferenceEndpoint,
    PatchModel = void,
    Response = ArmResourceUpdatedResponse<InferenceEndpoint> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = InferenceEndpoint>> &
      Azure.Core.Foundations.RetryAfterHeader & {
        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        @header("x-ms-async-operation-timeout")
        timeout: duration;
      })
  >;

  /**
   * Delete InferenceEndpoint (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete InferenceEndpoint (asynchronous).")
  delete is InferenceEndpointOps.DeleteWithoutOkAsync<
    InferenceEndpoint,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List Inference Endpoints.
   */
  @summary("List Inference Endpoints.")
  list is InferenceEndpointOps.List<
    InferenceEndpoint,
    Parameters = {
      /**
       * Number of InferenceEndpoint to be retrieved in a page of results.
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
    Response = ArmResponse<InferenceEndpointTrackedResourceArmPaginatedResult>
  >;
}

@@doc(InferenceEndpoint.name, "InferenceEndpoint name.");
@@doc(InferenceEndpoint.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(InferenceEndpoints.createOrUpdate::parameters.resource,
  "InferenceEndpoint entity to apply during operation."
);
@@doc(InferenceEndpoints.update::parameters.properties,
  "Online Endpoint entity to apply during operation."
);
@@doc(InferenceEndpoint.identity,
  "Managed service identity (system assigned and/or user assigned identities)"
);
@@doc(InferenceEndpoint.sku,
  "Sku details required for ARM contract for Autoscaling."
);
