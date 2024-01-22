import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ShareSubscription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
// FIXME: Trigger has no properties property
/**
 * A Trigger data transfer object.
 */
@parentResource(ShareSubscription)
model Trigger is ProxyResource<{}> {
  /**
   * The name of the trigger.
   */
  @path
  @key("triggerName")
  @segment("triggers")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
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
  create is ArmResourceCreateOrReplaceAsync<Trigger>;

  /**
   * Delete a Trigger in a shareSubscription
   */
  delete is ArmResourceDeleteAsync<Trigger>;

  /**
   * List Triggers in a share subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Triggers_ListByShareSubscription")
  listByShareSubscription is ArmResourceListByParent<
    Trigger,
    {
      ...BaseParameters<Trigger>;

      /**
       * Continuation token
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

@@projectedName(Triggers.create::parameters.resource, "json", "trigger");
@@extension(Triggers.create::parameters.resource,
  "x-ms-client-name",
  "trigger"
);
@@doc(Triggers.create::parameters.resource, "Trigger details.");
