import "@azure-tools/typespec-azure-resource-manager";
import "../../models/anchors/resourceAnchor.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20250401_preview)
@armResourceOperations(ResourceAnchor)
interface ResourceAnchors
  extends OracleTrackedResource<ResourceAnchor, ResourceAnchorProperties> {}
