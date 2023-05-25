import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Provisioning State Enum")
enum ProvisioningState {
  ...ResourceProvisioningState,
  Accepted,
  Created,
  Creating,
  Deleted,
  Deleting,
  NotSpecified,
  Ready,
  Running,
  Updating,
}