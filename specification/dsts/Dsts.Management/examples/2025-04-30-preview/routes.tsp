import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Dsts;

@armResourceOperations(ServiceAccount)
interface ServiceAccounts {
  get is ArmResourceRead<ServiceAccount>;
  listByResourceGroup is ArmResourceListByParent<ServiceAccount>;
  listBySubscription is ArmListBySubscription<ServiceAccount>;
  delete is ArmResourceDeleteSync<ServiceAccount>;
}
