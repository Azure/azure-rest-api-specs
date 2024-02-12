import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DocumentDB;

@lroStatus
@doc("The provisioning state of the last accepted operation.")
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("An operation is in-progress on the resource.")
  InProgress,

  @doc("An update operation is in-progress on the resource.")
  Updating,

  @doc("A drop operation is in-progress on the resource.")
  Dropping,
}
