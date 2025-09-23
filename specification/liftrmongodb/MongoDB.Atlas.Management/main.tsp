import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-liftr-base";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using LiftrBase;

/* MongoDB.Atlas Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "MongoDB.Atlas" })
@versioned(MongoDB.Atlas.Versions)
namespace MongoDB.Atlas;

/** The available API versions. */
@doc("Supported versions for the MongoDB.Atlas resource model")
enum Versions {
  /** 2024-11-18 preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2024_11_18_preview: "2024-11-18-preview",

  /** 2025-06-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2025_06_01: "2025-06-01",
}

@doc("User details for an organization")
model UserDetails {
  @doc("First name of the user")
  firstName: string;

  @doc("Last name of the user")
  lastName: string;

  @doc("Email address of the user")
  emailAddress: email;

  @doc("User's principal name")
  upn?: string;

  @doc("User's phone number")
  phoneNumber?: string;

  @doc("Company Name")
  companyName?: string;
}

@doc("Base resource properties that can be extended for arm resources.")
model BaseResourceProperties {
  @doc("Marketplace details of the resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  marketplace: MarketplaceDetails;

  @doc("Details of the user.")
  user: UserDetails;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("MongoDB specific Properties")
model PartnerProperties {
  @doc("Organization Id in MongoDB system")
  organizationId?: string;

  @doc("Redirect URL for the MongoDB")
  redirectUrl?: string;

  @doc("Organization name in MongoDB system")
  @pattern("^[a-zA-Z0-9 _\\-().,:@+&',]{1,64}$")
  @minLength(1) // Minimum length constraint
  @maxLength(64) // Maximum length constraint
  organizationName: string;
}

/** These properties will be sent to your endpoints registered with Liftr during CRUD on resource.
 * BaseResourceProperties contains Marketplace, useDetail related properties*/
@doc("Properties specific to Organization")
model OrganizationProperties is BaseResourceProperties {
  @doc("MongoDB properties")
  partnerProperties?: PartnerProperties;
}

@doc("The resource model definition for an Azure Organization")
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

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Organizations {
  get is ArmResourceRead<OrganizationResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<OrganizationResource>;
  update is ArmCustomPatchAsync<
    OrganizationResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      OrganizationResource,
      OrganizationProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<OrganizationResource>;
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;
  listBySubscription is ArmListBySubscription<OrganizationResource>;
}
