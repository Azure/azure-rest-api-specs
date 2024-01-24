import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the watcher type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@Azure.ResourceManager.Private.armResourceInternal(WatcherProperties)
@includeInapplicableMetadataInPayload(false)
model Watcher extends TrackedResourceBase {
  /**
   * The watcher name.
   */
  @path
  @key("watcherName")
  @segment("watchers")
  name: string;

  /**
   * Gets or sets the etag of the resource.
   */
  etag?: string;

  /**
   * Gets or sets the watcher properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WatcherProperties;
}

@armResourceOperations
interface Watchers {
  /**
   * Retrieve the watcher identified by watcher name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Watcher_Get")
  get is ArmResourceRead<Watcher>;

  /**
   * Create the watcher identified by watcher name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Watcher_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Watcher>;

  /**
   * Update the watcher identified by watcher name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Watcher_Update")
  update is ArmCustomPatchSync<Watcher, WatcherUpdateParameters>;

  /**
   * Delete the watcher by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Watcher_Delete")
  delete is ArmResourceDeleteSync<Watcher>;

  /**
   * Retrieve a list of watchers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Watcher_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    Watcher,
    {
      ...BaseParameters<Watcher>;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Resume the watcher identified by watcher name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Watcher_Start")
  start is ArmResourceActionSync<Watcher, void, void>;

  /**
   * Resume the watcher identified by watcher name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Watcher_Stop")
  stop is ArmResourceActionSync<Watcher, void, void>;
}

@@projectedName(Watchers.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Watchers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Watchers.createOrUpdate::parameters.resource,
  "The create or update parameters for watcher."
);
@@projectedName(Watchers.update::parameters.properties, "json", "parameters");
@@extension(Watchers.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Watchers.update::parameters.properties,
  "The update parameters for watcher."
);
