import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/versioning";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Advisor;
/**
 * The metadata entity contract.
 */
@tenantResource
model MetadataEntity
  is Azure.ResourceManager.ProxyResource<MetadataEntityProperties> {
  ...ResourceNameParameter<
    Resource = MetadataEntity,
    KeyName = "name",
    SegmentName = "metadata",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MetadataEntities {
  /**
   * Gets the metadata entity.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<
    MetadataEntity,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ArmDefaultErrorResponse,
    Response = ArmResponse<MetadataEntity> | ArmNotFoundResponseWithBody
  >;

  /**
   * Gets the list of metadata entities.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is ArmResourceListByParent<
    MetadataEntity,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The filter to apply to the recommendation metadata.<br>Filter can be applied to properties ['[recommendationCategory](#category)', '[recommendationSubCategory](#recommendationSubCategory)', 'RetirementDate'] with operators ['eq', 'and', 'le', 'ge']<br>The filter can also be applied to property ['[TrackingIds]']<br><br>⚠ **Note:** `recommendationControl` is a legacy filter property and will be deprecated in the future. Please use `recommendationSubCategory` for filtering recommendation subcategory.<br><br>Valid options for recommendationSubCategory: ['BusinessContinuity', 'DisasterRecovery', 'HighAvailability', 'MonitoringAndAlerting', 'Other', 'Personalized', 'PrioritizedRecommendations', 'Scalability', 'ServiceUpgradeAndRetirement', 'Validation']<br><br>Example:<br>- $filter=recommendationCategory eq 'HighAvailability' and recommendationSubCategory eq 'ServiceUpgradeAndRetirement' and retirementDate ge '2024-01-01' and retirementDate le '2028-01-01'. Filter can be applied on trackingIds as well.<br>- $filter=trackingIds/any(t: t eq 'some-guid')<br><br>⚠ **Note:** `trackingIDs` filter can be used for filtering one value at a time. The support to filter multiple values is not currently available. Also the support to add other filters along with `trackingIDs` is not available.
       */
      @added(Versions.v2026_10_01)
      @query("$filter")
      $filter?: string;
    },
    Error = ArmDefaultErrorResponse
  >;
}

@@doc(MetadataEntity.name, "Name of metadata entity.");
@@doc(MetadataEntity.properties, "The metadata entity properties.");
