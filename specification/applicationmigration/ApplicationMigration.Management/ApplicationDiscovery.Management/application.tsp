import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./discoveryHub.tsp";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@resource("applications")
@parentResource(DiscoveryHub)
model Application is ProxyResource<ApplicationProperties> {
  ...ResourceNameParameter<
    Resource = Application,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}
