import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Monitor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
@doc("A provider instance associated with SAP monitor.")
@parentResource(Monitor)
model ProviderInstance is ProxyResource<ProviderInstanceProperties> {
  @doc("Name of the provider instance.")
  @path
  @key("providerInstanceName")
  @segment("providerInstances")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ProviderInstances {
  @doc("Gets properties of a provider instance for the specified subscription, resource group, SAP monitor name, and resource name.")
  get is ArmResourceRead<ProviderInstance>;

  @doc("Creates a provider instance for the specified subscription, resource group, SAP monitor name, and resource name.")
  create is ArmResourceCreateOrUpdateAsync<
    ProviderInstance,
    BaseParameters<ProviderInstance>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a provider instance for the specified subscription, resource group, SAP monitor name, and resource name.")
  delete is ArmResourceDeleteAsync<
    ProviderInstance,
    BaseParameters<ProviderInstance>,
    ArmAsyncOperationHeader
  >;

  @doc("Gets a list of provider instances in the specified SAP monitor. The operations returns various properties of each provider instances.")
  list is ArmResourceListByParent<ProviderInstance>;
}

@@projectedName(ProviderInstances.create::parameters.resource,
  "json",
  "providerInstanceParameter"
);
@@extension(ProviderInstances.create::parameters.resource,
  "x-ms-client-name",
  "providerInstanceParameter"
);
@@doc(ProviderInstances.create::parameters.resource,
  "Request body representing a provider instance"
);
