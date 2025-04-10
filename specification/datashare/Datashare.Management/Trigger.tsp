import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ShareSubscription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
// FIXME: Trigger has no properties property
/**
 * A Trigger data transfer object.
 */
@parentResource(ShareSubscription)
model Trigger is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = Trigger,
    KeyName = "triggerName",
    SegmentName = "triggers",
    NamePattern = ""
  >;

  /**
   * Kind of synchronization on trigger.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: TriggerKind;
}

@armResourceOperations
interface Triggers {
  /**
   * Get a Trigger in a shareSubscription
   */
  get is ArmResourceRead<Trigger>;

  /**
   * Create a Trigger
   */
  create is ArmResourceCreateOrReplaceAsync<
    Trigger,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a Trigger in a shareSubscription
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Trigger,
    Response = ArmResponse<OperationResponse> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List Triggers in a share subscription
   */
  listByShareSubscription is ArmResourceListByParent<
    Trigger,
    Parameters = {
      /**
       * Continuation token
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<TriggerList>
  >;
}

@@doc(Trigger.name, "The name of the trigger.");
@@doc(Triggers.create::parameters.resource, "Trigger details.");
