import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.Support;

interface Operations extends Azure.ResourceManager.Operations {}

enum SeverityLevel {
  minimal,
  moderate,
  critical,
  highestcriticalimpact,
}

enum Consent {
  Yes,
  No,
}

enum PreferredContactMethod {
  email,
  phone,
}

enum UserConsent {
  Yes,
  No,
}

enum Status {
  open,
  closed,
}

enum CommunicationType {
  web,
  phone,
}

enum CommunicationDirection {
  inbound,
  outbound,
}

enum TranscriptContentType {}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}
@Azure.Core.fixed
enum Type {
  `Microsoft.Support/supportTickets`,
  `Microsoft.Support/communications`,
}

@doc("Details about an Azure service available for support ticket creation.")
model ServiceProperties {
  @doc("Localized name of the Azure service.")
  displayName?: string;

  @doc("ARM Resource types.")
  resourceTypes?: string[];
}

@doc("Details about a problem classification available for an Azure service.")
model ProblemClassificationProperties {
  @doc("Localized name of problem classification.")
  displayName?: string;

  @doc("This property indicates whether secondary consent is present for problem classification")
  secondaryConsentEnabled?: SecondaryConsentEnabled[];
}

@doc("This property indicates whether secondary consent is present for problem classification.")
model SecondaryConsentEnabled {
  @doc("User consent description.")
  description?: string;

  @doc("The Azure service for which secondary consent is needed for case creation.")
  type?: string;
}

@doc("Input of CheckNameAvailability API.")
model CheckNameAvailabilityInput {
  @doc("The resource name to validate.")
  name: string;

  @doc("The type of resource.")
  type: Type;
}

