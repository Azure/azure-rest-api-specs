import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatadogMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Datadog;

@parentResource(DatadogMonitorResource)
model DatadogSingleSignOnResource
  is Azure.ResourceManager.ProxyResource<DatadogSingleSignOnProperties> {
  ...ResourceNameParameter<
    Resource = DatadogSingleSignOnResource,
    KeyName = "configurationName",
    SegmentName = "singleSignOnConfigurations",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" ""
@armResourceOperations
interface DatadogSingleSignOnResources {
  /**
   * Gets the datadog single sign-on resource for the given Monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SingleSignOnConfigurations_Get")
  get is ArmResourceRead<DatadogSingleSignOnResource>;

  /**
   * Configures single-sign-on for this resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SingleSignOnConfigurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DatadogSingleSignOnResource>;

  /**
   * List the single sign-on configurations for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SingleSignOnConfigurations_List")
  list is ArmResourceListByParent<
    DatadogSingleSignOnResource,
    Response = ArmResponse<DatadogSingleSignOnResourceListResponse>
  >;
}

@@doc(DatadogSingleSignOnResource.name, "Configuration name");
@@doc(DatadogSingleSignOnResource.properties, "");
@@doc(DatadogSingleSignOnResources.createOrUpdate::parameters.resource, "");
