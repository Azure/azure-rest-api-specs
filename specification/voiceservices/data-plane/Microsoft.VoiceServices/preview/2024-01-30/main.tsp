import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.contoso.com/common/oauth2/v2.0/authorize",
      scopes: ["https://widget.contoso.com/.default"],
    }
  ]>
)
@service({
  title: "Microsoft.VoiceServices.ACG.ProvisioningPlatform.API",
})
@versioned(Microsoft.Voiceservices.Versions)

namespace Microsoft.Voiceservices;

@doc("The Microsoft.Voiceservices service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2024-01-30-preview version of the Microsoft.Voiceservices service.")
  `2024-01-30-preview`,
}

/* This is not used directly, is just to simplify the code */
model AccountName {
  @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
  @minLength(1)
  @maxLength(100)
  @pattern("^([A-Za-z0-9_-]+)$")
  accountName: string;
}

/* This is not used directly, is just to simplify the code */
model PhoneNumber {
  @doc("Phone number in E.164 format.")
  @minLength(3)
  @maxLength(16)
  @pattern("^\\+[1-9]\\d{1,14}$")
  phoneNumber: string;
}

/* This is not used directly, is just to simplify the code */
model CustomSipHeader {
  @doc("Contents of the custom SIP header to use with this number. Can only contain letters, numbers, underscores and dashes. Can be up to 100 characters in length. The name of the custom header is set as part of deploying Azure Communications Gateway.")
  @minLength(1)
  @maxLength(100)
  @pattern("^([A-Za-z0-9_-])+$")
  customSipHeader: string;
}

@doc("Details of the account.")
model AccountDetails {
  ...AccountName;

  @doc("The opaque correlator id for this account.")
  correlatorId: string;

  // TODO: finalise requirements on this.
  // @doc("Default preferred region for numbers under this account.")
  // defaultPreferredRegion?: string | null;

  @doc("Teams Common Account Configuration required for OC and TPM")
  teamsCommonConfig?: TeamsCommonConfig;

  @doc("Indicates that Teams Operator Connect (OC) is enabled for this account.")
  teamsOcEnabled: boolean;

  @doc("Count of Teams Operator Connect subscribers for this account.")
  teamsOcSubCount: int64;

  @doc("Teams Operator Connect (OC) Account Configuration. Only accepted if OC is enabled.")
  teamsOcConfig?: TeamsOcConfig;

  @doc("Indicates that Teams Direct Routing (DR) enabled for this account.")
  teamsDrEnabled: boolean;

  @doc("Count of Teams Direct Routing subscribers for this account.")
  teamsDrSubCount: int64;

  @doc("Teams Direct Routing (DR) Account Configuration. Only accepted if DR is enabled.")
  teamsDrConfig?: TeamsDrConfig;

  @doc("Indicates that Teams Phone Mobile (TPM) is enabled for this account.")
  teamsTpmEnabled: boolean;

  @doc("Count of Teams Phone Mobile subscribers for this account.")
  teamsTpmSubCount: int64;

  @doc("Teams Phone Mobile (TPM) Account Configuration. Only accepted if TPM is enabled.")
  teamsTpmConfig?: TeamsTpmConfig;

  @doc("Indicates that Zoom is enabled for this account.")
  zoomEnabled: boolean;

  @doc("Count of Zoom subscribers for this account.")
  zoomSubCount: int64;

  @doc("Zoom Account Configuration. Only accepted if Zoom is enabled.")
  zoomConfig?: ZoomConfig;
}

@doc("Details of the account as returned on a GET request.")
model AccountResponse {
  @doc("Name of the account.")
  @minLength(1)
  name: string;

  details?: AccountDetails;
  @doc("ETag for use with If-Match headers for optimistic concurrency.")
  etag?: string;

  @doc("Status of syncing changes to this object to relevant backend services.")
  serviceProvisioningStatus: ServiceProvisioningState;

  @doc("Error messages where syncing to UC services has failed.")
  serviceProvisioningErrors?: ServiceProvisioningErrors;
}

