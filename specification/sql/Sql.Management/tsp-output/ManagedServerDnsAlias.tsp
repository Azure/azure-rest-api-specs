import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed server DNS alias.
 */
@parentResource(ManagedInstance)
model ManagedServerDnsAlias is ProxyResource<ManagedServerDnsAliasProperties> {
  @path
  @key("dnsAliasName")
  @segment("dnsAliases")
  name: string;
}

@armResourceOperations
interface ManagedServerDnsAliases {
  /**
   * Gets a server DNS alias.
   */
  get is ArmResourceRead<ManagedServerDnsAlias>;

  /**
   * Creates a managed server DNS alias.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedServerDnsAlias>;

  /**
   * Deletes the managed server DNS alias with the given name.
   */
  delete is ArmResourceDeleteAsync<ManagedServerDnsAlias>;

  /**
   * Gets a list of managed server DNS aliases for a managed server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedServerDnsAliases_ListByManagedInstance")
  listByManagedInstance is ArmResourceListByParent<ManagedServerDnsAlias>;

  /**
   * Acquires managed server DNS alias from another managed server.
   */
  acquire is ArmResourceActionAsync<
    ManagedServerDnsAlias,
    ManagedServerDnsAliasAcquisition,
    ManagedServerDnsAlias
  >;
}

@@projectedName(ManagedServerDnsAliases.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedServerDnsAliases.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedServerDnsAliases.createOrUpdate::parameters.resource, "");
@@projectedName(ManagedServerDnsAliases.acquire::parameters.body,
  "json",
  "parameters"
);
@@extension(ManagedServerDnsAliases.acquire::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedServerDnsAliases.acquire::parameters.body, "");
