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
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;

  @visibility("read")
  @doc("The onboarding service device endpoints.")
  deviceEndpoints?: DeviceEndpoints;

  @doc("Selecting 'true' will enable a Microsoft managed PKI to issue certificates. Setting up of the CA and policies for certificate management will be while defining the onboarding policy.")
  @visibility("read", "create")
  enableCertificateManagement: boolean;

  @doc("Allow public network access to private links.")
  @visibility("read", "create", "update")
  publicNetworkAccess?: PublicNetworkAccessOptions;

  @doc("The private endpoint connections.")
  @visibility("read")
  privateEndpointConnections?: Array<PrivateEndpointConnection>;
}

@doc("Device endpoints.")
model DeviceEndpoints {
  @doc("The default endpoint.")
  @visibility("read")
  default?: DeviceEndpoint;
}

@doc("The device endpoint.")
model DeviceEndpoint {
  @doc("Hostname of the Endpoint.")
  @visibility("read")
  hostName?: string;
}

@doc("Options for public network access for private endpoints.")
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
