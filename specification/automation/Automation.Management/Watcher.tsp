import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the watcher type.
 */
@parentResource(AutomationAccount)
model Watcher is Azure.ResourceManager.ProxyResource<WatcherProperties> {
  ...ResourceNameParameter<
    Resource = Watcher,
    KeyName = "watcherName",
    SegmentName = "watchers",
    NamePattern = ""
  >;

  /**
   * Gets or sets the etag of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

@tag("Watcher")
@armResourceOperations(#{ omitTags: true })
interface Watchers {
  /**
   * Retrieve the watcher identified by watcher name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/watcheroperations")
  get is ArmResourceRead<Watcher>;

  /**
   * Create the watcher identified by watcher name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/watcheroperations")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Watcher>;

  /**
   * Update the watcher identified by watcher name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/watcheroperations")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Watcher, PatchModel = WatcherUpdateParameters>;

  /**
   * Delete the watcher by name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/watcheroperations")
  delete is ArmResourceDeleteSync<Watcher, Response = ArmDeletedResponse>;

  /**
   * Retrieve a list of watchers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/watcheroperations")
  listByAutomationAccount is ArmResourceListByParent<
    Watcher,
    Parameters = {
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/watcheroperations")
  start is ArmResourceActionSync<Watcher, void, OkResponse>;

  /**
   * Resume the watcher identified by watcher name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/watcheroperations")
  stop is ArmResourceActionSync<Watcher, void, OkResponse>;
}

@@doc(Watcher.name, "The watcher name.");
@@doc(Watcher.properties, "Gets or sets the watcher properties.");
@@doc(
  Watchers.createOrUpdate::parameters.resource,
  "The create or update parameters for watcher."
);
@@doc(
  Watchers.update::parameters.properties,
  "The update parameters for watcher."
);
