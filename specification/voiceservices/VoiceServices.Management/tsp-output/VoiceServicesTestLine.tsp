import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VoiceServicesCommunicationsGateway.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.VoiceServices;
@doc("A TestLine resource")
@parentResource(VoiceServicesCommunicationsGateway)
model VoiceServicesTestLine is TrackedResource<TestLineProperties> {
  @doc("Unique identifier for this test line")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  @key("testLineName")
  @segment("testLines")
  name: string;
}

@armResourceOperations
interface VoiceServicesTestLines {
  @doc("Get a TestLine")
  get is ArmResourceRead<VoiceServicesTestLine>;
  @doc("Create a TestLine")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VoiceServicesTestLine>;
  @doc("Update a TestLine")
  update is ArmTagsPatchSync<VoiceServicesTestLine>;
  @doc("Delete a TestLine")
  delete is ArmResourceDeleteAsync<VoiceServicesTestLine>;
  @doc("List TestLine resources by CommunicationsGateway")
  listByCommunicationsGateway is ArmResourceListByParent<VoiceServicesTestLine>;
}
