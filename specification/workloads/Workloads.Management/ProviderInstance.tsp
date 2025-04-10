import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Monitor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * A provider instance associated with SAP monitor.
 */
@parentResource(Monitor)
model ProviderInstance
  is Azure.ResourceManager.ProxyResource<ProviderInstanceProperties> {
  ...ResourceNameParameter<
    Resource = ProviderInstance,
    KeyName = "providerInstanceName",
    SegmentName = "providerInstances",
    NamePattern = ""
  >;

  /**
   * [currently not in use] Managed service identity(user assigned identities)
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: UserAssignedServiceIdentity;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ProviderInstance,
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of provider instances in the specified SAP monitor. The operations returns various properties of each provider instances.
   */
  list is ArmResourceListByParent<ProviderInstance>;
}

@@doc(ProviderInstance.name, "Name of the provider instance.");
@@doc(ProviderInstance.properties, "Provider Instance properties");
@@doc(ProviderInstances.create::parameters.resource,
  "Request body representing a provider instance"
);