model PaginatedList<T> {
  @doc("The list of records for this page.")
  value: T[];
  @doc("Link to the next page (if appropriate).")
  nextLink?: string;
}

model AccountResponsePaginatedList is PaginatedList<AccountResponse>{}

model BatchNumbersPut {
  @maxItems(100)
  numbers: BatchNumbersPutItem[];
}

model BatchNumbersPutItem {
  ...PhoneNumber;
  details: NumberDetails;
}

model BatchNumbersDelete {
  @maxItems(100)
  numbers: PhoneNumber[]
}

model BatchNumbersResponse {
  numbers: NumberResponse[];
}

model NumberDetails {
  ...PhoneNumber;
  services: NumberServices;
  ...CustomSipHeader;

  // TODO: finalise requirements on this.
  // @doc("Preferred region for this number.")
  // preferredRegion?: string | null;
}

model NumberResponse {
  ...PhoneNumber;
  ...AccountName;
  details: NumberDetails;
  status: NumberStatus;
  Etag?: string | null;
  serviceProvisioningStatus: ServiceProvisioningState;
  serviceProvisioningErrors?: ServiceProvisioningErrors;
}

model NumberResponsePaginatedList is PaginatedList<NumberResponse>{}

model NumberServices {

  @doc("Indicates that Teams Operator Connect (OC) is enabled for this number.")
  teamsOcEnabled: boolean;

  @doc("Teams Operator Connect (OC) Number Configuration")
  teamsOcConfig?: TeamsOcNumberConfig;

  @doc("Indicates that Teams Direct Routing (DR) is enabled for this number.")
  teamsDrEnabled: boolean;

  @doc("Teams Phone Mobile (TPM) Number Configuration")
  teamsTpmConfig?: TeamsTpmNumberConfig;

  @doc("Indicates that Teams Phone Mobile (TPM) is enabled for this number.")
  teamsTpmEnabled: boolean;

  @doc("Indicates that Zoom is enabled for this number.")
  zoomEnabled: boolean;
}

@doc("The Teams capabilities available for numbers with OC or TPM services enabled.")
model TeamsCapabilities {
  name: string;
  offerTypes: string[];
  mandatoryCapabilities: string[];
  choosableCapabilities: string[];
  supportsTollFree: boolean;
}

model TeamsCapabilitiesPaginatedList is PaginatedList<TeamsCapabilities>{}

model TeamsOcNumberConfig {
  usage: string;
  choosableCapabilities: string[];
  additionalUsages?: string[];
  civicAddressId?: string;
  locationId?: string;
  allowTenantAddressUpdate?: boolean = false;
  displayedCountryCode?: string;
}

model TeamsTpmNumberConfig {
  usage: string;
  choosableCapabilities: string[];
  additionalUsages?: string[];
  civicAddressId?: string;
  locationId?: string;
  allowTenantAddressUpdate?: boolean = false;
  displayedCountryCode?: string;
}

model NumberStatus {
  teamsOcNumberStatus?: TeamsOcNumberStatus;
  teamsTpmNumberStatus?: TeamsTpmNumberStatus;
}

model TeamsOcNumberStatus {
  assignmentStatus: string;
}

model TeamsTpmNumberStatus {
  assignmentStatus: string;
}

model ProblemDetails {
  type?: string;
  title?: string;
  status?: int32;
  detail?: string;
  instance?: string;
}

model ProvisioningError {
  service: ServiceEnum;
  errorCode: string;
  message: string;
}

@doc("Error details returned from the Teams API")
model OcErrorDetails {
  code: string;
  message: string;
}

@doc("Error body to return when requests to Teams API fails")
model OcErrorResponseBody {
  code: string;
  message: string;
  details: OcErrorDetails[];
}

model ServiceProvisioningErrors {
  allErrors: ProvisioningError[]
}

