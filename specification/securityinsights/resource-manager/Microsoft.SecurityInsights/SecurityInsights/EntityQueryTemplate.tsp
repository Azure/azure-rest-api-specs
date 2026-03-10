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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("kind")
model EntityQueryTemplate
  is Azure.ResourceManager.Legacy.DiscriminatedProxyResource<EntityQueryTemplateKind> {
  ...ResourceNameParameter<
    Resource = EntityQueryTemplate,
    KeyName = "entityQueryTemplateId",
    SegmentName = "entityQueryTemplates",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface EntityQueryTemplates {
  /**
   * Gets an entity query.
   */
  @tag("EntityQueries")
  get is Extension.Read<
    workspaceExternalResource,
    EntityQueryTemplate,
    Error = CloudError
  >;

  /**
   * Gets all entity query templates.
   */
  @tag("EntityQueries")
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
