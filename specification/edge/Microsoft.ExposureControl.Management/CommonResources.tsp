import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Exposure Control Resource Provider Service API.")
namespace Microsoft.Edge;

@doc("The provisioning state of a resource.")
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning,

  @doc("The resource is updating")
  Updating,

  @doc("The resource is being deleted")
  Deleting,

  @doc("The resource create request has been accepted")
  Accepted,
}

@doc("Ring status enum.")
enum RingStatus {
  @doc("Ring waiting.")
  Waiting,

  @doc("Ring active.")
  Active,

  @doc("Ring completed.")
  Completed,

  @doc("Ring cancelled.")
  Cancelled,

  @doc("Ring failed.")
  Failed,

  @doc("Ring bypassed.")
  AutoPassed,

  @doc("Omitted.")
  Omitted
}