enum ServiceProvisioningState {
  Pending: "Pending",
  Success: "Success",
  Failed: "Failed",
}

model TeamsDrConfig {
  @doc("Enables/disables caller ID screening for the account. Caller ID screening is enabled by default.")
  callScreening: boolean;

  @doc("Customer-specific domain name label. Can only contain letters, numbers, underscores and dashes. Can be up to 10 characters in length.")
  @minLength(1)
  @maxLength(10)
  @pattern("^([A-Za-z0-9_-]+)$")
  subdomain: string;

  subdomainTokens: TeamsDrSubdomainTokens;
  subdomainProvisionedState?: DNSProvisioningState;
  actualSubdomainTokens?: TeamsDrSubdomainTokens;
}

enum DNSProvisioningState {
  "0": 0,
  "1": 1,
  "2": 2
}

@doc("DNS TXT values (tokens) for the account.")
model TeamsDrSubdomainTokens {
  @doc("DNS TXT value for the first region, as provided by the customer from their Microsoft 365 Admin Center. Can only contain letters, numbers, underscores and dashes. Can be up to 100 characters in length.")
  @minLength(1)
  @maxLength(100)
  @pattern("^([A-Za-z0-9=_-]+)$")
  region1Token: string;

  @doc("DNS TXT value for the first region, as provided by the customer from their Microsoft 365 Admin Center. Can only contain letters, numbers, underscores and dashes. Can be up to 100 characters in length.")
  @minLength(1)
  @maxLength(100)
  @pattern("^([A-Za-z0-9=_-]+)$")
  region2Token: string;
}

enum ServiceEnum {
  Oc: "oc",
  Tpm: "tpm",
  Dr: "dr",
  Zoom: "zoom",
}

enum TeamsService {
  Oc: "oc",
  Tpm: "tpm",
}

model TeamsCommonConfig {
  @doc("The Microsoft Teams Tenant ID of the Account. This can only be updated if no OC or TPM numbers are configured in this account.")
  tenantId: string;

  @doc("Is data provisioned through ACG being synced to Teams.")
  syncEnabled: boolean;
}

model TeamsSyncEnabled {
  teamsSyncEnabled: boolean;
}

model TeamsOcConfig {
}

model TeamsTpmConfig {
}

model ZoomConfig {
}

model RFIDetailsPaginatedList is PaginatedList<RFIDetails>{}

