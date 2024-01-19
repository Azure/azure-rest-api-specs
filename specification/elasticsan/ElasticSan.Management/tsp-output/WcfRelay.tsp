import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
@doc("Description of the WCF relay resource.")
@parentResource(RelayNamespace)
model WcfRelay is ProxyResource<WcfRelayProperties> {
  @doc("The relay name.")
  @minLength(1)
  @path
  @key("relayName")
  @segment("wcfRelays")
  name: string;
}

@armResourceOperations
interface WcfRelays {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the description for the specified WCF relay.")
  @operationId("WCFRelays_Get")
  get is ArmResourceRead<WcfRelay>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a WCF relay. This operation is idempotent.")
  @operationId("WCFRelays_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<WcfRelay>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a WCF relay.")
  @operationId("WCFRelays_Delete")
  delete is ArmResourceDeleteSync<WcfRelay>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the WCF relays within the namespace.")
  @operationId("WCFRelays_ListByNamespace")
  listByNamespace is ArmResourceListByParent<WcfRelay>;
}

@@projectedName(WcfRelays.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(WcfRelays.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(WcfRelays.createOrUpdate::parameters.resource,
  "Parameters supplied to create a WCF relay."
);
