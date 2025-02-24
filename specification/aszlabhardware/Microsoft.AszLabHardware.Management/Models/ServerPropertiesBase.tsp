import "./OneAssetPhysicalLocation.tsp";
import "./ServerHardware.tsp";
import "./HardwareInfo.tsp";

@discriminator("type")
@doc("The model describing the physical location")
union PhysicalLocation {
  @doc("OneAsset physical location")
  oneAssetPhysicalLocation: OneAssetPhysicalLocation,
}

@doc("AszLabHardware.Lab/Server properties")
model ServerPropertiesBase {
  @visibility("read")
  @doc("The Serial Number of the Server.")
  serialNumber: string;

  @visibility("read")
  @doc("Asset tag of the server")
  assetTag: string;

  @visibility("read")
  @doc("Server Hardware Information")
  hardware?: HardwareInfo;

  @visibility("read")
  @doc("Physical location of the server")
  physicalLocation?: PhysicalLocation;
}
