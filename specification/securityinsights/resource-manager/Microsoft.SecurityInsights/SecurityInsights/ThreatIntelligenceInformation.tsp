import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Threat intelligence information object.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@discriminator("kind")
@parentResource(ThreatIntelligenceMain)
model ThreatIntelligenceInformation
  is Azure.ResourceManager.Legacy.DiscriminatedExtensionResource<ThreatIntelligenceResourceInnerKind> {
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
}

@armResourceOperations
interface ThreatIntelligenceInformations {
  /**
   * View a threat intelligence indicator by name.
   */
  get is Extension.Read<
    OperationalInsights,
    ThreatIntelligenceInformation,
    Error = CloudError
  >;

  /**
   * Update a threat Intelligence indicator.
   */
  create is Extension.CreateOrReplaceSync<
    OperationalInsights,
    ThreatIntelligenceIndicatorModel,
    Response = ArmResourceUpdatedResponse<ThreatIntelligenceInformation> | ArmResourceCreatedSyncResponse<ThreatIntelligenceInformation>,
    Error = CloudError
  >;

  /**
   * Delete a threat intelligence indicator.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    ThreatIntelligenceInformation,
    Error = CloudError
  >;

  /**
   * Get all threat intelligence indicators.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
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
    Response = ArmResponse<ThreatIntelligenceInformationList>,
    Error = CloudError
  >;

  /**
   * Append tags to a threat intelligence indicator.
   */
  appendTags is Extension.ActionSync<
    OperationalInsights,
    ThreatIntelligenceInformation,
    ThreatIntelligenceAppendTags,
    OkResponse,
    Error = CloudError
  >;

  /**
   * Replace tags added to a threat intelligence indicator.
   */
  replaceTags is Extension.ActionSync<
    OperationalInsights,
    ThreatIntelligenceInformation,
    ThreatIntelligenceIndicatorModel,
    ArmResponse<ThreatIntelligenceInformation>,
    Error = CloudError
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
