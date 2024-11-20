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
using Azure.Core;

namespace Microsoft.Chaos;
/**
 * Model that represents a Target resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required to add location to proxy resource."
model Target is Azure.ResourceManager.ProxyResource<TargetProperties> {
  ...ResourceNameParameter<
    Resource = Target,
    KeyName = "targetName",
    SegmentName = "targets",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;

  /**
   * Azure location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing property implementation."
  location?: azureLocation;
}

alias TargetParentResourceParameters = BaseParameters<Target> &
  ParentResourceParameters;

#suppress "@azure-tools/typespec-azure-resource-manager/improper-subscription-list-operation" "Does not expose subscription-scoped list, linting error."
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

      @doc("String that sets the continuation token.")
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
