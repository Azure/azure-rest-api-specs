import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * The more detailed status of the console.
 */
union ConsoleDetailedStatus {
  string,

  /**
   * The Ready status.
   */
  Ready: "Ready",

  /**
   * The Error status.
   */
  Error: "Error",
}

/**
 * The indicator of whether the console access is enabled.
 */
union ConsoleEnabled {
  string,

  /**
   * Console access enabled
   */
  True: "True",

  /**
   * Console access disabled
   */
  False: "False",
}

/**
 * The provisioning state of the virtual machine console.
 */
union ConsoleProvisioningState {
  string,

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",
}

/**
 * ConsoleList represents a list of virtual machine consoles.
 */
model ConsoleList is Azure.Core.Page<Console>;

/**
 * ConsoleProperties represents the properties of the virtual machine console.
 */
model ConsoleProperties {
  ...ConsoleSpec;
  ...ConsoleStatus;

  /**
   * The provisioning state of the virtual machine console.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ConsoleProvisioningState;
}

/**
 * ConsoleSpec represents the properties that are used as an input to the operator.
 */
model ConsoleSpec {
  /**
   * The indicator of whether the console access is enabled.
   */
  enabled: ConsoleEnabled;

  /**
   * The date and time after which the key will be disallowed access.
   */
  expiration?: utcDateTime;

  /**
   * The SSH public key that will be provisioned for user access. The user is expected to have the corresponding SSH private key for logging in.
   */
  sshPublicKey: SshPublicKey;
}

/**
 * ConsoleStatus represents the properties produced by the API implementing logic in the operator.
 */
model ConsoleStatus {
  /**
   * The more detailed status of the console.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: ConsoleDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The resource ID of the private link service that is used to provide virtual machine console access.
   */
  @visibility(Lifecycle.Read)
  privateLinkServiceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateLinkServices";
    }
  ]>;

  /**
   * The unique identifier for the virtual machine that is used to access the console.
   */
  @visibility(Lifecycle.Read)
  virtualMachineAccessId?: string;
}

/**
 * ConsolePatchParameters represents the body of the request to patch the virtual machine console.
 */
model ConsolePatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: ConsolePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * ConsolePatchProperties represents the properties of the virtual machine console that can be patched.
 */
model ConsolePatchProperties {
  /**
   * The indicator of whether the console access is enabled.
   */
  enabled?: ConsoleEnabled;

  /**
   * The date and time after which the key will be disallowed access.
   */
  expiration?: utcDateTime;

  /**
   * The SSH public key that will be provisioned for user access. The user is expected to have the corresponding SSH private key for logging in.
   */
  sshPublicKey?: SshPublicKey;
}
