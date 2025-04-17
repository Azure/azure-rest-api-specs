import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace GitHub.Network;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the managed application.")
union ProvisioningState {
  @doc("The provisioning of the resource failed.")
  Failed: "Failed",

  @doc("The resource was provisioned successfully.")
  Succeeded: "Succeeded",

  @doc("The provisioning of the resource was cancelled.")
  Canceled: "Canceled",

  @doc("The resource provisioning is in progress.")
  Accepted: "Accepted",

  string,
}

@doc("NetworkSettings resource-specific properties.")
model NetworkSettingsResourceProperties {
  @doc("Specifies a subnet ID for vnet-injection.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId?: string;

  @doc("Specifies the GitHub business (enterprise/organization) ID associated to the Azure subscription.")
  @added(Versions.`2024-04-01-preview`)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  businessId?: string;

  @doc("The managed application provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
