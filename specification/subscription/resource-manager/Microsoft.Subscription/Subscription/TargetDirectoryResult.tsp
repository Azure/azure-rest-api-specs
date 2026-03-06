import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Subscription;
/**
 * Subscription Response for Changed Target Directory.
 */
@singleton("default")
@subscriptionResource
model TargetDirectoryResult
  is Azure.ResourceManager.ProxyResource<TargetDirectoryResultProperties> {
  ...ResourceNameParameter<
    Resource = TargetDirectoryResult,
    KeyName = "changeTenantRequest",
    SegmentName = "changeTenantRequest",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TargetDirectoryResults {
  /**
   * The operation to view Initiator Subscription Changed Request
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Subscriptions_GetTargetDirectory")
  getTargetDirectory is ArmResourceRead<
    TargetDirectoryResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * The operation to initiate Subscription Changed Request
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Subscriptions_PutTargetDirectory")
  putTargetDirectory is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    TargetDirectoryResult,
    Request = TargetDirectoryRequest,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResourceUpdatedResponse<TargetDirectoryResult>
  >;

  /**
   * The operation to delete Initiator Subscription Changed Request
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Subscriptions_DeleteTargetDirectory")
  deleteTargetDirectory is ArmResourceDeleteSync<
    TargetDirectoryResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmDeletedResponse
  >;

  /**
   * The operation to list Initiator Subscription Changed Request
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Subscriptions_ListTargetDirectory")
  listTargetDirectory is ArmResourceListByParent<
    TargetDirectoryResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(TargetDirectoryResult.name, "");
@@doc(TargetDirectoryResult.properties,
  "Subscription Changed Target Directory response properties."
);
@@doc(TargetDirectoryResults.putTargetDirectory::parameters.resource,
  "Target Directory Request"
);
