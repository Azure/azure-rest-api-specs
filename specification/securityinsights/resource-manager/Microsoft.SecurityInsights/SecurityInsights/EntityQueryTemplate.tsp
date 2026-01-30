import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
// FIXME: EntityQueryTemplate has no properties property
/**
 * Specific entity query template.
 */
model EntityQueryTemplate is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = EntityQueryTemplate,
    KeyName = "entityQueryTemplateId",
    SegmentName = "entityQueryTemplates",
    NamePattern = ""
  >;

  /**
   * the entity query template kind
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: EntityQueryTemplateKind;
}

@armResourceOperations
interface EntityQueryTemplates {
  /**
   * Gets an entity query.
   */
  get is Extension.Read<
    workspaceExternalResource,
    EntityQueryTemplate,
    Error = CloudError
  >;

  /**
   * Gets all entity query templates.
   */
  list is Extension.ListByTarget<
    workspaceExternalResource,
    EntityQueryTemplate,
    Parameters = {
      /**
       * The entity template query kind we want to fetch
       */
      @query("kind")
      kind?: EntityQueryTemplateKind;
    },
    Response = ArmResponse<EntityQueryTemplateList>,
    Error = CloudError
  >;
}

@@doc(EntityQueryTemplate.name, "entity query template ID");
