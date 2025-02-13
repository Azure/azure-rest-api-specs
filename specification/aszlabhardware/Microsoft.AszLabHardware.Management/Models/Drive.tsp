@doc("Information regarding individual Disk Drives")
model Drive {
  @doc("The Id of the disk drive")
  diskId?: string;

  @doc("Description of the disk drive")
  description?: string;

  @doc("Manufacturer of the disk drive")
  manufacturer?: string;

  @doc("Disk drive model")
  `model`?: string;

  @doc("Part number of the disk drive")
  partNumber?: string;

  @doc("Serial number of the disk drive")
  serialNumber?: string;

  @doc("Firmware version of the disk drive")
  firmwareVersion?: string;

  @doc("Media type of the disk drive")
  mediaType?: string;

  @doc("Capacity of the disk drive in bytes")
  capacityBytes: int64;
}
