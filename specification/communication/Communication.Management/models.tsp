import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Communication;

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * system
   */
  system: "system",

  /**
   * user,system
   */
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,

  /**
   * Internal
   */
  Internal: "Internal",
}

/**
 * The reason why the given name is not available.
 */
union CheckNameAvailabilityReason {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * AlreadyExists
   */
  AlreadyExists: "AlreadyExists",
}

/**
 * Provisioning state of the resource.
 */
union CommunicationServices_ProvisioningState {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Moving
   */
  Moving: "Moving",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Provisioning state of the resource.
 */
union Domains_ProvisioningState {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Moving
   */
  Moving: "Moving",
}

/**
 * Describes how a Domains resource is being managed.
 */
union DomainManagement {
  string,

  /**
   * AzureManaged
   */
  AzureManaged: "AzureManaged",

  /**
   * CustomerManaged
   */
  CustomerManaged: "CustomerManaged",

  /**
   * CustomerManagedInExchangeOnline
   */
  CustomerManagedInExchangeOnline: "CustomerManagedInExchangeOnline",
}

/**
 * Status of the verification operation.
 */
union VerificationStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * VerificationRequested
   */
  VerificationRequested: "VerificationRequested",

  /**
   * VerificationInProgress
   */
  VerificationInProgress: "VerificationInProgress",

  /**
   * VerificationFailed
   */
  VerificationFailed: "VerificationFailed",

  /**
   * Verified
   */
  Verified: "Verified",

  /**
   * CancellationRequested
   */
  CancellationRequested: "CancellationRequested",
}

/**
 * Describes whether user engagement tracking is enabled or disabled.
 */
union UserEngagementTracking {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Type of verification.
 */
union VerificationType {
  string,

  /**
   * Domain
   */
  Domain: "Domain",

  /**
   * SPF
   */
  SPF: "SPF",

  /**
   * DKIM
   */
  DKIM: "DKIM",

  /**
   * DKIM2
   */
  DKIM2: "DKIM2",

  /**
   * DMARC
   */
  DMARC: "DMARC",
}

/**
 * Provisioning state of the resource.
 */
union EmailServices_ProvisioningState {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Moving
   */
  Moving: "Moving",
}

/**
 * Provisioning state of the resource. Unknown is the default state for Communication Services.
 */
union ProvisioningState {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Moving
   */
  Moving: "Moving",
}

/**
 * The keyType to regenerate. Must be either 'primary' or 'secondary'(case-insensitive).
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KeyType {
  /**
   * Primary
   */
  Primary,

  /**
   * Secondary
   */
  Secondary,
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Data POST-ed to the nameAvailability action
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NameAvailabilityParameters
  extends Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest {}

/**
 * Description of an Azure Notification Hub to link to the communication service
 */
model LinkNotificationHubParameters {
  /**
   * The resource ID of the notification hub
   */
  resourceId: string;

  /**
   * Connection string for the notification hub
   */
  connectionString: string;
}

/**
 * A notification hub that has been linked to the communication service
 */
model LinkedNotificationHub {
  /**
   * The resource ID of the notification hub
   */
  resourceId?: string;
}

/**
 * Object that includes an array of CommunicationServices and a possible link for next set.
 */
model CommunicationServiceResourceList
  is Azure.Core.Page<CommunicationServiceResource>;

/**
 * A class that describes the properties of the CommunicationService.
 */
model CommunicationServiceProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CommunicationServices_ProvisioningState;

  /**
   * FQDN of the CommunicationService instance.
   */
  @visibility(Lifecycle.Read)
  hostName?: string;

  /**
   * The location where the communication service stores its data at rest.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataLocation: string;

  /**
   * Resource ID of an Azure Notification Hub linked to this resource.
   */
  @visibility(Lifecycle.Read)
  notificationHubId?: string;

  /**
   * Version of the CommunicationService resource. Probably you need the same or higher version of client SDKs.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The immutable resource Id of the communication service.
   */
  @visibility(Lifecycle.Read)
  immutableResourceId?: string;

  /**
   * List of email Domain resource Ids.
   */
  linkedDomains?: DomainsResourceList;

