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

@parentResource(DatadogMonitorResource)
model DatadogSingleSignOnResource
  is ProxyResource<DatadogSingleSignOnProperties> {
  @doc("Configuration name")
  @path
  @key("configurationName")
  @segment("singleSignOnConfigurations")
  name: string;
}

@armResourceOperations
interface DatadogSingleSignOnResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the datadog single sign-on resource for the given Monitor.")
  @operationId("SingleSignOnConfigurations_Get")
  get is ArmResourceRead<DatadogSingleSignOnResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Configures single-sign-on for this resource.")
  @operationId("SingleSignOnConfigurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DatadogSingleSignOnResource,
    BaseParameters<DatadogSingleSignOnResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the single sign-on configurations for a given monitor resource.")
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
