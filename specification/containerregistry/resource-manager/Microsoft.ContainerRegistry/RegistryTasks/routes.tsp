// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface Registries {
  /**
   * Schedules a new run based on the request parameters and add it to the run queue.
   */
  @autoRoute
  scheduleRun is ArmProviderActionSync<
    Request = RunRequest,
    Response = Run,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the container registry.
       */
      @maxLength(50)
      @minLength(5)
      @pattern("^[a-zA-Z0-9]*$")
      @path
      @segment("registries")
      registryName: string;
    }
  >;
  /**
   * Get the upload location for the user to be able to upload the source.
   */
  @autoRoute
  @action("listBuildSourceUploadUrl")
  getBuildSourceUploadUrl is ArmProviderActionSync<
    Response = SourceUploadDefinition,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the container registry.
       */
      @maxLength(50)
      @minLength(5)
      @pattern("^[a-zA-Z0-9]*$")
      @path
      @segment("registries")
      registryName: string;
    }
  >;
}
