import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A database geo backup policy.")
@parentResource(Database)
model GeoBackupPolicy is ProxyResource<GeoBackupPolicyProperties> {
  @doc("The name of the geo backup policy.")
  @path
  @key("geoBackupPolicyName")
  @segment("geoBackupPolicies")
  name: GeoBackupPolicyName;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface GeoBackupPolicies {
  @doc("Gets a geo backup policy.")
  get is ArmResourceRead<GeoBackupPolicy>;

  @doc("Updates a database geo backup policy.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<GeoBackupPolicy>;

  @doc("Returns a list of geo backup policies.")
  listByDatabase is ArmResourceListByParent<GeoBackupPolicy>;
}

@@projectedName(GeoBackupPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(GeoBackupPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(GeoBackupPolicies.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating the geo backup policy."
);
