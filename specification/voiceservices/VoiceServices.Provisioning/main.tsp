import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service({
  title: "Microsoft.VoiceServices.Provisioning",
})
@useAuth(
  [
    OAuth2Auth<[
      {
        type: OAuth2FlowType.clientCredentials,
        tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
        scopes: [
          "https://func-voiceservice-rp-prod-eastuseuap.azurewebsites.net/.default"
        ],
      }
    ]>
  ]
)
@versioned(Microsoft.VoiceServices.Versions)
namespace Microsoft.VoiceServices;

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

@doc("The Microsoft.VoiceServices service versions.")
enum Versions {
  @doc("2024-02-29-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_02_29_preview: "2024-02-29-preview",
}

/*
 *     Common Model Declarations
 */

@doc("The provisioning states of an object on any relevant backend service.")
union ServiceProvisioningStatus {
  string,

  @doc("The object is pending provisioning.")
  pending: "pending",

  @doc("The object has been synced with the relevant backend service.")
  synced: "synced",

  @doc("The object provisioning operation failed with the relevant backend service.")
  failed: "failed",
}

alias ProvisioningStatus = {
  @doc("The status of the provisioning action associated with this resource.")
  @visibility("read")
  serviceProvisioningStatus?: ServiceProvisioningStatus;

  @doc("Any errors pertaining to the provisioning of this resource.")
  @visibility("read")
  serviceProvisioningErrors?: Azure.Core.Foundations.Error[];
};

@doc("An identifier, used to identify a Number resource.")
model NumberIdentifier {
  @doc("Telephone number in E.164 format.")
  @minLength(3)
  @maxLength(16)
  @pattern("^\\+[1-9]\\d+$")
  @visibility("read", "update", "create")
  telephoneNumber: string;
}

@doc("A list identifiers for a Number resource.")
model NumberIdentifiers {
  @doc("Array containing a list of identifiers for Number resources.")
  @visibility("read", "update", "create")
  numbers: NumberIdentifier[];
}

/*
 *     Account Level Model Declarations
 *      - Resource
 */

alias ServiceSyncEnabled = {
  @doc("Boolean indicating if data is being provisioned through the backend service.")
  @visibility("read", "update", "create")
  syncEnabled: boolean;
};

alias ServiceEnabled = {
  @doc("Boolean indicating if the service is enabled on this Account.")
  @visibility("read", "update", "create")
  enabled: boolean;
};

alias ServiceNumberCount = {
  @doc("The count of telephone numbers associated with this account that have this backend service enabled.")
  @visibility("read")
  numberCount?: int64;
};

@doc("Account details specific to Teams Operator Connect on this Account.")
model TeamsOperatorConnectAccountDetails {
  ...ServiceSyncEnabled;
  ...ServiceEnabled;
  ...ServiceNumberCount;
}

@doc("DNS TXT value for the region, as provided by the enterprise admin from their Microsoft 365 Admin Center. Can only contain letters, numbers, underscores and dashes. Can be up to 100 characters in length.")
model TeamsDirectRoutingSubdomainTokens {
  @doc("DNS TXT value for the first region, as provided by the enterprise admin from their Microsoft 365 Admin Center. Can only contain letters, numbers, underscores and dashes. Can be up to 100 characters in length.")
  @minLength(1)
  @maxLength(100)
  @pattern("^([A-Za-z0-9=_-]+)$")
  @visibility("read", "update", "create")
  region1Token: string;

  @doc("DNS TXT value for the second region, as provided by the enterprise admin from their Microsoft 365 Admin Center. Can only contain letters, numbers, underscores and dashes. Can be up to 100 characters in length.")
  @minLength(1)
  @maxLength(100)
  @pattern("^([A-Za-z0-9=_-]+)$")
  @visibility("read", "update", "create")
  region2Token: string;
}

@doc("Possible values for DNS provisioning state of Teams Direct Routing domains")
union TeamsDirectRoutingSubdomainProvisioningStatus {
  string,

  @doc("The DNS provisioning state Provisioned.")
  provisioned: "provisioned",

  @doc("The DNS provisioning state Not Provisioned.")
  notProvisioned: "notProvisioned",

