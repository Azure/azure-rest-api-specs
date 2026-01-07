import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@doc("Connection Hub resource.")
model ConnectionHub is TrackedResource<ConnectionHubProperties> {
  @doc("The connection hub name.")
  @key("connectionHubName")
  @segment("connectionHubs")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,62}[a-zA-Z0-9]$")
  name: string;
}

@doc("Connection Hub properties")
model ConnectionHubProperties {
  @doc("The status of the ConnectionHub resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Migrate project ID.")
  migrateProjectId: string;
}
