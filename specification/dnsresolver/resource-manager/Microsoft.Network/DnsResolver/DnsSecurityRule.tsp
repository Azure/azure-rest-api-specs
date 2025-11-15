import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DnsResolverPolicy.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Describes a DNS security rule.
 */
@parentResource(DnsResolverPolicy)
model DnsSecurityRule
  is Azure.ResourceManager.TrackedResource<DnsSecurityRuleProperties, false> {
  ...ResourceNameParameter<
    Resource = DnsSecurityRule,
    KeyName = "dnsSecurityRuleName",
    SegmentName = "dnsSecurityRules",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9_\\-]*[a-zA-Z0-9])?$"
  >;
  ...Legacy.EntityTagProperty;
}

@armResourceOperations
interface DnsSecurityRules {
  /**
   * Gets properties of a DNS security rule for a DNS resolver policy.
   */
  get is ArmResourceRead<DnsSecurityRule>;

  /**
   * Creates or updates a DNS security rule for a DNS resolver policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DnsSecurityRule,
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
    LroHeaders = ArmLroLocationHeader<FinalResult = DnsSecurityRule> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a DNS security rule.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DnsSecurityRule,
    PatchModel = DnsSecurityRulePatch,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    }
  >;

  /**
   * Deletes a DNS security rule for a DNS resolver policy. WARNING: This operation cannot be undone.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    DnsSecurityRule,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    }
  >;

  /**
   * Lists DNS security rules for a DNS resolver policy.
   */
  list is ArmResourceListByParent<
    DnsSecurityRule,
    Parameters = {
      /**
       * The maximum number of results to return. If not specified, returns up to 100 results.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

@@maxLength(DnsSecurityRule.name, 80);
@@minLength(DnsSecurityRule.name, 1);
@@doc(DnsSecurityRule.name, "The name of the DNS security rule.");
@@doc(DnsSecurityRule.properties, "Properties of the DNS security rule.");
@@doc(DnsSecurityRules.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(DnsSecurityRules.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