  @doc("The DNS provisioning state Inconsistent.")
  inconsistent: "inconsistent",
}

@doc("Configuration specific to Teams Direct Routing.")
model TeamsDirectRoutingAccountConfig {
  @doc("Enables/disables caller ID screening for the account. Caller ID screening is enabled by default.")
  @visibility("read", "update", "create")
  callScreening: boolean;

  @doc("Enterprise-specific domain name label. Can only contain letters, numbers, underscores and dashes. Can be up to 10 characters in length.")
  @minLength(1)
  @maxLength(10)
  @pattern("^([A-Za-z0-9_-]+)$")
  @visibility("read", "update", "create")
  subdomain: string;

  @doc("DNS TXT value for the Direct Routing regions, as provided by the customer from their Microsoft 365 Admin Center.")
  @visibility("read", "update", "create")
  subdomainTokens: TeamsDirectRoutingSubdomainTokens;
}

@doc("Account details specific to Teams Direct Routing on this Account.")
model TeamsDirectRoutingAccountDetails {
  ...ServiceSyncEnabled;
  ...ServiceEnabled;
  ...ServiceNumberCount;

  @doc("The configuration for Teams Direct Routing on this account.")
  @visibility("read", "update", "create")
  configuration?: TeamsDirectRoutingAccountConfig;

  @doc("The provisioning status of the domains.")
  @visibility("read")
  subdomainStatus: TeamsDirectRoutingSubdomainProvisioningStatus;
}

@doc("Account details specific to Teams Phone Mobile.")
model TeamsPhoneMobileAccountDetails {
  ...ServiceSyncEnabled;
  ...ServiceEnabled;
  ...ServiceNumberCount;
}

@doc("Account details specific to Zoom Phone Cloud Peering.")
model ZoomPhoneCloudPeeringAccountDetails {
  ...ServiceSyncEnabled;
  ...ServiceEnabled;
  ...ServiceNumberCount;
}

@doc("Account details specific to Azure Operator Call Protection.")
model AzureOperatorCallProtectionAccountDetails {
  ...ServiceEnabled;
  ...ServiceNumberCount;
}

@doc("Details of the backend services associated with this Account.")
model AccountServiceDetails {
  @doc("The Microsoft Teams Tenant ID of the Account. This can only be updated if no Operator Connect or Teams Phone Mobile numbers are configured in this account.")
  @visibility("read", "update", "create")
  teamsTenantId?: string;

  @doc("Details for the Teams Operator Connect service on this Account.")
  @visibility("read", "update", "create")
  teamsOperatorConnect?: TeamsOperatorConnectAccountDetails;

  @doc("Details for the Teams Direct Routing service on this Account.")
  @visibility("read", "update", "create")
  teamsDirectRouting?: TeamsDirectRoutingAccountDetails;

  @doc("Details for the Teams Phone Mobile service on this Account.")
  @visibility("read", "update", "create")
  teamsPhoneMobile?: TeamsPhoneMobileAccountDetails;

  @doc("Details for the Zoom Phone Cloud Peering service on this Account.")
  @visibility("read", "update", "create")
  zoomPhoneCloudPeering?: ZoomPhoneCloudPeeringAccountDetails;

  @doc("Details for the Azure Operator Call Protection service on this Account.")
  @visibility("read", "update", "create")
  azureOperatorCallProtection?: AzureOperatorCallProtectionAccountDetails;
}

@resource("accounts")
@doc("An account represents a group of numbers, typically associated with an enterprise.")
model AccountResource {
  ...ProvisioningStatus;

  @doc("Name of the account.")
  @minLength(1)
  @maxLength(100)
  @pattern("^([A-Za-z0-9_-]+)$")
  @visibility("read", "update", "create")
  @key("accountName")
  name: string;

  @doc("A user defined identifier used for correlating with external systems.")
  @visibility("read", "update", "create")
  correlationId?: string;

  @doc("The details of the account.")
  @visibility("read", "update", "create")
  serviceDetails?: AccountServiceDetails;
}

/*
 *     Account Level Model Declarations
 *      - Custom Actions
 */

@doc("The Teams capabilities available for numbers with Operator Connect or Teams Phone Mobile services enabled.")
model TeamsAvailableCapabilities {
  @doc("The available capabilities for the numbers specified with Operator Connect or Teams Phone Mobile services enabled.")
  @visibility("read")
  availableCapabilities: string[];
}

@doc("A teams capability plan for a given usage.")
model TeamsCapabilityPlan {
  @doc("The capability plan name.")
  @visibility("read")
  name: string;

  @doc("The offer types available.")
  @visibility("read")
  offerTypes?: string[];

  @doc("The telephone number usage.")
  @visibility("read")
  usage: string;

  @doc("Mandatory capabilities for telephone numbers.")
  @visibility("read")
  mandatoryCapabilities?: string[];

  @doc("Choosable capabilities for telephone numbers.")
  @visibility("read")
  choosableCapabilities?: string[];

  @doc("Boolean indicating if Toll free is supported.")
  @visibility("read")
  supportsTollFree: boolean;
}

@doc("The Teams telephone number upload usages for this account.")
model TeamsCapabilityPlans {
  @doc("A list of telephone number upload usages.")
  @visibility("read")
  capabilityPlans: TeamsCapabilityPlan[];
}

/*
 *     Account Level Model Declarations
 *      - Civic Addresses
 */

@doc("The possible validation status of Teams Civic Addresses.")
union ValidationStatus {
  string,

