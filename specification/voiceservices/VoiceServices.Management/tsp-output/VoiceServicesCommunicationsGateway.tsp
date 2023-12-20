import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.VoiceServices;
@doc("A CommunicationsGateway resource")
model VoiceServicesCommunicationsGateway
  is TrackedResource<CommunicationsGatewayProperties> {
  @doc("Unique identifier for this deployment")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  @key("communicationsGatewayName")
  @segment("communicationsGateways")
  name: string;
}

@armResourceOperations
interface VoiceServicesCommunicationsGateways {
  @doc("Get a CommunicationsGateway")
  get is ArmResourceRead<VoiceServicesCommunicationsGateway>;
  @doc("Create a CommunicationsGateway")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VoiceServicesCommunicationsGateway>;
  @doc("Update a CommunicationsGateway")
  update is ArmTagsPatchSync<VoiceServicesCommunicationsGateway>;
  @doc("Delete a CommunicationsGateway")
  delete is ArmResourceDeleteAsync<VoiceServicesCommunicationsGateway>;
  @doc("List CommunicationsGateway resources by resource group")
  listByResourceGroup is ArmResourceListByParent<VoiceServicesCommunicationsGateway>;
  @doc("List CommunicationsGateway resources by subscription ID")
  listBySubscription is ArmListBySubscription<VoiceServicesCommunicationsGateway>;
}
