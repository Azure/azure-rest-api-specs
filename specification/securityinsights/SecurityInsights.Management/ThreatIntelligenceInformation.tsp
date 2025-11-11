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
// FIXME: ThreatIntelligenceInformation has no properties property
/**
 * Threat intelligence information object.
 */
model ThreatIntelligenceInformation is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = ThreatIntelligenceInformation,
    KeyName = "name",
    SegmentName = "indicators",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * The kind of the entity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: ThreatIntelligenceResourceInnerKind;
}

alias ThreatWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface ThreatIntelligenceInformations {
  /**
   * View a threat intelligence indicator by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicator_Get")
  get is ArmResourceRead<ThreatIntelligenceInformation>;

  /**
   * Update a threat Intelligence indicator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicator_Create")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    ThreatIntelligenceInformation,
    Request = ThreatIntelligenceIndicatorModel
  >;

  /**
   * Delete a threat intelligence indicator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicator_Delete")
  delete is ArmResourceDeleteSync<ThreatIntelligenceInformation>;

  /**
   * Get all threat intelligence indicators.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicators_List")
  list is ArmResourceListByParent<
    ThreatIntelligenceInformation,
    Parameters = {
      /**
       * Filters the results, based on a Boolean condition. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Returns only the first n results. Optional.
       */
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Sorts the results. Optional.
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<ThreatIntelligenceInformationList>
  >;

  /**
   * Append tags to a threat intelligence indicator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicator_AppendTags")
  appendTags is ArmResourceActionSync<
    ThreatIntelligenceInformation,
    ThreatIntelligenceAppendTags,
    OkResponse
  >;

  /**
   * Replace tags added to a threat intelligence indicator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicator_ReplaceTags")
  replaceTags is ArmResourceActionSync<
    ThreatIntelligenceInformation,
    ThreatIntelligenceIndicatorModel,
    ArmResponse<ThreatIntelligenceInformation>
  >;
}

@@doc(ThreatIntelligenceInformation.name,
  "Threat intelligence indicator name field."
);
@@doc(ThreatIntelligenceInformations.create::parameters.resource,
  "Properties of threat intelligence indicators to create and update."
);
@@doc(ThreatIntelligenceInformations.appendTags::parameters.body,
  "The threat intelligence append tags request body"
);
@@doc(ThreatIntelligenceInformations.replaceTags::parameters.body,
  "Tags in the threat intelligence indicator to be replaced."
);
