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

@service(#{ title: "Cloud for Sovereignty Resource Provider." })
@versioned(Versions)
@armProviderNamespace
@armCommonTypesVersion("v5")
namespace Microsoft.Sovereign;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The Landing zone account resource type. A Landing zone account is the container for configuring, deploying and managing multiple landing zones.")
@added(Versions.Preview20250227)
@resource("landingZoneAccounts")
model LandingZoneAccountResource
  is TrackedResource<LandingZoneAccountResourceProperties> {
  @doc("The landing zone account.")
  @segment("landingZoneAccounts")
  @key("landingZoneAccountName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @visibility(Lifecycle.Read)
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@armResourceOperations(LandingZoneAccountResource)
@added(Versions.Preview20250227)
interface LandingZoneAccountOperations {
  @doc("Get a landing zone account.")
  get is ArmResourceRead<LandingZoneAccountResource>;
  @doc("Create a landing zone account.")
  create is ArmResourceCreateOrReplaceAsync<LandingZoneAccountResource>;
  @doc("Update a landing zone account.")
  update is ArmResourcePatchAsync<
    LandingZoneAccountResource,
    LandingZoneAccountResourceProperties
  >;
  @doc("Deletes a landing zone account.")
  delete is ArmResourceDeleteWithoutOkAsync<LandingZoneAccountResource>;
  @doc("List the landing zone accounts within a resource group.")
  listByResourceGroup is ArmResourceListByParent<LandingZoneAccountResource>;
  @doc("List the landing zone accounts within a subscription.")
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
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @path
  name: string;
}

@added(Versions.Preview20250227)
@armResourceOperations(LandingZoneConfigurationResource)
interface LandingZoneConfigurationOperations {
  @doc("Get a landing zone configuration.")
  get is ArmResourceRead<LandingZoneConfigurationResource>;
  @doc("Create a landing zone configuration.")
  create is ArmResourceCreateOrReplaceAsync<LandingZoneConfigurationResource>;
  @doc("Update a landing zone configuration.")
  update is ArmResourcePatchAsync<
    LandingZoneConfigurationResource,
    LandingZoneConfigurationResourceProperties
  >;
  @doc("Delete a landing zone configuration.")
  delete is ArmResourceDeleteWithoutOkAsync<LandingZoneConfigurationResource>;
  @doc("List the landing zone configurations within a landing zone account.")
  list is ArmResourceListByParent<LandingZoneConfigurationResource>;

  @action("generateLandingZone")
  @doc("Generate infrastructure as code (IaC) for a landing zone deployment.")
  @added(Versions.Preview20250227)
  @armResourceAction(LandingZoneConfigurationResource)
  generateLandingZone is ArmResourceActionAsync<
    LandingZoneConfigurationResource,
    GenerateLandingZoneRequest,
    GenerateLandingZoneResponse
  >;

  @action("updateAuthoringStatus")
  @doc("Update the authoring status on a landing zone configuration.")
  @added(Versions.Preview20250227)
  @armResourceAction(LandingZoneConfigurationResource)
  updateAuthoringStatus is ArmResourceActionAsync<
    LandingZoneConfigurationResource,
    UpdateAuthoringStatusRequest,
    UpdateAuthoringStatusResponse
  >;

  @action("createCopy")
  @doc("Create a duplicate of the landing zone configuration.")
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
@doc("The Landing zone registration resource type.")
model LandingZoneRegistrationResource
  is ProxyResource<LandingZoneRegistrationResourceProperties> {
  @doc("The name of the landing zone registration resource.")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @key("landingZoneRegistrationName")
  @segment("landingZoneRegistrations")
  @path
  name: string;
}

@added(Versions.Preview20250227)
@armResourceOperations(LandingZoneRegistrationResource)
interface LandingZoneRegistrationOperations {
  @doc("Get a landing zone registration.")
  get is ArmResourceRead<LandingZoneRegistrationResource>;
  @doc("Create a landing zone registration.")
  create is ArmResourceCreateOrReplaceAsync<LandingZoneRegistrationResource>;
  @doc("Update a landing zone registration.")
  update is ArmResourcePatchAsync<
    LandingZoneRegistrationResource,
    LandingZoneRegistrationResourceProperties
  >;
  @doc("Delete a landing zone registration.")
  delete is ArmResourceDeleteSync<LandingZoneRegistrationResource>;
  @doc("List the landing zone registrations within a landing zone account.")
  list is ArmResourceListByParent<LandingZoneRegistrationResource>;
}
