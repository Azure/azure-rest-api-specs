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
model Watcher is TrackedResource<WatcherProperties> {
  @doc("The watcher name.")
  @key("watcherName")
  @segment("watchers")
  name: string;

  @doc("Gets or sets the etag of the resource.")
  etag?: string;
}

@armResourceOperations
interface Watcher {
  @doc("Retrieve the watcher identified by watcher name.")
  get is ArmResourceRead<Watcher>;
  @doc("Create the watcher identified by watcher name.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Watcher>;
  @doc("Update the watcher identified by watcher name.")
  update is ArmCustomPatchSync<Watcher, WatcherUpdateParameters>;
  @doc("Delete the watcher by name.")
  delete is ArmResourceDeleteSync<Watcher>;
  @doc("Retrieve a list of watchers.")
  listByAutomationAccount is ArmResourceListByParent<
    Watcher,
    {
      ...BaseParameters<Watcher>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Resume the watcher identified by watcher name.")
  start is ArmResourceActionSync<Watcher, void, void>;
  @doc("Resume the watcher identified by watcher name.")
  stop is ArmResourceActionSync<Watcher, void, void>;
}