model RFIDetails {
  @doc("The ID of the Request for Information.")
  id?: string;
  @doc("The AAD tenant ID of the Request for Information.")
  tenantId?: string;
  @doc("Will always be 'teams'.")
  productContext?: string;
  @doc("The operator ID of the operator consent.")
  operatorId?: string;
  @doc("The status of the operator consent.")
  status?: RFIStatus | null;
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

enum RFIStatus {
  Active,
  Suspended,
  Removed
}

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

model CustomerRelationship {
  @doc("The status of the customer relationship.")
  status: string;
  @doc("The time (ISO8601 format) when the customer relationship is last modified.")
  lastModifiedOn?: utcDateTime;
  @doc("The comment of the customer relationship.")
  comment: string;
}

model TeamsCivicAddressPaginatedList is PaginatedList<TeamsCivicAddress>{}

model TeamsCivicAddress {
  @minLength(1)
  @doc("The ID of the civic address.")
  id: string;
  @doc("The country of the civic address.")
  country?: string | null;
  @doc("The house number of the civic address.")
  houseNumber?: string | null;
  @doc("The house number suffix of the civic address.")
  houseNumberSuffix?: string | null;
  @doc("The pre directional of the civic address.")
  preDirectional?: string | null;
  @doc("The street name of the civic address.")
  streetName?: string | null;
  @doc("The street suffix of the civic address.")
  streetSuffix?: string | null;
  @doc("The post directional of the civic address.")
  postDirectional?: string | null;
  @doc("The state or province of the civic address.")
  stateOrProvince?: string | null;
  @doc("The county or district of the civic address.")
  countyOrDistrict?: string | null;
  @doc("The city or town of the civic address.")
  cityOrTown?: string | null;
  @doc("The city or town alias of the civic address.")
  cityOrTownAlias?: string | null;
  @doc("The postal or zip code of the civic address.")
  postalOrZipCode?: string | null;
  @doc("The description of the civic address.")
  description?: string | null;
  @doc("The company name of the civic address.")
  companyName?: string | null;
  @doc("The company ID of the civic address.")
  companyId?: string | null;
  @minLength(1)
  @doc("The default location ID of the civic address.")
  defaultLocationId: string;
  @doc("The validation status of the civic address.")
  validationStatus?: ValidationStatus | null;
  @doc("The customer tenant ID of the civic address.")
  tenantId?: string | null;
  @doc("The partner ID of the civic address.")
  partnerId?: string | null;
  @doc("The list of locations associated with the civic address.")
  locations?: Location[];
  @doc("The latitude of the civic address.")
  latitude?: string | null;
  @doc("The longitude of the civic address.")
  longitude?: string | null;
}

enum ValidationStatus {
  NotValidated,
  Validated
}

model Location {
  @minLength(1)
  @doc("The ID of the location.")
  id: string;
  @minLength(1)
  @doc("The civic address ID of the location.")
  civicAddressId: string;
  @doc("The description of the location.")
  description?: string | null;
  @doc("The additional information of the location.")
  additionalInfo?: string | null;
  @doc("Flag indicating whether the location is default or not.")
  isDefault?: boolean;
  @doc("The elin of the location.")
  elin?: string | null;
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
  maxPageSize?: int32 = 10;
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
op accounts(...FilterListQueryParameters): {
  @header contentType: "application/json";
  @body success: AccountResponsePaginatedList;
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
    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string): {
    @header contentType: "application/json";
    @body success: AccountResponse;
  } | {
    @statusCode statusCode: 404;
    @header contentType: "application/json";
    @body error: ProblemDetails;
  } | {
    @statusCode statusCode: 500;
  };

  @put
  @summary("Create or update Account.")
  @doc("Create of update the details of an Account.")
  op put(
    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    @header ifMatch?: string,
    @header ifNoneMatch?: string,
    @header contentType: "application/json",
    @body account: AccountDetails): {
    @header contentType: "application/json";
    @body success: AccountResponse;
  } | {
    @statusCode statusCode: 400 | 404 | 409 | 412;
    @header contentType: "application/json";
    @body error: ProblemDetails;
  } | {
    @statusCode statusCode: 500;
  };

  @patch
  @summary("Create or update Account.")
  @doc("Create of update the details of an Account.")
  op patch(
    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    @header ifMatch?: string,
    @header ifNoneMatch?: string,
    @header contentType: "application/json",
    @body account: AccountDetails): {
    @header contentType: "application/json";
    @body success: AccountResponse;
  } | {
    @statusCode statusCode: 201;
    @header contentType: "application/json";
    @body success: AccountResponse;
  } | {
    @statusCode statusCode: 400 | 404 | 409 | 412;
    @header contentType: "application/json";
    @body error: ProblemDetails;
  } | {
    @statusCode statusCode: 500;
  };

  @delete
  @summary("Delete Account.")
  @doc("Delete a specific Account using its Name. This will fail if any Numbers are provisioned on the Account.")
  op delete(
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
    @body error: ProblemDetails;
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
    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    @header contentType: "application/json",
    @body account: BatchNumbersPut
  ) : {
    @header contentType: "application/json";
    @body success: BatchNumbersResponse;
  } | {
    @statusCode statusCode: 400 | 404;
    @header contentType: "application/json";
    @body error: ProblemDetails;
  } | {
    @statusCode statusCode: 500
  };

  @delete
  @route("/numbers/batch")
  @tag("BatchNumbers")
  @summary("Delete batches of numbers")
  @doc("Delete up to 100 numbers on the specified account")
  op deleteBatchNumbers(
    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    @header contentType: "application/json",
    @body account: BatchNumbersDelete
  ) : {
    @statusCode statusCode: 204
  } | {
    @statusCode statusCode: 400;
    @header contentType: "application/json";
    @body error: ProblemDetails;
  } | {
    @statusCode statusCode: 500
  };

  @route("/numbers")
  @tag("Number")
  @summary("Get list of Numbers on an Account.")
  @doc("Get a list of Numbers on the specified Account. The returned list is paginated.")
  op getNumbers(
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
    @body error: ProblemDetails;
  } | {
    @statusCode statusCode: 500;
  };

  @route("/numbers/{phoneNumber}")
  @tag("Number")
  @summary("Get a Number")
  @doc("Get details of a specific Number associated with an Account.")
  op getPhoneNumbers(
    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    @path phoneNumber: string): {
    @header contentType: "application/json";
    @body success: NumberResponse;
  } | {
    @statusCode statusCode: 404;
    @header contentType: "application/json";
    @body error: ProblemDetails;
  } | {
    @statusCode statusCode: 500;
  };

  @route("/numbers/{phoneNumber}")
  @tag("Number")
  @summary("Create or update a Number.")
  @doc("Create or update a Number on the specified Account. The Number must have a UC service enabled and other configuration.")
  @put
  op putPhoneNumbers(
    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    @path phoneNumber: string,
    @header ifMatch?: string,
    @header ifNoneMatch?: string,
    @header contentType: "application/json",
    @body account: NumberDetails): {
      @header contentType: "application/json";
      @body success: NumberResponse;
  } | {
    @header contentType: "application/json";
    @body success: NumberResponse;
    @statusCode statusCode: 201
  } | {
    @statusCode statusCode: 400 | 404 | 409 | 412;
    @header contentType: "application/json";
    @body error: ProblemDetails;
  } | {
    @statusCode statusCode: 500;
  };

  @route("/numbers/{phoneNumber}")
  @tag("Number")
  @summary("Delete Number")
  @doc("Delete a Number on the specified Account.")
  @delete
  op deletePhoneNumbers(
    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    @path phoneNumber: string) : {
      @statusCode statusCode: 204;
  } | {
    @statusCode statusCode: 400;
    @header contentType: "application/json";
    @body error: ProblemDetails;
  } | {
    @statusCode statusCode: 500;
  };

  @route("/teams/civic-address/{civicAddressId}")
  @summary("Get a Civic Address.")
  @doc("Get a specific Civic Address and its associated locations.")
  op getTeamsCivicAddress(
    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    @path civicAddressId: string,
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
    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    FilterListQueryParameters: int32
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
    @path
    @doc("The account name to query.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    @query
    @doc("The Teams service to query capabilities for.") teamsServiceType?: TeamsService
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
    @path
    @doc("Name of the account. Can only contain letters, numbers, underscores and dashes, and is case-sensitive. Can be up to 100 characters in length.")
    @minLength(1)
    @maxLength(100)
    @pattern("^([A-Za-z0-9_-]+)$") accountName: string,
    @header contentType: "application/json",
    @body account: TeamsSyncEnabled): {
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
    ...FilterListQueryParameters): {
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
    @query productContext?: string,
    ...FilterListQueryParameters): {
    @header contentType: "application/json";
    @body success: RFIDetailsPaginatedList;
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
    @path
    @doc("The tenant ID of the RFI.") tenantId: string,
  ): {
    @header contentType: "application/json";
    @body success: RFIDetails;
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
    @path
    @doc("The tenant ID of the RFI.") tenantId: string,
    @header contentType: "application/json",
    @body account: CustomerRelationship
  ) : {
      @header contentType: "application/json";
    @body success: CustomerRelationship;
  } | {
    @statusCode statusCode: 400 | 404 | 409 | 412;
    @header contentType: "application/json";
    @body error: ProblemDetails;
  } | {
    @statusCode statusCode: 500;
  };
}
