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
 * Description of hybrid connection resource.
 */
@parentResource(RelayNamespace)
model HybridConnection
  is Azure.ResourceManager.ProxyResource<HybridConnectionProperties> {
  ...ResourceNameParameter<
    Resource = HybridConnection,
    KeyName = "hybridConnectionName",
    SegmentName = "hybridConnections",
    NamePattern = ""
  >;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@@minLength(HybridConnectionNameParameter.name, 1);
@@doc(HybridConnectionNameParameter.name, "The hybrid connection name.");
model HybridConnectionNameParameter
  is ResourceNameParameter<
    Resource = HybridConnection,
    KeyName = "hybridConnectionName",
    SegmentName = "hybridConnections",
    NamePattern = ""
  >;

@armResourceOperations
interface HybridConnectionOperationGroup {
  /**
   * Returns the description for the specified hybrid connection.
   */
  get is ArmResourceRead<HybridConnection>;

  /**
   * Creates or updates a service hybrid connection. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    HybridConnection,
    Response = ArmResourceUpdatedResponse<HybridConnection>
  >;

  /**
   * Deletes a hybrid connection.
   */
  delete is ArmResourceDeleteSync<HybridConnection>;

  /**
   * Lists the hybrid connection within the namespace.
   */
  listByNamespace is ArmResourceListByParent<HybridConnection>;
}

@@minLength(HybridConnection.name, 1);
@@doc(HybridConnection.name, "The hybrid connection name.");
@@doc(HybridConnection.properties, "Properties of the HybridConnection.");
@@doc(HybridConnectionOperationGroup.createOrUpdate::parameters.resource,
  "Parameters supplied to create a hybrid connection."
);
