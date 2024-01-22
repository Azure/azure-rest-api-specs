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
/**
 * Description of the WCF relay resource.
 */
@parentResource(RelayNamespace)
model WcfRelay is ProxyResource<WcfRelayProperties> {
  /**
   * The relay name.
   */
  @minLength(1)
  @path
  @key("relayName")
  @segment("wcfRelays")
  name: string;
}

@armResourceOperations
interface WcfRelays {
  /**
   * Returns the description for the specified WCF relay.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WCFRelays_Get")
  get is ArmResourceRead<WcfRelay>;

  /**
   * Creates or updates a WCF relay. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WCFRelays_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<WcfRelay>;

  /**
   * Deletes a WCF relay.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WCFRelays_Delete")
  delete is ArmResourceDeleteSync<WcfRelay>;

  /**
   * Lists the WCF relays within the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
