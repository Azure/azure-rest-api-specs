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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Monitor)
@Azure.ResourceManager.Private.armResourceInternal(ProviderInstanceProperties)
@includeInapplicableMetadataInPayload(false)
model ProviderInstance extends ProxyResourceBase {
  /**
   * Name of the provider instance.
   */
  @path
  @key("providerInstanceName")
  @segment("providerInstances")
  name: string;

  /**
   * Provider Instance properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ProviderInstanceProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
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
  create is ArmResourceCreateOrReplaceAsync<
    ProviderInstance,
    BaseParameters<ProviderInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a provider instance for the specified subscription, resource group, SAP monitor name, and resource name.
   */
  delete is ArmResourceDeleteAsync<
    ProviderInstance,
    BaseParameters<ProviderInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Gets a list of provider instances in the specified SAP monitor. The operations returns various properties of each provider instances.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProviderInstances_List")
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
