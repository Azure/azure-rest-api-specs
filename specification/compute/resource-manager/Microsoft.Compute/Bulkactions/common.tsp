import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.Compute;

@doc("A reference to an Azure resource.")
model SubResource {
  @doc("The Azure resource ID.")
  id?: string;
}

@doc("A reference to a secret stored in Azure Key Vault.")
model KeyVaultSecretReference {
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("The URL of the secret in Azure Key Vault.")
  secretUrl: string;

  @doc("The Azure resource ID of the Key Vault that contains the secret.")
  sourceVault: SubResource;
}

/**
 * The type of identity used for the virtual machine scale set. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the virtual machine scale set.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Identity for the virtual machine.
 */
model VirtualMachineIdentity {
  /**
   * The principal id of virtual machine identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id associated with the virtual machine. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the virtual machine. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the virtual machine.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the Virtual Machine. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentitiesValue>;
}

/**
 * The policy used to select an availability zone for the virtual machine.
 */
union ZonePlacementPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Any: "Any",

  /**
   * Bulk Actions automatically selects an availability zone based on the request.
   */
  Auto: "Auto",
}

/**
 * The customer-defined constraints for virtual machine placement.
 */
model Placement {
  /**
   * The policy used to select an availability zone.
   */
  zonePlacementPolicy?: ZonePlacementPolicyType;

  /**
   * The availability zones that Bulk Actions can select. When omitted, Bulk Actions can consider any supported zone in the region.
   */
  includeZones?: string[];

  /**
   * The availability zones that Bulk Actions must not select.
   */
  excludeZones?: string[];
}

/**
 * Additional parameters for reimaging a virtual machine that does not use an ephemeral operating system disk.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility with existing Compute contract naming"
#suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
model OSProfileProvisioningData {
  /**
   * The password for the virtual machine administrator account. The password must be 8 to 123 characters long for Windows virtual machines or 6 to 72 characters long for Linux virtual machines. It must contain characters from at least three of these categories: lowercase letters, uppercase letters, digits, and special characters. The following values are not allowed: `abc@123`, `P@$$w0rd`, `P@ssw0rd`, `P@ssword123`, `Pa$$word`, `pass@word1`, `Password!`, `Password1`, `Password22`, and `iloveyou!`. This secret is accepted only in the request and is not returned in responses.
   */
  @secret
  adminPassword?: string;

  /**
   * Base64-encoded custom data provided to the virtual machine. The decoded data can contain up to 65,535 bytes. Do not include secrets or passwords.
   */
  customData?: string;
}

/**
 * The parameters for reimaging a virtual machine. The operating system disk is always reimaged.
 */
model VirtualMachineReimageParameters {
  /**
   * Indicates whether to reimage the temporary disk. The default value is `false`. This option is supported only for virtual machines or virtual machine scale sets that use an ephemeral operating system disk.
   */
  tempDisk?: boolean;

  /**
   * The exact image version to use when reimaging the operating system disk. When omitted, the disk is reimaged to its current image version.
   */
  exactVersion?: string;

  /**
   * The operating system profile used when reimaging a non-ephemeral operating system disk.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  osProfile?: OSProfileProvisioningData;
}
