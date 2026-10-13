import "@azure-tools/typespec-azure-resource-manager";
import "../../models/anchors/networkAnchor.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20250401_preview)
@armResourceOperations(NetworkAnchor)
interface NetworkAnchors
  extends OracleTrackedResource<NetworkAnchor, NetworkAnchorProperties> {}
