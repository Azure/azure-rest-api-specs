import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-liftr-base";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using LiftrBase;

/* Microsoft.LiftrPilot Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.LiftrPilot management service" })
@versioned(Microsoft.LiftrPilot.Versions)
namespace Microsoft.LiftrPilot;

interface Operations extends Azure.ResourceManager.Operations {}

/** The available API versions. */
enum Versions {
  /** 2024-10-03-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2024_10_03_preview: "2024-10-03-preview",

  /** 2025-04-03-preview version (new) */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2025_04_03_preview: "2025-04-03-preview",

  /** 2025-04-18-preview version (new) */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2025_04_18_preview: "2025-04-18-preview",
}

/** These properties will be sent to your endpoints registered with Liftr during CRUD on resource.
 * BaseResourceProperties contains Marketplace, useDetail related properties*/
@doc("Properties specific to Organization")
model OrganizationProperties is BaseResourceProperties;

model OrganizationResource
  is Azure.ResourceManager.TrackedResource<OrganizationProperties> {
  @key("organizationName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("organizations")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the Organization resource")
  @path
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * The type used for update operations of the Organization Resource.
 */
model OrganizationResourceUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Organizations {
  get is ArmResourceRead<OrganizationResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<OrganizationResource>;
  update is ArmCustomPatchSync<
    OrganizationResource,
    OrganizationResourceUpdate
  >;
  delete is ArmResourceDeleteWithoutOkAsync<OrganizationResource>;
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;
  listBySubscription is ArmListBySubscription<OrganizationResource>;
}

@added(Versions.v2025_04_03_preview)
@doc("Liftr-Pilot proxy resource")
@parentResource(OrganizationResource)
model PilotProxyResource is ProxyResource<PilotProxyResourceProperties> {
  @key("pilotProxyResourceName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("pilotProxyResources")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the PilotProxyResource")
  @path
  name: string;
}

@added(Versions.v2025_04_03_preview)
@doc("The properties of PilotProxyResource")
model PilotProxyResourceProperties {
  @doc("Description of the proxy resource")
  description: string;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2025_04_03_preview)
@armResourceOperations
interface PilotProxyResources {
  get is ArmResourceRead<PilotProxyResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PilotProxyResource>;
  delete is ArmResourceDeleteWithoutOkAsync<PilotProxyResource>;
  listByOrganization is ArmResourceListByParent<PilotProxyResource>;
}

@added(Versions.v2025_04_18_preview)
@doc("Liftr-Pilot pure proxy resource")
@parentResource(OrganizationResource)
model PilotPureProxyResource
  is ProxyResource<PilotPureProxyResourceProperties> {
  @key("pilotPureProxyResourceName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("pilotPureProxyResources")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the PilotPureProxyResource")
  @path
  name: string;
}

@added(Versions.v2025_04_18_preview)
@doc("The properties of PurePilotProxyResource")
model PilotPureProxyResourceProperties {
  @doc("Description of the pure proxy resource")
  description: string;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2025_04_18_preview)
@armResourceOperations
interface PilotPureProxyResources {
  get is ArmResourceRead<PilotPureProxyResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PilotPureProxyResource>;
  delete is ArmResourceDeleteWithoutOkAsync<PilotPureProxyResource>;
  listByOrganization is ArmResourceListByParent<PilotPureProxyResource>;
}
