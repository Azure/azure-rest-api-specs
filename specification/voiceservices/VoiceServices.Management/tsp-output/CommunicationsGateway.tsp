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
model CommunicationsGateway
  is TrackedResource<CommunicationsGatewayProperties> {
  @doc("Unique identifier for this deployment")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  @key("communicationsGatewayName")
  @segment("communicationsGateways")
  name: string;
}

@armResourceOperations
interface CommunicationsGateways {
  @doc("Get a CommunicationsGateway")
  get is ArmResourceRead<CommunicationsGateway>;
  @doc("Create a CommunicationsGateway")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CommunicationsGateway>;
  @doc("Update a CommunicationsGateway")
  update is ArmTagsPatchSync<CommunicationsGateway>;
  @doc("Delete a CommunicationsGateway")
  delete is ArmResourceDeleteAsync<CommunicationsGateway>;
  @doc("List CommunicationsGateway resources by resource group")
  listByResourceGroup is ArmResourceListByParent<CommunicationsGateway>;
  @doc("List CommunicationsGateway resources by subscription ID")
  listBySubscription is ArmListBySubscription<CommunicationsGateway>;
}