  @doc("The civic address is not validated.")
  notValidated: "notValidated",

  @doc("The civic address is validated.")
  validated: "validated",
}

@doc("A location used by Team Operator Connect or Teams Phone Mobile telephone numbers.")
model Location {
  @minLength(1)
  @doc("The ID of the location.")
  @visibility("read")
  id: string;

  @minLength(1)
  @doc("The civic address ID of the location.")
  @visibility("read")
  civicAddressId: string;

  @doc("The description of the location.")
  @visibility("read")
  description?: string;

  @doc("The additional information of the location.")
  @visibility("read")
  additionalInfo?: string;

  @doc("Flag indicating whether the location is default or not.")
  @visibility("read")
  isDefault?: boolean;

  @doc("The elin (Emergency Location Identification Number) of the location.")
  @visibility("read")
  elin?: string;
}

@doc("A civic address available for Teams Operator Connect or Teams Phone Mobile users.")
@resource("teamsCivicAddresses")
@parentResource(AccountResource)
model TeamsCivicAddressResource {
  @minLength(1)
  @doc("The ID of the civic address.")
  @key("civicAddressId")
  @visibility("read")
  id: string;

  @doc("The country of the civic address.")
  @visibility("read")
  country?: string;

  @doc("The house number of the civic address.")
  @visibility("read")
  houseNumber?: string;

  @doc("The house number suffix of the civic address.")
  @visibility("read")
  houseNumberSuffix?: string;

  @doc("The pre directional of the civic address.")
  @visibility("read")
  preDirectional?: string;

  @doc("The street name of the civic address.")
  @visibility("read")
  streetName?: string;

  @doc("The street suffix of the civic address.")
  @visibility("read")
  streetSuffix?: string;

  @doc("The post directional of the civic address.")
  @visibility("read")
  postDirectional?: string;

  @doc("The state or province of the civic address.")
  @visibility("read")
  stateOrProvince?: string;

  @doc("The county or district of the civic address.")
  @visibility("read")
  countyOrDistrict?: string;

  @doc("The city or town of the civic address.")
  @visibility("read")
  cityOrTown?: string;

  @doc("The city or town alias of the civic address.")
  @visibility("read")
  cityOrTownAlias?: string;

  @doc("The postal or zip code of the civic address.")
  @visibility("read")
  postalOrZipCode?: string;

  @doc("The description of the civic address.")
  @visibility("read")
  description?: string;

  @doc("The company name of the civic address.")
  @visibility("read")
  companyName?: string;

  @doc("The company ID of the civic address.")
  @visibility("read")
  companyId?: string;

  @minLength(1)
  @doc("The default location ID of the civic address.")
  @visibility("read")
  defaultLocationId: string;

  @doc("The validation status of the civic address.")
  @visibility("read")
  validationStatus?: ValidationStatus;

  @doc("The customer tenant ID of the civic address.")
  @visibility("read")
  tenantId?: string;

  @doc("The partner ID of the civic address.")
  @visibility("read")
  partnerId?: string;

  @doc("The list of locations associated with the civic address.")
  @visibility("read")
  locations?: Location[];

  @doc("The latitude of the civic address.")
  @visibility("read")
  latitude?: string;

  @doc("The longitude of the civic address.")
  @visibility("read")
  longitude?: string;
}

/*
 *     Number Level Model Declarations
 *      - Resource
 */

@doc("Indicates whether a number is assigned to a user.")
union TelephoneNumberAssignmentStatus {
  string,

