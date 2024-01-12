import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service({
  title: "Microsoft.VoiceServices.ProvisioningAPI",
})
@versioned(Microsoft.Voiceservices.Versions)

namespace Microsoft.Voiceservices;

@doc("The Microsoft.Voiceservices service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-01-30-preview version of the Microsoft.Voiceservices service.")
  `2024-01-30-preview`,
}

@doc("API version query parameter.")
model ApiVersionParameter {
  @query("api-version")
  @doc("The API version to use")
  apiVersion: string;
}

/* This is not used directly, is just to simplify the code */
@doc("Utility model for Account names.")
model AccountName {
  @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
  @minLength(1)
  @maxLength(100)
  @pattern("^([A-Za-z0-9_-]+)$")
  accountNameString: string;
}

/* This is not used directly, is just to simplify the code */
@doc("Utility model for phone numbers.")
model PhoneNumber {
  @doc("Phone number in E.164 format.")
  @minLength(3)
  @maxLength(16)
  @pattern("^\\+[1-9]\\d{1,14}$")
  phoneNumberString: string;
}

/* This is not used directly, is just to simplify the code */
@doc("Utility model for custom SIP headers.")
model CustomSipHeader {
  @doc("Contents of the custom SIP header to use with this number. Can only contain letters, numbers, underscores and dashes. Can be up to 100 characters in length. The name of the custom header is set as part of deploying Azure Communications Gateway.")
  @minLength(1)
  @maxLength(100)
  @pattern("^([A-Za-z0-9_-])+$")
  customSipHeaderString: string;
}

@doc("A list of phone numbers")
model PhoneNumbers {
  @doc("Array containing a list of phone numbers.")
  numbers: PhoneNumber[]
}

@doc("Details of the account.")
model AccountDetails {
  ...AccountName;

  @doc("The opaque correlator id for this account.")
  correlatorId?: string;

  // TODO: finalise requirements on this.
  // @doc("Default preferred region for numbers under this account.")
  // defaultPreferredRegion?: string;

  @doc("Teams Common Account Configuration required for OC and TPM")
  teamsCommonConfig?: TeamsCommonConfig;

  @doc("Indicates that Teams Operator Connect (OC) is enabled for this account.")
  teamsOcEnabled: boolean;

  @doc("Teams Operator Connect (OC) Account Configuration. Only accepted if OC is enabled.")
  teamsOcConfig?: TeamsOcConfig;

  @doc("Indicates that Teams Direct Routing (DR) enabled for this account.")
  directRoutingEnabled: boolean;

  @doc("Teams Direct Routing (DR) Account Configuration. Only accepted if DR is enabled.")
  directRouting?: TeamsDrConfig;

  @doc("Indicates that Teams Phone Mobile (TPM) is enabled for this account.")
  teamsTpmEnabled: boolean;

  @doc("Teams Phone Mobile (TPM) Account Configuration. Only accepted if TPM is enabled.")
  teamsTpmConfig?: TeamsTpmConfig;

  @doc("Indicates that Zoom is enabled for this account.")
  zoomEnabled: boolean;

  @doc("Zoom Account Configuration. Only accepted if Zoom is enabled.")
  zoomConfig?: ZoomConfig;
}

@doc("Details of the account as returned on a GET request.")
model AccountResponse {
  @doc("Name of the account.")
  @minLength(1)
  name: string;

  @doc("The details of the account.")
  details?: AccountDetails;

  @doc("ETag for use with If-Match headers for optimistic concurrency.")
  etag?: string;

  @doc("The provisioning state of Teams Direct Routing DNS domains.")
  directRoutingProvisioningState?: TeamsDrSubdomainProvisioningState;

  @doc("Count of Teams Operator Connect subscribers for this account.")
  teamsOcSubCount: int64;

  @doc("Count of Teams Direct Routing subscribers for this account.")
  teamsDrSubCount: int64;

  @doc("Count of Teams Phone Mobile subscribers for this account.")
  teamsTpmSubCount: int64;

  @doc("Count of Zoom subscribers for this account.")
  zoomSubCount: int64;

  @doc("Status of syncing changes to this object to relevant backend services.")
  serviceProvisioningStatus: ServiceProvisioningState;

  @doc("Error messages where syncing to UC services has failed.")
  serviceProvisioningErrors?: ServiceProvisioningErrors;
}

model PaginatedList<T> {
  @doc("The list of records for this page.")
  value: T[];

  @doc("The number of records returned for this page.")
  numberOfRecords: int32;

  @doc("Link to the next page (if appropriate).")
  nextLink?: string;

  ...ListQueryParameters
}

