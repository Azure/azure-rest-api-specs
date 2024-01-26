import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Support;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * A value that indicates the urgency of the case, which in turn determines the response time according to the service level agreement of the technical support plan you have with Azure. Note: 'Highest critical impact', also known as the 'Emergency - Severe impact' level in the Azure portal is reserved only for our Premium customers.
 */
enum SeverityLevel {
  minimal,
  moderate,
  critical,
  highestcriticalimpact,
}

/**
 * Advanced diagnostic consent to be updated on the support ticket.
 */
enum Consent {
  Yes,
  No,
}

/**
 * Preferred contact method.
 */
enum PreferredContactMethod {
  email,
  phone,
}

/**
 * User consent value provided
 */
enum UserConsent {
  Yes,
  No,
}

/**
 * Status to be updated on the ticket.
 */
enum Status {
  open,
  closed,
}

/**
 * Communication type.
 */
enum CommunicationType {
  web,
  phone,
}

/**
 * Direction of communication.
 */
enum CommunicationDirection {
  inbound,
  outbound,
}

/**
 * Content type.
 */
enum TranscriptContentType {}

/**
 * The type of resource.
 */
@fixed
enum Type {
  `Microsoft.Support/supportTickets`,
  `Microsoft.Support/communications`,
}

/**
 * Details about an Azure service available for support ticket creation.
 */
model ServiceProperties {
  /**
   * Localized name of the Azure service.
   */
  displayName?: string;

  /**
   * ARM Resource types.
   */
  resourceTypes?: string[];
}

/**
 * Details about a problem classification available for an Azure service.
 */
model ProblemClassificationProperties {
  /**
   * Localized name of problem classification.
   */
  displayName?: string;

  /**
   * This property indicates whether secondary consent is present for problem classification
   */
  secondaryConsentEnabled?: SecondaryConsentEnabled[];
}

/**
 * This property indicates whether secondary consent is present for problem classification.
 */
model SecondaryConsentEnabled {
  /**
   * User consent description.
   */
  description?: string;

  /**
   * The Azure service for which secondary consent is needed for case creation.
   */
  type?: string;
}

/**
 * Input of CheckNameAvailability API.
 */
model CheckNameAvailabilityInput {
  /**
   * The resource name to validate.
   */
  name: string;

  /**
   * The type of resource.
   */
  type: Type;
}

/**
 * Output of check name availability API.
 */
model CheckNameAvailabilityOutput {
  /**
   * Indicates whether the name is available.
   */
  @visibility("read")
  nameAvailable?: boolean;

  /**
   * The reason why the name is not available.
   */
  @visibility("read")
  reason?: string;

  /**
   * The detailed error message describing why the name is not available.
   */
  @visibility("read")
  message?: string;
}

/**
 * Describes the properties of a support ticket.
 */
model SupportTicketDetailsProperties {
  /**
   * System generated support ticket Id that is unique.
   */
  supportTicketId?: string;

  /**
   * Detailed description of the question or issue.
   */
  description: string;

  /**
   * Each Azure service has its own set of issue categories, also known as problem classification. This parameter is the unique Id for the type of problem you are experiencing.
   */
  problemClassificationId: string;

  /**
   * Localized name of problem classification.
   */
  @visibility("read")
  problemClassificationDisplayName?: string;

  /**
   * A value that indicates the urgency of the case, which in turn determines the response time according to the service level agreement of the technical support plan you have with Azure. Note: 'Highest critical impact', also known as the 'Emergency - Severe impact' level in the Azure portal is reserved only for our Premium customers.
   */
  severity: SeverityLevel;

  /**
   * Enrollment Id associated with the support ticket.
   */
  @visibility("read")
  enrollmentId?: string;

  /**
   * Indicates if this requires a 24x7 response from Azure.
   */
  require24X7Response?: boolean;

  /**
   * Advanced diagnostic consent to be updated on the support ticket.
   */
  advancedDiagnosticConsent?: Consent;

  /**
   * Problem scoping questions associated with the support ticket.
   */
  problemScopingQuestions?: string;

  /**
   * Support plan id associated with the support ticket.
   */
  supportPlanId?: string;

  /**
   * Contact information of the user requesting to create a support ticket.
   */
  contactDetails: ContactProfile;

  /**
   * Service Level Agreement information for this support ticket.
   */
  serviceLevelAgreement?: ServiceLevelAgreement;

  /**
   * Information about the support engineer working on this support ticket.
   */
  supportEngineer?: SupportEngineer;

  /**
   * Support plan type associated with the support ticket.
   */
  @visibility("read")
  supportPlanType?: string;

  /**
   * Support plan type associated with the support ticket.
   */
  @visibility("read")
  supportPlanDisplayName?: string;

  /**
   * Title of the support ticket.
   */
  title: string;

  /**
   * Time in UTC (ISO 8601 format) when the problem started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  problemStartTime?: utcDateTime;

  /**
   * This is the resource Id of the Azure service resource associated with the support ticket.
   */
  serviceId: string;

  /**
   * Localized name of the Azure service.
   */
  @visibility("read")
  serviceDisplayName?: string;

  /**
   * Status of the support ticket.
   */
  @visibility("read")
  status?: string;

  /**
   * Time in UTC (ISO 8601 format) when the support ticket was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * Time in UTC (ISO 8601 format) when the support ticket was last modified.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedDate?: utcDateTime;

  /**
   * File workspace name.
   */
  fileWorkspaceName?: string;

  /**
   * Additional ticket details associated with a technical support ticket request.
   */
  technicalTicketDetails?: TechnicalTicketDetails;

  /**
   * Additional ticket details associated with a quota support ticket request.
   */
  quotaTicketDetails?: QuotaTicketDetails;

  /**
   * This property indicates secondary consents for the support ticket
   */
  secondaryConsent?: SecondaryConsent[];
}

