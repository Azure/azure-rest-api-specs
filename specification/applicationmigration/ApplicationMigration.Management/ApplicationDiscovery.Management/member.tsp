import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./discoveryHub.tsp";
import "./application.tsp";
import "./models.tsp";
import "./main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@parentResource(Application)
model Member is ProxyResource<MemberProperties> {
  ...ResourceNameParameter<
    Resource = Member,
    KeyName = "memberName",
    SegmentName = "members",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}
