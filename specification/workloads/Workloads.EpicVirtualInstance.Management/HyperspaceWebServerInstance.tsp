import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EpicVirtualInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * Define the Epic HyperspaceWeb Server Instance resource.
 */
@parentResource(EpicVirtualInstance)
model HyperspaceWebServerInstance
  is TrackedResource<HyperspaceWebServerProperties> {
  /**
   * The name of Epic HyperspaceWeb Server instance resource.
   */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,78}[a-zA-Z0-9_]")
  @path
  @key("hyperspaceWebInstanceName")
  @segment("hyperspaceWebInstances")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface HyperspaceWebServerInstances {
  /**
   * Gets the Epic HyperspaceWeb Server Instance corresponding to the Virtual Instance for Epic solutions resource.
   */
  get is ArmResourceRead<HyperspaceWebServerInstance>;

  /**
   * Puts the Epic HyperspaceWeb Server Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT by end user will return a Bad Request error.
   */
  create is ArmResourceCreateOrReplaceAsync<HyperspaceWebServerInstance>;

  /**
   * Puts the Epic HyperspaceWeb Server Instance resource.
   */
  @parameterVisibility
  update is ArmTagsPatchSync<HyperspaceWebServerInstance>;

  /**
   * Deletes the Epic HyperspaceWeb Server Instance resource. &lt;br&gt;&lt;br&gt;This operation will be used by service only. Delete by end user will return a Bad Request error.
   */
  delete is ArmResourceDeleteWithoutOkAsync<HyperspaceWebServerInstance>;

  /**
   * Lists the Epic HyperspaceWeb Server Instance resources for a given Virtual Instance for Epic solutions resource.
   */
  listByEpicVirtualInstance is ArmResourceListByParent<HyperspaceWebServerInstance>;
}
