import "./Drive.tsp";

@doc("Information regarding collection of disk drives")
model DriveCollection {
  @doc("Total count of drives")
  totalDriveCount: int32;

  @doc("The total capacity in bytes")
  totalDriveCapacityBytes: int64;

  @doc("Information about individual disk drives")
  drives: Drive[];
}
