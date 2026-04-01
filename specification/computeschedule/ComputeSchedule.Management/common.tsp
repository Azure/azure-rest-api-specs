import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.ComputeSchedule;

@doc("Describes a reference to a sub-resource.")
model SubResource {
  @doc("The ID of the sub-resource.")
  id?: string;
}

@doc("Describes a reference to Key Vault Secret")
model KeyVaultSecretReference {
  @doc("The URL referencing a secret in a Key Vault.")
  secretUrl: string;

  @doc("The relative URL of the Key Vault containing the secret.")
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
 * Specifies the policy for resource's placement in availability zone. Possible values are: **Any** (used for Virtual Machines), **Auto** (used for Virtual Machine Scale Sets) - An availability zone will be automatically picked by system as part of resource creation.
 */
union ZonePlacementPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Any: "Any",

  /**
   * The platform automatically selects an availability zone based on the request.
   */
  Auto: "Auto",
}

/**
 * Describes the user-defined constraints for resource hardware placement.
 */
model Placement {
  /**
   * Specifies the policy for resource's placement in availability zone. Possible values are: **Any** (used for Virtual Machines), **Auto** (used for Virtual Machine Scale Sets) - An availability zone will be automatically picked by system as part of resource creation.
   */
  zonePlacementPolicy?: ZonePlacementPolicyType;

  /**
   * This property supplements the 'zonePlacementPolicy' property. If 'zonePlacementPolicy' is set to 'Any'/'Auto', availability zone selected by the system must be present in the list of availability zones passed with 'includeZones'. If 'includeZones' is not provided, all availability zones in region will be considered for selection.
   */
  includeZones?: string[];

  /**
   * This property supplements the 'zonePlacementPolicy' property. If 'zonePlacementPolicy' is set to 'Any'/'Auto', availability zone selected by the system must not be present in the list of availability zones passed with 'excludeZones'. If 'excludeZones' is not provided, all availability zones in region will be considered for selection.
   */
  excludeZones?: string[];
}

/**
 * Additional parameters for Reimaging Non-Ephemeral Virtual Machine.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility with existing Compute contract naming"
model OSProfileProvisioningData {
  @doc("Specifies the password of the administrator account. <br><br> **Minimum-length (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\\W_]) <br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\", \"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\", \"Password22\", \"iloveyou!\" <br><br> For resetting the password, see [How to reset the Remote Desktop service or its login password in a Windows VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp) <br><br> For resetting root password, see [Manage users, SSH, and check or repair disks on Azure Linux VMs using the VMAccess Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)")
  @secret
  adminPassword?: string;

  /**
   * Specifies a base-64 encoded string of custom data. The base-64 encoded string is decoded to a binary array that is saved as a file on the Virtual Machine. The maximum length of the binary array is 65535 bytes. **Note: Do not pass any secrets or passwords in customData property.** This property cannot be updated after the VM is created. The property customData is passed to the VM to be saved as a file, for more information see [Custom Data on Azure VMs](https://azure.microsoft.com/blog/custom-data-and-cloud-init-on-windows-azure/). If using cloud-init for your Linux VM, see [Using cloud-init to customize a Linux VM during creation](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init).
   */
  customData?: string;
}

/**
 * Parameters for Reimaging Virtual Machine. NOTE: Virtual Machine OS disk will always be reimaged
 */
model VirtualMachineReimageParameters {
  /**
   * Specifies whether to reimage temp disk. Default value: false. Note: This temp disk reimage parameter is only supported for VM/VMSS with Ephemeral OS disk.
   */
  tempDisk?: boolean;

  /**
   * Specifies in decimal number, the version the OS disk should be reimaged to. If exact version is not provided, the OS disk is reimaged to the existing version of OS Disk.
   */
  exactVersion?: string;

  /**
   * Specifies information required for reimaging the non-ephemeral OS disk.
   */
  osProfile?: OSProfileProvisioningData;
}
