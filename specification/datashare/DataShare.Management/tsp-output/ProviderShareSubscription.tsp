import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Share.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
/**
 * A provider side share subscription data transfer object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Share)
@includeInapplicableMetadataInPayload(false)
model ProviderShareSubscription extends ProxyDto {
  /**
   * To locate shareSubscription
   */
  @path
  @key("providerShareSubscriptionId")
  @segment("providerShareSubscriptions")
  @visibility("read")
  name: string;

  /**
   * properties of providerShareSubscription
   */
  @extension("x-ms-client-flatten", true)
  properties?: ProviderShareSubscriptionProperties;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProviderShareSubscriptions_ListByShare")
  listByShare is ArmResourceListByParent<
    ProviderShareSubscription,
    {
      ...BaseParameters<ProviderShareSubscription>;

      /**
       * Continuation Token
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * Adjust a share subscription's expiration date in a provider share
   */
  adjust is ArmResourceActionSync<
    ProviderShareSubscription,
    ProviderShareSubscription,
    ProviderShareSubscription
  >;

  /**
   * Reinstate share subscription in a provider share
   */
  reinstate is ArmResourceActionSync<
    ProviderShareSubscription,
    ProviderShareSubscription,
    ProviderShareSubscription
  >;

  /**
   * Revoke share subscription in a provider share
   */
  revoke is ArmResourceActionAsync<
    ProviderShareSubscription,
    void,
    ProviderShareSubscription,
    BaseParameters<ProviderShareSubscription>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(ProviderShareSubscriptions.adjust::parameters.body,
  "json",
  "providerShareSubscription"
);
@@extension(ProviderShareSubscriptions.adjust::parameters.body,
  "x-ms-client-name",
  "providerShareSubscription"
);
@@doc(ProviderShareSubscriptions.adjust::parameters.body,
  "The provider share subscription"
);
@@projectedName(ProviderShareSubscriptions.reinstate::parameters.body,
  "json",
  "providerShareSubscription"
);
@@extension(ProviderShareSubscriptions.reinstate::parameters.body,
  "x-ms-client-name",
  "providerShareSubscription"
);
@@doc(ProviderShareSubscriptions.reinstate::parameters.body,
  "The provider share subscription"
);
