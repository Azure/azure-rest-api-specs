@doc("Information about the individual memory modules of the server")
model MemoryModule {
  @doc("Name of the memory module")
  moduleName?: string;

  @doc("Location of the memory module")
  moduleLocation?: string;

  @doc("Manufacturer of the memory module")
  manufacturer?: string;

  @doc("Part number of the memory module")
  partNumber?: string;

  @doc("Serial number of the memory module")
  serialNumber?: string;

  @doc("Capacity of memory module in MiB")
  capacityMiB: int64;

  @doc("Device type of memory module")
  memoryDeviceType?: string;

  @doc("Product ID of memory module")
  moduleProductId?: string;
}
