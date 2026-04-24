import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetworkCloud;

/**
 * The strategy for creating the OS disk.
 */
union OsDiskCreateOption {
  string,

  /**
   * The Os Disk will be created on ephemeral storage.
   */
  Ephemeral: "Ephemeral",

  /**
   * The Os Disk is on persistent storage.
   */
  Persistent: "Persistent",
}

/**
 * The strategy for deleting the OS disk.
 */
union OsDiskDeleteOption {
  string,

  /**
   * The Os Disk will be deleted when the virtual machine is deleted.
   */
  Delete: "Delete",
}

/**
 * Selects the boot method for the virtual machine.
 */
union VirtualMachineBootMethod {
  string,

  /**
   * BIOS boot mode.
   */
  BIOS: "BIOS",

  /**
   * UEFI boot mode.
   */
  UEFI: "UEFI",
}

/**
 * The more detailed status of the virtual machine.
 */
union VirtualMachineDetailedStatus {
  string,

  /**
   * The Available status.
   */
  Available: "Available",

  /**
   * The Error status.
   */
  Error: "Error",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The Running status.
   */
  Running: "Running",

  /**
   * The Scheduling status.
   */
  Scheduling: "Scheduling",

  /**
   * The Stopped status.
   */
  Stopped: "Stopped",

  /**
   * The Terminating status.
   */
  Terminating: "Terminating",

  /**
   * The Unknown status.
   */
  Unknown: "Unknown",
}

/**
 * The type of the device model to use.
 */
union VirtualMachineDeviceModelType {
  string,

  /**
   * The T1 device model.
   */
  T1: "T1",

  /**
   * The T2 device model.
   */
  T2: "T2",

  /**
   * The T3 device model.
   */
  T3: "T3",
}

/**
 * Field Deprecated, the value will be ignored if provided. The indicator of whether one of the specified CPU cores is isolated to run the emulator thread for this virtual machine.
 */
union VirtualMachineIsolateEmulatorThread {
  string,

  /**
   * Do not isolate the emulator thread.
   */
  False: "False",

  /**
   * Isolate the emulator thread.
   */
  True: "True",
}

/**
 * The scope for the virtual machine affinity or anti-affinity placement hint. It should always be "Machine" in the case of node affinity.
 */
union VirtualMachinePlacementHintPodAffinityScope {
  string,

  /**
   * The virtual machine placement hint is scoped to the bare metal machine.
   */
  Machine: "Machine",

  /**
   * The virtual machine placement hint is scoped to the rack.
   */
  Rack: "Rack",
}

/**
 * The specification of whether this hint supports affinity or anti-affinity with the referenced resources.
 */
union VirtualMachinePlacementHintType {
  string,

  /**
   * The virtual machine has affinity with the referenced resources.
   */
  Affinity: "Affinity",

  /**
   * The virtual machine has anti-affinity with the referenced resources.
   */
  AntiAffinity: "AntiAffinity",
}

/**
 * The power state of the virtual machine.
 */
union VirtualMachinePowerState {
  string,

  /**
   * The virtual machine is powered off.
   */
  Off: "Off",

  /**
   * The virtual machine is powered on.
   */
  On: "On",

  /**
   * The virtual machine power state is unknown.
   */
  Unknown: "Unknown",
}

/**
 * The provisioning state of the virtual machine.
 */
union VirtualMachineProvisioningState {
  string,

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",
}

/**
 * The indicator of whether the hint is a hard or soft requirement during scheduling.
 */
union VirtualMachineSchedulingExecution {
  string,

  /**
   * The hint is a requirement during scheduling.
   */
  Hard: "Hard",

  /**
   * The hint is applied using a best-effort approach during scheduling.
   */
  Soft: "Soft",
}

/**
 * Field Deprecated, use virtualizationModel instead. The type of the virtio interface.
 */
union VirtualMachineVirtioInterfaceType {
  string,

  /**
   * Modern virtio interface.
   */
  Modern: "Modern",

  /**
   * Transitional virtio interface.
   */
  Transitional: "Transitional",
}

/**
 * The indicator of which relay type the machine should be assigned to use. Platform indicates the use of a platform-dedicated relay. Public indicates the use of the standard public relay for Arc services.
 */
