import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("An extended server blob auditing policy.")
@parentResource(Server)
model ExtendedServerBlobAuditingPolicy
  is ProxyResource<ExtendedServerBlobAuditingPolicyProperties> {
  @doc("The name of the blob auditing policy.")
  @path
  @key("blobAuditingPolicyName")
  @segment("extendedAuditingSettings")
  name: BlobAuditingPolicyName;
}

@armResourceOperations
interface ExtendedServerBlobAuditingPolicies {
  @doc("Gets an extended server's blob auditing policy.")
  get is ArmResourceRead<ExtendedServerBlobAuditingPolicy>;

  @doc("Creates or updates an extended server's blob auditing policy.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExtendedServerBlobAuditingPolicy>;

  @doc("Lists extended auditing settings of a server.")
  listByServer is ArmResourceListByParent<ExtendedServerBlobAuditingPolicy>;
}

@@projectedName(ExtendedServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ExtendedServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ExtendedServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "Properties of extended blob auditing policy"
);
