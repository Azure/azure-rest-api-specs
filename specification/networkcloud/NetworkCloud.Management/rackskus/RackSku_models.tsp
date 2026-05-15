import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Microsoft.NetworkCloud;

/**
 * The type of bootstrap protocol used.
 */
union BootstrapProtocol {
  string,

  /**
   * PXE bootstrap protocol
   */
  PXE: "PXE",
}

/**
 * The connection type of the rack SKU resource.
 */
union MachineSkuDiskConnectionType {
  string,

  /**
   * PCIE connection type
   */
  PCIE: "PCIE",

  /**
   * SATA connection type
   */
  SATA: "SATA",

  /**
   * RAID connection type
   */
  RAID: "RAID",

  /**
   * SAS connection type
   */
  SAS: "SAS",
}

/**
 * The disk type of rack SKU resource.
 */
union DiskType {
  string,

  /**
   * HDD disk type
   */
  HDD: "HDD",

  /**
   * SSD disk type
   */
  SSD: "SSD",
}

/**
 * The connection type of the device.
 */
union DeviceConnectionType {
  string,

  /**
   * PCI connection type
   */
  PCI: "PCI",
}

/**
 * The provisioning state of the rack SKU resource.
 */
union RackSkuProvisioningState {
  string,

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",
}

/**
 * The type of the rack.
 */
union RackSkuType {
  string,

  /**
   * Aggregator Rack
   */
  Aggregator: "Aggregator",

  /**
   * Compute Rack
   */
  Compute: "Compute",

  /**
   * Combination of Aggregator Rack and Compute Rack for a single rack cluster
   */
  Single: "Single",
}

/**
 * RackSkuList represents a list of rack SKUs.
 */
model RackSkuList is Azure.Core.Page<RackSku>;

/**
 * RackSkuProperties represents the properties of compute-related hardware for a rack. This supports both aggregator and compute racks.
 */
model RackSkuProperties {
  /**
   * The list of machine SKUs and associated rack slot for the compute-dedicated machines in this rack model.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  computeMachines?: MachineSkuSlot[];

  /**
   * The list of machine SKUs and associated rack slot for the control-plane dedicated machines in this rack model.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  controllerMachines?: MachineSkuSlot[];

  /**
   * The deployment type supported by the rack SKU.
   */
  @added(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  deploymentType?: DeploymentType;

  /**
   * The free-form text describing the rack.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The maximum number of compute racks supported by an aggregator rack. 0 if this is a compute rack or a rack for a single rack cluster(rackType="Single").
   */
  @visibility(Lifecycle.Read)
  maxClusterSlots?: int64;

  /**
   * The provisioning state of the rack SKU resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: RackSkuProvisioningState;

  /**
   * The type of the rack.
   */
  @visibility(Lifecycle.Read)
  rackType?: RackSkuType;

  /**
   * The list of appliance SKUs and associated rack slot for the storage appliance(s) in this rack model.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  storageAppliances?: StorageApplianceSkuSlot[];

  /**
   * The list of supported SKUs if the rack is an aggregator.
   */
  @visibility(Lifecycle.Read)
  supportedRackSkuIds?: string[];
}

/**
 * MachineSkuSlot represents a single SKU and rack slot associated with the machine.
 */
model MachineSkuSlot {
  /**
   * The list of the resource properties.
   */
  properties?: MachineSkuProperties;

  /**
   * The position in the rack for the machine.
   */
  @visibility(Lifecycle.Read)
  rackSlot?: int64;
}

/**
 * MachineSkuProperties represents the properties of the machine SKU.
 */
model MachineSkuProperties {
  /**
   * The type of bootstrap protocol used.
   */
  @visibility(Lifecycle.Read)
  bootstrapProtocol?: BootstrapProtocol;

  /**
   * The count of CPU cores for this machine.
   */
  @visibility(Lifecycle.Read)
  cpuCores?: int64;

  /**
   * The count of CPU sockets for this machine.
   */
  @visibility(Lifecycle.Read)
  cpuSockets?: int64;

  /**
   * The list of disks.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  disks?: MachineDisk[];

  /**
   * The generation of the architecture.
   */
  @visibility(Lifecycle.Read)
  generation?: string;

  /**
   * The hardware version of the machine.
   */
  @visibility(Lifecycle.Read)
  hardwareVersion?: string;

  /**
   * The maximum amount of memory. Measured in gibibytes.
   */
  @visibility(Lifecycle.Read)
  @clientName("memoryCapacityGB")
  @encodedName("application/json", "memoryCapacityGB")
  memoryCapacityGb?: int64;

  /**
   * The model of the machine.
   */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /**
   * The list of network interfaces.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  networkInterfaces?: NetworkInterface[];

  /**
   * The count of SMT and physical core threads for this machine.
   */
  @visibility(Lifecycle.Read)
  totalThreads?: int64;

  /**
   * The make of the machine.
   */
  @visibility(Lifecycle.Read)
  vendor?: string;
}

/**
 * MachineDisk represents the properties of the disk.
 */
model MachineDisk {
  /**
   * The maximum amount of storage. Measured in gibibytes.
   */
  @visibility(Lifecycle.Read)
  @clientName("capacityGB")
  @encodedName("application/json", "capacityGB")
  capacityGb?: int64;

  /**
   * The connection type of the rack SKU resource.
   */
  @visibility(Lifecycle.Read)
  connection?: MachineSkuDiskConnectionType;

  /**
   * The disk type of rack SKU resource.
   */
  @visibility(Lifecycle.Read)
  type?: DiskType;
}

/**
 * NetworkInterface represents properties of the network interface.
 */
model NetworkInterface {
  /**
   * The partial address of Peripheral Component Interconnect (PCI).
   */
  @visibility(Lifecycle.Read)
  address?: string;

  /**
   * The connection type of the device.
   */
  @visibility(Lifecycle.Read)
  deviceConnectionType?: DeviceConnectionType;

  /**
   * The model name of the device.
   */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /**
   * The physical slot for this device.
   */
  @visibility(Lifecycle.Read)
  physicalSlot?: int64;

  /**
   * The number of ports on the device.
   */
  @visibility(Lifecycle.Read)
  portCount?: int64;

  /**
   * The maximum amount of data in gigabits that the line card transmits through a port at any given second.
   */
  @visibility(Lifecycle.Read)
  portSpeed?: int64;

  /**
   * The vendor name of the device.
   */
  @visibility(Lifecycle.Read)
  vendor?: string;
}

/**
 * StorageApplianceSkuSlot represents the single SKU and rack slot associated with the storage appliance.
 */
model StorageApplianceSkuSlot {
  /**
   * The list of the resource properties.
   */
  properties?: StorageApplianceSkuProperties;

  /**
   * The position in the rack for the storage appliance.
   */
  @visibility(Lifecycle.Read)
  rackSlot?: int64;
}

/**
 * StorageApplianceSkuProperties represents the properties of the storage appliance SKU.
 */
model StorageApplianceSkuProperties {
  /**
   * The maximum capacity of the storage appliance. Measured in gibibytes.
   */
  @visibility(Lifecycle.Read)
  @clientName("capacityGB")
  @encodedName("application/json", "capacityGB")
  capacityGb?: int64;

  /**
   * The model of the storage appliance.
   */
  @visibility(Lifecycle.Read)
  `model`?: string;
}
