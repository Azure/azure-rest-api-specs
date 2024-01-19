import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
@doc("The IP Prefix resource definition.")
model IpPrefix is TrackedResource<IpPrefixProperties> {
  @doc("Name of the IP Prefix.")
  @path
  @key("ipPrefixName")
  @segment("ipPrefixes")
  name: string;
}

@armResourceOperations
interface IpPrefixes {
  @doc("Implements IP Prefix GET method.")
  get is ArmResourceRead<IpPrefix>;

  @doc("Implements IP Prefix PUT method.")
  create is ArmResourceCreateOrUpdateAsync<
    IpPrefix,
    BaseParameters<IpPrefix>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the IP Prefix resource.")
  update is ArmCustomPatchAsync<
    IpPrefix,
    IpPrefixPatch,
    BaseParameters<IpPrefix>,
    ArmLroLocationHeader
  >;

  @doc("Implements IP Prefix DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<
    IpPrefix,
    BaseParameters<IpPrefix>,
    ArmLroLocationHeader
  >;

  @doc("Implements IpPrefixes list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<IpPrefix>;

  @doc("Implements IpPrefixes list by subscription GET method.")
  listBySubscription is ArmListBySubscription<IpPrefix>;
}

@@projectedName(IpPrefixes.create::parameters.resource, "json", "body");
@@extension(IpPrefixes.create::parameters.resource, "x-ms-client-name", "body");
@@doc(IpPrefixes.create::parameters.resource, "Request payload.");
@@projectedName(IpPrefixes.update::parameters.properties, "json", "body");
@@extension(IpPrefixes.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(IpPrefixes.update::parameters.properties,
  "IP Prefix properties to update."
);