@doc("Paginated list of Account Responses")
model AccountResponsePaginatedList is PaginatedList<AccountResponse>{}

@doc("List of phone numbers to be uploaded to an account via a PUT request.")
model BatchNumbersPut {
  @doc("The list of numbers to upload. At most 100 can be uploaded in one request.")
  @maxItems(100)
  numbers: BatchNumbersPutItem[];
}

@doc("And individual phone number and configuration to be uploaded as part of a bulk request.")
model BatchNumbersPutItem {
  ...PhoneNumber;

  @doc("The configuration for the number uploaded.")
  details: NumberDetails;
}

@doc("A list of phone numbers to delete.")
model BatchNumbersDelete {
  @doc("The list of number to delete. At most 100 can be deleted in one request.")
  @maxItems(100)
  numbers: PhoneNumber[]
}

@doc("The response to a bulk upload of phone numbers.")
model BatchNumbersResponse {
  @doc("A list of configurations for a set of phone numbers provisioned in ACG.")
  numbers: NumberResponse[];
}

@doc("Read/Write configuration for a phone number provisioned in ACG.")
model NumberDetails {
  ...PhoneNumber;

  @doc("Configuration for the individual UC services for this number.")
  services: NumberServices;

  ...CustomSipHeader;

  // TODO: finalise requirements on this.
  // @doc("Preferred region for this number.")
  // preferredRegion?: string;
}

@doc("The configuration for a phone number provisioned in ACG.")
model NumberResponse {
  ...PhoneNumber;
  ...AccountName;

  @doc("The read/write configuration for this phone number.")
  details: NumberDetails;

  @doc("The assigment status of this phone number.")
  status: AssignmentStatus;

  @doc("ETag for use with If-Match headers for optimistic concurrency.")
  etag?: string;

  @doc("The provisioning state of the phone number with any UC services.")
  serviceProvisioningStatus: ServiceProvisioningState;

  @doc("Any error details returned by UC services.")
  serviceProvisioningErrors?: ServiceProvisioningErrors;
}

@doc("A paginated list of phone number configuration.")
model NumberResponsePaginatedList is PaginatedList<NumberResponse>{}

@doc("Configuration for UC services for a phone number.")
model NumberServices {
  @doc("Indicates that Teams Operator Connect (OC) is enabled for this number.")
  teamsOcEnabled: boolean;

  @doc("Teams Operator Connect (OC) Number Configuration")
  teamsOcNumberConfig?: TeamsOcNumberConfig;

  @doc("Indicates that Teams Direct Routing (DR) is enabled for this number.")
  teamsDrEnabled: boolean;

  @doc("Teams Phone Mobile (TPM) Number Configuration")
  teamsTpmNumberConfig?: TeamsTpmNumberConfig;

  @doc("Indicates that Teams Phone Mobile (TPM) is enabled for this number.")
  teamsTpmEnabled: boolean;

  @doc("Indicates that Zoom is enabled for this number.")
  zoomEnabled: boolean;
}

@doc("The Teams capabilities available for numbers with OC or TPM services enabled.")
model TeamsCapabilities {
  @doc("The capability plan name.")
  name: string;

  @doc("The offer types available.")
  offerTypes: string[];

  @doc("Mandatory capabilities for phone numbers.")
  mandatoryCapabilities: string[];

  @doc("Choosable capabilities for phone numbers.")
  choosableCapabilities: string[];

  @doc("Boolean indicating if Toll free is supported.")
  supportsTollFree: boolean;
}

@doc("Paginated list of Teams capabilities.")
model TeamsCapabilitiesPaginatedList is PaginatedList<TeamsCapabilities>{}

@doc("Phone number configuration for Teams OC phone numbers.")
model TeamsOcNumberConfig {
  @doc("The usage for this phone number.")
  usage: string;

  @doc("The choosable capabilities for this phone number.")
  choosableCapabilities: string[];

  @doc("The additional usages for this phone number.")
  additionalUsages?: string[];

  @doc("The ID of the civic address to be used as the emergency address for this phone number.")
  civicAddressId?: string;

  @doc("The ID of the location to be used as the emergency address for this phone number.")
  locationId?: string;

  @doc("If the enterprise is allowed to update the address for this phone number.")
  allowTenantAddressUpdate?: boolean = false;

  @doc("The country code to be displayed with this phone number")
  displayedCountryCode?: string;
}

