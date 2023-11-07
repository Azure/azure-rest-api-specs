import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Scom;
@doc("A gateway resource.")
@parentResource(ManagedInstance)
model ManagedGateway is ProxyResource<ManagedGatewayProperties> {
  @doc("The gateway resource name.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
  @path
  @key("managedGatewayName")
  @segment("managedGateways")
  name: string;
}

@armResourceOperations
interface ManagedGateways {
  @doc("Retrieve the details of the gateway resource.")
  get is ArmResourceRead<ManagedGateway>;
  @doc("Create or update a gateway resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedGateway>;
  @doc("Remove a gateway resource.")
  delete is ArmResourceDeleteSync<ManagedGateway>;
  @doc("A comprehensive list of all gateway resources within a SCOM managed instance.")
  listByManagedInstance is ArmResourceListByParent<ManagedGateway>;
}