  /**
   * Allow, disallow, or let network security perimeter configuration control public network access to the protected resource. Value is optional but if passed in, it must be 'Enabled', 'Disabled' or 'SecuredByPerimeter'.
   */
  publicNetworkAccess?: Azure.ResourceManager.CommonTypes.PublicNetworkAccess;

  /**
   * Disable local authentication for the CommunicationService.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  disableLocalAuth?: boolean;
}

/**
 * A class representing update parameters for CommunicationService resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CommunicationServiceResourceUpdate extends TaggedResource {
  /**
   * The properties of the service.
   */
  properties?: CommunicationServiceUpdateProperties;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

/**
 * A class that describes the properties that can be updated for CommunicationService resource.
 */
model CommunicationServiceUpdateProperties {
  /**
   * List of email Domain resource Ids.
   */
  linkedDomains?: DomainsResourceList;

  /**
   * Allow, disallow, or let network security perimeter configuration control public network access to the protected resource. Value is optional but if passed in, it must be 'Enabled', 'Disabled' or 'SecuredByPerimeter'.
   */
  publicNetworkAccess?: Azure.ResourceManager.CommonTypes.PublicNetworkAccess;

  /**
   * Disable local authentication for the CommunicationService.
   */
  @visibility(Lifecycle.Update)
  disableLocalAuth?: boolean;
}

/**
 * An ARM resource with that can accept tags
 */
model TaggedResource {
  /**
   * Tags of the service which is a list of key value pairs that describe the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * A class representing the access keys of a CommunicationService.
 */
model CommunicationServiceKeys {
  /**
   * The primary access key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  primaryKey?: string;

  /**
   * The secondary access key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secondaryKey?: string;

  /**
   * CommunicationService connection string constructed via the primaryKey
   */
  primaryConnectionString?: string;

  /**
   * CommunicationService connection string constructed via the secondaryKey
   */
  secondaryConnectionString?: string;
}

/**
 * Parameters describes the request to regenerate access keys
 */
model RegenerateKeyParameters {
  /**
   * The keyType to regenerate. Must be either 'primary' or 'secondary'(case-insensitive).
   */
  keyType?: KeyType;
}

/**
 * A class that describes the properties of a Domains resource.
 */
model DomainProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: Domains_ProvisioningState;

  /**
   * The location where the Domains resource data is stored at rest.
   */
  @visibility(Lifecycle.Read)
  dataLocation?: string;

  /**
   * P2 sender domain that is displayed to the email recipients [RFC 5322].
   */
  @visibility(Lifecycle.Read)
  fromSenderDomain?: string;

  /**
   * P1 sender domain that is present on the email envelope [RFC 5321].
   */
  @visibility(Lifecycle.Read)
  mailFromSenderDomain?: string;

  /**
   * Describes how a Domains resource is being managed.
   */
  domainManagement: DomainManagement;

  /**
   * List of VerificationStatusRecord
   */
  @visibility(Lifecycle.Read)
  verificationStates?: DomainPropertiesVerificationStates;

  /**
   * List of DnsRecord
   */
  @visibility(Lifecycle.Read)
  verificationRecords?: DomainPropertiesVerificationRecords;

  /**
   * Describes whether user engagement tracking is enabled or disabled.
   */
  userEngagementTracking?: UserEngagementTracking;
}

/**
 * List of VerificationStatusRecord
 */
model DomainPropertiesVerificationStates {
  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Domain?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SPF?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DKIM?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DKIM2?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DMARC?: VerificationStatusRecord;
}

/**
 * A class that represents a VerificationStatus record.
 */
model VerificationStatusRecord {
  /**
   * Status of the verification operation.
   */
  @visibility(Lifecycle.Read)
  status?: VerificationStatus;

  /**
   * Error code. This property will only be present if the status is UnableToVerify.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;
}

/**
 * List of DnsRecord
 */
model DomainPropertiesVerificationRecords {
  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Domain?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SPF?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DKIM?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DKIM2?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DMARC?: DnsRecord;
}

/**
 * A class that represents a VerificationStatus record.
 */
model DnsRecord {
  /**
   * Type of the DNS record. Example: TXT
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Name of the DNS record.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Value of the DNS record.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * Represents an expiry time in seconds to represent how long this entry can be cached by the resolver, default = 3600sec.
   */
  @visibility(Lifecycle.Read)
  ttl?: int32;
}

/**
 * A class that describes the PATCH request parameters of a Domains resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UpdateDomainRequestParameters extends TaggedResource {
  /**
   * A class that describes the updatable properties of a Domains resource.
   */
  properties?: UpdateDomainProperties;
}

/**
 * A class that describes the updatable properties of a Domains resource.
 */
model UpdateDomainProperties {
  /**
   * Describes whether user engagement tracking is enabled or disabled.
   */
  userEngagementTracking?: UserEngagementTracking;
}

/**
 * Object that includes an array of Domains resource and a possible link for next set.
 */
model DomainResourceList is Azure.Core.Page<DomainResource>;

/**
 * Input parameter for verification APIs
 */
model VerificationParameter {
  /**
   * Type of verification.
   */
  verificationType: VerificationType;
}

/**
 * A class that describes the properties of the EmailService.
 */
model EmailServiceProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EmailServices_ProvisioningState;

