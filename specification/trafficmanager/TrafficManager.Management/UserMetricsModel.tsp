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
@singleton("default")
@subscriptionResource
model UserMetricsModel extends ProxyResource {
  properties: UserMetricsProperties;
}

alias UserMetricsModelOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {},
  ErrorType = CloudError
>;

@armResourceOperations
interface UserMetricsModels {
  /**
   * Get the subscription-level key used for Real User Metrics collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is ArmResourceRead<
    UserMetricsModel,
    Parameters = {
      /**
       * The user metrics keys. The default value is "default".
       */
      @path
      @segment("trafficManagerUserMetricsKeys")
      @key("trafficManagerUserMetricsKeys")
      trafficManagerUserMetricsKeys: "default";
    },
    Error = CloudError
  >;

  /**
   * Create or update a subscription-level key used for Real User Metrics collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is UserMetricsModelOps.CreateOrUpdateSync<
    Resource = UserMetricsModel,
    Parameters = {
      /**
       * The user metrics keys. The default value is "default".
       */
      @path
      @segment("trafficManagerUserMetricsKeys")
      @key("trafficManagerUserMetricsKeys")
      trafficManagerUserMetricsKeys: "default";
    },
    Response = ArmResourceCreatedSyncResponse<UserMetricsModel>,
    OverrideErrorType = CloudError,
    Request = void
  >;

  /**
   * Delete a subscription-level key used for Real User Metrics collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteSync<
    UserMetricsModel,
    Parameters = {
      /**
       * The user metrics keys. The default value is "default".
       */
      @path
      @segment("trafficManagerUserMetricsKeys")
      @key("trafficManagerUserMetricsKeys")
      trafficManagerUserMetricsKeys: "default";
    },
    Response = ArmResponse<DeleteOperationResult>,
    Error = CloudError
  >;
}

@@doc(UserMetricsModel.name, "");
@@doc(UserMetricsModel.properties,
  "The properties of the Traffic Manager User Metrics."
);
