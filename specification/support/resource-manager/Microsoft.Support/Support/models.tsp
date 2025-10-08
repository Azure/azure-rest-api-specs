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

/**
 * A value that indicates the urgency of the case, which in turn determines the response time according to the service level agreement of the technical support plan you have with Azure. Note: 'Highest critical impact', also known as the 'Emergency - Severe impact' level in the Azure portal is reserved only for our Premium customers.
 */
union SeverityLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  minimal: "minimal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  moderate: "moderate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  critical: "critical",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  highestcriticalimpact: "highestcriticalimpact",
}

/**
 * Advanced diagnostic consent to be updated on the support ticket.
 */
union Consent {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Yes: "Yes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  No: "No",
}

/**
 * Preferred contact method.
 */
union PreferredContactMethod {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  email: "email",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  phone: "phone",
}

/**
 * This property indicates if support ticket is a temporary ticket.
 */
union IsTemporaryTicket {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Yes: "Yes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  No: "No",
}

/**
 * User consent value provided
 */
union UserConsent {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Yes: "Yes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  No: "No",
}

/**
 * Status to be updated on the ticket.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  open: "open",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  closed: "closed",
}

/**
 * Communication type.
 */
union CommunicationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  web: "web",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  phone: "phone",
}

/**
 * Direction of communication.
 */
union CommunicationDirection {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  inbound: "inbound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  outbound: "outbound",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * The type of resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum Type {
  `Microsoft.Support/supportTickets`,
  `Microsoft.Support/communications`,
}

/**
 * The operation supported by Microsoft Support resource provider.
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The object that describes the operation.
   */
  display?: OperationDisplay;
}

/**
 * The object that describes the operation.
 */
model OperationDisplay {
  /**
   * The description of the operation.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The action that users can perform, based on their permission level.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * Service provider: Microsoft Support.
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * Resource on which the operation is performed.
   */
  @visibility(Lifecycle.Read)
  resource?: string;
}

/**
 * Collection of Service resources.
 */
model ServicesListResult {
  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: string;

  /**
   * List of Service resources.
   */
  @pageItems
  value?: Service[];
}

/**
 * Details about an Azure service available for support ticket creation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
 * Collection of ProblemClassification resources.
 */
model ProblemClassificationsListResult {
  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: string;

  /**
   * List of ProblemClassification resources.
   */
  @pageItems
  value?: ProblemClassification[];
}

/**
 * Details about a problem classification available for an Azure service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ProblemClassificationProperties {
  /**
   * Localized name of problem classification.
   */
  displayName?: string;

  /**
   * This property indicates whether secondary consent is present for problem classification
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * The reason why the name is not available.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * The detailed error message describing why the name is not available.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Describes the properties of a support ticket.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  problemClassificationDisplayName?: string;

  /**
   * A value that indicates the urgency of the case, which in turn determines the response time according to the service level agreement of the technical support plan you have with Azure. Note: 'Highest critical impact', also known as the 'Emergency - Severe impact' level in the Azure portal is reserved only for our Premium customers.
   */
  severity: SeverityLevel;

  /**
   * Enrollment Id associated with the support ticket.
   */
  enrollmentId?: string;

  /**
   * Indicates if this requires a 24x7 response from Azure.
   */
  require24X7Response?: boolean;

  /**
   * Advanced diagnostic consent to be updated on the support ticket.
   */
  advancedDiagnosticConsent: Consent;

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
  @visibility(Lifecycle.Read)
  supportPlanType?: string;

  /**
   * Support plan type associated with the support ticket.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  serviceDisplayName?: string;

  /**
   * Status of the support ticket.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Time in UTC (ISO 8601 format) when the support ticket was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * Time in UTC (ISO 8601 format) when the support ticket was last modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedDate?: utcDateTime;

  /**
   * File workspace name.
   */
  fileWorkspaceName?: string;

  /**
   * This property indicates if support ticket is a temporary ticket.
   */
  @visibility(Lifecycle.Read)
  isTemporaryTicket?: IsTemporaryTicket;

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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
   * Phone number. This is required if preferred contact method is phone. It is also required when submitting 'critical' or 'highestcriticalimpact' severity cases.
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Time in UTC (ISO 8601 format) when the service level agreement expires.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * Service Level Agreement in minutes.
   */
  @visibility(Lifecycle.Read)
  slaMinutes?: int32;
}

/**
 * Support engineer information.
 */
model SupportEngineer {
  /**
   * Email address of the Azure Support engineer assigned to the support ticket.
   */
  @visibility(Lifecycle.Read)
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
  @OpenAPI.extension("x-ms-identifiers", #["region"])
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
 * Updates severity, ticket status, contact details, advanced diagnostic consent and secondary consent in the support ticket.
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
   * Phone number. This is required if preferred contact method is phone. It is also required when submitting 'critical' or 'highestcriticalimpact' severity cases.
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model CommunicationDetailsProperties {
  /**
   * Communication type.
   */
  @visibility(Lifecycle.Read)
  communicationType?: CommunicationType;

  /**
   * Direction of communication.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;
}

/**
 * Describes the properties of a Chat Transcript Details resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ChatTranscriptDetailsProperties {
  /**
   * List of chat transcript communication resources.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  messages?: MessageProperties[];

  /**
   * Time in UTC (ISO 8601 format) when the chat began.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  contentType?: string;

  /**
   * Direction of communication.
   */
  @visibility(Lifecycle.Read)
  communicationDirection?: CommunicationDirection;

  /**
   * Name of the sender.
   */
  sender?: string;

  /**
   * Body of the communication.
   */
  body?: string;

  /**
   * Time in UTC (ISO 8601 format) when the communication was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;
}

/**
 * Describes the properties of a file workspace.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model FileWorkspaceDetailsProperties {
  /**
   * Time in UTC (ISO 8601 format) when file workspace was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Time in UTC (ISO 8601 format) when file workspace is going to expire.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;
}

/**
 * Describes the properties of a file.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model FileDetailsProperties {
  /**
   * Time in UTC (ISO 8601 format) when file workspace was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Size of each chunk. The size of each chunk should be provided in bytes and must not exceed 2.5 megabytes (MB).
   */
  chunkSize?: int32;

  /**
   * Size of the file to be uploaded. The file size must not exceed 5 MB and should be provided in bytes.
   */
  fileSize?: int32;

  /**
   * Number of chunks to be uploaded. The maximum number of allowed chunks is 2.
   */
  numberOfChunks?: int32;
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
  chunkIndex?: int32;
}
