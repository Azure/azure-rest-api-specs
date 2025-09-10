import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.DeviceOnboarding;

// ------------------------------------------------------------------
// Section 1: Onboarding Service
// ------------------------------------------------------------------
// Root-level tracked resource: provisioning resource
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A provisioning resource.")
model OnboardingService
  is Azure.ResourceManager.TrackedResource<OnboardingServiceProperties> {
  @doc("The name of the Provisioning Resource.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9-]{3,63}[a-zA-Z0-9]$")
  @key("onboardingServiceName")
  @segment("onboardingServices")
  @path
  name: string;

  // TODO resource SKU @Jesus to define
}

@doc("Details of the EdgeProvisioning OnboardingService.")
model OnboardingServiceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The onboarding service device endpoints.")
  deviceEndpoints?: DeviceEndpoints;

  @doc("Selecting 'true' will enable a Microsoft managed PKI to issue certificates. Setting up of the CA and policies for certificate management will be while defining the onboarding policy.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  enableCertificateManagement: boolean;

  @doc("Allow public network access to private links.")
  @removed(Versions.v2025_05_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  publicNetworkAccess?: PublicNetworkAccessOptions;

  @doc("The private endpoint connections.")
  @removed(Versions.v2025_05_01_preview)
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: Array<PrivateEndpointConnection>;
}

@doc("Device endpoints.")
model DeviceEndpoints {
  @doc("The default endpoint.")
  @visibility(Lifecycle.Read)
  default?: DeviceEndpoint;
}

@doc("The device endpoint.")
model DeviceEndpoint {
  @doc("Hostname of the Endpoint.")
  @visibility(Lifecycle.Read)
  hostName?: string;
}

@doc("Options for public network access for private endpoints.")
@removed(Versions.v2025_05_01_preview)
union PublicNetworkAccessOptions {
  string,

  @doc("The value indicating the public network access is enabled.")
  Enabled: "Enabled",

  @doc("The value indicating the public network access is disabled.")
  Disabled: "Disabled",
}

@armResourceOperations
interface OnboardingServices {
  get is ArmResourceRead<OnboardingService>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OnboardingService>;
  delete is ArmResourceDeleteWithoutOkAsync<OnboardingService>;
  update is ArmResourcePatchAsync<
    OnboardingService,
    OnboardingServiceProperties
  >;
  listByResourceGroup is ArmResourceListByParent<OnboardingService>;
  listBySubscription is ArmListBySubscription<OnboardingService>;
}
