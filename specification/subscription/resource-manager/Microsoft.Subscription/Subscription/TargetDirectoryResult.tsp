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

model GetTargetDirectoryBaseParameters
  is Azure.ResourceManager.Foundations.SubscriptionBaseParameters;
model PutTargetDirectoryBaseParameters
  is Azure.ResourceManager.Foundations.SubscriptionBaseParameters;
model DeleteTargetDirectoryBaseParameters
  is Azure.ResourceManager.Foundations.SubscriptionBaseParameters;
model ListTargetDirectoryBaseParameters
  is Azure.ResourceManager.Foundations.SubscriptionBaseParameters;

@armResourceOperations(#{ omitTags: true })
interface TargetDirectoryResults {
  /**
   * The operation to view Initiator Subscription Changed Request
   */
  getTargetDirectory is ArmResourceRead<
    TargetDirectoryResult,
    BaseParameters = GetTargetDirectoryBaseParameters
  >;

  /**
   * The operation to initiate Subscription Changed Request
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  putTargetDirectory is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    TargetDirectoryResult,
    Request = TargetDirectoryRequest,
    BaseParameters = PutTargetDirectoryBaseParameters,
    Response = ArmResourceUpdatedResponse<TargetDirectoryResult>
  >;

  /**
   * The operation to delete Initiator Subscription Changed Request
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteTargetDirectory is ArmResourceDeleteSync<
    TargetDirectoryResult,
    BaseParameters = DeleteTargetDirectoryBaseParameters,
    Response = ArmDeletedResponse
  >;

  /**
   * The operation to list Initiator Subscription Changed Request
   */
  listTargetDirectory is ArmResourceListByParent<
    TargetDirectoryResult,
    BaseParameters = ListTargetDirectoryBaseParameters,
    Response = ArmResponse<TargetDirectoryListResult>
  >;
}

@@doc(TargetDirectoryResult.name, "");
@@doc(TargetDirectoryResult.properties,
  "Subscription Changed Target Directory response properties."
);
@@doc(TargetDirectoryResults.putTargetDirectory::parameters.resource,
  "Target Directory Request"
);
