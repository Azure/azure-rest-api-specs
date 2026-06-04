import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,

  /**
   * The user executor.
   */
  user: "user",

  /**
   * The system executor.
   */
  system: "system",

  /**
   * The combined user and system executor.
   */
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,

  /**
   * Actions for internal only APIs.
   */
  Internal: "Internal",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * The resource was created by a user.
   */
  User: "User",

  /**
   * The resource was created by an application.
   */
  Application: "Application",

  /**
   * The resource was created by a managed identity.
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * The resource was created using a key.
   */
  Key: "Key",
}

/**
 * The status of the action.
 */
union ActionStateStatus {
  string,

  /**
   * The completed status.
   */
  Completed: "Completed",

  /**
   * The in-progress status.
   */
  InProgress: "InProgress",

  /**
   * The failed status.
   */
  Failed: "Failed",
}

/**
 * The status of the step. A value of Completed or Failed indicates a terminal state for the step.
 */
union StepStateStatus {
  string,

  /**
   * The completed status.
   */
  Completed: "Completed",

  /**
   * The in-progress status.
   */
  InProgress: "InProgress",

  /**
   * The failed status.
   */
  Failed: "Failed",

  /**
   * The not started status.
   */
  NotStarted: "NotStarted",
}

/**
 * The type (kind) of the cluster. When specified, the value must exactly match the kind configured on the cluster manager that manages the cluster. If omitted, the service will default the value to the kind value of the cluster manager.
 */
union DeploymentType {
  string,

  /**
   * Azure Operator Nexus
   */
  Nexus: "Nexus",

  /**
   * Azure Local
   */
  AzureLocal: "AzureLocal",
}

/**
 * The indicator of whether this is the default gateway. Only one of the attached networks (including the CloudServicesNetwork attachment) for a single machine may be specified as True.
 */
union DefaultGateway {
  string,

  /**
   * This is the default gateway.
   */
  True: "True",

  /**
   * This is not the default gateway.
   */
  False: "False",
}

/**
 * The IP allocation mechanism for the virtual machine. Dynamic and Static are only valid for l3Network which may also specify Disabled. Otherwise, Disabled is the only permitted value.
 */
union VirtualMachineIPAllocationMethod {
  string,

  /**
   * Dynamic VM IP allocation.
   */
  Dynamic: "Dynamic",

  /**
   * Static VM IP allocation.
   */
  Static: "Static",

