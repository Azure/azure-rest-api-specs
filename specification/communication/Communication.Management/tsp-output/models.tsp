import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Communication;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning state of the resource.
 */
enum CommunicationServicesProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Running,
  Creating,
  Updating,
  Deleting,
  Moving,
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * Provisioning state of the resource.
 */
enum DomainsProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Running,
  Creating,
  Updating,
  Deleting,
  Moving,
}

/**
 * Describes how a Domains resource is being managed.
 */
enum DomainManagement {
  AzureManaged,
  CustomerManaged,
  CustomerManagedInExchangeOnline,
}

/**
 * Status of the verification operation.
 */
enum VerificationStatus {
  NotStarted,
  VerificationRequested,
  VerificationInProgress,
  VerificationFailed,
  Verified,
  CancellationRequested,
}

/**
 * Describes whether user engagement tracking is enabled or disabled.
 */
enum UserEngagementTracking {
  Disabled,
  Enabled,
}

/**
 * Type of verification.
 */
enum VerificationType {
  Domain,
  SPF,
  DKIM,
  DKIM2,
  DMARC,
}

/**
 * Provisioning state of the resource.
 */
enum EmailServicesProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Running,
  Creating,
  Updating,
  Deleting,
  Moving,
}

/**
 * Provisioning state of the resource. Unknown is the default state for Communication Services.
 */
enum ProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Running,
  Creating,
  Updating,
  Deleting,
  Moving,
}

/**
 * The keyType to regenerate. Must be either 'primary' or 'secondary'(case-insensitive).
 */
@fixed
enum KeyType {
  Primary,
  Secondary,
}

/**
 * Data POST-ed to the nameAvailability action
 */
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
 * A class that describes the properties of the CommunicationService.
 */
model CommunicationServiceProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: CommunicationServicesProvisioningState;

  /**
   * FQDN of the CommunicationService instance.
   */
  @visibility("read")
  hostName?: string;

  /**
   * The location where the communication service stores its data at rest.
   */
  @visibility("read", "create")
  dataLocation: string;

  /**
   * Resource ID of an Azure Notification Hub linked to this resource.
   */
  @visibility("read")
  notificationHubId?: string;

  /**
   * Version of the CommunicationService resource. Probably you need the same or higher version of client SDKs.
   */
  @visibility("read")
  version?: string;

  /**
   * The immutable resource Id of the communication service.
   */
  @visibility("read")
  immutableResourceId?: string;

  /**
   * List of email Domain resource Ids.
   */
  linkedDomains?: string[];
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
 * A class representing update parameters for CommunicationService resource.
 */
model CommunicationServiceResourceUpdate extends TaggedResource {
  /**
   * The properties of the service.
   */
  @extension("x-ms-client-flatten", true)
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
  @visibility("read", "create", "update")
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
  @visibility("read")
  provisioningState?: DomainsProvisioningState;

  /**
   * The location where the Domains resource data is stored at rest.
   */
  @visibility("read")
  dataLocation?: string;

  /**
   * P2 sender domain that is displayed to the email recipients [RFC 5322].
   */
  @visibility("read")
  fromSenderDomain?: string;

  /**
   * P1 sender domain that is present on the email envelope [RFC 5321].
   */
  @visibility("read")
  mailFromSenderDomain?: string;

  /**
   * Describes how a Domains resource is being managed.
   */
  domainManagement: DomainManagement;

  /**
   * List of VerificationStatusRecord
   */
  @visibility("read")
  verificationStates?: DomainPropertiesVerificationStates;

  /**
   * List of DnsRecord
   */
  @visibility("read")
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
  @projectedName("json", "Domain")
  domain?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  SPF?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  @projectedName("json", "DKIM")
  dkim?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  @projectedName("json", "DKIM2")
  dkim2?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  @projectedName("json", "DMARC")
  dmarc?: VerificationStatusRecord;
}

/**
 * A class that represents a VerificationStatus record.
 */
model VerificationStatusRecord {
  /**
   * Status of the verification operation.
   */
  @visibility("read")
  status?: VerificationStatus;

  /**
   * Error code. This property will only be present if the status is UnableToVerify.
   */
  @visibility("read")
  errorCode?: string;
}

/**
 * List of DnsRecord
 */
model DomainPropertiesVerificationRecords {
  /**
   * A class that represents a VerificationStatus record.
   */
  @projectedName("json", "Domain")
  domain?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  SPF?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  @projectedName("json", "DKIM")
  dkim?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  @projectedName("json", "DKIM2")
  dkim2?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  @projectedName("json", "DMARC")
  dmarc?: DnsRecord;
}

/**
 * A class that represents a VerificationStatus record.
 */
model DnsRecord {
  /**
   * Type of the DNS record. Example: TXT
   */
  @visibility("read")
  type?: string;

  /**
   * Name of the DNS record.
   */
  @visibility("read")
  name?: string;

  /**
   * Value of the DNS record.
   */
  @visibility("read")
  value?: string;

  /**
   * Represents an expiry time in seconds to represent how long this entry can be cached by the resolver, default = 3600sec.
   */
  @visibility("read")
  ttl?: int32;
}

/**
 * A class that describes the PATCH request parameters of a Domains resource.
 */
model UpdateDomainRequestParameters extends TaggedResource {
  /**
   * A class that describes the updatable properties of a Domains resource.
   */
  @extension("x-ms-client-flatten", true)
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
  @visibility("read")
  provisioningState?: EmailServicesProvisioningState;

  /**
   * The location where the email service stores its data at rest.
   */
  @visibility("read", "create")
  dataLocation: string;
}

/**
 * A class representing update parameters for EmailService resource.
 */
model EmailServiceResourceUpdate extends TaggedResource {}

/**
 * A class that describes the properties of a SenderUsername resource.
 */
model SenderUsernameProperties {
  /**
   * The location where the SenderUsername resource data is stored at rest.
   */
  @visibility("read")
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
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * A class that describes the properties of a SuppressionList resource.
 */
model SuppressionListProperties {
  /**
   * The the name of the suppression list. This value must match one of the valid sender usernames of the sending domain.
   */
  listName?: string;

  /**
   * The date the resource was last updated.
   */
  @visibility("read")
  lastUpdatedTimeStamp?: string;

  /**
   * The date the resource was created.
   */
  @visibility("read")
  createdTimeStamp?: string;

  /**
   * The location where the SuppressionListAddress data is stored at rest. This value is inherited from the parent Domains resource.
   */
  @visibility("read")
  dataLocation?: string;
}

/**
 * A class that describes the properties of a SuppressionListAddress resource.
 */
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
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * The location where the SuppressionListAddress data is stored at rest. This value is inherited from the parent Domains resource.
   */
  @visibility("read")
  dataLocation?: string;
}
