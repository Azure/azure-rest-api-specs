import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
@doc("Network function resource response.")
model NetworkFunction is TrackedResource<NetworkFunctionPropertiesFormat> {
  @doc("The name of the network function resource.")
  @path
  @key("networkFunctionName")
  @segment("networkFunctions")
  name: string;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface NetworkFunctions {
  @doc("Gets information about the specified network function resource.")
  get is ArmResourceRead<NetworkFunction>;

  @doc("Creates or updates a network function resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NetworkFunction,
    BaseParameters<NetworkFunction>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates the tags for the network function resource.")
  updateTags is ArmCustomPatchSync<NetworkFunction, TagsObject>;

  @doc("Deletes the specified network function resource.")
  delete is ArmResourceDeleteAsync<
    NetworkFunction,
    BaseParameters<NetworkFunction>,
    ArmLroLocationHeader
  >;

  @doc("Lists all the network function resources in a resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkFunction>;

  @doc("Lists all the network functions in a subscription.")
  listBySubscription is ArmListBySubscription<NetworkFunction>;

  @doc("Execute a request to services on a containerized network function.")
  executeRequest is ArmResourceActionAsync<
    NetworkFunction,
    ExecuteRequestParameters,
    void,
    BaseParameters<NetworkFunction>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkFunctions.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(NetworkFunctions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctions.createOrUpdate::parameters.resource,
  "Parameters supplied in the body to the create or update network function operation."
);
@@projectedName(NetworkFunctions.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(NetworkFunctions.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctions.updateTags::parameters.properties,
  "Parameters supplied to the update network function tags operation."
);
@@projectedName(NetworkFunctions.executeRequest::parameters.body,
  "json",
  "parameters"
);
@@extension(NetworkFunctions.executeRequest::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctions.executeRequest::parameters.body,
  "Payload for execute request post call."
);