union RelayType {
  string,

  /**
   * Utilize the platform-dedicated relay for Arc services.
   */
  Platform: "Platform",

  /**
   * Utilize the standard public relay for Arc services.
   */
  Public: "Public",
}

/**
 * The indicator of whether to skip the graceful OS shutdown and power off the virtual machine immediately.
 */
union SkipShutdown {
  string,

  /**
   * Skip the graceful OS shutdown and power off the virtual machine immediately.
   */
  True: "True",

  /**
   * Do not skip the graceful OS shutdown.
   */
  False: "False",
}

/**
 * ImageRepositoryCredentials represents the credentials used to login to the image repository.
 */
model ImageRepositoryCredentials {
  /**
   * The password or token used to access an image in the target repository.
   */
  @minLength(1)
  @secret
  password: string;

  /**
   * The URL of the authentication server used to validate the repository credentials.
   */
  registryUrl: string;

  /**
   * The username used to access an image in the target repository.
   */
  @minLength(1)
  username: string;
}

/**
 * OsDisk represents configuration of the boot disk.
 */
model OsDisk {
  /**
   * The strategy for creating the OS disk.
   */
  createOption?: OsDiskCreateOption = OsDiskCreateOption.Ephemeral;

  /**
   * The strategy for deleting the OS disk.
   */
  deleteOption?: OsDiskDeleteOption = OsDiskDeleteOption.Delete;

  /**
   * The size of the disk. Required if the createOption is Ephemeral. Allocations are measured in gibibytes.
   */
  @clientName("diskSizeGB")
  @encodedName("application/json", "diskSizeGB")
  diskSizeGb: int64;
}

/**
 * StorageProfile represents information about a disk.
 */
model StorageProfile {
  /**
   * The disk to use with this virtual machine.
   */
  osDisk: OsDisk;

  /**
   * The resource IDs of volumes that are requested to be attached to the virtual machine.
   */
  volumeAttachments?: string[];
}

/**
 * VirtualMachineAssignRelayParameters represents the body of the request to update the relay used for a Microsoft.HybridCompute machine associated with the virtual machine.
 */
model VirtualMachineAssignRelayParameters {
  /**
   * The resourceId of the Microsoft.HybridCompute machine resource to assign relay usage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  machineId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/machines";
    }
  ]>;

  /**
   * The indicator of which relay type the machine should be assigned to use. Platform indicates the use of a platform-dedicated relay. Public indicates the use of the standard public relay for Arc services.
   */
  relayType?: RelayType = RelayType.Platform;
}

/**
 * VirtualMachineList represents a list of virtual machines.
 */
model VirtualMachineList is Azure.Core.Page<VirtualMachine>;

/**
 * VirtualMachinePatchParameters represents the body of the request to patch the virtual machine.
 */