@doc("Phone number configuration for Teams Phone Mobile phone numbers.")
model TeamsTpmNumberConfig {
  @doc("The usage for this phone number.")
  usage: string;

  @doc("The choosable capabilities for this phone number.")
  choosableCapabilities: string[];

  @doc("The additional usages for this phone number.")
  additionalUsages?: string[];

  @doc("The ID of the civic address to be used as the emergency address for this phone number.")
  civicAddressId?: string;

  @doc("The ID of the location to be used as the emergency address for this phone number.")
  locationId?: string;

  @doc("If the enterprise is allowed to update the address for this phone number.")
  allowTenantAddressUpdate?: boolean = false;

  @doc("The country code to be displayed with this phone number")
  displayedCountryCode?: string;
}

@doc("Indicates whether a number is assigned to a user. This is only relevant for some UC providers.")
enum AssignmentStatus {
  @doc("The phone number a TPM number and is assigned to a user.")
  TpmAssigned: "TPM Assigned",

  @doc("The phone number a TPM number and is not assigned to a user.")
  TpmUnassigned: "TPM Unassigned",

  @doc("The phone number is a Teams Operator Connect number and is assigned to a user.")
  OcAssigned: "OC Assigned",

  @doc("The phone number is a Teams Operator Connect number and is not assigned to a user.")
  OcUnassigned: "OC Unassigned",

  @doc("The phone number is not configured for use with any services that require the number to be assigned to a user.")
  NA: "Not Applicable"
}

@doc("The code and message for an error.")
model ErrorDetail {
  @doc("A machine readable error code.")
  code: string;

  @doc("A human readable representation of the error.")
  message: string;

  @doc("An array of details about specific errors that led to this error.")
  details?: ErrorDetail[];

  @doc("An object containing more specific information about the error.")
  innerError?: InnerError;
}

@doc("More specific information on an error object.")
model InnerError {
  @doc("A machine readable error code.")
  code?: string;

  @doc("Inner error details if they exist.")
  innerErrorString: string;
}

@doc("A provisioning error reported from a UC service.")
model ProvisioningError {
  @doc("The service the error relates to.")
  service: ServiceEnum;

  @doc("The error code returned from the service.")
  errorCode: string;

  @doc("The error message returned from the service.")
  message?: string;
}

@doc("Error details returned from the Teams API for queries passed through to Teams.")
model OcErrorDetails {
  @doc("The error code returned from the Teams API")
  code: string;

  @doc("The error message returned from the Teams API")
  message?: string;
}

@doc("Error body to return when requests to Teams API fails")
model OcErrorResponseBody {
  @doc("The error code returned by the Teams API.")
  code: string;

  @doc("The error message returned by the Teams API.")
  message: string;

  @doc("The error details returned from the Teams API.")
  details: OcErrorDetails[];
}

@doc("List of all service provisioning errors for the object.")
model ServiceProvisioningErrors {
  @doc("List of service provisioning errors.")
  allErrors: ProvisioningError[]
}

@doc("The provisioning states of an object on any relevant UC service.")
enum ServiceProvisioningState {
  @doc("The object is pending provisioning.")
  Pending: "Pending",

  @doc("The object has been provisioned in the relevnat UC service.")
  Success: "Success",

  @doc("The object provisioning operation failed with the relevant UC service.")
  Failed: "Failed",
}

@doc("Configuration specific to Teams Direct Routing.")
model TeamsDrConfig {
  @doc("Enables/disables caller ID screening for the account. Caller ID screening is enabled by default.")
  callScreening: boolean;

  @doc("Customer-specific domain name label. Can only contain letters, numbers, underscores and dashes. Can be up to 10 characters in length.")
  @minLength(1)
  @maxLength(10)
  @pattern("^([A-Za-z0-9_-]+)$")
  subdomain: string;

  @doc("DNS TXT value for the Direct Routing regions, as provided by the customer from their Microsoft 365 Admin Center.")
  subdomainTokens: TeamsDrSubdomainTokens;

  @doc("Status of DNS configuration and the DNS TXT values for the DNS records")
  subdomainProvisionedState?: DNSProvisioningState;

  @doc("DNS TXT value for the Direct Routing regions, as provided by the customer from their Microsoft 365 Admin Center.")
  actualSubdomainTokens?: TeamsDrSubdomainTokens;
}

@doc("Possible values for DNS provisioning state of Teams Direct Routing domains")
enum DNSProvisioningState {
  @doc("The DNS provisioning state Provisioned.")
  Provisioned: "Provisioned",

