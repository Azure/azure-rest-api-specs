import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Confluent;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provision states for confluent RP")
enum ProvisionState {
  Accepted,
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
  Deleted,
  NotSpecified,
}

@doc("SaaS Offer Status for confluent RP")
enum SaaSOfferStatus {
  Started,
  PendingFulfillmentStart,
  InProgress,
  Subscribed,
  Suspended,
  Reinstated,
  Succeeded,
  Failed,
  Unsubscribed,
  Updating,
}

@doc("Response of a list operation.")
model ConfluentAgreementResourceListResponse
  is Azure.Core.Page<ConfluentAgreementResource>;

@doc("Agreement Terms definition")
model ConfluentAgreementResource {
  @doc("The ARM id of the resource.")
  @visibility("read")
  id?: string;

  @doc("The name of the agreement.")
  @visibility("read")
  name?: string;

  @doc("The type of the agreement.")
  @visibility("read")
  type?: string;

  @doc("Metadata pertaining to creation and last modification of the resource")
  @visibility("read")
  systemData?: SystemData;

  @doc("Represents the properties of the resource.")
  properties?: ConfluentAgreementProperties;
}

@doc("Terms properties for Marketplace and Confluent.")
model ConfluentAgreementProperties {
  @doc("Publisher identifier string.")
  publisher?: string;

  @doc("Product identifier string.")
  product?: string;

  @doc("Plan identifier string.")
  plan?: string;

  @doc("Link to HTML with Microsoft and Publisher terms.")
  licenseTextLink?: string;

  @doc("Link to the privacy policy of the publisher.")
  privacyPolicyLink?: string;

  @doc("Date and time in UTC of when the terms were accepted. This is empty if Accepted is false.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retrieveDatetime?: utcDateTime;

  @doc("Terms signature.")
  signature?: string;

  @doc("If any version of the terms have been accepted, otherwise false.")
  accepted?: boolean;
}

@doc("Default error response for resource provider")
@error
model ResourceProviderDefaultErrorResponse {
  @doc("Response body of Error")
  @visibility("read")
  error?: ErrorResponseBody;
}

@doc("Response body of Error")
model ErrorResponseBody {
  @doc("Error code")
  @visibility("read")
  code?: string;

  @doc("Error message")
  @visibility("read")
  message?: string;

  @doc("Error target")
  @visibility("read")
  target?: string;

  @doc("Error detail")
  @visibility("read")
  details?: ErrorResponseBody[];
}

@doc("Organization resource property")
model OrganizationResourceProperties {
  @doc("The creation time of the resource.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("Provision states for confluent RP")
  @visibility("read")
  provisioningState?: ProvisionState;

  @doc("Id of the Confluent organization.")
  @visibility("read")
  organizationId?: string;

  @doc("SSO url for the Confluent organization.")
  @visibility("read")
  ssoUrl?: string;

  @doc("Confluent offer detail")
  offerDetail: OfferDetail;

  @doc("Subscriber detail")
  userDetail: UserDetail;
}

@doc("Confluent Offer detail")
model OfferDetail {
  @doc("Publisher Id")
  @maxLength(50)
  publisherId: string;

  @doc("Offer Id")
  @maxLength(50)
  id: string;

  @doc("Offer Plan Id")
  @maxLength(50)
  planId: string;

  @doc("Offer Plan Name")
  @maxLength(50)
  planName: string;

  @doc("Offer Plan Term unit")
  @maxLength(25)
  termUnit: string;

  @doc("SaaS Offer Status")
  @visibility("read")
  status?: SaaSOfferStatus;
}

@doc("Subscriber detail")
model UserDetail {
  @doc("First name")
  @maxLength(50)
  firstName?: string;

  @doc("Last name")
  @maxLength(50)
  lastName?: string;

  @doc("Email address")
  @pattern("^\\S+@\\S+\\.\\S+$")
  emailAddress: string;
}

@doc("Organization Resource update")
model OrganizationResourceUpdate {
  @doc("ARM resource tags")
  tags?: Record<string>;
}

@doc("An Confluent REST API operation.")
model OperationResult {
  @doc("Operation name: {provider}/{resource}/{operation}")
  name?: string;

  @doc("The object that represents the operation.")
  display?: OperationDisplay;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;
}
