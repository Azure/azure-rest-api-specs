@doc("The different types of drives")
union DriveType {
  @doc("Hard Disk Drive")
  Hdd: "HDD",

  @doc("SATA SSD")
  SataSsd: "SATASSD",

  @doc("NVME SSD")
  NvmeSsd: "NVMESSD",

  string,
}

@doc("Information about the drive")
model ServerHardwareDrive {
  @doc("The manufacturer of the drive")
  manufacturer?: string;

  @doc("The model of the drive")
  `model`?: string;

  @doc("The type of the drive")
  type?: DriveType;

  @doc("The total capacity of the drive")
  capacityGb?: int32;
}