@doc("Output of check name availability API.")
model CheckNameAvailabilityOutput {
  @doc("Indicates whether the name is available.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("The reason why the name is not available.")
  @visibility("read")
  reason?: string;

  @doc("The detailed error message describing why the name is not available.")
  @visibility("read")
  message?: string;
}

@doc("Describes the properties of a support ticket.")
model SupportTicketDetailsProperties {
  @doc("System generated support ticket Id that is unique.")
  supportTicketId?: string;

  @doc("Detailed description of the question or issue.")
  description: string;

  @doc("Each Azure service has its own set of issue categories, also known as problem classification. This parameter is the unique Id for the type of problem you are experiencing.")
  problemClassificationId: string;

  @doc("Localized name of problem classification.")
  @visibility("read")
  problemClassificationDisplayName?: string;

  @doc("A value that indicates the urgency of the case, which in turn determines the response time according to the service level agreement of the technical support plan you have with Azure. Note: 'Highest critical impact', also known as the 'Emergency - Severe impact' level in the Azure portal is reserved only for our Premium customers.")
  severity: SeverityLevel;

  @doc("Enrollment Id associated with the support ticket.")
  @visibility("read")
  enrollmentId?: string;

  @doc("Indicates if this requires a 24x7 response from Azure.")
  require24X7Response?: boolean;

  @doc("Advanced diagnostic consent to be updated on the support ticket.")
  advancedDiagnosticConsent?: Consent;

  @doc("Problem scoping questions associated with the support ticket.")
  problemScopingQuestions?: string;

  @doc("Support plan id associated with the support ticket.")
  supportPlanId?: string;

  @doc("Contact information of the user requesting to create a support ticket.")
  contactDetails: ContactProfile;

  @doc("Service Level Agreement information for this support ticket.")
  serviceLevelAgreement?: ServiceLevelAgreement;

  @doc("Information about the support engineer working on this support ticket.")
  supportEngineer?: SupportEngineer;

  @doc("Support plan type associated with the support ticket.")
  @visibility("read")
  supportPlanType?: string;

  @doc("Support plan type associated with the support ticket.")
  @visibility("read")
  supportPlanDisplayName?: string;

  @doc("Title of the support ticket.")
  title: string;

  @doc("Time in UTC (ISO 8601 format) when the problem started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  problemStartTime?: utcDateTime;

  @doc("This is the resource Id of the Azure service resource associated with the support ticket.")
  serviceId: string;

  @doc("Localized name of the Azure service.")
  @visibility("read")
  serviceDisplayName?: string;

  @doc("Status of the support ticket.")
  @visibility("read")
  status?: string;

  @doc("Time in UTC (ISO 8601 format) when the support ticket was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("Time in UTC (ISO 8601 format) when the support ticket was last modified.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedDate?: utcDateTime;

  @doc("File workspace name.")
  fileWorkspaceName?: string;

  @doc("Additional ticket details associated with a technical support ticket request.")
  technicalTicketDetails?: TechnicalTicketDetails;

  @doc("Additional ticket details associated with a quota support ticket request.")
  quotaTicketDetails?: QuotaTicketDetails;

  @doc("This property indicates secondary consents for the support ticket")
  secondaryConsent?: SecondaryConsent[];
}

@doc("Contact information associated with the support ticket.")
model ContactProfile {
  @doc("First name.")
  firstName: string;

  @doc("Last name.")
  lastName: string;

  @doc("Preferred contact method.")
  preferredContactMethod: PreferredContactMethod;

  @doc("Primary email address.")
  primaryEmailAddress: string;

  @doc("Additional email addresses listed will be copied on any correspondence about the support ticket.")
  additionalEmailAddresses?: string[];

  @doc("Phone number. This is required if preferred contact method is phone.")
  phoneNumber?: string;

  @doc("Time zone of the user. This is the name of the time zone from [Microsoft Time Zone Index Values](https://support.microsoft.com/help/973627/microsoft-time-zone-index-values).")
  preferredTimeZone: string;

  @doc("Country of the user. This is the ISO 3166-1 alpha-3 code.")
  country: string;

  @doc("Preferred language of support from Azure. Support languages vary based on the severity you choose for your support ticket. Learn more at [Azure Severity and responsiveness](https://azure.microsoft.com/support/plans/response). Use the standard language-country code. Valid values are 'en-us' for English, 'zh-hans' for Chinese, 'es-es' for Spanish, 'fr-fr' for French, 'ja-jp' for Japanese, 'ko-kr' for Korean, 'ru-ru' for Russian, 'pt-br' for Portuguese, 'it-it' for Italian, 'zh-tw' for Chinese and 'de-de' for German.")
  preferredSupportLanguage: string;
}

@doc("Service Level Agreement details for a support ticket.")
model ServiceLevelAgreement {
  @doc("Time in UTC (ISO 8601 format) when the service level agreement starts.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Time in UTC (ISO 8601 format) when the service level agreement expires.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  @doc("Service Level Agreement in minutes.")
  @visibility("read")
  slaMinutes?: int32;
}

@doc("Support engineer information.")
model SupportEngineer {
  @doc("Email address of the Azure Support engineer assigned to the support ticket.")
  @visibility("read")
  emailAddress?: string;
}

@doc("Additional information for technical support ticket.")
model TechnicalTicketDetails {
  @doc("This is the resource Id of the Azure service resource (For example: A virtual machine resource or an HDInsight resource) for which the support ticket is created.")
  resourceId?: string;
}

@doc("Additional set of information required for quota increase support ticket for certain quota types, e.g.: Virtual machine cores. Get complete details about Quota payload support request along with examples at [Support quota request](https://aka.ms/supportrpquotarequestpayload).")
model QuotaTicketDetails {
  @doc("Required for certain quota types when there is a sub type, such as Batch, for which you are requesting a quota increase.")
  quotaChangeRequestSubType?: string;

  @doc("Quota change request version.")
  quotaChangeRequestVersion?: string;

  @doc("This property is required for providing the region and new quota limits.")
  quotaChangeRequests?: QuotaChangeRequest[];
}

@doc("This property is required for providing the region and new quota limits.")
model QuotaChangeRequest {
  @doc("Region for which the quota increase request is being made.")
  region?: string;

  @doc("Payload of the quota increase request.")
  payload?: string;
}

@doc("This property indicates secondary consent for the support ticket.")
model SecondaryConsent {
  @doc("User consent value provided")
  userConsent?: UserConsent;

  @doc("The service name for which the secondary consent is being provided. The value needs to be retrieved from the Problem Classification API response.")
  type?: string;
}

@doc("Updates severity, ticket status, and contact details in the support ticket.")
model UpdateSupportTicket {
  @doc("Severity level.")
  severity?: SeverityLevel;

  @doc("Status to be updated on the ticket.")
  status?: Status;

  @doc("Contact details to be updated on the support ticket.")
  contactDetails?: UpdateContactProfile;

  @doc("Advanced diagnostic consent to be updated on the support ticket.")
  advancedDiagnosticConsent?: Consent;

  @doc("This property indicates secondary consents for the support ticket")
  secondaryConsent?: SecondaryConsent[];
}

@doc("Contact information associated with the support ticket.")
model UpdateContactProfile {
  @doc("First name.")
  firstName?: string;

  @doc("Last name.")
  lastName?: string;

  @doc("Preferred contact method.")
  preferredContactMethod?: PreferredContactMethod;

  @doc("Primary email address.")
  primaryEmailAddress?: string;

  @doc("Email addresses listed will be copied on any correspondence about the support ticket.")
  additionalEmailAddresses?: string[];

  @doc("Phone number. This is required if preferred contact method is phone.")
  phoneNumber?: string;

  @doc("Time zone of the user. This is the name of the time zone from [Microsoft Time Zone Index Values](https://support.microsoft.com/help/973627/microsoft-time-zone-index-values).")
  preferredTimeZone?: string;

  @doc("Country of the user. This is the ISO 3166-1 alpha-3 code.")
  country?: string;

  @doc("Preferred language of support from Azure. Support languages vary based on the severity you choose for your support ticket. Learn more at [Azure Severity and responsiveness](https://azure.microsoft.com/support/plans/response/). Use the standard language-country code. Valid values are 'en-us' for English, 'zh-hans' for Chinese, 'es-es' for Spanish, 'fr-fr' for French, 'ja-jp' for Japanese, 'ko-kr' for Korean, 'ru-ru' for Russian, 'pt-br' for Portuguese, 'it-it' for Italian, 'zh-tw' for Chinese and 'de-de' for German.")
  preferredSupportLanguage?: string;
}

@doc("Describes the properties of a communication resource.")
model CommunicationDetailsProperties {
  @doc("Communication type.")
  @visibility("read")
  communicationType?: CommunicationType;

  @doc("Direction of communication.")
  @visibility("read")
  communicationDirection?: CommunicationDirection;

  @doc("Email address of the sender. This property is required if called by a service principal.")
  sender?: string;

  @doc("Subject of the communication.")
  subject: string;

  @doc("Body of the communication.")
  body: string;

  @doc("Time in UTC (ISO 8601 format) when the communication was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;
}

@doc("Describes the properties of a Chat Transcript Details resource.")
model ChatTranscriptDetailsProperties {
  @doc("List of chat transcript communication resources.")
  messages?: MessageProperties[];

  @doc("Time in UTC (ISO 8601 format) when the chat began.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}

@doc("Describes the properties of a Message Details resource.")
model MessageProperties {
  @doc("Content type.")
  @visibility("read")
  contentType?: TranscriptContentType;

  @doc("Direction of communication.")
  @visibility("read")
  communicationDirection?: CommunicationDirection;

  @doc("Name of the sender.")
  sender?: string;

  @doc("Body of the communication.")
  body: string;

  @doc("Time in UTC (ISO 8601 format) when the communication was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"")
  @visibility("read")
  id?: ResourceIdentifier;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Describes the properties of a file workspace.")
model FileWorkspaceDetailsProperties {
  @doc("Time in UTC (ISO 8601 format) when file workspace was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  @doc("Time in UTC (ISO 8601 format) when file workspace is going to expire.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;
}

@doc("Describes the properties of a file.")
model FileDetailsProperties {
  @doc("Time in UTC (ISO 8601 format) when file workspace was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  @doc("Size of each chunk")
  chunkSize?: float32;

  @doc("Size of the file to be uploaded")
  fileSize?: float32;

  @doc("Number of chunks to be uploaded")
  numberOfChunks?: float32;
}

@doc("File content associated with the file under a workspace.")
model UploadFile {
  @doc("File Content in base64 encoded format")
  content?: string;

  @doc("Index of the uploaded chunk (Index starts at 0)")
  chunkIndex?: float32;
}