  @doc("The telephone number is assigned to a user.")
  assigned: "assigned",

  @doc("The telephone number is not assigned to a user.")
  unassigned: "unassigned",
}

alias NumberAssignmentStatus = {
  @doc("The assignment status of this Number.")
  @visibility("read", "update", "create")
  assignmentStatus?: TelephoneNumberAssignmentStatus;
};

@doc("Telephone number configuration for Teams Operator Connect and Teams Phone Mobile telephone numbers.")
model TeamsCommonNumberConfig {
  @doc("The usage for this telephone number.")
  @visibility("read", "update", "create")
  usage: string;

  @doc("The choosable capabilities for this telephone number.")
  @visibility("read", "update", "create")
  choosableCapabilities: string[];

  @doc("The acquired capabilities for this telephone number.")
  @visibility("read")
  acquiredCapabilities?: string[];

  @doc("The available capabilities for this telephone number.")
  @visibility("read")
  availableCapabilities?: string[];

  @doc("The additional usages for this telephone number.")
  @visibility("read", "update", "create")
  additionalUsages?: string[];

  @doc("The ID of the civic address to be used as the emergency address for this telephone number.")
  @visibility("read", "update", "create")
  civicAddressId?: string;

  @doc("The ID of the location to be used as the emergency address for this telephone number.")
  @visibility("read", "update", "create")
  locationId?: string;

  @doc("If the enterprise is allowed to update the address for this telephone number.")
  @visibility("read", "update", "create")
  allowTenantAddressUpdate?: boolean = false;

  @doc("The country code to be displayed with this telephone number")
  @visibility("read", "update", "create")
  displayedCountryCode?: string;
}

alias NumberServiceEnabled = {
  @doc("Boolean indicating if the service is enabled on this Number.")
  @visibility("read", "update", "create")
  enabled: boolean;
};

@doc("Telephone number configuration for Teams Operator Connect telephone numbers.")
model TeamsOperatorConnectNumberConfig {
  ...TeamsCommonNumberConfig;
}

@doc("Details for the Teams Operator Connect service on this Number.")
model TeamsOperatorConnectNumberDetails {
  ...NumberServiceEnabled;
  ...NumberAssignmentStatus;

  @doc("The configuration for Teams Operator Connect on this number.")
  @visibility("read", "update", "create")
  configuration?: TeamsOperatorConnectNumberConfig;
}

@doc("Details for the Teams Direct Routing service on this Number.")
model TeamsDirectRoutingNumberDetails {
  ...NumberServiceEnabled;
}

@doc("Telephone number configuration for Teams Phone Mobile telephone numbers.")
model TeamsPhoneMobileNumberConfig {
  ...TeamsCommonNumberConfig;
}

@doc("Details for the Teams Phone Mobile service on this Number.")
model TeamsPhoneMobileNumberDetails {
  ...NumberServiceEnabled;
  ...NumberAssignmentStatus;

  @doc("The configuration for Teams Phone Mobile on this number.")
  @visibility("read", "update", "create")
  configuration?: TeamsPhoneMobileNumberConfig;
}

@doc("Details for the Zoom Phone Cloud Peering service on this Number.")
model ZoomPhoneCloudPeeringNumberDetails {
  ...NumberServiceEnabled;
}

@doc("Details for the Azure Operator Call Protection service on this Number.")
model AzureOperatorCallProtectionNumberDetails {
  ...NumberServiceEnabled;
}

@doc("Configuration of backend services for a telephone number.")
model NumberServiceDetails {
  @doc("Details for the Teams Operator Connect service on this Number.")
  @visibility("read", "update", "create")
  teamsOperatorConnect?: TeamsOperatorConnectNumberDetails;

  @doc("Details for the Teams Direct Routing service on this Number.")
  @visibility("read", "update", "create")
  teamsDirectRouting?: TeamsDirectRoutingNumberDetails;

  @doc("Details for the Teams Phone Mobile service on this Number.")
  @visibility("read", "update", "create")
  teamsPhoneMobile?: TeamsPhoneMobileNumberDetails;

  @doc("Details for the Zoom Phone Cloud Peering service on this Number.")
  @visibility("read", "update", "create")
  zoomPhoneCloudPeering?: ZoomPhoneCloudPeeringNumberDetails;

  @doc("Details for the Azure Operator Call Protection service on this Number.")
  @visibility("read", "update", "create")
  azureOperatorCallProtection?: AzureOperatorCallProtectionNumberDetails;
}

@doc("Configuration for this number.")
model NumberConfiguration {
  @doc("Contents of the custom SIP header to use with this number. Can only contain letters, numbers, underscores and dashes. Can be up to 100 characters in length. The name of the custom header is set as part of the provisioning platform configuration on Azure Communications Gateway.")
  @minLength(1)
  @maxLength(100)
  @pattern("^([A-Za-z0-9_-])+$")
  @visibility("read", "update", "create")
  customSipHeader?: string;
}

@doc("The configuration for a telephone number provisioned in Azure Communications Gateway.")
@resource("numbers")
@parentResource(AccountResource)
model NumberResource {
  ...ProvisioningStatus;

  @doc("Telephone number in E.164 format.")
  @minLength(1)
  @maxLength(16)
  @pattern("^\\+[1-9]\\d+$")
  @visibility("read", "update", "create")
  @key("telephoneNumber")
  telephoneNumber: string;

  @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
  @minLength(1)
  @maxLength(100)
  @pattern("^([A-Za-z0-9_-]+)$")
  @visibility("read", "update", "create")
  accountName: string;

  @doc("Configuration of the individual backend services for this number.")
  @visibility("read", "update", "create")
  serviceDetails: NumberServiceDetails;

  @doc("Configuration for this number.")
  @visibility("read", "update", "create")
  configuration?: NumberConfiguration;
}

@doc("List of telephone numbers to be uploaded to an account via a PUT request.")
model BatchNumbers {
  @doc("The list of numbers to upload. At most 100 can be uploaded in one request.")
  @maxItems(100)
  @visibility("read", "update", "create")
  numbers: NumberResource[];
}

@doc("A list of telephone numbers to delete.")
model BatchNumbersDelete {
  @doc("The list of number to delete. At most 100 can be deleted in one request.")
  @maxItems(100)
  @visibility("read", "update", "create")
  numbers: NumberIdentifier[];
}

model PagedNumberList is Azure.Core.Page<NumberResource>;

/*
 *     Teams Request for Information Level Model Declarations
 *      - Resource
 */

@doc("The possible state for an Operator Consent.")
union TeamsConsentStatus {
  string,

