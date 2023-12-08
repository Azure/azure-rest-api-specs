import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MediaLiveEvent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Media;
@doc("The Live Output.")
@parentResource(MediaLiveEvent)
model MediaLiveOutput is ProxyResource<LiveOutputProperties> {
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
interface MediaLiveOutputs {
  @doc("Gets a live output.")
  get is ArmResourceRead<MediaLiveOutput>;
  @doc("Creates a new live output.")
  create is ArmResourceCreateOrUpdateAsync<MediaLiveOutput>;
  @doc("Deletes a live output. Deleting a live output does not delete the asset the live output is writing to.")
  delete is ArmResourceDeleteAsync<MediaLiveOutput>;
  @doc("Lists the live outputs of a live event.")
  list is ArmResourceListByParent<MediaLiveOutput>;
}
