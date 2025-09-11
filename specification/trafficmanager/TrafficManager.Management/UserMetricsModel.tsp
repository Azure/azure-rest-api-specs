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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is UserMetricsModelOps.Read<UserMetricsModel>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Create or update a subscription-level key used for Real User Metrics collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is UserMetricsModelOps.CreateOrUpdateSync<
    Resource = UserMetricsModel,
    Response = ArmResourceCreatedSyncResponse<UserMetricsModel>,
    OverrideErrorType = CloudError,
    Request = void
  >;

  /**
   * Delete a subscription-level key used for Real User Metrics collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is UserMetricsModelOps.DeleteSync<
    Resource = UserMetricsModel,
    Response = ArmResponse<DeleteOperationResult>,
    OverrideErrorType = CloudError
  >;
  // delete is ArmResourceDeleteSync<
  //   UserMetricsModel,
  //   BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
  //   Response = ArmResponse<DeleteOperationResult>,
  //   Error = CloudError
  // >;
}

@@doc(UserMetricsModel.name, "");
@@doc(UserMetricsModel.properties,
  "The properties of the Traffic Manager User Metrics."
);
