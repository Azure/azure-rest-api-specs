import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
// FIXME: Trigger has no properties property
/**
 * Trigger details.
 */
@parentResource(DataBoxEdgeDevice)
model Trigger is ProxyResource<{}> {
  /**
   * The trigger name.
   */
  @path
  @key("name")
  @segment("triggers")
  @visibility("read")
  name: string;

  /**
   * Trigger Kind.
   */
  kind: TriggerEventType;
}

@armResourceOperations
interface Triggers {
  /**
   * Get a specific trigger by name.
   */
  get is ArmResourceRead<Trigger>;

  /**
   * Creates or updates a trigger.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Trigger>;

  /**
   * Deletes the trigger on the gateway device.
   */
  delete is ArmResourceDeleteAsync<Trigger>;

  /**
   * Lists all the triggers configured in the device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Triggers_ListByDataBoxEdgeDevice")
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    Trigger,
    {
      ...BaseParameters<Trigger>;

      /**
       * Specify $filter='CustomContextTag eq <tag>' to filter on custom context tag property
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(Triggers.createOrUpdate::parameters.resource,
  "json",
  "trigger"
);
@@extension(Triggers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "trigger"
);
@@doc(Triggers.createOrUpdate::parameters.resource, "The trigger.");
