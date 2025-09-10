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

/* Liftrbasic.Samplerp Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Liftrbasic.Samplerp management service" })
@versioned(Liftrbasic.Samplerp.Versions)
namespace Liftrbasic.Samplerp;

/** The available API versions. */
enum Versions {
  /** 2023-12-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2023_12_01_preview: "2023-12-01-preview",
}

@doc("Partner's specific Properties")
model PartnerProperties {
  @doc("workspace name")
  workspace: string;
}

/** These properties will be sent to your endpoints registered with Liftr during CRUD on resource.
 * BaseResourceProperties contains Marketplace, useDetail related properties*/
@doc("Properties specific to Organization")
model OrganizationProperties is BaseResourceProperties {
  @doc("partner properties")
  partnerProperties?: PartnerProperties;

  @doc("Single sign-on properties")
  singleSignOnProperties?: SingleSignOnPropertiesV2;
}

model OrganizationResource
  is Azure.ResourceManager.TrackedResource<OrganizationProperties> {
  @key("organizationname")
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

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Organizations {
  get is ArmResourceRead<OrganizationResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<OrganizationResource>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchSync<
    OrganizationResource,
    OrganizationResourceUpdate
  >;
  delete is ArmResourceDeleteWithoutOkAsync<OrganizationResource>;
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;
  listBySubscription is ArmListBySubscription<OrganizationResource>;
}
