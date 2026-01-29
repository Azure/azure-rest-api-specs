import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkManagerRoutingConfiguration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Defines the routing rule collection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@parentResource(NetworkManagerRoutingConfiguration)
@Http.Private.includeInapplicableMetadataInPayload(false)
model RoutingRuleCollection extends ChildResource {
  properties?: RoutingRuleCollectionPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("ruleCollectionName")
  @segment("ruleCollections")
  @pattern("^[a-zA-Z0-9_.-]*$")
  name: string;

  /**
   * The system metadata related to this resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

@armResourceOperations
interface RoutingRuleCollections {
  /**
   * Gets a network manager routing configuration rule collection.
   */
  get is ArmResourceRead<RoutingRuleCollection, Error = CloudError>;

  /**
   * Creates or updates a routing rule collection.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    RoutingRuleCollection,
    Error = CloudError
  >;

  /**
   * Deletes an routing rule collection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    RoutingRuleCollection,
    Parameters = {
      /**
       * Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the rule collections in a routing configuration, in a paginated format.
   */
  list is ArmResourceListByParent<
    RoutingRuleCollection,
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

@@doc(RoutingRuleCollection.name,
  "The name of the network manager routing Configuration rule collection."
);
@@doc(RoutingRuleCollection.properties,
  "Indicates the properties for the network manager routing rule collection."
);
@@doc(RoutingRuleCollections.createOrUpdate::parameters.resource,
  "The Rule Collection to create or update"
);
