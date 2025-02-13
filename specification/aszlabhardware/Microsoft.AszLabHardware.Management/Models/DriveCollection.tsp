import "./Drive.tsp";

using OpenAPI;

@doc("Information regarding collection of disk drives")
model DriveCollection {
  @doc("Total count of drives")
  totalDriveCount: int32;

  @doc("The total capacity in bytes")
  totalDriveCapacityBytes: int64;

  @doc("Information about individual disk drives")
  @extension("x-ms-identifiers", ["diskId"])
  drives: Drive[];
}
