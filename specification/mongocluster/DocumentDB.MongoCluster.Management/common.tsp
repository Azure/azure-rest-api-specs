import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DocumentDB;

interface Operations extends Azure.ResourceManager.Operations {}

@lroStatus
@doc("The provisioning state of the last accepted operation.")
union ProvisioningState {
  string,

  ResourceProvisioningState,

  @doc("An operation is in-progress on the resource.")
  "InProgress",

  @doc("An update operation is in-progress on the resource.")
  "Updating",

  @doc("A drop operation is in-progress on the resource.")
  "Dropping",
}
