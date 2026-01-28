import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataMigration;

@doc("Properties of the MigrationService resource.")
model MigrationServiceProperties {
  @doc("The provisioning state of the migration service.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("A migration service resource.")
model MigrationService is TrackedResource<MigrationServiceProperties> {
  @doc("The migration service name.")
  @key("serviceName")
  @segment("postgresqlMigrationServices")
  @path
  @pattern("^[a-zA-Z0-9-]*$")
  name: string;
}