  @doc("The DNS provisioning state Not Provisioned.")
  NotProvisioned: "NotProvisioned",

  @doc("The DNS provisioning state Inconsistent.")
  Inconsistent: "Inconsistent"
}

@doc("DNS TXT value for the region, as provided by the customer from their Microsoft 365 Admin Center. Can only contain letters, numbers, underscores and dashes. Can be up to 100 characters in length.")
model TeamsDrSubdomainTokens {
  @doc("The DNS TXT value of the first region.")
  region1Token: TeamsDrSubdomainToken;

  @doc("The DNS TXT value of the second region.")
  region2Token: TeamsDrSubdomainToken;
}

@doc("A DNS TXT value.")
model TeamsDrSubdomainToken {
  @doc("DNS TXT value for the first region, as provided by the customer from their Microsoft 365 Admin Center. Can only contain letters, numbers, underscores and dashes. Can be up to 100 characters in length.")
  @minLength(1)
  @maxLength(100)
  @pattern("^([A-Za-z0-9=_-]+)$")
  token: string;
}

@doc("The provisioning state of Teams Direct Routing domains.")
model TeamsDrSubdomainProvisioningState {
  @doc("The DNS TXT values of the domains the state relates to.")
  teamsDrSubdomainTokens?: TeamsDrSubdomainTokens;

  @doc("The provisioning status of the domains.")
  teamsDrSubdomainStatus: DNSProvisioningState;
}

@doc("The UC service supported by the API.")
enum ServiceEnum {
  @doc("Teams Operator Connect.")
  Oc: "oc",

  @doc("Teams Phone Mobile.")
  Tpm: "tpm",

  @doc("Teams Direct Routing.")
  Dr: "dr",

  @doc("Zoom")
  Zoom: "zoom",
}

@doc("The Teams Service supported by this API that require provisioning in Teams.")
enum TeamsService {
  @doc("Teams Operator Connect.")
  Oc: "oc",

  @doc("Teams Phone Mobile.")
  Tpm: "tpm",
}

@doc("Configuration that is common for all Teams services on a given account.")
model TeamsCommonConfig {
  @doc("The Microsoft Teams Tenant ID of the Account. This can only be updated if no OC or TPM numbers are configured in this account.")
  tenantId: string;

  @doc("Is data provisioned through ACG being synced to Teams.")
  syncEnabled: boolean;
}

@doc("Indicating if the account should be syncing configuration from ACG to Teams.")
model TeamsSyncEnabled {
  @doc("Boolean indicating if account configuration is synced to Teams.")
  teamsSyncEnabledBool: boolean;
}

@doc("Account onfiguration specific to Teams Operator Connect.")
model TeamsOcConfig {
}

@doc("Account configuration specific to Teams Phone Mobile.")
model TeamsTpmConfig {
}

@doc("Account configuration specific to Zoom.")
model ZoomConfig {
}

@doc("A paginated list of RFI details.")
model RfiDetailsPaginatedList is PaginatedList<RfiDetails>{}

@doc("Details of an RFI.")
model RfiDetails {
  @doc("The ID of the Request for Information.")
  id?: string;

  @doc("The AAD tenant ID of the Request for Information.")
  tenantId?: string;

  @doc("Will always be 'teams'.")
  productContext?: string;

  @doc("The operator ID of the operator consent.")
  operatorId?: string;

  @doc("The status of the operator consent.")
  status?: RFIStatus;

  @doc("The time (ISO8601 format) when the operator consent is created.")
  consentedOn?: utcDateTime;

  @doc("The time (ISO8601 format) when the operator consent is last modified.")
  lastModifiedOn?: utcDateTime;

  @doc("The list of consented countries.")
  consentedCountries: string[];

  @doc("The list of tenant contacts.")
  contacts?: ContactDetails[];

  @doc("The customer relationship of the operator consent.")
  customerRelationship: CustomerRelationship;
}

@doc("The possible state for an RFI.")
enum RFIStatus {
  @doc("The RFI is active.")
  Active,

  @doc("The RFI is suspended.")
  Suspended,

  @doc("The RFI is removed.")
  Removed
}

@doc("Contact details for an individual.")
model ContactDetails {
  @doc("The full name of the contact detail.")
  @minLength(1)
  fullName: string;

  @doc("The email of the contact detail.")
  @minLength(1)
  email: string;

  @doc("The phone number of the contact detail.")
  phoneNumber?: string;

  @doc("The company name of the contact detail.")
  companyName?: string;

  @doc("The company size of the contact detail.")
  companySize?: string
}

