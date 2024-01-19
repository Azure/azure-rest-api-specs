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
@doc("The customer's ASN that is registered by the peering service provider.")
@parentResource(Peering)
model PeeringRegisteredAsn is ProxyResource<PeeringRegisteredAsnProperties> {
  @doc("The name of the registered ASN.")
  @path
  @key("registeredAsnName")
  @segment("registeredAsns")
  name: string;
}

@armResourceOperations
interface PeeringRegisteredAsns {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an existing registered ASN with the specified name under the given subscription, resource group and peering.")
  @operationId("RegisteredAsns_Get")
  get is ArmResourceRead<PeeringRegisteredAsn>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a new registered ASN with the specified name under the given subscription, resource group and peering.")
  @operationId("RegisteredAsns_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringRegisteredAsn>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing registered ASN with the specified name under the given subscription, resource group and peering.")
  @operationId("RegisteredAsns_Delete")
  delete is ArmResourceDeleteSync<PeeringRegisteredAsn>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all registered ASNs under the given subscription, resource group and peering.")
  @operationId("RegisteredAsns_ListByPeering")
  listByPeering is ArmResourceListByParent<PeeringRegisteredAsn>;
}

@@projectedName(PeeringRegisteredAsns.createOrUpdate::parameters.resource,
  "json",
  "registeredAsn"
);
@@extension(PeeringRegisteredAsns.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "registeredAsn"
);
@@doc(PeeringRegisteredAsns.createOrUpdate::parameters.resource,
  "The properties needed to create a registered ASN."
);
