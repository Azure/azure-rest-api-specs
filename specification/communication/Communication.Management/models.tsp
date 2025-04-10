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
 * Provisioning state of the resource.
 */
union CommunicationServicesProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
union ManagedServiceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * Provisioning state of the resource.
 */
union DomainsProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
}

/**
 * Describes how a Domains resource is being managed.
 */
union DomainManagement {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureManaged: "AzureManaged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CustomerManaged: "CustomerManaged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CustomerManagedInExchangeOnline: "CustomerManagedInExchangeOnline",
}

/**
 * Status of the verification operation.
 */
union VerificationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotStarted: "NotStarted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  VerificationRequested: "VerificationRequested",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  VerificationInProgress: "VerificationInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  VerificationFailed: "VerificationFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Verified: "Verified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CancellationRequested: "CancellationRequested",
}

/**
 * Describes whether user engagement tracking is enabled or disabled.
 */
union UserEngagementTracking {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Type of verification.
 */
union VerificationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Domain: "Domain",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SPF: "SPF",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DKIM: "DKIM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DKIM2: "DKIM2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DMARC: "DMARC",
}

/**
 * Provisioning state of the resource.
 */
union EmailServicesProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
}

/**
 * Provisioning state of the resource. Unknown is the default state for Communication Services.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
}

/**
 * The keyType to regenerate. Must be either 'primary' or 'secondary'(case-insensitive).
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum KeyType {
  Primary,
  Secondary,
}

/**
 * Data POST-ed to the nameAvailability action
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NameAvailabilityParameters extends CheckNameAvailabilityRequest {}

/**
 * The check availability request body.
 */
model CheckNameAvailabilityRequest {
  /**
   * The name of the resource for which availability needs to be checked.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;
}

/**
 * The check availability result.
 */
model CheckNameAvailabilityResponse {
  /**
   * Indicates if the resource name is available.
   */
  nameAvailable?: boolean;

  /**
   * The reason why the given name is not available.
   */
  reason?: CheckNameAvailabilityReason;

  /**
   * Detailed reason why the given name is available.
   */
  message?: string;
}

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
  provisioningState?: CommunicationServicesProvisioningState;

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
  linkedDomains?: string[];
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
model ManagedServiceIdentity {
  /**
   * The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
   */
  type: ManagedServiceIdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * A class representing update parameters for CommunicationService resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CommunicationServiceResourceUpdate extends TaggedResource {
  /**
   * The properties of the service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: CommunicationServiceUpdateProperties;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: ManagedServiceIdentity;
}

/**
 * A class that describes the properties that can be updated for CommunicationService resource.
 */
model CommunicationServiceUpdateProperties {
  /**
   * List of email Domain resource Ids.
   */
  linkedDomains?: string[];
}

/**
 * An ARM resource with that can accept tags
 */
model TaggedResource {
  /**
   * Tags of the service which is a list of key value pairs that describe the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  primaryKey?: string;

  /**
   * The secondary access key.
   */
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
  provisioningState?: DomainsProvisioningState;

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
  Domain?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  SPF?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  DKIM?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  DKIM2?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
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
  Domain?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  SPF?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  DKIM?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  DKIM2?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model UpdateDomainRequestParameters extends TaggedResource {
  /**
   * A class that describes the updatable properties of a Domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  provisioningState?: EmailServicesProvisioningState;

  /**
   * The location where the email service stores its data at rest.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataLocation: string;
}

/**
 * A class representing update parameters for EmailService resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SmtpUsernameProperties {
  /**
   * The SMTP username. Could be free form or in the email address format.
   */
  username: string;

  /**
   * The application Id for the linked Entra Application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  entraApplicationId: string;

  /**
   * The tenant of the linked Entra Application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SuppressionListProperties {
  /**
   * The the name of the suppression list. This value must match one of the valid sender usernames of the sending domain.
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
