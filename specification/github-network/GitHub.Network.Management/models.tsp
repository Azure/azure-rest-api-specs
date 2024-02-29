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
enum ProvisioningState {
  @doc("The provisioning of the resource failed.")
  Failed,

  @doc("The resource was provisioned successfully.")
  Succeeded,

  @doc("The provisioning of the resource was cancelled.")
  Canceled,

  @doc("The resource provisioning is in progress.")
  Accepted,
}

@doc("NetworkSettings resource-specific properties.")
model NetworkSettingsResourceProperties {
  @doc("Specifies a subnet ID for vnet-injection.")
  subnetId?: string;

  @doc("Specifies the GitHub business (enterprise/organization) ID associated to the Azure subscription.")
  @added(Versions.`2024-04-01-preview`)
  businessId?: string;

  @doc("Specifies the GitHub organization (enterprise) ID associated to the Azure subscription.")
  @removed(Versions.`2024-04-01-preview`)
  organizationId?: string;

  @doc("Specifies a comma-separated list of service names the resource is associated with.")
  @removed(Versions.`2024-04-01-preview`)
  targetServices?: [];

  @doc("The managed application provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
