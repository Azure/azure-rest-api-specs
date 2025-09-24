import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Class representing Traffic Manager User Metrics.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@subscriptionResource
model UserMetricsModel extends ProxyResource {
  properties?: UserMetricsProperties;
}

alias UserMetricsModelOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /**
     * The user metrics keys. The default value is "default".
     */
    @path
    @segment("trafficManagerUserMetricsKeys")
    @key("trafficManagerUserMetricsKeys")
    trafficManagerUserMetricsKeys: "default";
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface UserMetricsModels {
  /**
   * Get the subscription-level key used for Real User Metrics collection.
   */
  get is UserMetricsModelOps.Read<UserMetricsModel>;

  /**
   * Create or update a subscription-level key used for Real User Metrics collection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is UserMetricsModelOps.CreateOrUpdateSync<
    Resource = UserMetricsModel,
    Response = ArmResourceCreatedSyncResponse<UserMetricsModel>,
    Request = void
  >;

  /**
   * Delete a subscription-level key used for Real User Metrics collection.
   */
  delete is UserMetricsModelOps.DeleteSync<
    UserMetricsModel,
    Response = ArmResponse<DeleteOperationResult>
  >;
}

@@doc(UserMetricsModel.name, "");
@@doc(UserMetricsModel.properties,
  "The properties of the Traffic Manager User Metrics."
);
