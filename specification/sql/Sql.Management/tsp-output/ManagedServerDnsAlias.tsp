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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedInstance)
@Azure.ResourceManager.Private.armResourceInternal(
  ManagedServerDnsAliasProperties
)
@includeInapplicableMetadataInPayload(false)
model ManagedServerDnsAlias extends ProxyResource {
  @path
  @key("dnsAliasName")
  @segment("dnsAliases")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedServerDnsAliasProperties;
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
