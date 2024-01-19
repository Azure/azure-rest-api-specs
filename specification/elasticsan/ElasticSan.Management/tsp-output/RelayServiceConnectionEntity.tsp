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
@doc("Hybrid Connection for an App Service app.")
@parentResource(Site)
model RelayServiceConnectionEntity
  is ProxyResource<RelayServiceConnectionEntityProperties> {
  @doc("Name of the hybrid connection.")
  @path
  @key("entityName")
  @segment("hybridconnection")
  name: string;
}

@armResourceOperations
interface RelayServiceConnectionEntities {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets a hybrid connection configuration by its name.")
  @operationId("WebApps_GetRelayServiceConnection")
  getRelayServiceConnection is ArmResourceRead<RelayServiceConnectionEntity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  @operationId("WebApps_CreateOrUpdateRelayServiceConnection")
  createOrUpdateRelayServiceConnection is ArmResourceCreateOrReplaceSync<RelayServiceConnectionEntity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  @operationId("WebApps_UpdateRelayServiceConnection")
  updateRelayServiceConnection is ArmCustomPatchSync<
    RelayServiceConnectionEntity,
    RelayServiceConnectionEntity
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Deletes a relay service connection by its name.")
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
