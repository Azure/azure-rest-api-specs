import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Service.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ApiCenter;

@added(Versions.v2024_03_15_preview)
@doc("Soft-deleted service entity.")
model DeletedService is ProxyResource<DeletedServiceProperties> {
  @doc("The name of the deleted service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("deletedServiceName")
  @segment("deletedServices")
  name: string;
}

@armResourceOperations
@added(Versions.v2024_03_15_preview)
interface DeletedServices {
  @doc("Returns details of the soft-deleted service.")
  get is ArmResourceRead<DeletedService>;
  @doc("Permanently deletes specified service.")
  delete is ArmResourceDeleteSync<DeletedService>;
  @doc("Lists soft-deleted services.")
  list is ArmResourceListByParent<DeletedService>;
  @doc("Lists services within an Azure subscription.")
  listBySubscription is ArmListBySubscription<DeletedService>;
}
