using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Oracle.Database;

// https://docs.oracle.com/en-us/iaas/api/#/en/dns/20180115/

@doc("DnsPrivateView resource definition")
@parentResource(SubscriptionLocationResource)
model DnsPrivateView is ProxyResource<DnsPrivateViewProperties> {
  @doc("DnsPrivateView OCID")
  @key("dnsprivateviewocid")
  @path
  @segment("dnsPrivateViews")
  name: Ocid;
}

@doc("Views resource model")
model DnsPrivateViewProperties {

  @doc("The OCID of the view")
  @visibility("read")
  ocid: Ocid;

  @doc("The display name of the view resource")
  @visibility("read")
  displayName?: string;

  @doc("A Boolean flag indicating whether or not parts of the resource are unable to be explicitly managed.")
  @visibility("read")
  isProtected: boolean;

  @doc("Views lifecycleState")
  @visibility("read")
  lifecycleState?: DnsPrivateViewsLifecycleState;

  @doc("The canonical absolute URL of the resource.")
  @visibility("read")
  self: string;

  @doc("views timeCreated")
  @visibility("read")
  timeCreated: utcDateTime;

  @doc("views timeCreated")
  @visibility("read")
  timeUpdated: utcDateTime;

  @doc("Azure resource provisioning state.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("DnsPrivateViews lifecycle state enum")
enum DnsPrivateViewsLifecycleState {
  @doc("Active value")
  Active,

  @doc("Deleted value")
  Deleted,

  @doc("Deleting value")
  Deleting,

  @doc("Updating value")
  Updating,
}
