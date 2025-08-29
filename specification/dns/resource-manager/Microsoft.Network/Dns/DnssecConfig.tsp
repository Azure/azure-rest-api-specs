import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Zone.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Represents the DNSSEC configuration.
 */
@singleton("default")
@parentResource(Zone)
model DnssecConfig is Azure.ResourceManager.ProxyResource<DnssecProperties> {
  ...ResourceNameParameter<
    Resource = DnssecConfig,
    KeyName = "dnssecConfig",
    SegmentName = "dnssecConfigs",
    NamePattern = ""
  >;

  /**
   * The etag of the DNSSEC configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations
interface DnssecConfigs {
  /**
   * Gets the DNSSEC configuration.
   */
  get is ArmResourceRead<DnssecConfig, Error = CloudError>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Creates or updates the DNSSEC configuration on a DNS zone.
   */
  createOrUpdate is Azure.ResourceManager.CustomLegacy.CreateOrUpdateWithoutBodyAsync<
    DnssecConfig,
    Parameters = {
      /**
       * The etag of the DNSSEC configuration. Omit this value to always overwrite the DNSSEC configuration. Specify the last-seen etag value to prevent accidentally overwriting any concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;

      /**
       * Set to '*' to allow this DNSSEC configuration to be created, but to prevent updating existing DNSSEC configuration. Other values will be ignored.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      IfNoneMatch?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = DnssecConfig> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Deletes the DNSSEC configuration on a DNS zone. This operation cannot be undone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DnssecConfig,
    Parameters = {
      /**
       * The etag of this DNSSEC configuration. Omit this value to always delete the DNSSEC configuration. Specify the last-seen etag value to prevent accidentally deleting any concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists the DNSSEC configurations in a DNS zone.
   */
  listByDnsZone is ArmResourceListByParent<DnssecConfig, Error = CloudError>;
}

@@doc(DnssecConfig.name, "");
@@doc(DnssecConfig.properties, "The DNSSEC properties.");
