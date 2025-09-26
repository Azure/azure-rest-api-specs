import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
/**
 * Description of the WCF relay resource.
 */
@parentResource(RelayNamespace)
model WcfRelay is Azure.ResourceManager.ProxyResource<WcfRelayProperties> {
  ...ResourceNameParameter<
    Resource = WcfRelay,
    KeyName = "relayName",
    SegmentName = "wcfRelays",
    NamePattern = ""
  >;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@@minLength(WcfRelayNameParameter.name, 1);
@@doc(WcfRelayNameParameter.name, "The relay name.");
model WcfRelayNameParameter
  is ResourceNameParameter<
    Resource = WcfRelay,
    KeyName = "relayName",
    SegmentName = "wcfRelays",
    NamePattern = ""
  >;

@armResourceOperations
interface WcfRelaysOps {
  /**
   * Returns the description for the specified WCF relay.
   */
  get is ArmResourceRead<
    WcfRelay,
    Response = ArmResponse<WcfRelay> | ArmNoContentResponse
  >;

  /**
   * Creates or updates a WCF relay. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    WcfRelay,
    Response = ArmResourceUpdatedResponse<WcfRelay>
  >;

  /**
   * Deletes a WCF relay.
   */
  delete is ArmResourceDeleteSync<WcfRelay>;

  /**
   * Lists the WCF relays within the namespace.
   */
  listByNamespace is ArmResourceListByParent<
    WcfRelay,
    Response = WcfRelaysListResult
  >;
}

@@minLength(WcfRelay.name, 1);
@@doc(WcfRelay.name, "The relay name.");
@@doc(WcfRelay.properties, "Properties of the WCF relay.");
@@doc(WcfRelaysOps.createOrUpdate::parameters.resource,
  "Parameters supplied to create a WCF relay."
);