  @doc("The Operator Consent is active.")
  active: "active",

  @doc("The Operator Consent is suspended.")
  suspended: "suspended",

  @doc("The Operator Consent is removed.")
  removed: "removed",
}

@doc("Contact details for an individual.")
model ContactDetails {
  @doc("The full name of the contact detail.")
  @minLength(1)
  @visibility("read")
  fullName: string;

  @doc("The email of the contact detail.")
  @minLength(1)
  @visibility("read")
  email: string;

  @doc("The telephone number of the contact detail.")
  @visibility("read")
  telephoneNumber?: string;

  @doc("The company name of the contact detail.")
  @visibility("read")
  companyName?: string;

  @doc("The company size of the contact detail.")
  @visibility("read")
  companySize?: string;
}

@doc("Details of a customer relationship.")
model CustomerRelationship {
  @doc("The status of the customer relationship.")
  @visibility("read", "update", "create")
  status?: string;

  @doc("The time (ISO8601 format) when the customer relationship is last modified.")
  @visibility("read")
  lastModifiedOn?: utcDateTime;

  @doc("The comment of the customer relationship.")
  @visibility("read", "update", "create")
  comment?: string;
}

@doc("The configuration for a telephone number provisioned in ACG.")
@resource("teamsRequestsForInformation")
model RequestForInformationResource {
  ...ProvisioningStatus;

  @doc("The ID of the Request for Information.")
  @visibility("read")
  id?: string;

  @doc("The Teams tenant ID which generated this Request for Information.")
  @minLength(1)
  @maxLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("tenantId")
  @visibility("read")
  tenantId: string;

  @doc("The name of the account associated with this Request for Information.")
  @visibility("read")
  accountName?: string;

  @doc("Will always be 'teams'.")
  @visibility("read")
  productContext?: string;

  @doc("The operator ID of the operator consent.")
  @visibility("read")
  operatorId?: string;

  @doc("The status of the operator consent.")
  @visibility("read")
  status?: TeamsConsentStatus;

  @doc("The time (ISO8601 format) when the operator consent is created.")
  @visibility("read")
  consentedOn?: utcDateTime;

  @doc("The time (ISO8601 format) when the operator consent is last modified.")
  @visibility("read")
  lastModifiedOn?: utcDateTime;

  @doc("The list of consented countries.")
  @visibility("read")
  consentedCountries?: string[];

  @doc("The list of tenant contacts.")
  @visibility("read")
  contacts?: ContactDetails[];

  @doc("The customer relationship of the operator consent.")
  @visibility("read", "update", "create")
  customerRelationship?: CustomerRelationship;
}

/*
 *     Query Parameters
 */

@doc("Provides the custom 'filter' query parameter for list operations")
model FilterQueryParameter {
  @query("filter")
  @doc("Filter the result list using the given expression")
  filter?: string;
}

@doc("Indicates whether the response should include an 'x-ms-record-count' header which contains the total number or records available for this request.")
model RecordCountQueryParameter {
  @query("countRecords")
  @doc("Whether to return a count of the total number of records available for this request.")
  countRecords?: boolean;
}

@doc("Indicates whether the child Number objects of an Account should be deleted with the Account, defaults to false.")
model DeleteNumbersQueryParameter {
  @query("deleteNumbers")
  @doc("Whether to delete the child Number resources of the Account, defaults to false.")
  deleteNumbers?: boolean;
}

@doc("Provides the custom 'x-ms-record-count' header for list operations which details the total number of records available for this request.")
model CountOfRecordsHeader {
  @header("x-ms-record-count")
  @doc("The total number of records available for this request.")
  countOfRecords?: int32;
}

alias BodyParameter<
  T,
  TName extends valueof string = "body",
  TDoc extends valueof string = "Body parameter."
> = {
  #suppress "@azure-tools/typespec-azure-core/friendly-name" "Legacy"
  @doc(TDoc)
  @friendlyName(TName)
  @bodyRoot
  body: T;
};

alias FilterQueryParameters = QueryParametersTrait<{
  ...FilterQueryParameter;
}>;

alias CustomRecordCountRequestQueryParameter = QueryParametersTrait<{
  ...RecordCountQueryParameter;
}>;

alias CustomDeleteNumbersQueryParameter = QueryParametersTrait<{
  ...DeleteNumbersQueryParameter;
}>;

alias CustomRecordCountResponseHeader = ResponseHeadersTrait<{
  ...CountOfRecordsHeader;
}>;

alias FilteredPaginatedJobQueryParams = ListQueryParametersTrait<{
  ...StandardListQueryParameters;
  ...FilterQueryParameter;
  ...RecordCountQueryParameter;
}>;

alias ResponseHeadersWithCount = ResponseHeadersTrait<{
  ...CountOfRecordsHeader;
}>;

/*
 *     Resource Operations
 */

interface Accounts {
  @tag("Account")
  @summary("Get list of Accounts")
  @doc("Get list of Accounts with details. An Account represents an Enterprise or collection of users.")
  list is Operations.ResourceList<
    AccountResource,
    FilteredPaginatedJobQueryParams & ResponseHeadersWithCount
  >;

