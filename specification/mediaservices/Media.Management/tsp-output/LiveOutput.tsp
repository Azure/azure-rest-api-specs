import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LiveEvent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
@doc("The Live Output.")
@parentResource(LiveEvent)
model LiveOutput is ProxyResource<LiveOutputProperties> {
  @doc("The name of the live output.")
  @maxLength(256)
  @minLength(1)
  @pattern("^([a-zA-Z0-9])+(-*[a-zA-Z0-9])*$")
  @path
  @key("liveOutputName")
  @segment("liveOutputs")
  name: string;
}

@armResourceOperations
interface LiveOutputs {
  @doc("Gets a live output.")
  get is ArmResourceRead<LiveOutput>;

  @doc("Creates a new live output.")
  create is ArmResourceCreateOrUpdateAsync<LiveOutput>;

  @doc("Deletes a live output. Deleting a live output does not delete the asset the live output is writing to.")
  delete is ArmResourceDeleteAsync<LiveOutput>;

  @doc("Lists the live outputs of a live event.")
  list is ArmResourceListByParent<LiveOutput>;
}

@@projectedName(LiveOutputs.create::parameters.resource, "json", "parameters");
@@extension(LiveOutputs.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LiveOutputs.create::parameters.resource,
  "Live Output properties needed for creation."
);
