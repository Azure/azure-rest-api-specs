import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Network function resource response.
 */
model NetworkFunction
  is Azure.ResourceManager.TrackedResource<NetworkFunctionPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkFunction,
    KeyName = "networkFunctionName",
    SegmentName = "networkFunctions",
    NamePattern = ""
  >;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface NetworkFunctions {
  /**
   * Gets information about the specified network function resource.
   */
  get is ArmResourceRead<NetworkFunction>;

  /**
   * Creates or updates a network function resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  #suppress "@azure-tools/typespec-azure-resource-manager/retry-after"
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @extension("x-ms-long-running-operation", true)
  createOrUpdate is ArmResourceCreateOrReplaceSync<NetworkFunction>;

  /**
   * Updates the tags for the network function resource.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<NetworkFunction, PatchModel = TagsObject>;

  /**
   * Deletes the specified network function resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkFunction,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the network function resources in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<NetworkFunction>;

  /**
   * Lists all the network functions in a subscription.
   */
  listBySubscription is ArmListBySubscription<NetworkFunction>;

  /**
   * Execute a request to services on a containerized network function.
   */
  executeRequest is ArmResourceActionAsync<
    NetworkFunction,
    ExecuteRequestParameters,
    OkResponse,
    LroHeaders = ArmLroLocationHeader
  >;
}

@@doc(NetworkFunction.name, "The name of the network function resource.");
@@doc(NetworkFunction.properties, "Network function properties.");
@@doc(NetworkFunctions.createOrUpdate::parameters.resource,
  "Parameters supplied in the body to the create or update network function operation."
);
@@doc(NetworkFunctions.updateTags::parameters.properties,
  "Parameters supplied to the update network function tags operation."
);
@@doc(NetworkFunctions.executeRequest::parameters.body,
  "Payload for execute request post call."
);
