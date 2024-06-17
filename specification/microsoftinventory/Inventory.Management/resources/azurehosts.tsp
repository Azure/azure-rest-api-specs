import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/azureHost.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service({
  title: "Microsoft Inventory",
})
@versioned(Microsoft.Inventory.Versions)
namespace Microsoft.Inventory;

@tenantResource
model AzureHostResource is ProxyResource<AzureHostProperties> {
  @pattern("[a-zA-Z0-9]+[-]*")
  @key("azureHostName")
  @segment("physicalAzureHosts")
  @doc("Azure Host")
  @path
  name: string;
}

@armResourceOperations
interface AzureHosts {
  getAzureHost is ArmLocResourceRead<
    AzureHostResource,
    BaseParameters<AzureHostResource> & LocationParameter
  >;
  list is ArmLocResourceListByParent<
    AzureHostResource,
    LocationCollectionParameters<AzureHostResource>
  >;
}
