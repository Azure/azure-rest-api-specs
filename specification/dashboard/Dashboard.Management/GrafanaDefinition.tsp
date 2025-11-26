import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Dashboard;
/**
 * The grafana definition resource type.
 */
@added(Versions.v2025_11_01_preview)
@parentResource(ManagedGrafana)
model GrafanaDefinition
  is Azure.ResourceManager.ProxyResource<GrafanaDefinitionsProperties> {
  ...ResourceNameParameter<
    Resource = GrafanaDefinition,
    KeyName = "definitionName",
    SegmentName = "grafanaDefinitions",
    NamePattern = "^[a-zA-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]$"
  >;
}

@armResourceOperations
interface GrafanaDefinitions {
  /**
   * Get the properties of a specific grafana definition.
   */
  @added(Versions.v2025_11_01_preview)
  get is ArmResourceRead<GrafanaDefinition>;

  /**
   * Create a grafana definition to update a grafana workspace resource.
   */
  @added(Versions.v2025_11_01_preview)
  @doc("Create a grafana definition to update a grafana workspace resource.")
  @put
  @armResourceCreateOrUpdate(GrafanaDefinition)
  create(
    ...ResourceInstanceParameters<GrafanaDefinition>,

    @doc("The grafana definition resource to create or update.")
    @bodyRoot
    requestBodyParameters: GrafanaDefinition,
  ): {
    @statusCode _: 200;

    @doc("Resource 'GrafanaDefinition' update operation succeeded")
    @body
    @added(Versions.v2025_11_01_preview)
    requestBodyParameters: GrafanaDefinition;
  } | {
    @statusCode _: 201;

    @doc("Resource 'GrafanaDefinition' create operation succeeded")
    @body
    @added(Versions.v2025_11_01_preview)
    requestBodyParameters: GrafanaDefinition;
  } | ErrorResponse;

  /**
   * Delete a grafana definition.
   */
  @added(Versions.v2025_11_01_preview)
  delete is ArmResourceDeleteSync<GrafanaDefinition>;

  /**
   * List all grafana definitions under the specified Grafana workspace.
   */
  @added(Versions.v2025_11_01_preview)
  list is ArmResourceListByParent<
    GrafanaDefinition,
    Response = ArmResponse<GrafanaDefinitionsListResponse>
  >;
}

@@doc(GrafanaDefinition.name, "The name of the grafana definition.");
@@doc(GrafanaDefinition.properties,
  "Properties specific to the grafana definition resource."
);
