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
  @pattern(".*")
  name: Ocid;
}

@doc("Views resource model")
model DnsPrivateViewProperties {
  @doc("The OCID of the view")
  ocid: Ocid;

  @doc("The display name of the view resource")
  displayName: string;

  @doc("A Boolean flag indicating whether or not parts of the resource are unable to be explicitly managed.")
  isProtected: boolean;

  @doc("Views lifecycleState")
  lifecycleState: DnsPrivateViewsLifecycleState;

  @doc("The canonical absolute URL of the resource.")
  self: string;

  @doc("views timeCreated")
  timeCreated: utcDateTime;

  @doc("views timeUpdated")
  timeUpdated: utcDateTime;

  @doc("Azure resource provisioning state.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("DNS Private Views lifecycle state enum")
union DnsPrivateViewsLifecycleState {
  @doc("DNS Private View is active")
  Active: "Active",

  @doc("DNS Private View is deleted")
  Deleted: "Deleted",

  @doc("DNS Private View is deleting")
  Deleting: "Deleting",

  @doc("DNS Private View is updating")
  Updating: "Updating",

  string,
}
