import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EventHubsNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
/**
 * Single item in List or Get Schema Group operation
 */
@parentResource(EventHubsNamespace)
model EventHubsSchemaGroup is ProxyResource<SchemaGroupProperties> {
  /**
   * The Schema Group name
   */
  @maxLength(256)
  @minLength(1)
  @path
  @key("schemaGroupName")
  @segment("schemagroups")
  name: string;
}

@armResourceOperations
interface EventHubsSchemaGroups {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SchemaRegistry_Get")
  get is ArmResourceRead<EventHubsSchemaGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SchemaRegistry_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<EventHubsSchemaGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SchemaRegistry_Delete")
  delete is ArmResourceDeleteSync<EventHubsSchemaGroup>;

  /**
   * Gets all the Schema Groups in a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SchemaRegistry_ListByNamespace")
  listByNamespace is ArmResourceListByParent<
    EventHubsSchemaGroup,
    {
      ...BaseParameters<EventHubsSchemaGroup>;

      /**
       * Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.
       */
      @maxValue(1000)
      @query("$skip")
      $skip?: int32;

      /**
       * May be used to limit the number of results to the most recent N usageDetails.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  >;
}

@@projectedName(EventHubsSchemaGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(EventHubsSchemaGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubsSchemaGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to create an Event Hub resource."
);
