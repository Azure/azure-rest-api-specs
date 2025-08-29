import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Describes a DNS forwarding ruleset.
 */
model DnsForwardingRuleset
  is Azure.ResourceManager.TrackedResource<
    DnsForwardingRulesetProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = DnsForwardingRuleset,
    KeyName = "dnsForwardingRulesetName",
    SegmentName = "dnsForwardingRulesets",
    NamePattern = ""
  >;
  ...Legacy.EntityTagProperty;
}

@armResourceOperations
interface DnsForwardingRulesets {
  /**
   * Gets a DNS forwarding ruleset properties.
   */
  get is ArmResourceRead<DnsForwardingRuleset, Error = CloudError>;

  /**
   * Creates or updates a DNS forwarding ruleset.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DnsForwardingRuleset,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;

      /**
       * Set to '*' to allow a new resource to be created, but to prevent updating an existing resource. Other values will be ignored.
       */
      @header
      ifNoneMatch?: string;
    },
    Response = ArmResourceUpdatedResponse<DnsForwardingRuleset> | ArmResourceCreatedResponse<
      DnsForwardingRuleset,
      ArmLroLocationHeader<FinalResult = DnsForwardingRuleset> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse,
    Error = CloudError
  >;

  /**
   * Updates a DNS forwarding ruleset.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DnsForwardingRuleset,
    PatchModel = DnsForwardingRulesetPatch,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    },
    Error = CloudError
  >;

  /**
   * Deletes a DNS forwarding ruleset. WARNING: This operation cannot be undone. All forwarding rules within the ruleset will be deleted.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DnsForwardingRuleset,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists DNS forwarding rulesets within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    DnsForwardingRuleset,
    Parameters = {
      /**
       * The maximum number of results to return. If not specified, returns up to 100 results.
       */
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;

  /**
   * Lists DNS forwarding rulesets in all resource groups of a subscription.
   */
  list is ArmListBySubscription<
    DnsForwardingRuleset,
    Parameters = {
      /**
       * The maximum number of results to return. If not specified, returns up to 100 results.
       */
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;
}

@@doc(DnsForwardingRuleset.name, "The name of the DNS forwarding ruleset.");
@@doc(DnsForwardingRuleset.properties,
  "Properties of the DNS forwarding ruleset."
);
@@doc(DnsForwardingRulesets.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(DnsForwardingRulesets.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