@doc("Details of a customer relationship.")
model CustomerRelationship {
  @doc("The status of the customer relationship.")
  status: string;

  @doc("The time (ISO8601 format) when the customer relationship is last modified.")
  lastModifiedOn?: utcDateTime;

  @doc("The comment of the customer relationship.")
  comment: string;
}

@doc("A paginated list of civic addresses available for Teams OC or TPM users.")
model TeamsCivicAddressPaginatedList is PaginatedList<TeamsCivicAddress>{}

@doc("A civic address available for Teams OC or TPM users.")
model TeamsCivicAddress {
  @minLength(1)
  @doc("The ID of the civic address.")
  id: string;

  @doc("The country of the civic address.")
  country?: string;

  @doc("The house number of the civic address.")
  houseNumber?: string;

  @doc("The house number suffix of the civic address.")
  houseNumberSuffix?: string;

  @doc("The pre directional of the civic address.")
  preDirectional?: string;

  @doc("The street name of the civic address.")
  streetName?: string;

  @doc("The street suffix of the civic address.")
  streetSuffix?: string;

  @doc("The post directional of the civic address.")
  postDirectional?: string;

  @doc("The state or province of the civic address.")
  stateOrProvince?: string;

  @doc("The county or district of the civic address.")
  countyOrDistrict?: string;

  @doc("The city or town of the civic address.")
  cityOrTown?: string;

  @doc("The city or town alias of the civic address.")
  cityOrTownAlias?: string;

  @doc("The postal or zip code of the civic address.")
  postalOrZipCode?: string;

  @doc("The description of the civic address.")
  description?: string;

  @doc("The company name of the civic address.")
  companyName?: string;

  @doc("The company ID of the civic address.")
  companyId?: string;

  @minLength(1)
  @doc("The default location ID of the civic address.")
  defaultLocationId: string;

  @doc("The validation status of the civic address.")
  validationStatus?: ValidationStatus;

  @doc("The customer tenant ID of the civic address.")
  tenantId?: string;

  @doc("The partner ID of the civic address.")
  partnerId?: string;

  @doc("The list of locations associated with the civic address.")
  locations?: Location[];

  @doc("The latitude of the civic address.")
  latitude?: string;

  @doc("The longitude of the civic address.")
  longitude?: string;
}

@doc("The possible validation status of Teams Civic Addresses.")
enum ValidationStatus {
  @doc("The civic address is not validated.")
  NotValidated,

  @doc("The civic address is validated.")
  Validated
}

@doc("A location used by Team Operator Connect or Teams Phone Mobile phone numbers.")
model Location {
  @minLength(1)
  @doc("The ID of the location.")
  id: string;

  @minLength(1)
  @doc("The civic address ID of the location.")
  civicAddressId: string;

  @doc("The description of the location.")
  description?: string;

  @doc("The additional information of the location.")
  additionalInfo?: string;

  @doc("Flag indicating whether the location is default or not.")
  isDefault?: boolean;

  @doc("The elin of the location.")
  elin?: string;
}

@doc("Provides the custom '$skip' query parameter for list operations.")
model CustomSkipQueryParameter {
  @query("skip")
  @doc("The number of result items to skip.")
  @minValue(0)
  skip?: int32;
}

@doc("Provides the custom 'maxpagesize' query parameter for list operations.")
model CustomMaxPageSizeQueryParameter {
  @query("maxpagesize")
  @doc("The maximum number of result items per page.")
  @minValue(1)
  @maxValue(500)
  maxPageSize?: int32 = 200;
}

@doc("Provides the custom 'pageNumber' query parameter for list operations.")
model CustomPageNumberQueryParameter {
  @query("pagenumber")
  @doc("The page number of the current page.")
  @minValue(1)
  pageNumber?: int32 = 1;
}

@doc("Provides the custom 'filter' query parameter for list operations")
model CustomFilterQueryParameter {
  @query("filter")
  @doc("Filter the result list using the given expression")
  filter?: string;
}

alias ListQueryParameters = {
  ...CustomSkipQueryParameter;
  ...CustomMaxPageSizeQueryParameter;
  ...CustomPageNumberQueryParameter;
};

alias FilterListQueryParameters = {
  ...CustomFilterQueryParameter;
  ...ListQueryParameters;
};

//OPERATIONS

@route("/accounts")
@tag("Account")
@summary("Get list of Accounts")
@doc("Get list of Accounts with details. An Account represents an Enterprise or collection of users.")
op accounts(...FilterListQueryParameters, ...ApiVersionParameter): {
  @header contentType: "application/json";
  @body body: AccountResponsePaginatedList;
} | {
  @statusCode statusCode: 204;
} | {
  @statusCode statusCode: 500;
};

