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

/* LambdaTest.HyperExecute Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "LambdaTest.HyperExecute management service" })
@versioned(LambdaTest.HyperExecute.Versions)
namespace LambdaTest.HyperExecute;

/** The available API versions. */
enum Versions {
  /** 2024-02-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v2_preview)
  v2024_02_01_preview: "2024-02-01-preview",
}

@doc("Partner's specific Properties")
model PartnerProperties {
  @minValue(1)
  @maxValue(1000)
  @doc("The number of licenses subscribed")
  licensesSubscribed: int32;
}

/** These properties will be sent to your endpoints registered with Liftr during CRUD on resource.
 * BaseResourceProperties contains Marketplace, useDetail related properties*/
@doc("Properties specific to Organization")
model OrganizationProperties is BaseResourceProperties {
  @doc("partner properties")
  partnerProperties: PartnerProperties;

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
  update is ArmCustomPatchSync<
    OrganizationResource,
    OrganizationResourceUpdate
  >;
  delete is ArmResourceDeleteWithoutOkAsync<OrganizationResource>;
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;
  listBySubscription is ArmListBySubscription<OrganizationResource>;
}
