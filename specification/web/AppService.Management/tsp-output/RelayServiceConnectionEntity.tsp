import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Hybrid Connection for an App Service app.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Site)
@includeInapplicableMetadataInPayload(false)
model RelayServiceConnectionEntity extends ProxyOnlyResource {
  /**
   * Name of the hybrid connection.
   */
  @path
  @key("entityName")
  @segment("hybridconnection")
  @visibility("read")
  name: string;

  /**
   * RelayServiceConnectionEntity resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: RelayServiceConnectionEntityProperties;
}

@armResourceOperations
interface RelayServiceConnectionEntities {
  /**
   * Description for Gets a hybrid connection configuration by its name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetRelayServiceConnection")
  getRelayServiceConnection is ArmResourceRead<RelayServiceConnectionEntity>;

  /**
   * Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateRelayServiceConnection")
  createOrUpdateRelayServiceConnection is ArmResourceCreateOrReplaceSync<RelayServiceConnectionEntity>;

  /**
   * Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WebApps_UpdateRelayServiceConnection")
  updateRelayServiceConnection is ArmCustomPatchSync<
    RelayServiceConnectionEntity,
    RelayServiceConnectionEntity
  >;

  /**
   * Description for Deletes a relay service connection by its name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_DeleteRelayServiceConnection")
  deleteRelayServiceConnection is ArmResourceDeleteSync<RelayServiceConnectionEntity>;
}

@@projectedName(RelayServiceConnectionEntities.createOrUpdateRelayServiceConnection::parameters.resource,
  "json",
  "connectionEnvelope"
);
@@extension(RelayServiceConnectionEntities.createOrUpdateRelayServiceConnection::parameters.resource,
  "x-ms-client-name",
  "connectionEnvelope"
);
@@doc(RelayServiceConnectionEntities.createOrUpdateRelayServiceConnection::parameters.resource,
  "Details of the hybrid connection configuration."
);
@@projectedName(RelayServiceConnectionEntities.updateRelayServiceConnection::parameters.properties,
  "json",
  "connectionEnvelope"
);
@@extension(RelayServiceConnectionEntities.updateRelayServiceConnection::parameters.properties,
  "x-ms-client-name",
  "connectionEnvelope"
);
@@doc(RelayServiceConnectionEntities.updateRelayServiceConnection::parameters.properties,
  "Details of the hybrid connection configuration."
);