  /**
   * No VM IP allocation.
   */
  Disabled: "Disabled",
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
 * Model representing the standard `extendedLocation` envelope property for a resource, with the
 * requirement that the `extendedLocation` property is included in the payload when creating the resource.
 */
// Note: this model replaces the common `ExtendedLocationProperty` model for resources that require the `extendedLocation` property during creation. This is to ensure that the contract explicitly requires the `extendedLocation` property in the payload when creating the resource, while still allowing for the use of the common `ExtendedLocationProperty` model for resources that do not require the `extendedLocation` property during creation.
model RequiredExtendedLocationProperty {
  /**
   * The extended location of the resource. This property is required when creating the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Legacy API has extended location in the resource envelope and marks it required."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: Foundations.ExtendedLocation;
}

/**
 * ActionState represents the state of an action taken against a resource. This can be used to represent both explicitly and implicitly defined action types.
 */
model ActionState {
  /**
   * The representation of the action for which this is a status. Matches ARM resource action format when the action is an ARM-based action.
   */
  @visibility(Lifecycle.Read)
  actionType?: string;

  /**
   * The correlation ID for the original action request. Omitted if there is no related correlation ID.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;

  /**
   * The timestamp of when the action reached its final, terminal state. Uses ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  endTime?: string;

  /**
   * The description providing additional context for the status value. May be empty or contain guidance in the case of a failure.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The timestamp of when the action began, in ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * The status of the action.
   */
  @visibility(Lifecycle.Read)
  status?: ActionStateStatus;

  /**
   * The ordered list of the individual steps which make up the action.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  stepStates?: StepState[];
}

/**
 * StepState represents the state of a step in an action.
 */
model StepState {
  /**
   * The timestamp for when processing of the step reached its terminal state, in ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  endTime?: string;

  /**
   * The message providing additional context for the status value. May be empty, or contain diagnostic information in the case of a failure.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The timestamp for when processing of the step began, in ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * The status of the step. A value of Completed or Failed indicates a terminal state for the step.
   */
  @visibility(Lifecycle.Read)
  status?: StepStateStatus;

  /**
   * The name for the step.
   */
  @visibility(Lifecycle.Read)
  stepName?: string;
}

/**
 * AdministrativeCredentials represents the admin credentials for the device requiring password-based authentication.
 */
model AdministrativeCredentials {
  /**
   * The password of the administrator of the device used during initialization.
   */
  @minLength(1)
  @secret
  password: string;

  /**
   * The username of the administrator of the device used during initialization.
   */
  @minLength(1)
  username: string;
}

/**
 * CertificateInfo represents the non-private information of an X.509 Certificate.
 */
model CertificateInfo {
  /**
   * The hash value of the X.509 Certificate.
   */
  @visibility(Lifecycle.Read)
  hash?: string;

  /**
   * The textual value of the X.509 Certificate.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * SecretRotationStatus represents the status of a secret rotation.
 */
model SecretRotationStatus {
  /**
   * The maximum number of days the secret may be used before it must be changed.
   */
  @visibility(Lifecycle.Read)
  expirePeriodDays?: int64;

  /**
   * The date and time when the secret was last changed.
   */
  @visibility(Lifecycle.Read)
  lastRotationTime?: utcDateTime;

  /**
   * The number of days a secret exists before rotations will be attempted.
   */
  @visibility(Lifecycle.Read)
  rotationPeriodDays?: int64;

  /**
   * The reference to the secret in a key vault.
   */
  @visibility(Lifecycle.Read)
  secretArchiveReference?: SecretArchiveReference;

  /**
   * The type name used to identify the purpose of the secret.
   */
  @visibility(Lifecycle.Read)
  secretType?: string;
}

/**
 * SecretArchiveReference represents the reference to a secret in a key vault.
 */
model SecretArchiveReference {
  /**
   * The resource ID of the key vault containing the secret.
   */
  @visibility(Lifecycle.Read)
  keyVaultId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * The URI of the key containing the secret.
   */
  @visibility(Lifecycle.Read)
  keyVaultUri?: url;

  /**
   * The name of the secret in the key vault.
   */
  @visibility(Lifecycle.Read)
  secretName?: string;

  /**
   * The version of the secret in the key vault.
   */
  @visibility(Lifecycle.Read)
  secretVersion?: string;
}

/**
 * ManagedResourceGroupConfiguration represents the configuration of the resource group managed by Azure.
 */
model ManagedResourceGroupConfiguration {
  /**
   * The location of the managed resource group. If not specified, the location of the parent resource is chosen.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * The name for the managed resource group. If not specified, the unique name is automatically generated.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(75)
  name?: string;
}

/**
 * SshPublicKey represents the public key used to authenticate with a resource through SSH.
 */
model SshPublicKey {
  /**
   * The SSH public key data.
   */
  @minLength(1)
  keyData: string;
}

/**
 * NetworkAttachment represents the single network attachment.
 */
model NetworkAttachment {
  /**
   * The resource ID of the associated network attached to the virtual machine. It can be one of cloudServicesNetwork, l3Network, l2Network or trunkedNetwork resources.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  attachedNetworkId: Azure.Core.armResourceIdentifier;

  /**
   * The indicator of whether this is the default gateway. Only one of the attached networks (including the CloudServicesNetwork attachment) for a single machine may be specified as True.
   */
  defaultGateway?: DefaultGateway;

  /**
   * The IP allocation mechanism for the virtual machine. Dynamic and Static are only valid for l3Network which may also specify Disabled. Otherwise, Disabled is the only permitted value.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipAllocationMethod: VirtualMachineIPAllocationMethod;

  /**
   * The IPv4 address of the virtual machine.  This field is used only if the attached network has IPAllocationType of IPV4 or DualStack.  If IPAllocationMethod is: Static - this field must contain a user specified IPv4 address from within the subnet specified in the attached network. Dynamic - this field is read-only, but will be populated with an address from within the subnet specified in the attached network. Disabled - this field will be empty.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv4Address?: string;

  /**
   * The IPv6 address of the virtual machine.  This field is used only if the attached network has IPAllocationType of IPV6 or DualStack.  If IPAllocationMethod is: Static - this field must contain an IPv6 address range from within the range specified in the attached network. Dynamic - this field is read-only, but will be populated with an range from within the subnet specified in the attached network. Disabled - this field will be empty.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv6Address?: string;

  /**
   * The MAC address of the interface for the virtual machine that corresponds to this network attachment.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * The associated network's interface name. If specified, the network attachment name has a maximum length of 15 characters and must be unique to this virtual machine. If the user doesn’t specify this value, the default interface name of the network resource will be used. For a CloudServicesNetwork resource, this name will be ignored.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(15)
  networkAttachmentName?: string;
}

/**
 * The current status of an async operation.
 */
model OperationStatusResult {
  /**
   * The end time of the operation.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * If present, details of the operation error.
   */
  @visibility(Lifecycle.Read)
  error?: CommonTypes.ErrorDetail;

  /**
   * Fully qualified ID for the async operation.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of the async operation.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The operations list.
   */
  @visibility(Lifecycle.Read)
  operations?: OperationStatusResult[];

  /**
   * Percent of the operation that is complete.
   */
  @visibility(Lifecycle.Read)
  @maxValue(100)
  @minValue(0)
  percentComplete?: float32;

  /**
   * The additional properties of the operation status result.
   */
  properties?: OperationStatusResultProperties;

  /**
   * Fully qualified ID of the resource against which the original async operation was started.
   */
  @visibility(Lifecycle.Read)
  resourceId?: Azure.Core.armResourceIdentifier;

  /**
   * The start time of the operation.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * Operation status.
   */
  status: string;
}

/**
 * OperationStatusResultProperties represents additional properties of the operation status result.
 */
model OperationStatusResultProperties {
  /**
   * For actions that run commands or scripts, the exit code of the script execution.
   */
  @visibility(Lifecycle.Read)
  exitCode?: string;

  /**
   * For actions that run commands or scripts, the leading bytes of the output of the script execution.
   */
  @visibility(Lifecycle.Read)
  outputHead?: string;

  /**
   * For actions that run commands or scripts, a reference to the location of the result.
   */
  @visibility(Lifecycle.Read)
  resultRef?: url;

  /**
   * For actions that run commands or scripts, the URL where the full output of the script output can be retrieved.
   */
  @visibility(Lifecycle.Read)
  resultUrl?: url;
}

/**
 * TagsParameter represents the resource tags.
 */
model TagsParameter {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}
