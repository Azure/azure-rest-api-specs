import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Confluent;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provision states for confluent RP
 */
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

/**
 * SaaS Offer Status for confluent RP
 */
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

/**
 * Response of a list operation.
 */
model ConfluentAgreementResourceListResponse
  is Azure.Core.Page<ConfluentAgreementResource>;

/**
 * Agreement Terms definition
 */
model ConfluentAgreementResource {
  /**
   * The ARM id of the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the agreement.
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the agreement.
   */
  @visibility("read")
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource
   */
  @visibility("read")
  systemData?: SystemData;

  /**
   * Represents the properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConfluentAgreementProperties;
}

/**
 * Terms properties for Marketplace and Confluent.
 */
model ConfluentAgreementProperties {
  /**
   * Publisher identifier string.
   */
  publisher?: string;

  /**
   * Product identifier string.
   */
  product?: string;

  /**
   * Plan identifier string.
   */
  plan?: string;

  /**
   * Link to HTML with Microsoft and Publisher terms.
   */
  licenseTextLink?: string;

  /**
   * Link to the privacy policy of the publisher.
   */
  privacyPolicyLink?: string;

  /**
   * Date and time in UTC of when the terms were accepted. This is empty if Accepted is false.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retrieveDatetime?: utcDateTime;

  /**
   * Terms signature.
   */
  signature?: string;

  /**
   * If any version of the terms have been accepted, otherwise false.
   */
  accepted?: boolean;
}

/**
 * Default error response for resource provider
 */
@error
model ResourceProviderDefaultErrorResponse {
  /**
   * Response body of Error
   */
  @visibility("read")
  error?: ErrorResponseBody;
}

/**
 * Response body of Error
 */
model ErrorResponseBody {
  /**
   * Error code
   */
  @visibility("read")
  code?: string;

  /**
   * Error message
   */
  @visibility("read")
  message?: string;

  /**
   * Error target
   */
  @visibility("read")
  target?: string;

  /**
   * Error detail
   */
  @visibility("read")
  details?: ErrorResponseBody[];
}

/**
 * Organization resource property
 */
model OrganizationResourceProperties {
  /**
   * The creation time of the resource.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Provision states for confluent RP
   */
  @visibility("read")
  provisioningState?: ProvisionState;

  /**
   * Id of the Confluent organization.
   */
  @visibility("read")
  organizationId?: string;

  /**
   * SSO url for the Confluent organization.
   */
  @visibility("read")
  ssoUrl?: string;

  /**
   * Confluent offer detail
   */
  offerDetail: OfferDetail;

  /**
   * Subscriber detail
   */
  userDetail: UserDetail;
}

/**
 * Confluent Offer detail
 */
model OfferDetail {
  /**
   * Publisher Id
   */
  @maxLength(50)
  publisherId: string;

  /**
   * Offer Id
   */
  @maxLength(50)
  id: string;

  /**
   * Offer Plan Id
   */
  @maxLength(50)
  planId: string;

  /**
   * Offer Plan Name
   */
  @maxLength(50)
  planName: string;

  /**
   * Offer Plan Term unit
   */
  @maxLength(25)
  termUnit: string;

  /**
   * SaaS Offer Status
   */
  @visibility("read")
  status?: SaaSOfferStatus;
}

/**
 * Subscriber detail
 */
model UserDetail {
  /**
   * First name
   */
  @maxLength(50)
  firstName?: string;

  /**
   * Last name
   */
  @maxLength(50)
  lastName?: string;

  /**
   * Email address
   */
  @pattern("^\\S+@\\S+\\.\\S+$")
  emailAddress: string;
}

/**
 * Organization Resource update
 */
model OrganizationResourceUpdate {
  /**
   * ARM resource tags
   */
  tags?: Record<string>;
}

/**
 * An Confluent REST API operation.
 */
model OperationResult {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The object that represents the operation.
   */
  display?: OperationDisplay;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;
}
