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

@armResourceOperations
interface DatadogSingleSignOnResourcesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * Monitor resource name
         */
        @path
        @segment("monitors")
        monitorName: string,
      },
      {
        /**
         * Configuration name
         */
        @path
        @segment("singleSignOnConfigurations")
        configurationName: string,
      },
      ErrorResponse
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface DatadogSingleSignOnResources {
  /**
   * Gets the datadog single sign-on resource for the given Monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<DatadogSingleSignOnResource>;

  /**
   * Configures single-sign-on for this resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is DatadogSingleSignOnResourcesOps.CreateOrUpdateAsync<
    DatadogSingleSignOnResource,
    OptionalRequestBody = true
  >;

  /**
   * List the single sign-on configurations for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is ArmResourceListByParent<
    DatadogSingleSignOnResource,
    Response = ArmResponse<DatadogSingleSignOnResourceListResponse>
  >;
}

@@doc(DatadogSingleSignOnResource.name, "Configuration name");
@@doc(DatadogSingleSignOnResource.properties, "");
@@doc(DatadogSingleSignOnResources.createOrUpdate::parameters.resource, "");
