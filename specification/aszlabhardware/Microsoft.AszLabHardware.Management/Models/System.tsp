import "./ProcessorCollection.tsp";
import "./MemoryCollection.tsp";
import "./StorageCollection.tsp";
import "./NetworkCollection.tsp";

@doc("Details of the physical properties of the AszLabHw Server System")
model System {
  @doc("The IP Address of the server")
  // Add IP address regex validation?
  bmcIpAddress?: string;

  @doc("The manufacturer of the server")
  manufacturer?: string;

  @doc("The model of the server")
  `model`?: string;

  @doc("The part number of the server")
  partNumber?: string;

  @doc("The service tag of the server")
  serviceTag?: string;

  @doc("The serial number of the server")
  serialNumber?: string;

  @doc("The asset tag of the server")
  assetTag?: string;

  @doc("The host name of the server")
  hostName?: string;

  @doc("The BIOS version of the server")
  biosVersion?: string;

  @doc("The complex programmable logic device version of the server")
  cpldVersion?: string;

  @doc("The TPM of the server")
  tpm?: string;

  @doc("The firmware of the TPM")
  tpmFirmware?: string;

  @doc("The CPUs of the server")
  processorInventory?: ProcessorCollection;

  @doc("The memory information of the server")
  memoryInventory?: MemoryCollection;

  @doc("The disk information of the server")
  storageInventory?: StorageCollection;

  @doc("The network information of the server")
  networkInventory: NetworkCollection;
}
