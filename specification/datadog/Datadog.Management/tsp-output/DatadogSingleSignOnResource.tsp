import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatadogMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Datadog;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DatadogMonitorResource)
@Azure.ResourceManager.Private.armResourceInternal(
  DatadogSingleSignOnProperties
)
@includeInapplicableMetadataInPayload(false)
model DatadogSingleSignOnResource extends ProxyResourceBase {
  /**
   * Configuration name
   */
  @path
  @key("configurationName")
  @segment("singleSignOnConfigurations")
  name: string;

  @extension("x-ms-client-flatten", true)
  properties?: DatadogSingleSignOnProperties;
}

@armResourceOperations
interface DatadogSingleSignOnResources {
  /**
   * Gets the datadog single sign-on resource for the given Monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SingleSignOnConfigurations_Get")
  get is ArmResourceRead<DatadogSingleSignOnResource>;

  /**
   * Configures single-sign-on for this resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SingleSignOnConfigurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DatadogSingleSignOnResource,
    BaseParameters<DatadogSingleSignOnResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List the single sign-on configurations for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SingleSignOnConfigurations_List")
  list is ArmResourceListByParent<DatadogSingleSignOnResource>;
}

@@projectedName(DatadogSingleSignOnResources.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(DatadogSingleSignOnResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(DatadogSingleSignOnResources.createOrUpdate::parameters.resource, "");
