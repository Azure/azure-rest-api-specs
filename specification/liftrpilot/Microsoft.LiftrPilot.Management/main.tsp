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
@service({
  title: "Microsoft.LiftrPilot management service",
})
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
