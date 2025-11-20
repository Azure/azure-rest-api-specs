import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Dynatrace.Observability;
/**
 * Single sign-on configurations for a given monitor resource.
 */
@parentResource(MonitorResource)
model DynatraceSingleSignOnResource
  is Azure.ResourceManager.ProxyResource<
    DynatraceSingleSignOnProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = DynatraceSingleSignOnResource,
    KeyName = "configurationName",
    SegmentName = "singleSignOnConfigurations",
    NamePattern = "^[a-zA-Z]*$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface DynatraceSingleSignOnResources {
  /**
   * Get a DynatraceSingleSignOnResource
   */
  get is ArmResourceRead<DynatraceSingleSignOnResource>;

  /**
   * Create a DynatraceSingleSignOnResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DynatraceSingleSignOnResource>;

  /**
   * List all DynatraceSingleSignOnResource by monitorName
   */
  list is ArmResourceListByParent<DynatraceSingleSignOnResource>;
}

@@doc(DynatraceSingleSignOnResource.name, "Single Sign On Configuration Name");
@@doc(DynatraceSingleSignOnResource.properties,
  "The resource-specific properties for this resource."
);
