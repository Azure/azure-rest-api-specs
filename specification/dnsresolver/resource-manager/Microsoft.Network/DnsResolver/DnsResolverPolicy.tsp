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
 * Describes a DNS resolver policy.
 */
model DnsResolverPolicy
  is Azure.ResourceManager.TrackedResource<DnsResolverPolicyProperties> {
  ...ResourceNameParameter<
    Resource = DnsResolverPolicy,
    KeyName = "dnsResolverPolicyName",
    SegmentName = "dnsResolverPolicies",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9_\\-]*[a-zA-Z0-9])?$"
  >;
  ...Legacy.EntityTagProperty;
}

@armResourceOperations
interface DnsResolverPolicies {
  /**
   * Gets properties of a DNS resolver policy.
   */
  get is ArmResourceRead<DnsResolverPolicy>;

  /**
   * Creates or updates a DNS resolver policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DnsResolverPolicy,
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
    LroHeaders = ArmLroLocationHeader<FinalResult = DnsResolverPolicy> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a DNS resolver policy.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DnsResolverPolicy,
    PatchModel = DnsResolverPolicyPatch,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    }
  >;

  /**
   * Deletes a DNS resolver policy. WARNING: This operation cannot be undone.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    DnsResolverPolicy,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    }
  >;

  /**
   * Lists DNS resolver policies within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    DnsResolverPolicy,
    Parameters = {
      /**
       * The maximum number of results to return. If not specified, returns up to 100 results.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Lists DNS resolver policies in all resource groups of a subscription.
   */
  list is ArmListBySubscription<
    DnsResolverPolicy,
    Parameters = {
      /**
       * The maximum number of results to return. If not specified, returns up to 100 results.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

@@maxLength(DnsResolverPolicy.name, 80);
@@minLength(DnsResolverPolicy.name, 1);
@@doc(DnsResolverPolicy.name, "The name of the DNS resolver policy.");
@@doc(DnsResolverPolicy.properties, "Properties of the DNS resolver policy.");
@@doc(DnsResolverPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(DnsResolverPolicies.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
