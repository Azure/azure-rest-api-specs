import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DnsForwardingRuleset.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Describes a forwarding rule within a DNS forwarding ruleset.
 */
@parentResource(DnsForwardingRuleset)
model ForwardingRule
  is Azure.ResourceManager.ProxyResource<ForwardingRuleProperties, false> {
  ...ResourceNameParameter<
    Resource = ForwardingRule,
    KeyName = "forwardingRuleName",
    SegmentName = "forwardingRules",
    NamePattern = ""
  >;
  ...Legacy.EntityTagProperty;
}

@armResourceOperations
interface ForwardingRules {
  /**
   * Gets properties of a forwarding rule in a DNS forwarding ruleset.
   */
  get is ArmResourceRead<ForwardingRule, Error = CloudError>;

  /**
   * Creates or updates a forwarding rule in a DNS forwarding ruleset.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ForwardingRule,
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
    Error = CloudError
  >;

  /**
   * Updates a forwarding rule in a DNS forwarding ruleset.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ForwardingRule,
    PatchModel = ForwardingRulePatch,
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
   * Deletes a forwarding rule in a DNS forwarding ruleset. WARNING: This operation cannot be undone.
   */
  delete is ArmResourceDeleteSync<
    ForwardingRule,
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
   * Lists forwarding rules in a DNS forwarding ruleset.
   */
  list is ArmResourceListByParent<
    ForwardingRule,
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

@@doc(ForwardingRule.name, "The name of the forwarding rule.");
@@doc(ForwardingRule.properties, "Properties of the forwarding rule.");
@@doc(ForwardingRules.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(ForwardingRules.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
