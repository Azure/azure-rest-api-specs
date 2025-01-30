import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./landingZoneAccountResourceProperties.tsp";
import "./landingZoneConfigurationResourceProperties.tsp";
import "./landingZoneRegistrationResourceProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using OpenAPI;

@service({
  title: "Cloud for Sovereignty Resource Provider.",
})
@versioned(Versions)
@armProviderNamespace
@armCommonTypesVersion("v5")
namespace Microsoft.Sovereign;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The Landing zone account parent resource type.")
@added(Versions.Preview20250227)
@resource("landingZoneAccounts")
model LandingZoneAccountResource
  is TrackedResource<LandingZoneAccountResourceProperties> {
  @doc("The parent landing zone account")
  @segment("landingZoneAccounts")
  @key("landingZoneAccountName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @visibility("read")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@armResourceOperations(LandingZoneAccountResource)
@added(Versions.Preview20250227)
interface LandingZoneAccountOperations {
  @doc("Gets the landing zone account.")
  get is ArmResourceRead<LandingZoneAccountResource>;
  @doc("Creates the landing zone account.")
  create is ArmResourceCreateOrReplaceAsync<LandingZoneAccountResource>;
  @doc("Updates the landing zone account.")
  update is ArmResourcePatchAsync<
    LandingZoneAccountResource,
    LandingZoneAccountResourceProperties
  >;
  @doc("Deletes the landing zone account.")
  delete is ArmResourceDeleteWithoutOkAsync<LandingZoneAccountResource>;
  @doc("Lists the landing zone accounts within a resource group.")
  listByResourceGroup is ArmResourceListByParent<LandingZoneAccountResource>;
  @doc("Lists the landing zone accounts within a subscription.")
  listBySubscription is ArmListBySubscription<LandingZoneAccountResource>;
}

@parentResource(LandingZoneAccountResource)
@added(Versions.Preview20250227)
@resource("landingZoneConfigurations")
model LandingZoneConfigurationResource
  is ProxyResource<LandingZoneConfigurationResourceProperties> {
  @doc("The landing zone configuration name")
  @segment("landingZoneConfigurations")
  @key("landingZoneConfigurationName")
  @visibility("read")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @path
  name: string;
}

@added(Versions.Preview20250227)
@armResourceOperations(LandingZoneConfigurationResource)
interface LandingZoneConfigurationOperations {
  @doc("Gets the landing zone configuration.")
  get is ArmResourceRead<LandingZoneConfigurationResource>;
  @doc("Creates the landing zone configuration.")
  create is ArmResourceCreateOrReplaceAsync<LandingZoneConfigurationResource>;
  @doc("Updates the landing zone configuration.")
  update is ArmResourcePatchAsync<
    LandingZoneConfigurationResource,
    LandingZoneConfigurationResourceProperties
  >;
  @doc("Deletes the landing zone configuration.")
  delete is ArmResourceDeleteWithoutOkAsync<LandingZoneConfigurationResource>;
  @doc("Lists the landing zone configurations within a resource group.")
  listByResourceGroup is ArmResourceListByParent<LandingZoneConfigurationResource>;
  @doc("Lists the landing zone configurations within a subscription.")
  listBySubscription is ArmListBySubscription<LandingZoneConfigurationResource>;

  @action("generateLandingZone")
  @doc("Generate the landing zone.")
  @added(Versions.Preview20250227)
  @armResourceAction(LandingZoneConfigurationResource)
  generateLandingZone is ArmResourceActionAsync<
    LandingZoneConfigurationResource,
    GenerateLandingZoneRequest,
    GenerateLandingZoneResponse
  >;

  @action("updateAuthoringStatus")
  @doc("Provides a mechanism to update the authoring status.")
  @added(Versions.Preview20250227)
  @armResourceAction(LandingZoneConfigurationResource)
  updateAuthoringStatus is ArmResourceActionAsync<
    LandingZoneConfigurationResource,
    UpdateAuthoringStatusRequest,
    UpdateAuthoringStatusResponse
  >;

  @action("createCopy")
  @doc("Provides a mechanism to create a copy of the landing zone configuration.")
  @added(Versions.Preview20250227)
  @armResourceAction(LandingZoneConfigurationResource)
  createCopy is ArmResourceActionAsync<
    LandingZoneConfigurationResource,
    CreateLandingZoneConfigurationCopyRequest,
    CreateLandingZoneConfigurationCopyResponse
  >;
}

// Landing zone registration resource type
@parentResource(LandingZoneAccountResource)
@added(Versions.Preview20250227)
@resource("landingZoneRegistrations")
@doc("The Landing Zone registration resource type")
model LandingZoneRegistrationResource
  is ProxyResource<LandingZoneRegistrationResourceProperties> {
  @doc("The name of the Landing Zone Registration resource.")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @key("landingZoneRegistrationName")
  @segment("landingZoneRegistrations")
  @path
  name: string;
}

@added(Versions.Preview20250227)
@armResourceOperations(LandingZoneRegistrationResource)
interface LandingZoneRegistrationOperations {
  @doc("Gets the landing zone registration.")
  get is ArmResourceRead<LandingZoneRegistrationResource>;
  @doc("Creates the landing zone registration.")
  create is ArmResourceCreateOrReplaceAsync<LandingZoneRegistrationResource>;
  @doc("Updates the landing zone registration.")
  update is ArmResourcePatchAsync<
    LandingZoneRegistrationResource,
    LandingZoneRegistrationResourceProperties
  >;
  @doc("Deletes the landing zone registration.")
  delete is ArmResourceDeleteSync<LandingZoneRegistrationResource>;
  @doc("Lists the landing zone registrations within a resource group.")
  listByResourceGroup is ArmResourceListByParent<LandingZoneRegistrationResource>;
  @doc("Lists the landing zone registrations within a subscription.")
  listBySubscription is ArmListBySubscription<LandingZoneRegistrationResource>;
}