/**
 * Contact information associated with the support ticket.
 */
model ContactProfile {
  /**
   * First name.
   */
  firstName: string;

  /**
   * Last name.
   */
  lastName: string;

  /**
   * Preferred contact method.
   */
  preferredContactMethod: PreferredContactMethod;

  /**
   * Primary email address.
   */
  primaryEmailAddress: string;

  /**
   * Additional email addresses listed will be copied on any correspondence about the support ticket.
   */
  additionalEmailAddresses?: string[];

  /**
   * Phone number. This is required if preferred contact method is phone.
   */
  phoneNumber?: string;

  /**
   * Time zone of the user. This is the name of the time zone from [Microsoft Time Zone Index Values](https://support.microsoft.com/help/973627/microsoft-time-zone-index-values).
   */
  preferredTimeZone: string;

  /**
   * Country of the user. This is the ISO 3166-1 alpha-3 code.
   */
  country: string;

  /**
   * Preferred language of support from Azure. Support languages vary based on the severity you choose for your support ticket. Learn more at [Azure Severity and responsiveness](https://azure.microsoft.com/support/plans/response). Use the standard language-country code. Valid values are 'en-us' for English, 'zh-hans' for Chinese, 'es-es' for Spanish, 'fr-fr' for French, 'ja-jp' for Japanese, 'ko-kr' for Korean, 'ru-ru' for Russian, 'pt-br' for Portuguese, 'it-it' for Italian, 'zh-tw' for Chinese and 'de-de' for German.
   */
  preferredSupportLanguage: string;
}

/**
 * Service Level Agreement details for a support ticket.
 */
model ServiceLevelAgreement {
  /**
   * Time in UTC (ISO 8601 format) when the service level agreement starts.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Time in UTC (ISO 8601 format) when the service level agreement expires.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * Service Level Agreement in minutes.
   */
  @visibility("read")
  slaMinutes?: int32;
}

/**
 * Support engineer information.
 */
model SupportEngineer {
  /**
   * Email address of the Azure Support engineer assigned to the support ticket.
   */
  @visibility("read")
  emailAddress?: string;
}

/**
 * Additional information for technical support ticket.
 */
model TechnicalTicketDetails {
  /**
   * This is the resource Id of the Azure service resource (For example: A virtual machine resource or an HDInsight resource) for which the support ticket is created.
   */
  resourceId?: string;
}

/**
 * Additional set of information required for quota increase support ticket for certain quota types, e.g.: Virtual machine cores. Get complete details about Quota payload support request along with examples at [Support quota request](https://aka.ms/supportrpquotarequestpayload).
 */
model QuotaTicketDetails {
  /**
   * Required for certain quota types when there is a sub type, such as Batch, for which you are requesting a quota increase.
   */
  quotaChangeRequestSubType?: string;

  /**
   * Quota change request version.
   */
  quotaChangeRequestVersion?: string;

  /**
   * This property is required for providing the region and new quota limits.
   */
  quotaChangeRequests?: QuotaChangeRequest[];
}

/**
 * This property is required for providing the region and new quota limits.
 */
model QuotaChangeRequest {
  /**
   * Region for which the quota increase request is being made.
   */
  region?: string;

  /**
   * Payload of the quota increase request.
   */
  payload?: string;
}

/**
 * This property indicates secondary consent for the support ticket.
 */
