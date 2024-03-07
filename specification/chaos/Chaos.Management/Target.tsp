import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
/**
 * Model that represents a Target resource.
 */
model Target is ProxyResource<Record<unknown>> {
  /**
   * String that represents a Target resource name.
   */
  @pattern("^[a-zA-Z0-9_\\-\\.]+$")
  @path
  @key("targetName")
  @segment("targets")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Targets {
  /**
   * Get a Target resource that extends a tracked regional resource.
   */
  get is ArmResourceRead<Target>;

  /**
   * Create or update a Target resource that extends a tracked regional resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Target>;

  /**
   * Delete a Target resource that extends a tracked regional resource.
   */
  delete is ArmResourceDeleteSync<Target>;

  /**
   * Get a list of Target resources that extend a tracked regional resource.
   */
  list is ArmResourceListByParent<
    Target,
    {
      ...BaseParameters<Target>;

      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}

@@doc(Targets.createOrUpdate::parameters.resource,
  "Target resource to be created or updated."
);
