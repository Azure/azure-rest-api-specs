import "./DriveCollection.tsp";

@doc("Information regarding the storage of the server")
model StorageCollection {
  @doc("Number of disk drives")
  totalDriveCount: int32;

  @doc("The total capacity in bytes")
  totalDriveCapacityBytes: int64;

  @doc("SSD_SATA Disk drive collections")
  ssdSata: DriveCollection;

  @doc("HDD Disk drive collections")
  hdd: DriveCollection;

  @doc("SSD_NVMe Disk drive collections")
  ssdNvme: DriveCollection;
}
