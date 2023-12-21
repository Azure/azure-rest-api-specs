import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Share.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataShare;
@doc("A provider side share subscription data transfer object.")
@parentResource(Share)
model ProviderShareSubscription
  is ProxyResource<ProviderShareSubscriptionProperties> {
  @doc("To locate shareSubscription")
  @path
  @key("providerShareSubscriptionId")
  @segment("providerShareSubscriptions")
  name: string;
}

@armResourceOperations
interface ProviderShareSubscriptions {
  @doc("Get share subscription in a provider share")
  getByShare is ArmResourceRead<ProviderShareSubscription>;
  @doc("List share subscriptions in a provider share")
  listByShare is ArmResourceListByParent<
    ProviderShareSubscription,
    {
      ...BaseParameters<ProviderShareSubscription>;

      @doc("Continuation Token")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
  @doc("Adjust a share subscription's expiration date in a provider share")
  adjust is ArmResourceActionSync<
    ProviderShareSubscription,
    ProviderShareSubscription,
    ProviderShareSubscription
  >;
  @doc("Reinstate share subscription in a provider share")
  reinstate is ArmResourceActionSync<
    ProviderShareSubscription,
    ProviderShareSubscription,
    ProviderShareSubscription
  >;
  @doc("Revoke share subscription in a provider share")
  revoke is ArmResourceActionAsync<
    ProviderShareSubscription,
    void,
    ProviderShareSubscription
  >;
}
