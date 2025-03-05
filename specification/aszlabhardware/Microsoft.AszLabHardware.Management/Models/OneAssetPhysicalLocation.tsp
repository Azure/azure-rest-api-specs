@doc("The OneAsset model describing the physical location")
model OneAssetPhysicalLocation {
  @visibility(Lifecycle.Read)
  @doc("OneAsset type")
  type: "OneAsset";

  @visibility(Lifecycle.Read)
  @doc("The physical datacenter")
  datacenter?: string;

  @visibility(Lifecycle.Read)
  @doc("The colocation")
  colocation?: string;

  @visibility(Lifecycle.Read)
  @doc("The colocation zone")
  colocationZone?: string;

  @visibility(Lifecycle.Read)
  @doc("The physical rack")
  rack?: string;

  @visibility(Lifecycle.Read)
  @doc("The chassis")
  chassis?: string;

  @visibility(Lifecycle.Read)
  @doc("The slot in the chassis")
  slotNumber?: int32;
}
