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
@doc("Definition of the watcher type.")
@parentResource(AutomationAccount)
model Watcher is TrackedResource<WatcherProperties> {
  @doc("The watcher name.")
  @path
  @key("watcherName")
  @segment("watchers")
  name: string;

  @doc("Gets or sets the etag of the resource.")
  etag?: string;
}

@armResourceOperations
interface Watchers {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the watcher identified by watcher name.")
  @operationId("Watcher_Get")
  get is ArmResourceRead<Watcher>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create the watcher identified by watcher name.")
  @operationId("Watcher_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Watcher>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the watcher identified by watcher name.")
  @operationId("Watcher_Update")
  update is ArmCustomPatchSync<Watcher, WatcherUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the watcher by name.")
  @operationId("Watcher_Delete")
  delete is ArmResourceDeleteSync<Watcher>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of watchers.")
  @operationId("Watcher_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    Watcher,
    {
      ...BaseParameters<Watcher>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Resume the watcher identified by watcher name.")
  @operationId("Watcher_Start")
  start is ArmResourceActionSync<Watcher, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Resume the watcher identified by watcher name.")
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
