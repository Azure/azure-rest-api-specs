import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Share.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
/**
 * A provider side share subscription data transfer object.
 */
@parentResource(Share)
model ProviderShareSubscription
  is Azure.ResourceManager.ProxyResource<ProviderShareSubscriptionProperties> {
  ...ResourceNameParameter<
    Resource = ProviderShareSubscription,
    KeyName = "providerShareSubscriptionId",
    SegmentName = "providerShareSubscriptions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ProviderShareSubscriptions {
  /**
   * Get share subscription in a provider share
   */
  getByShare is ArmResourceRead<ProviderShareSubscription>;

  /**
   * List share subscriptions in a provider share
   */
  listByShare is ArmResourceListByParent<
    ProviderShareSubscription,
    Parameters = {
      /**
       * Continuation Token
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<ProviderShareSubscriptionList>
  >;

  /**
   * Adjust a share subscription's expiration date in a provider share
   */
  adjust is ArmResourceActionSync<
    ProviderShareSubscription,
    ProviderShareSubscription,
    ArmResponse<ProviderShareSubscription>
  >;

  /**
   * Reinstate share subscription in a provider share
   */
  reinstate is ArmResourceActionSync<
    ProviderShareSubscription,
    ProviderShareSubscription,
    ArmResponse<ProviderShareSubscription>
  >;

  /**
   * Revoke share subscription in a provider share
   */
  revoke is ArmResourceActionAsync<
    ProviderShareSubscription,
    void,
    ArmResponse<ProviderShareSubscription>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(ProviderShareSubscription.name, "To locate shareSubscription");
@@doc(ProviderShareSubscription.properties,
  "properties of providerShareSubscription"
);
@@doc(ProviderShareSubscriptions.adjust::parameters.body,
  "The provider share subscription"
);
@@doc(ProviderShareSubscriptions.reinstate::parameters.body,
  "The provider share subscription"
);
