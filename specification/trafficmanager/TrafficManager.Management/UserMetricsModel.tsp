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
@singleton("default")
@subscriptionResource
model UserMetricsModel
  is Azure.ResourceManager.ProxyResource<UserMetricsProperties> {
  ...ResourceNameParameter<
    Resource = UserMetricsModel,
    KeyName = "trafficManagerUserMetricsKey",
    SegmentName = "trafficManagerUserMetricsKeys",
    NamePattern = ""
  >;
}

@armResourceOperations
interface UserMetricsModelOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
    {
      ...ApiVersionParameter,
      ...SubscriptionIdParameter,
      ...Azure.ResourceManager.Legacy.Provider,

      /**
       * The user metrics keys. The default value is "default".
       */
      @path
      @segment("trafficManagerUserMetricsKeys")
      @key("trafficManagerUserMetricsKeys")
      trafficManagerUserMetricsKeys: "default",
    },
    {},
    ErrorType = CloudError
  >{}

@armResourceOperations
interface UserMetricsModels {
  /**
   * Get the subscription-level key used for Real User Metrics collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("TrafficManagerUserMetricsKeys_Get")
  get is ArmResourceRead<
    UserMetricsModel,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Create or update a subscription-level key used for Real User Metrics collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("TrafficManagerUserMetricsKeys_CreateOrUpdate")
  createOrUpdate is UserMetricsModelOps.CreateOrUpdateSync<
    UserMetricsModel,
    Request = void,
    Response = ArmResourceCreatedSyncResponse<UserMetricsModel>,
  >;

  /**
   * Delete a subscription-level key used for Real User Metrics collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("TrafficManagerUserMetricsKeys_Delete")
  delete is ArmResourceDeleteSync<
    UserMetricsModel,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<DeleteOperationResult>,
    Error = CloudError
  >;
}

@@doc(UserMetricsModel.name, "");
@@doc(UserMetricsModel.properties,
  "The properties of the Traffic Manager User Metrics."
);
