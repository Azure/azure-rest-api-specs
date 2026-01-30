import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkManager.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * The Scope Connections resource
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(NetworkManager)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model ScopeConnection extends ChildResource {
  properties?: ScopeConnectionProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("scopeConnectionName")
  @segment("scopeConnections")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The system metadata related to this resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@armResourceOperations
interface ScopeConnections {
  /**
   * Get specified scope connection created by this Network Manager.
   */
  get is ArmResourceRead<ScopeConnection, Error = CloudError>;

  /**
   * Creates or updates scope connection from Network Manager
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ScopeConnection,
    Error = CloudError
  >;

  /**
   * Delete the pending scope connection created by this network manager.
   */
  delete is ArmResourceDeleteSync<ScopeConnection, Error = CloudError>;

  /**
   * List all scope connections created by this network manager.
   */
  list is ArmResourceListByParent<
    ScopeConnection,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = CloudError
  >;
}

@@doc(ScopeConnection.name, "Name for the cross-tenant connection.");
@@doc(ScopeConnection.properties, "The scope connection properties");
@@doc(ScopeConnections.createOrUpdate::parameters.resource,
  "Scope connection to be created/updated."
);
