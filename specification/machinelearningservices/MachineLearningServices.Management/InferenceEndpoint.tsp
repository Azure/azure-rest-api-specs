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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  ...Azure.ResourceManager.ResourceSkuProperty;
}

@armResourceOperations
interface InferenceEndpoints {
  /**
   * Get InferenceEndpoint.
   */
  get is ArmResourceRead<InferenceEndpoint>;

  /**
   * Create or update InferenceEndpoint (asynchronous).
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<InferenceEndpoint>;

  /**
   * Update InferenceEndpoint (asynchronous).
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<InferenceEndpoint, PatchModel = any>;

  /**
   * Delete InferenceEndpoint (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    InferenceEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List Inference Endpoints.
   */
  list is ArmResourceListByParent<
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