  /**
   * The location where the email service stores its data at rest.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataLocation: string;
}

/**
 * A class representing update parameters for EmailService resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EmailServiceResourceUpdate extends TaggedResource {}

/**
 * Object that includes an array of EmailServices and a possible link for next set.
 */
model EmailServiceResourceList is Azure.Core.Page<EmailServiceResource>;

/**
 * A class representing a Domains SenderUsernames collection.
 */
model SenderUsernameResourceCollection
  is Azure.Core.Page<SenderUsernameResource>;

/**
 * A class that describes the properties of a SenderUsername resource.
 */
model SenderUsernameProperties {
  /**
   * The location where the SenderUsername resource data is stored at rest.
   */
  @visibility(Lifecycle.Read)
  dataLocation?: string;

  /**
   * A sender senderUsername to be used when sending emails.
   */
  username: string;

  /**
   * The display name for the senderUsername.
   */
  displayName?: string;

  /**
   * Provisioning state of the resource. Unknown is the default state for Communication Services.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Collection of SmtpUsername resources. Response will include a nextLink if response contains more pages.
 */
model SmtpUsernameResourceCollection is Azure.Core.Page<SmtpUsernameResource>;

/**
 * A class that describes the properties of a SmtpUsername resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SmtpUsernameProperties {
  /**
   * The SMTP username. Could be free form or in the email address format.
   */
  username: string;

  /**
   * The application Id for the linked Entra Application.
   */
  entraApplicationId: string;

  /**
   * The tenant of the linked Entra Application.
   */
  tenantId: string;
}

/**
 * A class representing a Domains SuppressionListResource collection.
 */
model SuppressionListResourceCollection
  is Azure.Core.Page<SuppressionListResource>;

/**
 * A class that describes the properties of a SuppressionList resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SuppressionListProperties {
  /**
   * The name of the suppression list. This value must match one of the valid sender usernames of the sending domain.
   */
  listName?: string;

  /**
   * The date the resource was last updated.
   */
  @visibility(Lifecycle.Read)
  lastUpdatedTimeStamp?: string;

  /**
   * The date the resource was created.
   */
  @visibility(Lifecycle.Read)
  createdTimeStamp?: string;

  /**
   * The location where the SuppressionListAddress data is stored at rest. This value is inherited from the parent Domains resource.
   */
  @visibility(Lifecycle.Read)
  dataLocation?: string;
}

/**
 * Collection of addresses in a suppression list. Response will include a nextLink if response contains more pages.
 */
model SuppressionListAddressResourceCollection
  is Azure.Core.Page<SuppressionListAddressResource>;

/**
 * A class that describes the properties of a SuppressionListAddress resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SuppressionListAddressProperties {
  /**
   * Email address of the recipient.
   */
  email: string;

  /**
   * The first name of the email recipient.
   */
  firstName?: string;

  /**
   * The last name of the email recipient.
   */
  lastName?: string;

  /**
   * An optional property to provide contextual notes or a description for an address.
   */
  notes?: string;

  /**
   * The date the address was last updated in a suppression list.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * The location where the SuppressionListAddress data is stored at rest. This value is inherited from the parent Domains resource.
   */
  @visibility(Lifecycle.Read)
  dataLocation?: string;
}

/**
 * List of FQDNs of verified domains in Exchange Online.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VerifiedExchangeOnlineDomainList is string[];

/**
 * List of email Domain resource Ids.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DomainsResourceList is string[];
