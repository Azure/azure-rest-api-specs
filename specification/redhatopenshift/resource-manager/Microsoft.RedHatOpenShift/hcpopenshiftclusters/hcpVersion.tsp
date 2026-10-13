import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.RedHatOpenShift;

@armResourceOperations(HcpOpenShiftVersion)
interface HcpOpenShiftVersions {
  get is ArmResourceRead<HcpOpenShiftVersion>;
  list is ArmResourceListByParent<HcpOpenShiftVersion>;
}

/** HcpOpenShiftVersion represents a location based available HCP OpenShift version */
@parentResource(SubscriptionLocationResource)
model HcpOpenShiftVersion is ProxyResource<HcpOpenShiftVersionProperties> {
  ...ResourceNameParameter<
    HcpOpenShiftVersion,
    NamePattern = "^[a-zA-Z0-9-\\.]{3,24}$"
  >;
}

/** HcpOpenShiftVersionProperties contains details of an available HCP Openshift version */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Proxy resource does not have provisioning state"
model HcpOpenShiftVersionProperties {
  /** ChannelGroup is the name of the group where this version belongs. */
  channelGroup: string;

  /** Enabled indicates if this version can be used to create clusters. */
  enabled: boolean;

  /** EndOfLifeTimestamp is the date and time when this version will reach End of Life. */
  endOfLifeTimestamp: utcDateTime;
}
