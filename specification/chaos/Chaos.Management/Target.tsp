import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./target.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.Chaos;

@armResourceOperations
interface Targets {
  /**
   * Get a Target resource that extends a tracked regional resource.
   */
  get is ArmResourceRead<Target, TargetParentResourceParameters>;

  /**
   * Create or update a Target resource that extends a tracked regional resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Target,
    TargetParentResourceParameters
  >;

  /**
   * Delete a Target resource that extends a tracked regional resource.
   */
  delete is ArmResourceDeleteSync<Target, TargetParentResourceParameters>;

  /**
   * Get a list of Target resources that extend a tracked regional resource.
   */
  list is ArmResourceListByParent<
    Target,
    {
      ...TargetParentResourceParameters;

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
