import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./applinkmember.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.AppLink;

@doc("AppLinkMember upgrade history")
@parentResource(AppLinkMember)
model UpgradeHistory is ProxyResource<UpgradeHistoryProperties> {
  ...ResourceNameParameter<UpgradeHistory>;
}

@doc("AppLinkMember upgrade history properties")
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

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface UpgradeHistories {
  @doc("List the upgrade history of an Azure Kubernetes Application Network member.")
  listByAppLinkMember is ArmResourceListByParent<UpgradeHistory>;
}