@route("/accounts/teamstenant/{tenantId}")
@tag("Account")
@summary("Get accounts with with Teams services using the specified Tenant ID")
@doc("Get accounts with with Teams services using the specified Tenant ID")
op getAccountsByTenant(
  ...ApiVersionParameter,

  @path
  @doc("The Teams tenant ID")
  tenantId: string): {
  @header contentType: "application/json";
  @body success: AccountResponsePaginatedList;
} | {
  @statusCode statusCode: 404;
} | {
  @statusCode statusCode: 500
};

@route("/accounts/{accountName}")
@tag("Account")
namespace Account {
  @get
  @summary("Get Account.")
  @doc("Get details of a specific Account using its Name. An Account represents an Enterprise or collection of users.")
  op get(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$")
    accountName: string,

    @path
    @doc("Additionally return the provisioning state of the backends configured for this account (e.g. DNS subdomain provisioning for Microsoft Teams Direct Routing).")
    status: boolean): {

    @header
    contentType: "application/json";

    @body success: AccountResponse;
  } | {
    @statusCode statusCode: 404;
    @header contentType: "application/json";
    @body error: ErrorDetail;
  } | {
    @statusCode statusCode: 500;
  };

  @put
  @summary("Create or update Account.")
  @doc("Create of update the details of an Account.")
  op put(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$")
    accountName: string,

    @header
    @doc("Makes a request conditional on a matching etag.")
    ifMatch?: string,

    @header
    @doc("Makes a request conditional on a non-matching etag.")
    ifNoneMatch?: string,

    @header
    @doc("The content type of the reqeust body.")
    contentType: "application/json",

    @body
    @doc("The details of the account to create")
    body: AccountDetails): {
    @header contentType: "application/json";
    @body success: AccountResponse;
  } | {
    @statusCode statusCode: 201;
    @header contentType: "application/json";
    @body body: AccountResponse;
  } | {
    @statusCode statusCode: 400 | 404 | 409 | 412;
    @header contentType: "application/json";
    @body error: ErrorDetail;
  } | {
    @statusCode statusCode: 500;
  };

  @patch
  @summary("Create or update Account.")
  @doc("Create of update the details of an Account.")
  op patch(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$")
    accountName: string,

    @header
    @doc("Makes a request conditional on a matching etag.")
    ifMatch?: string,

    @header
    @doc("Makes a request conditional on a non-matching etag.")
    ifNoneMatch?: string,

    @header
    @doc("The content type for the request body.")
    contentType: "application/json",

    @body
    @doc("The Account to create or update.")
    account: AccountDetails): {
    @header contentType: "application/json";
    @body success: AccountResponse;
  } | {
    @statusCode statusCode: 201;
    @header contentType: "application/json";
    @body success: AccountResponse;
  } | {
    @statusCode statusCode: 400 | 404 | 409 | 412;
    @header contentType: "application/json";
    @body error: ErrorDetail;
  } | {
    @statusCode statusCode: 500;
  };

  @delete
  @summary("Delete Account.")
  @doc("Delete a specific Account using its Name. This will fail if any Numbers are provisioned on the Account.")
  op delete(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    @doc("Indicates if all subscribers under the account should also be deleted.")
    @query deleteAllSubs?: boolean
  ) : {
    @statusCode statusCode: 204;
  } | {
    @statusCode statusCode: 400;
    @header contentType: "application/json";
    @body error: ErrorDetail;
  } | {
    @statusCode statusCode: 500;
  };
}

@route("/account/{accountName}")
namespace Accounts {
  @route("/numbers/batch")
  @tag("BatchNumbers")
  @summary("Create or update Numbers.")
  @doc("Create or update up to 100 Numbers on the specified account. Each Number must have a UC service enabled and other configuration.")
  @patch
  op patchBatchNumbers(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$")
    accountName: string,

    @header
    @doc("The content type of the request body.")
    contentType: "application/json",

    @body
    @doc("The numbers to upload in a batch.")
    body: BatchNumbersPut
  ) : {
    @header contentType: "application/json";
    @body success: BatchNumbersResponse;
  } | {
    @statusCode statusCode: 400 | 404;
    @header contentType: "application/json";
    @body error: ErrorDetail;
  } | {
    @statusCode statusCode: 500
  };

