using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    ProviderInstance,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a provider instance for the specified subscription, resource group, SAP monitor name, and resource name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ProviderInstance>;

  /**
   * Gets a list of provider instances in the specified SAP monitor. The operations returns various properties of each provider instances.
   */
  listByMonitor is ArmResourceListByParent<ProviderInstance>;
}

@@doc(ProviderInstances.create::parameters.resource,
  "Request body representing a provider instance associated with a SAP monitor."
);
