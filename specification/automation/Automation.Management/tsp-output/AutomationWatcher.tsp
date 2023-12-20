import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automation;
@doc("Definition of the watcher type.")
@parentResource(AutomationAccount)
model AutomationWatcher is TrackedResource<WatcherProperties> {
  @doc("The watcher name.")
  @path
  @key("watcherName")
  @segment("watchers")
  name: string;
}

@armResourceOperations
interface AutomationWatchers {
  @doc("Retrieve the watcher identified by watcher name.")
  get is ArmResourceRead<AutomationWatcher>;
  @doc("Create the watcher identified by watcher name.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationWatcher>;
  @doc("Update the watcher identified by watcher name.")
  update is ArmResourcePatchSync<AutomationWatcher, WatcherProperties>;
  @doc("Delete the watcher by name.")
  delete is ArmResourceDeleteSync<AutomationWatcher>;
  @doc("Retrieve a list of watchers.")
  listByAutomationAccount is ArmResourceListByParent<
    AutomationWatcher,
    {
      ...BaseParameters<AutomationWatcher>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Resume the watcher identified by watcher name.")
  start is ArmResourceActionSync<AutomationWatcher, void, void>;
  @doc("Resume the watcher identified by watcher name.")
  stop is ArmResourceActionSync<AutomationWatcher, void, void>;
}
