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
/**
 * A provider instance associated with SAP monitor.
 */
@parentResource(Monitor)
model ProviderInstance is ProxyResource<ProviderInstanceProperties> {
  /**
   * Name of the provider instance.
   */
  @pattern("^[a-zA-Z0-9-_]+$")
  @path
  @key("providerInstanceName")
  @segment("providerInstances")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface ProviderInstances {
  /**
   * Gets properties of a provider instance for the specified subscription, resource group, SAP monitor name, and resource name.
   */
  get is ArmResourceRead<ProviderInstance>;

  /**
   * Creates a provider instance for the specified subscription, resource group, SAP monitor name, and resource name.
   */
  create is ArmResourceCreateOrReplaceAsync<ProviderInstance>;

  /**
   * Deletes a provider instance for the specified subscription, resource group, SAP monitor name, and resource name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ProviderInstance>;

  /**
   * Gets a list of provider instances in the specified SAP monitor. The operations returns various properties of each provider instances.
   */
  list is ArmResourceListByParent<ProviderInstance>;
}

@@doc(ProviderInstances.create::parameters.resource,
  "Request body representing a provider instance associated with a SAP monitor."
);
