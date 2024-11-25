import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
/**
 * Model that represents a Target resource.
 */
model Target is Azure.ResourceManager.ProxyResource<Record<unknown>> {
  ...ResourceNameParameter<
    Resource = Target,
    KeyName = "targetName",
    SegmentName = "targets",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
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
    Parameters = {
      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = TargetListResult
  >;
}

@@doc(Target.name, "String that represents a Target resource name.");
@@doc(Target.properties, "The properties of the target resource.");
@@doc(Targets.createOrUpdate::parameters.resource,
  "Target resource to be created or updated."
);
