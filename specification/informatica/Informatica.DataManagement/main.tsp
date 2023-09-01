import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-apiview";
import "@azure-tools/typespec-azure-resource-manager";

@armProviderNamespace
@service({
  title: "Informatica.DataManagement",
  version: "2023-08-20-preview",
  description: "Azure Native Services Informatica DataManagement",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@useDependency(Azure.Core.Versions.v1_0_Preview_1)
namespace Informatica.DataManagement;

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using OpenAPI;

@doc("Reusable representation of an email address.")
@pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
scalar email extends string;

@doc("An Organization Resource by Informatica.")
model InformaticaOrganizationResource
  is TrackedResource<OrganizationProperties> {
  @key("organizationName")
  @segment("organizations")
  @doc("Name of the Organizations resource")
  @path
  name: string;
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Single sign-on configurations for a Informatica resource.")
@parentResource(InformaticaOrganizationResource)
model SingleSignOn is ProxyResource<InformaticaSingleSignOnProperties> {
  @key("configurationName")
  @segment("singleSignOnConfigurations")
  @doc("Name of the SSO Configuration")
  @path
  name: string;
}

@armResourceOperations
interface SingleSignOnOperations
  extends ProxyResourceOperations<SingleSignOn> {}

@armResourceOperations
interface Organizations
  extends Azure.ResourceManager.TrackedResourceOperations<
      InformaticaOrganizationResource,
      OrganizationProperties
    > {
  get is ArmResourceRead<InformaticaOrganizationResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<InformaticaOrganizationResource>;
  delete is ArmResourceDeleteAsync<InformaticaOrganizationResource>;
  update is ArmCustomPatchSync<
    InformaticaOrganizationResource,
    OrganizationProperties
  >;
}

@doc("An Organization Resource by Informatica.")
@parentResource(InformaticaOrganizationResource)
model InformaticaServerlessRuntimeResource
  is TrackedResource<InformaticaServerlessRuntimeProperties> {
  @key("serverlessRuntimeName")
  @segment("serverlessRuntimes")
  @doc("Name of the Serverless Runtime resource")
  @path
  name: string;
}

@armResourceOperations
interface ServerlessRuntimes
  extends Azure.ResourceManager.TrackedResourceOperations<
      InformaticaServerlessRuntimeResource,
      InformaticaServerlessRuntimeProperties
    > {
  get is ArmResourceRead<InformaticaServerlessRuntimeResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<InformaticaServerlessRuntimeResource>;
  delete is ArmResourceDeleteAsync<InformaticaServerlessRuntimeResource>;
  update is ArmCustomPatchSync<
    InformaticaServerlessRuntimeResource,
    InformaticaServerlessRuntimeProperties
  >;
}

@doc("Properties specific to the Informatica DataManagement Organization resource.")
model OrganizationProperties {
  @visibility("read")
  @doc("Provisioning State of the resource.")
  provisioningState?: ProvisioningState;

  @doc("Informatica Organization properties.")
  informaticaProperties?: InformaticaProperties;

  @doc("Marketplace details.")
  marketplaceDetails?: MarketplaceDetails;

  @doc("User details")
  userDetails?: UserDetails;

  @doc("Company details.")
  companyDetails?: CompanyDetails;

  @doc("Link Organization")
  linkOrganization?: LinkOrganization;
}

@doc("Company Details.")
model CompanyDetails {
  @doc("company Name")
  companyName?: string;

  @doc("Office Address")
  officeAddress?: string;

  @doc("Country name")
  country?: string;

  @doc("Domain name")
  domain?: string;

  @doc("Business phone number")
  business?: string;

  @doc("Number Of Employees")
  numberOfEmployees?: int32;
}

@doc("Marketplace details.")
model MarketplaceDetails {
  @doc("Marketplace Subscription Id")
  marketplaceSubscriptionId: string;

  @doc("Marketplace offer details.")
  offerDetails: OfferDetails;
}

@doc("Details of the product offering.")
model OfferDetails {
  @maxLength(50)
  @doc("Id of the product publisher.")
  publisherId: string;

  @maxLength(50)
  @doc("Id of the product offering.")
  offerId: string;

  @maxLength(50)
  @doc("Id of the product offer plan.")
  planId: string;

  @maxLength(50)
  @doc("Name of the product offer plan.")
  planName: string;

  @maxLength(25)
  @doc("Offer plan term unit.")
  termUnit?: string;

  @maxLength(50)
  @doc("Offer plan term id.")
  termId: string;
}

@doc("Properties of the Informatica organization.")
model InformaticaProperties {
  @doc("Organization id")
  organizationId?: string;

  @doc("The login URL specific to this Informatica Organization")
  singleSignOnProperties?: InformaticaSingleSignOnProperties;
}

@doc("Link Organization")
model LinkOrganization{
  @doc("Link organization token")
  token?: string;
}

@doc("Single sign on Info of the Informatica organization.")
model InformaticaSingleSignOnProperties {
  @doc("Single sign-on state")
  singleSignOnState?: SingleSignOnStates;

  @doc("The Id of the Enterprise App used for Single sign-on.")
  enterpriseAppId?: string;

  @doc("The login URL specific to this Informatica Organization")
  singleSignOnUrl?: string;

  @doc("Provisioning state")
  provisioningState?: ProvisioningState;
}

@doc("User Info of Informatica Organization resource.")
model UserDetails {
  @maxLength(50)
  @doc("User first name.")
  firstName?: string;

  @maxLength(50)
  @doc("User last name.")
  lastName?: string;

  @doc("User email address.")
  emailAddress?: email;

  @doc("UPN of user")
  upn?: string;

  @maxLength(40)
  @doc("Phone number of the user used by for contacting them if needed")
  phoneNumber?: string;
}

@doc("Serverless Runtime properties.")
model InformaticaServerlessRuntimeProperties{
  @visibility("read")
  @doc("Provisioning State of the resource.")
  provisioningState?: ProvisioningState;

  @doc("description of the serverless runtime.")
  description?: string;

  @doc("Platform type of the Serverless Runtime.")
  platform?: string;

  @doc("Application type of the Serverless Runtime.")
  applicationType?: string;

  @doc("Compute units of the serverless runtime.")
  computeUnits?: string;

  @doc("Informatica Serverless Network profile properties.")
  serverlessRuntimeNetworkProfile?: ServerlessRuntimeNetworkProfile;

  @doc("String KV pairs indicating Advanced custom properties.")
  advancedCustomProperties?: Record<string>;

  @doc("Supplementary file location.")
  supplementaryFileLocation?: string;

  @doc("Serverless config properties")
  serverlessRuntimeConfig?: ServerlessRuntimeConfigProperties;
}

@doc("Serverless Runtime config properties.")
model ServerlessRuntimeConfigProperties{
  @doc("The List of Informatica Serverless Runtime CDI Config Properties.")
  @extension("x-ms-identifiers", [])
  cdiConfigProps?: CdiConfigProps[];

  @doc("The List of Informatica Serverless Runtime CDIE Config Properties.")
  @extension("x-ms-identifiers", [])
  cdieConfigProps?: CdiConfigProps[];
}

@doc("Informatica CDI Configuration Properties.")
model CdiConfigProps{
  @doc("EngineName of the application config.")
  engineName: string;

  @doc("EngineVersion of the application config.")
  name: string;

  @doc("ApplicationConfigs of the CDI or CDIE.")
  @extension("x-ms-identifiers", [])
  applicationConfigs: ApplicationConfigs[];
}

@doc("Application configs")
model ApplicationConfigs{
  @doc("Type of the application config.")
  type: string;

  @doc("Name of the application config.")
  name: string;

  @doc("Value of the application config.")
  value: string;
  
  @doc("Platform type of the application config.")
  platform: string;

  @doc("Customized value of the application config.")
  customized: string;

  @doc("Default value of the application config.")
  defaultValue: string;
}

@doc("Informatica Serverless Runtime Network Interface configurations.")
model NetworkInterfaceConfiguration {
  @doc("Virtual network resource id")
  vnetId : string;

  @doc("Virtual network subnet resource id")
  subnetId : string;

  @doc("Network security group name")
  nsg : string;
}

@doc("Informatica Serverless Runtime Network Profile.")
model ServerlessRuntimeNetworkProfile{
  @doc("Network Interface Configuration Profile")
  networkInterfaceConfiguration : NetworkInterfaceConfiguration;
}

@doc("Provisioning State of the Organization resource.")
enum ProvisioningState {
  @doc("Organization resource creation request accepted")
  Accepted,

  @doc("Organization resource creation started")
  Creating,

  @doc("Organization resource is being updated")
  Updating,

  @doc("Organization resource deletion started")
  Deleting,

  @doc("Organization resource creation successful")
  Succeeded,

  @doc("Organization resource creation failed")
  Failed,

  @doc("Organization resource creation canceled")
  Canceled,

  @doc("Organization resource is deleted")
  Deleted,

  @doc("Organization resource state is unknown")
  NotSpecified,
}

@doc("Various states of the SSO resource.")
enum SingleSignOnStates {
  @doc("SSO state Initial")
  Initial,

  @doc("SSO state Enable")
  Enable,

  @doc("SSO state Disable")
  Disable,

  @doc("SSO state Existing")
  Existing,
}