model SecondaryConsent {
  /**
   * User consent value provided
   */
  userConsent?: UserConsent;

  /**
   * The service name for which the secondary consent is being provided. The value needs to be retrieved from the Problem Classification API response.
   */
  type?: string;
}

/**
 * Updates severity, ticket status, and contact details in the support ticket.
 */
model UpdateSupportTicket {
  /**
   * Severity level.
   */
  severity?: SeverityLevel;

  /**
   * Status to be updated on the ticket.
   */
  status?: Status;

  /**
   * Contact details to be updated on the support ticket.
   */
  contactDetails?: UpdateContactProfile;

  /**
   * Advanced diagnostic consent to be updated on the support ticket.
   */
  advancedDiagnosticConsent?: Consent;

  /**
   * This property indicates secondary consents for the support ticket
   */
  secondaryConsent?: SecondaryConsent[];
}

/**
 * Contact information associated with the support ticket.
 */
model UpdateContactProfile {
  /**
   * First name.
   */
  firstName?: string;

  /**
   * Last name.
   */
  lastName?: string;

  /**
   * Preferred contact method.
   */
  preferredContactMethod?: PreferredContactMethod;

  /**
   * Primary email address.
   */
  primaryEmailAddress?: string;

  /**
   * Email addresses listed will be copied on any correspondence about the support ticket.
   */
  additionalEmailAddresses?: string[];

  /**
   * Phone number. This is required if preferred contact method is phone.
   */
  phoneNumber?: string;

  /**
   * Time zone of the user. This is the name of the time zone from [Microsoft Time Zone Index Values](https://support.microsoft.com/help/973627/microsoft-time-zone-index-values).
   */
  preferredTimeZone?: string;

  /**
   * Country of the user. This is the ISO 3166-1 alpha-3 code.
   */
  country?: string;

  /**
   * Preferred language of support from Azure. Support languages vary based on the severity you choose for your support ticket. Learn more at [Azure Severity and responsiveness](https://azure.microsoft.com/support/plans/response/). Use the standard language-country code. Valid values are 'en-us' for English, 'zh-hans' for Chinese, 'es-es' for Spanish, 'fr-fr' for French, 'ja-jp' for Japanese, 'ko-kr' for Korean, 'ru-ru' for Russian, 'pt-br' for Portuguese, 'it-it' for Italian, 'zh-tw' for Chinese and 'de-de' for German.
   */
  preferredSupportLanguage?: string;
}

/**
 * Describes the properties of a communication resource.
 */
model CommunicationDetailsProperties {
  /**
   * Communication type.
   */
  @visibility("read")
  communicationType?: CommunicationType;

  /**
   * Direction of communication.
   */
  @visibility("read")
  communicationDirection?: CommunicationDirection;

  /**
   * Email address of the sender. This property is required if called by a service principal.
   */
  sender?: string;

  /**
   * Subject of the communication.
   */
  subject: string;

  /**
   * Body of the communication.
   */
  body: string;

  /**
   * Time in UTC (ISO 8601 format) when the communication was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;
}

/**
 * Describes the properties of a Chat Transcript Details resource.
 */
model ChatTranscriptDetailsProperties {
  /**
   * List of chat transcript communication resources.
   */
  messages?: MessageProperties[];

  /**
   * Time in UTC (ISO 8601 format) when the chat began.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}

/**
 * Describes the properties of a Message Details resource.
 */
model MessageProperties {
  /**
   * Content type.
   */
  @visibility("read")
  contentType?: TranscriptContentType;

  /**
   * Direction of communication.
   */
  @visibility("read")
  communicationDirection?: CommunicationDirection;

  /**
   * Name of the sender.
   */
  sender?: string;

  /**
   * Body of the communication.
   */
  body: string;

  /**
   * Time in UTC (ISO 8601 format) when the communication was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Describes the properties of a file workspace.
 */
model FileWorkspaceDetailsProperties {
  /**
   * Time in UTC (ISO 8601 format) when file workspace was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Time in UTC (ISO 8601 format) when file workspace is going to expire.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;
}

/**
 * Describes the properties of a file.
 */
model FileDetailsProperties {
  /**
   * Time in UTC (ISO 8601 format) when file workspace was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Size of each chunk
   */
  chunkSize?: float32;

  /**
   * Size of the file to be uploaded
   */
  fileSize?: float32;

  /**
   * Number of chunks to be uploaded
   */
  numberOfChunks?: float32;
}

/**
 * File content associated with the file under a workspace.
 */
model UploadFile {
  /**
   * File Content in base64 encoded format
   */
  content?: string;

  /**
   * Index of the uploaded chunk (Index starts at 0)
   */
  chunkIndex?: float32;
}