model VirtualMachinePatchParameters {
  /**
   * The identity for the resource.
   */
  identity?: CommonTypes.ManagedServiceIdentity;

  /**
   * The list of the resource properties.
   */
  properties?: VirtualMachinePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * VirtualMachinePatchProperties represents the properties of the virtual machine that can be patched.
 */
model VirtualMachinePatchProperties {
  /**
   * The credentials used to login to the image repository that has access to the specified image.
   */
  vmImageRepositoryCredentials?: ImageRepositoryCredentials;
}

/**
 * VirtualMachinePlacementHint represents a single scheduling hint of the virtual machine.
 */
model VirtualMachinePlacementHint {
  /**
   * The specification of whether this hint supports affinity or anti-affinity with the referenced resources.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hintType: VirtualMachinePlacementHintType;

  /**
   * The resource ID of the target object that the placement hints will be checked against, e.g., the bare metal node to host the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resourceId: Azure.Core.armResourceIdentifier;

  /**
   * The indicator of whether the hint is a hard or soft requirement during scheduling.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  schedulingExecution: VirtualMachineSchedulingExecution;

  /**
   * The scope for the virtual machine affinity or anti-affinity placement hint. It should always be "Machine" in the case of node affinity.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  scope: VirtualMachinePlacementHintPodAffinityScope;
}

/**
 * VirtualMachinePowerOffParameters represents the body of the request to power off virtual machine.
 */
model VirtualMachinePowerOffParameters {
  /**
   * The indicator of whether to skip the graceful OS shutdown and power off the virtual machine immediately.
   */
  skipShutdown?: SkipShutdown = SkipShutdown.False;
}

/**
 * VirtualMachineProperties represents the properties of the virtual machine.
 */
model VirtualMachineProperties {
  ...VirtualMachineSpec;
  ...VirtualMachineStatus;

  /**
   * The provisioning state of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: VirtualMachineProvisioningState;
}

/**
 * VirtualMachineSpec represents the properties that are used as an input to the operator.
 */
model VirtualMachineSpec {
  /**
   * The name of the administrator to which the ssh public keys will be added into the authorized keys.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(32)
  @minLength(1)
  @pattern("^[a-z_][a-z0-9_]{0,31}$")
  adminUsername: string;

  /**
   * Selects the boot method for the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  bootMethod?: VirtualMachineBootMethod = VirtualMachineBootMethod.UEFI;

  /**
   * The cloud service network that provides platform-level services for the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  cloudServicesNetworkAttachment: NetworkAttachment;

  /**
   * The number of CPU cores in the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minValue(2)
  cpuCores: int64;

  /**
   * Field Deprecated, the value will be ignored if provided. The indicator of whether one of the specified CPU cores is isolated to run the emulator thread for this virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isolateEmulatorThread?: VirtualMachineIsolateEmulatorThread = VirtualMachineIsolateEmulatorThread.True;

  /**
   * The memory size of the virtual machine. Allocations are measured in gibibytes.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minValue(1)
  @clientName("memorySizeGB")
  @encodedName("application/json", "memorySizeGB")
  memorySizeGb: int64;

  /**
   * The list of network attachments to the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  networkAttachments?: NetworkAttachment[];

  /**
   * Field Deprecated: The Base64 encoded cloud-init network data. The networkDataContent property will be used in preference to this property.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkData?: string;

  /**
   * The Base64 encoded cloud-init network data.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @secret
  networkDataContent?: string;

  /**
   * The scheduling hints for the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  placementHints?: VirtualMachinePlacementHint[];

  /**
   * The list of ssh public keys. Each key will be added to the virtual machine using the cloud-init ssh_authorized_keys mechanism for the adminUsername.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  sshPublicKeys?: SshPublicKey[];

  /**
   * The storage profile that specifies size and other parameters about the disks related to the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageProfile: StorageProfile;

  /**
   * Field Deprecated: The Base64 encoded cloud-init user data. The userDataContent property will be used in preference to this property.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  userData?: string;

  /**
   * The Base64 encoded cloud-init user data.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @secret
  userDataContent?: string;

  /**
   * Field Deprecated, use virtualizationModel instead. The type of the virtio interface.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  virtioInterface?: VirtualMachineVirtioInterfaceType = VirtualMachineVirtioInterfaceType.Modern;

  /**
   * The type of the device model to use.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmDeviceModel?: VirtualMachineDeviceModelType = VirtualMachineDeviceModelType.T2;

  /**
   * The virtual machine image that is currently provisioned to the OS disk, using the full url and tag notation used to pull the image.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmImage: string;

  /**
   * The credentials used to login to the image repository that has access to the specified image.
   */
  vmImageRepositoryCredentials?: ImageRepositoryCredentials;
}

/**
 * VirtualMachineStatus represents the status of the virtual machine.
 */
model VirtualMachineStatus {
  /**
   * The cluster availability zone containing this virtual machine.
   */
  @visibility(Lifecycle.Read)
  availabilityZone?: string;

  /**
   * The resource ID of the bare metal machine that hosts the virtual machine.
   */
  @visibility(Lifecycle.Read)
  bareMetalMachineId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource ID of the cluster the virtual machine is created for.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The extended location to use for creation of a VM console resource.
   */
  consoleExtendedLocation?: Foundations.ExtendedLocation;

  /**
   * The more detailed status of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: VirtualMachineDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The power state of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  powerState?: VirtualMachinePowerState;

  /**
   * The resource IDs of volumes that are attached to the virtual machine.
   */
  @visibility(Lifecycle.Read)
  volumes?: string[];
}
