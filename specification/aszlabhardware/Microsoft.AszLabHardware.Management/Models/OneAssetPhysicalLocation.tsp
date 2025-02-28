@doc("The OneAsset model describing the physical location")
model OneAssetPhysicalLocation {
  @visibility("read")
  @doc("OneAsset type")
  type: "OneAsset";

  @visibility("read")
  @doc("The physical datacenter")
  datacenter?: string;

  @visibility("read")
  @doc("The colocation")
  colocation?: string;

  @visibility("read")
  @doc("The colocation zone")
  colocationZone?: string;

  @visibility("read")
  @doc("The physical rack")
  rack?: string;

  @visibility("read")
  @doc("The chassis")
  chassis?: string;

  @visibility("read")
  @doc("The slot in the chassis")
  slotNumber?: int32;
}