  @tag("Account")
  @summary("Get Account.")
  @doc("Get details of a specific Account using its Name. An Account represents an Enterprise or collection of users.")
  get is Operations.ResourceRead<AccountResource>;

  @tag("Account")
  @summary("Create or Replace Account.")
  @doc("Create or replace the details of an Account.")
  createOrReplace is Operations.ResourceCreateOrReplace<AccountResource>;

  @tag("Account")
  @summary("Delete Account.")
  @doc("Delete a specific Account using its Name. This will fail if any Numbers are provisioned on the Account.")
  delete is Operations.ResourceDelete<
    AccountResource,
    CustomDeleteNumbersQueryParameter
  >;

  @tag("BatchNumbers")
  @summary("Create or update Numbers.")
  @doc("Create or update up to 100 Numbers on the specified account.")
  createOrUpdateNumbers is Operations.ResourceAction<
    AccountResource,
    BodyParameter<
      BatchNumbers,
      "body",
      "Batch of numbers to create or replace."
    >,
    BatchNumbers
  >;

  @tag("BatchNumbers")
  @summary("Delete Numbers.")
  @doc("Delete up to 100 Numbers on the specified account.")
  deleteNumbers is Operations.ResourceAction<
    AccountResource,
    BodyParameter<BatchNumbersDelete, "body", "Batch numbers to delete.">,
    NoContentResponse
  >;