  @delete
  @route("/numbers/batch")
  @tag("BatchNumbers")
  @summary("Delete batches of numbers.")
  @doc("Delete up to 100 numbers on the specified account.")
  op deleteBatchNumbers(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$")
    accountName: string,

    @header
    @doc("The content type for the request body.")
    contentType: "application/json",

    @body
    @doc("The phone numbers to delete.")
    account: BatchNumbersDelete
  ) : {
    @statusCode statusCode: 204
  } | {
    @statusCode statusCode: 400;
    @header contentType: "application/json";
    @body error: ErrorDetail;
  } | {
    @statusCode statusCode: 500
  };

  @route("/numbers")
  @tag("Number")
  @summary("Get list of Numbers on an Account.")
  @doc("Get a list of Numbers on the specified Account. The returned list is paginated.")
  op getNumbers(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    ...FilterListQueryParameters): {
    @header contentType: "application/json";
    @body success: NumberResponsePaginatedList;
  } | {
    @statusCode statusCode: 204;
  } | {
    @statusCode statusCode: 404;
    @header contentType: "application/json";
    @body error: ErrorDetail;
  } | {
    @statusCode statusCode: 500;
  };

  @route("/numbers/{phoneNumber}")
  @tag("Number")
  @summary("Get a Number")
  @doc("Get details of a specific Number associated with an Account.")
  op getPhoneNumbers(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$")
    accountName: string,

    @path
    @doc("The phone numberto get configuration for.")
    @minLength(3)
    @maxLength(16)
    @pattern("^\\+[1-9]\\d{1,14}$")
    phoneNumber: string): {
    @header contentType: "application/json";
    @body success: NumberResponse;
  } | {
    @statusCode statusCode: 404;
    @header contentType: "application/json";
    @body error: ErrorDetail;
  } | {
    @statusCode statusCode: 500;
  };

  @route("/numbers/{phoneNumber}")
  @tag("Number")
  @summary("Create or update a Number.")
  @doc("Create or update a Number on the specified Account. The Number must have a UC service enabled and other configuration.")
  @put
  op putPhoneNumbers(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$")
    accountName: string,

    @path
    @doc("The phone number to request details of.")
    @minLength(3)
    @maxLength(16)
    @pattern("^\\+[1-9]\\d{1,14}$")
    phoneNumber: string,

    @header
    @doc("Makes a request conditional on a matching etag.")
    ifMatch?: string,

    @header
    @doc("Makes a request conditional on a non-matching etag.")
    ifNoneMatch?: string,

    @header
    @doc("The contenct type for the request.")
    contentType: "application/json",

    @body
    @doc("The number details for the phone numbers to upload.")
    body: NumberDetails): {
      @header contentType: "application/json";
      @body success: NumberResponse;
  } | {
    @header contentType: "application/json";
    @body success: NumberResponse;
    @statusCode statusCode: 201
  } | {
    @statusCode statusCode: 400 | 404 | 409 | 412;
    @header contentType: "application/json";
    @body error: ErrorDetail;
  } | {
    @statusCode statusCode: 500;
  };

  @route("/numbers/{phoneNumber}")
  @tag("Number")
  @summary("Delete Number")
  @doc("Delete a Number on the specified Account.")
  @delete
  op deletePhoneNumbers(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$")
    accountName: string,

    @path
    @doc("The phone number of the number to delete.")
    @minLength(3)
    @maxLength(16)
    @pattern("^\\+[1-9]\\d{1,14}$")
    phoneNumber: string) : {
      @statusCode statusCode: 204;
  } | {
    @statusCode statusCode: 400;
    @header contentType: "application/json";
    @body error: ErrorDetail;
  } | {
    @statusCode statusCode: 500;
  };

  @route("/teams/civic-address/{civicAddressId}")
  @summary("Get a Civic Address.")
  @doc("Get a specific Civic Address and its associated locations.")
  op getTeamsCivicAddress(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$")
    accountName: string,

    @path
    @doc("The ID of the civic address to retrieve.")
    civicAddressId: string,
  ) : {
    @header contentType: "application/json";
    @body success: TeamsCivicAddress;
  } | {
    @statusCode statusCode: 400;
    @header contentType: "application/json";
    @body error: OcErrorResponseBody;
  } | {
    @statusCode statusCode: 404;
  } | {
    @statusCode statusCode: 500;
    @header contentType: "application/json";
    @body error: OcErrorResponseBody;
  };

