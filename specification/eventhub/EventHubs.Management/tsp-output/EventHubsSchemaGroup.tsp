import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EventHubsNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.EventHubs;
@doc("Single item in List or Get Schema Group operation")
@parentResource(EventHubsNamespace)
model EventHubsSchemaGroup is ProxyResource<SchemaGroupProperties> {
  @doc("The Schema Group name ")
  @maxLength(256)
  @minLength(1)
  @path
  @key("schemaGroupName")
  @segment("schemagroups")
  name: string;
}

@armResourceOperations
interface EventHubsSchemaGroups {
  get is ArmResourceRead<EventHubsSchemaGroup>;

  createOrUpdate is ArmResourceCreateOrReplaceSync<EventHubsSchemaGroup>;

  delete is ArmResourceDeleteSync<EventHubsSchemaGroup>;
  @doc("Gets all the Schema Groups in a Namespace.")
  listByNamespace is ArmResourceListByParent<
    EventHubsSchemaGroup,
    {
      ...BaseParameters<EventHubsSchemaGroup>;

      @doc("Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.")
      @query("$skip")
      $skip?: int32;

      @doc("May be used to limit the number of results to the most recent N usageDetails.")
      @query("$top")
      $top?: int32;
    }
  >;
}
