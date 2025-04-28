import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@doc("Properties of network")
model SubnetProperties {
  @doc("Vnet resource id")
  subnetResourceId: string;
}
