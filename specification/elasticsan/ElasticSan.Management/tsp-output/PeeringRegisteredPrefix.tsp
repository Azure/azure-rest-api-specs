import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Peering.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Peering;
@doc("The customer's prefix that is registered by the peering service provider.")
@parentResource(Peering)
model PeeringRegisteredPrefix
  is ProxyResource<PeeringRegisteredPrefixProperties> {
  @doc("The name of the registered prefix.")
  @path
  @key("registeredPrefixName")
  @segment("registeredPrefixes")
  name: string;
}

@armResourceOperations
interface PeeringRegisteredPrefixes {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an existing registered prefix with the specified name under the given subscription, resource group and peering.")
  @operationId("RegisteredPrefixes_Get")
  get is ArmResourceRead<PeeringRegisteredPrefix>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a new registered prefix with the specified name under the given subscription, resource group and peering.")
  @operationId("RegisteredPrefixes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringRegisteredPrefix>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing registered prefix with the specified name under the given subscription, resource group and peering.")
  @operationId("RegisteredPrefixes_Delete")
  delete is ArmResourceDeleteSync<PeeringRegisteredPrefix>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all registered prefixes under the given subscription, resource group and peering.")
  @operationId("RegisteredPrefixes_ListByPeering")
  listByPeering is ArmResourceListByParent<PeeringRegisteredPrefix>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Validates an existing registered prefix with the specified name under the given subscription, resource group and peering.")
  @operationId("RegisteredPrefixes_Validate")
  validate is ArmResourceActionSync<
    PeeringRegisteredPrefix,
    void,
    PeeringRegisteredPrefix
  >;
}

@@projectedName(PeeringRegisteredPrefixes.createOrUpdate::parameters.resource,
  "json",
  "registeredPrefix"
);
@@extension(PeeringRegisteredPrefixes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "registeredPrefix"
);
@@doc(PeeringRegisteredPrefixes.createOrUpdate::parameters.resource,
  "The properties needed to create a registered prefix."
);
