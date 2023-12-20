import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ApiCenter;
@doc("The service entity.")
model ApiCenterService is TrackedResource<ServiceProperties> {
  @doc("Service name")
  @pattern("^[a-zA-Z0-9\\-]{1,64}$")
  @path
  @key("serviceName")
  @segment("services")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ApiCenterServices {
  @doc("Get service")
  get is ArmResourceRead<ApiCenterService>;
  @doc("Create or update service")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApiCenterService>;
  @doc("Update service")
  update is ArmResourcePatchSync<ApiCenterService, ServiceProperties>;
  @doc("Delete service")
  delete is ArmResourceDeleteSync<ApiCenterService>;
  @doc("Lists services within a resource group")
  listByResourceGroup is ArmResourceListByParent<ApiCenterService>;
  @doc("Lists services within an Azure subscription.")
  listBySubscription is ArmListBySubscription<ApiCenterService>;
}
