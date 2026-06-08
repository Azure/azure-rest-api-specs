import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SaaS;

@armResourceOperations
interface SaasSubscriptionLevel {
  get is ArmResourceRead<
    SaasResource,
    Parameters = ExpandCustomerDataQueryParameter
  >;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SaasResource>;
  update is ArmCustomPatchAsync<
    SaasResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      SaasResource,
      SaasResourceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SaasResource>;
  listByResourceGroup is ArmResourceListByParent<
    SaasResource,
    Parameters = ExpandCustomerDataQueryParameter
  >;
  listAccessToken is ArmResourceActionSync<
    SaasResource,
    void,
    AccessTokenResult
  >;
  /** Unsubscribes from a SaaS subscription, optionally providing a reason and feedback. The resource remains in Azure but the subscription is cancelled. */
  unsubscribe is ArmResourceActionAsync<
    SaasResource,
    UnsubscribeOptions,
    SaasResource
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Global operations not scoped to a single resource"
interface SaasSubscriptionLevelGlobal {
  listByAzureSubscription is ArmListBySubscription<
    SaasResource,
    Parameters = ExpandCustomerDataQueryParameter
  >;
  checkNameAvailability is checkGlobalNameAvailability;
}