  @tag("Number")
  @summary("Get Numbers.")
  @doc("Get a list of Numbers on the specified account.")
  listNumbers is Operations.ResourceList<
    NumberResource,
    FilteredPaginatedJobQueryParams & ResponseHeadersWithCount
  >;

  @tag("Number")
  @summary("Get Number.")
  @doc("Get details of a specific Number using its telephone number.")
  getNumber is Operations.ResourceRead<NumberResource>;

  @tag("Number")
  @summary("Create or replace Number.")
  @doc("Create or replace the details of a Number.")
  createOrReplaceNumber is Operations.ResourceCreateOrReplace<NumberResource>;

  @tag("Number")
  @summary("Delete Number.")
  @doc("Delete a specific Number using its telephone number.")
  deleteNumber is Operations.ResourceDelete<NumberResource>;

  @tag("TeamsCapabilityPlans")
  @summary("Get Teams Usages.")
  @doc("Get a list of Teams capability plans on the specified account.")
  getTeamsCapabilityPlans is Operations.ResourceAction<
    AccountResource,
    {},
    TeamsCapabilityPlans
  >;

  @tag("TeamsAvailableCapabilities")
  @summary("Get Teams Available Capabilities.")
  @doc("Get a list of Teams Available Capabilities on the specified account.")
  getTeamsAvailableCapabilities is Operations.ResourceAction<
    AccountResource,
    BodyParameter<
      NumberIdentifiers,
      "body",
      "List identifiers for a Number resource"
    >,
    TeamsAvailableCapabilities
  >;

  @tag("TeamsCivicAddresses")
  @summary("Get Teams Civic Addresses.")
  @doc("Get a list of Teams Civic Addresses on the specified account.")
  listTeamsCivicAddresses is Operations.ResourceList<
    TeamsCivicAddressResource,
    FilteredPaginatedJobQueryParams & ResponseHeadersWithCount
  >;

  @tag("TeamsCivicAddress")
  @summary("Get Teams Civic Address.")
  @doc("Get details of a specific Teams Civic Address using its ID.")
  getTeamsCivicAddress is Operations.ResourceRead<TeamsCivicAddressResource>;
}

interface TeamsRequestsForInformation {
  @tag("TeamsRequestForInformation")
  @summary("Get list of Requests for Information")
  @doc("Get list of Requests for Information with details.")
  list is Operations.ResourceList<
    RequestForInformationResource,
    FilteredPaginatedJobQueryParams & ResponseHeadersWithCount
  >;

  @tag("TeamsRequestForInformation")
  @summary("Get Request for Information.")
  @doc("Get details of a specific Request for Information using its ID.")
  getRequestForInformation is Operations.ResourceRead<RequestForInformationResource>;

  @tag("TeamsRequestForInformation")
  @summary("Create or update Request for Information.")
  @doc("Create of update the details of a Request for Information.")
  createOrUpdateRequestForInformation is Operations.ResourceCreateOrUpdate<RequestForInformationResource>;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "RpcOperation, when specified as a GET, adds a required `body` field which we do not want."
@route("/numbers")
@get
@readsResource(NumberResource)
@doc("List all the Numbers associated with this Communications Gateway.")
op listNumbers is RpcOperation<
  {
    ...StandardListQueryParameters;
    ...FilterQueryParameter;
    ...RecordCountQueryParameter;
  },
  PagedNumberList & CountOfRecordsHeader
>;
