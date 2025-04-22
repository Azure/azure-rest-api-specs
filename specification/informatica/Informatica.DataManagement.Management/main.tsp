import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@armProviderNamespace
@service(#{ title: "Informatica.DataManagement" })
@versioned(Versions)
@armCommonTypesVersion("v3")
namespace Informatica.DataManagement;

using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@doc("Reusable representation of an email address.")
@pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
scalar email extends string;

@doc("An Organization Resource by Informatica.")
model InformaticaOrganizationResource
  is Azure.ResourceManager.TrackedResource<OrganizationProperties> {
  @key("organizationName")
  @pattern("^[a-zA-Z0-9_-]*$")
  @segment("organizations")
  @doc("Name of the Organizations resource")
  @path
  name: string;
}

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Enum representing the versions.
 */
enum Versions {
  /**
   * The 2024-05-08 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_05_08: "2024-05-08",
}

@armResourceOperations
interface Organizations
  extends Azure.ResourceManager.TrackedResourceOperations<
      InformaticaOrganizationResource,
      OrganizationProperties
    > {
  get is ArmResourceRead<InformaticaOrganizationResource>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    InformaticaOrganizationResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<InformaticaOrganizationResource>;
  update is ArmCustomPatchSync<
    InformaticaOrganizationResource,
    InformaticaOrganizationResourceUpdate
  >;

  @doc("Gets Metadata of the serverless runtime environment.")
  @armResourceAction(InformaticaOrganizationResource)
  @post
  getServerlessMetadata(
    ...ResourceInstanceParameters<InformaticaOrganizationResource>,
  ): ArmResponse<ServerlessMetadataResponse> | ErrorResponse;

  @doc("Gets all serverless runtime resources in a given informatica organization resource.")
  @armResourceAction(InformaticaOrganizationResource)
  @post
  getAllServerlessRuntimes(
    ...ResourceInstanceParameters<InformaticaOrganizationResource>,
  ): ArmResponse<InformaticaServerlessRuntimeResourceList> | ErrorResponse;
}

@armResourceOperations
interface ServerlessRuntimes
  extends ProxyResourceOperations<InformaticaServerlessRuntimeResource> {
  get is ArmResourceRead<InformaticaServerlessRuntimeResource>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    InformaticaServerlessRuntimeResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<InformaticaServerlessRuntimeResource>;
  update is ArmCustomPatchSync<
    InformaticaServerlessRuntimeResource,
    InformaticaServerlessRuntimeResourceUpdate
  >;

  @doc("Checks all dependencies for a serverless runtime resource")
  @armResourceAction(InformaticaServerlessRuntimeResource)
  @post
  checkDependencies(
    ...ResourceInstanceParameters<InformaticaServerlessRuntimeResource>,
  ): ArmResponse<CheckDependenciesResponse> | ErrorResponse;

  @doc("Starts a failed runtime resource")
  @armResourceAction(InformaticaServerlessRuntimeResource)
  @post
  startFailedServerlessRuntime(
    ...ResourceInstanceParameters<InformaticaServerlessRuntimeResource>,
  ): ArmNoContentResponse | ErrorResponse;

  @doc("Returns a serverless runtime resource by ID")
  @armResourceAction(InformaticaServerlessRuntimeResource)
  @post
  serverlessResourceById(
    ...ResourceInstanceParameters<InformaticaServerlessRuntimeResource>,
  ): ArmResponse<InformaticaServerlessRuntimeResource> | ErrorResponse;
}

@doc("Model for the check dependencies API for an informatica serverless runtime resource")
model CheckDependenciesResponse {
  @doc("Count of dependencies")
  count: int32;

  @doc("id of resource")
  id: string;

  @doc("List of dependencies")
  references: ServerlessRuntimeDependency[];
}

@doc("Dependency reference for a serverless runtime resource")
model ServerlessRuntimeDependency {
  @doc("Dependency ID")
  id: string;

  @doc("Application context ID")
  appContextId: string;

  @doc("Dependency path")
  path: string;

  @doc("document type")
  documentType: string;

  @doc("description of Dependency")
  description: string;

  @doc("Last Update Time")
  lastUpdatedTime: string;
}

@doc("A list of serverless runtime resources as fetched using the informatica APIs")
model InformaticaServerlessRuntimeResourceList {
  @doc("List of runtime resources for the fetch all API")
  informaticaRuntimeResources: InfaRuntimeResourceFetchMetaData[];
}

@doc("Informatica runtime resource metadata as received via the informatica fetch all runtime environments API")
model InfaRuntimeResourceFetchMetaData {
  @doc("Environment name")
  name: string;

  @doc("Created time")
  createdTime: string;

  @doc("Updated Time")
  updatedTime: string;

  @doc("Created by")
  createdBy: string;

  @doc("Last Updated by")
  updatedBy: string;

  @doc("Informatica serverless runtime id")
  id: string;

  @doc("Environment Type")
  type: RuntimeType;

  @doc("Status of the environment")
  status: string;

  @doc("Display message for the given status")
  statusLocalized: string;

  @doc("status message")
  statusMessage: string;

  @doc("Serverless Config Properties")
  serverlessConfigProperties: InfaServerlessFetchConfigProperties;

  @doc("Description of the runtime resource")
  description?: string;
}

@doc("InfaServerlessFetchConfigProperties for the fetch all serverless API as received from informatica API response")
model InfaServerlessFetchConfigProperties {
  @doc("subnet name")
  subnet?: string;

  @doc("applicationType name")
  applicationType?: string;

  @doc("Resource group name")
  resourceGroupName?: string;

  @doc("Advanced custom properties")
  advancedCustomProperties?: string;

  @doc("Supplementary File location")
  supplementaryFileLocation?: string;

  @doc("Serverless Account Platform")
  platform?: string;

  @doc("Tags for the resource")
  tags?: string;

  @doc("virtual network")
  vnet?: string;

  @doc("Execution timeout")
  executionTimeout?: string;

  @doc("Compute Units")
  computeUnits?: string;

  @doc("Tenant ID")
  tenantId?: uuid;

  @doc("subscription ID")
  subscriptionId?: string;

  @doc("region name for the runtime environment")
  region?: string;

  @doc("Serverless Arm Resource ID")
  serverlessArmResourceId?: Azure.Core.armResourceIdentifier<[]>;
}

@doc("A Serverless Runtime environment  resource by Informatica.")
@parentResource(InformaticaOrganizationResource)
model InformaticaServerlessRuntimeResource
  is Azure.ResourceManager.ProxyResource<InformaticaServerlessRuntimeProperties> {
  @key("serverlessRuntimeName")
  @pattern("^[a-zA-Z0-9_-]*$")
  @segment("serverlessRuntimes")
  @doc("Name of the Serverless Runtime resource")
  @path
  name: string;
}

@doc("Properties specific to the Informatica DataManagement Organization resource.")
model OrganizationProperties {
  @visibility(Lifecycle.Read)
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
  marketplaceSubscriptionId?: string;

  @doc("Marketplace offer details.")
  offerDetails: OfferDetails;
}

@doc("Details of the product offering.")
model OfferDetails {
  @maxLength(250)
  @doc("Id of the product publisher.")
  publisherId: string;

  @maxLength(250)
  @doc("Id of the product offering.")
  offerId: string;

  @maxLength(250)
  @doc("Id of the product offer plan.")
  planId: string;

  @maxLength(250)
  @doc("Name of the product offer plan.")
  planName: string;

  @maxLength(50)
  @doc("Offer plan term unit.")
  termUnit?: string;

  @maxLength(250)
  @doc("Offer plan term id.")
  termId: string;
}

@doc("Properties of the Informatica organization.")
model InformaticaProperties {
  @doc("Organization id")
  organizationId?: string;

  @doc("Organization name")
  organizationName?: string;

  @doc("Informatica organization region")
  informaticaRegion?: string;

  @doc("Single sing on URL for informatica organization")
  singleSignOnUrl?: url;
}

@doc("Link Organization")
model LinkOrganization {
  @doc("Link organization token")
  token?: string;
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

@doc("Serverless Runtime environment Metadata response.")
model ServerlessMetadataResponse {
  @doc("type of the runtime environment.")
  type?: RuntimeType;

  @doc("serverless config properties")
  serverlessConfigProperties?: ServerlessConfigProperties;

  @doc("serverless runtime config properties")
  serverlessRuntimeConfigProperties?: ServerlessRuntimeConfigProperties;
}

@doc("Serverless Runtime properties.")
model InformaticaServerlessRuntimeProperties {
  @visibility(Lifecycle.Read)
  @doc("Provisioning State of the resource.")
  provisioningState?: ProvisioningState;

  @doc("description of the serverless runtime.")
  description?: string;

  @doc("Platform type of the Serverless Runtime.")
  platform?: PlatformType;

  @doc("Application type of the Serverless Runtime environment.")
  applicationType?: ApplicationType;

  @doc("Compute units of the serverless runtime.")
  computeUnits?: string;

  @doc("Serverless Execution timeout")
  executionTimeout?: string;

  @doc("Serverless account creation location")
  serverlessAccountLocation: string;

  @doc("Informatica Serverless Network profile properties.")
  serverlessRuntimeNetworkProfile?: ServerlessRuntimeNetworkProfile;

  @doc("String KV pairs indicating Advanced custom properties.")
  @extension("x-ms-identifiers", #[])
  advancedCustomProperties?: AdvancedCustomProperties[];

  @doc("Supplementary file location.")
  supplementaryFileLocation?: string;

  @doc("Serverless config properties")
  serverlessRuntimeConfig?: ServerlessRuntimeConfigProperties;

  @doc("Serverless Runtime Tags")
  @extension("x-ms-identifiers", #[])
  serverlessRuntimeTags?: ServerlessRuntimeTag[];

  @doc("Serverless runtime user context properties")
  serverlessRuntimeUserContextProperties?: ServerlessRuntimeUserContextProperties;
}

@doc("Serverless Runtime config properties.")
model ServerlessRuntimeConfigProperties {
  @doc("The List of Informatica Serverless Runtime CDI Config Properties.")
  @extension("x-ms-identifiers", #[])
  cdiConfigProps?: CdiConfigProps[];

  @doc("The List of Informatica Serverless Runtime CDIE Config Properties.")
  @extension("x-ms-identifiers", #[])
  cdieConfigProps?: CdiConfigProps[];
}

@doc("Metadata Serverless Config Properties")
model ServerlessConfigProperties {
  @doc("Platform types")
  platform?: PlatformType;

  @doc("List of application types supported by informatica")
  @extension("x-ms-identifiers", #[])
  applicationTypes?: ApplicationTypeMetadata[];

  @doc("The list of compute units with possible array of values")
  @extension("x-ms-identifiers", #[])
  computeUnits?: ComputeUnitsMetadata[];

  @doc("Serverless Runtime execution timeout")
  executionTimeout?: string;

  @doc("List of supported serverless informatica regions")
  @extension("x-ms-identifiers", #[])
  regions?: RegionsMetadata[];
}

@doc("Informatica Serverless advanced custom properties")
model AdvancedCustomProperties {
  @doc("advanced custom properties key")
  key?: string;

  @doc("advanced custom properties value")
  value?: string;
}

@doc("Serverless Runtime Tags")
model ServerlessRuntimeTag {
  @doc("The name (also known as the key) of the tag.")
  name?: string;

  @doc("The value of the tag.")
  value?: string;
}

@doc("Informatica Serverless Runtime User context properties")
model ServerlessRuntimeUserContextProperties {
  @doc("User context token for OBO flow.")
  userContextToken: string;
}

@doc("Informatica Serverless Runtime Application type Metadata")
model ApplicationTypeMetadata {
  @doc("Application type name")
  name?: string;

  @doc("Application type value")
  value?: string;
}

@doc("Informatica Serverless Runtime Application type Metadata")
model ComputeUnitsMetadata {
  @doc("ComputeUnit name")
  name?: string;

  @doc("ComputeUnit value")
  value?: string[];
}

@doc("Informatica Serverless Runtime Regions Metadata")
model RegionsMetadata {
  @doc("Region Id")
  id?: string;

  @doc("Region name")
  name?: string;
}

@doc("Informatica CDI Configuration Properties.")
model CdiConfigProps {
  @doc("EngineName of the application config.")
  engineName: string;

  @doc("EngineVersion of the application config.")
  engineVersion: string;

  @doc("ApplicationConfigs of the CDI or CDIE.")
  @extension("x-ms-identifiers", #[])
  applicationConfigs: ApplicationConfigs[];
}

@doc("Application configs")
model ApplicationConfigs {
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
  vnetId: Azure.Core.armResourceIdentifier<[]>;

  @doc("Virtual network subnet resource id")
  subnetId: Azure.Core.armResourceIdentifier<[]>;

  @doc("Virtual network resource guid")
  vnetResourceGuid?: string;
}

@doc("Informatica Serverless Runtime Network Profile.")
model ServerlessRuntimeNetworkProfile {
  @doc("Network Interface Configuration Profile")
  networkInterfaceConfiguration: NetworkInterfaceConfiguration;
}

@doc("Provisioning State of the Organization resource.")
union ProvisioningState {
  string,

  @doc("Organization resource creation request accepted")
  Accepted: "Accepted",

  @doc("Organization resource creation started")
  Creating: "Creating",

  @doc("Organization resource is being updated")
  Updating: "Updating",

  @doc("Organization resource deletion started")
  Deleting: "Deleting",

  @doc("Organization resource creation successful")
  Succeeded: "Succeeded",

  @doc("Organization resource creation failed")
  Failed: "Failed",

  @doc("Organization resource creation canceled")
  Canceled: "Canceled",

  @doc("Organization resource is deleted")
  Deleted: "Deleted",

  @doc("Organization resource state is unknown")
  NotSpecified: "NotSpecified",
}

@doc("Various application types of the Serverless Runtime environments")
union ApplicationType {
  string,

  @doc("Data Integration")
  CDI: "CDI",

  @doc("Advanced Data Integration")
  CDIE: "CDIE",
}

@doc("Various types of the Platform types.")
union PlatformType {
  string,

  @doc("Azure platform type")
  AZURE: "AZURE",
}

@doc("Various types of the runtime types.")
union RuntimeType {
  string,

  @doc("Serverless Runtime type")
  SERVERLESS: "SERVERLESS",
}

// additional models for Organizations_patch
model InformaticaOrganizationResourceUpdate
  is OptionalProperties<UpdateableProperties<OmitProperties<
    InformaticaOrganizationResource,
    "name" | "properties"
  >>> {
  /** Patchable PropertieInformaticaOrganizationPropertiesUpdates of the Organization observability resource */
  properties?: OrganizationPropertiesCustomUpdate;
}

/** Patchable Properties of the Informatica Organization resource */
model OrganizationPropertiesCustomUpdate {
  @doc("Informatica Organization properties")
  informaticaOrganizationProperties?: InformaticaOrganizationResourceUpdate;

  @doc("Marketplace details")
  marketplaceDetails?: MarketplaceDetailsUpdate;

  @doc("User details")
  userDetails?: UserDetailsUpdate;

  @doc("Company Details")
  companyDetails?: CompanyDetailsUpdate;

  @doc("Existing Resource Id")
  existingResourceId?: Azure.Core.armResourceIdentifier<[]>;
}

/** Marketplace details */
model MarketplaceDetailsUpdate {
  @doc("Marketplace Subscription Id")
  marketplaceSubscriptionId?: string;

  @doc("Marketplace offer details.")
  offerDetails?: OfferDetailsUpdate;
}

/** Details of the product offering */
model OfferDetailsUpdate
  is OptionalProperties<UpdateableProperties<OfferDetails>>;

/** User Info of Informatica Organization resource */
model UserDetailsUpdate
  is OptionalProperties<UpdateableProperties<UserDetails>>;

/** Company details of Informatica Organization resource */
model CompanyDetailsUpdate
  is OptionalProperties<UpdateableProperties<CompanyDetails>>;

// additional models for Organizations_patch
model InformaticaServerlessRuntimeResourceUpdate
  is OptionalProperties<UpdateableProperties<OmitProperties<
    InformaticaServerlessRuntimeResource,
    "name" | "properties"
  >>> {
  /** Patchable PropertieInformaticaOrganizationPropertiesUpdates of the Organization observability resource */
  properties?: ServerlessRuntimePropertiesCustomUpdate;
}

/** Patchable Properties of the Informatica Serverless Runtime resource */
model ServerlessRuntimePropertiesCustomUpdate {
  @doc("description of the serverless runtime.")
  description?: string;

  @doc("Platform type of the Serverless Runtime.")
  platform?: PlatformType;

  @doc("Application type of the Serverless Runtime environment.")
  applicationType?: ApplicationType;

  @doc("Compute units of the serverless runtime.")
  computeUnits?: string;

  @doc("Serverless Execution timeout")
  executionTimeout?: string;

  @doc("Serverless account creation location")
  serverlessAccountLocation?: string;

  @doc("Informatica Serverless Network profile properties.")
  serverlessRuntimeNetworkProfile?: ServerlessRuntimeNetworkProfileUpdate;

  @doc("String KV pairs indicating Advanced custom properties.")
  @extension("x-ms-identifiers", #[])
  advancedCustomProperties?: AdvancedCustomProperties[];

  @doc("Supplementary file location.")
  supplementaryFileLocation?: string;

  @doc("Serverless config properties")
  serverlessRuntimeConfig?: ServerlessRuntimeConfigPropertiesUpdate;

  @doc("Serverless Runtime Tags")
  @extension("x-ms-identifiers", #[])
  serverlessRuntimeTags?: ServerlessRuntimeTag[];

  @doc("Serverless runtime user context properties")
  serverlessRuntimeUserContextProperties?: ServerlessRuntimeUserContextPropertiesUpdate;
}

@doc("Informatica Serverless Network profile properties update.")
model ServerlessRuntimeNetworkProfileUpdate {
  @doc("Network Interface Configuration Profile Update")
  networkInterfaceConfiguration: NetworkInterfaceConfigurationUpdate;
}

model NetworkInterfaceConfigurationUpdate
  is OptionalProperties<UpdateableProperties<NetworkInterfaceConfiguration>>;

model ServerlessRuntimeConfigPropertiesUpdate
  is OptionalProperties<UpdateableProperties<ServerlessRuntimeConfigProperties>>;

model ServerlessRuntimeUserContextPropertiesUpdate
  is OptionalProperties<UpdateableProperties<ServerlessRuntimeUserContextProperties>>;
