import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./applinkmember.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AppLink;

@doc("AppLinkMember upgrade history")
@parentResource(AppLinkMember)
model UpgradeHistory is ProxyResource<UpgradeHistoryProperties> {
    ...ResourceNameParameter<UpgradeHistory>;
}

model UpgradeHistoryProperties {
  @doc("Start timestamp")
  startTimestamp: utcDateTime;

  @doc("End timestamp")
  endTimestamp?: utcDateTime;

  @doc("Upgrade initiator")
  initiatedBy: string;

  @doc("Version upgraded from")
  fromVersion: string;

  @doc("Version upgraded to")
  toVersion: string;
}


@armResourceOperations
interface UpgradeHistories {
    listByAppLinkMember is ArmResourceListByParent<UpgradeHistory>;
}
