import "./OneAssetPhysicalLocation.tsp";
import "./ServerHardware.tsp";
import "./HardwareInfo.tsp";

@discriminated(#{ discriminatorPropertyName: "type", envelope: "none" })
@doc("The model describing the physical location")
union PhysicalLocation {
  @doc("OneAsset physical location")
  OneAsset: OneAssetPhysicalLocation,
}

@doc("AszLabHardware.Lab/Server properties")
model ServerPropertiesBase {
  @visibility(Lifecycle.Read)
  @doc("The Serial Number of the Server.")
  serialNumber: string;

  @visibility(Lifecycle.Read)
  @doc("Asset tag of the server")
  assetTag: string;

  @visibility(Lifecycle.Read)
  @doc("Server Hardware Information")
  hardware?: HardwareInfo;

  @visibility(Lifecycle.Read)
  @doc("Physical location of the server")
  physicalLocation?: PhysicalLocation;
}