  @route("/teams/civic-addresses")
  @summary("Get a list of Civic Addresses.",)
  @doc("Get a list of Civic Addresses and its associated locations for a specific Account. The returned list is paginated.")
  op getTeamsCivicAddresses(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$")
    accountName: string,

    ...FilterListQueryParameters
  ) : {
    @header contentType: "application/json";
    @body success: TeamsCivicAddressPaginatedList;
  } | {
    @statusCode statusCode: 400;
    @header contentType: "application/json";
    @body error: OcErrorResponseBody;
  } | {
    @statusCode statusCode: 500;
    @header contentType: "application/json";
    @body error: OcErrorResponseBody;
  };

  @route("/teams/capabilities/")
  @summary("Get the list of usages available")
  @doc("Get a list of usages that can be used by a partner for teams enabled number. Returned as JSON mapping use case to capabilities")
  @get
  op getCapabilities(
    ...ApiVersionParameter,

    @path
    @doc("The account name to query.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$")
    accountName: string,

    @header
    @doc("The contenct type for the request.")
    contentType: "application/json",

    @body
    @doc("The phone numbers to query capabilities for.")
    phoneNumbers: PhoneNumbers
  ): {
    @header contentType: "application/json";
    @body success: TeamsCapabilitiesPaginatedList;
  } | {
    @statusCode statusCode: 400 | 404;
  } | {
    @statusCode statusCode: 500;
  };

  @route("/teams/sync")
  @tag("TeamsSync")
  @summary("Enable or disable syncing of provisioned data to Teams")
  @doc("Enable or disable syncing of provisioned data to Teams")
  @post
  op setTeamsSync(
    ...ApiVersionParameter,

    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$")
    accountName: string,

    @header
    @doc("The contenct type for the request.")
    contentType: "application/json",

    @body
    @doc("JSON to indicate if data should by synced to Teams.")
    body: TeamsSyncEnabled): {
    @statusCode statusCode: 200;
  } | {
    @statusCode statusCode: 400;
  } | {
    @statusCode statusCode: 500;
  };
}

@route("/numbers")
@tag("Numbers")
namespace NumbersFromAllAccounts {
  @summary("Get list of numbers")
  @doc("Get a list of Numbers from all Accounts. The returned list is paginated.")
  op listAllNumbers(
    ...FilterListQueryParameters,
    ...ApiVersionParameter,

    @query
    @doc("Query information for a specific number.")
    @pattern("^\\+[1-9]\\d+$")
    @minLength(1)
    @maxLength(16)
    number: string): {
    @header contentType: "application/json";
    @body success: NumberResponsePaginatedList;
  } | {
    @statusCode statusCode: 204;
  } | {
    @statusCode statusCode: 500;
  };
}

@route("/teams/rfis")
@tag("RFIs")
namespace Rfis {
  @summary("Get list of Requests for Information (Consents).")
  @doc("Get the list of Accounts that have submitted a Request for Information (i.e. have consented to being contacted).")
  op getRfis(
    ...ApiVersionParameter,

    @query
    @doc("The Teams product context for the RFIs.")
    productContext?: string,

    ...FilterListQueryParameters): {
    @header contentType: "application/json";
    @body success: RfiDetailsPaginatedList;
  } | {
    @statusCode statusCode: 204;
  } | {
    @statusCode statusCode: 500;
  };
}

@route("/teams/rfi/{tenantId}")
@tag("RFI")
namespace Rfi {
  @summary("Get an RFI by tenant ID")
  @doc("Get a specific RFT from the tenant ID.")
  @get
  op getRfiByTenant(
    ...ApiVersionParameter,

    @path
    @doc("The tenant ID of the RFI.")
    tenantId: string,
  ): {
    @header contentType: "application/json";
    @body success: RfiDetails;
  } | {
    @statusCode statusCode: 404;
  } | {
    @statusCode statusCode: 500;
  };

  @route("/customer-relationship")
  @summary("Update the Customer Relationship.")
  @doc("Update the Customer Relationship on the specified RFI.")
  @put
  op updateCustomerRelationship(
    ...ApiVersionParameter,

    @path
    @doc("The tenant ID of the RFI.")
    tenantId: string,

    @header
    @doc("The contenct type for the request.")
    contentType: "application/json",

    @body
    @doc("The customer relationship to insert.")
    body: CustomerRelationship
  ) : {
    @header contentType: "application/json";
    @body success: CustomerRelationship;
  } | {
    @statusCode statusCode: 400 | 404 | 409 | 412;
    @header contentType: "application/json";
    @body error: ErrorDetail;
  } | {
    @statusCode statusCode: 500;
  };
}
