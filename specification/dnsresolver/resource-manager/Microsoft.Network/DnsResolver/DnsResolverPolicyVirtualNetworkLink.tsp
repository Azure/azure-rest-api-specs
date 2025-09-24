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
 * Describes a DNS resolver policy virtual network link.
 */
@parentResource(DnsResolverPolicy)
model DnsResolverPolicyVirtualNetworkLink
  is Azure.ResourceManager.TrackedResource<
    DnsResolverPolicyVirtualNetworkLinkProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = DnsResolverPolicyVirtualNetworkLink,
    KeyName = "dnsResolverPolicyVirtualNetworkLinkName",
    SegmentName = "virtualNetworkLinks",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9_\\-]*[a-zA-Z0-9])?$"
  >;
  ...Legacy.EntityTagProperty;
}

@armResourceOperations
interface DnsResolverPolicyVirtualNetworkLinks {
  /**
   * Gets properties of a DNS resolver policy virtual network link.
   */
  get is ArmResourceRead<DnsResolverPolicyVirtualNetworkLink>;

  /**
   * Creates or updates a DNS resolver policy virtual network link.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DnsResolverPolicyVirtualNetworkLink,
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
    LroHeaders = ArmLroLocationHeader<FinalResult = DnsResolverPolicyVirtualNetworkLink> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a DNS resolver policy virtual network link.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DnsResolverPolicyVirtualNetworkLink,
    PatchModel = DnsResolverPolicyVirtualNetworkLinkPatch,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    }
  >;

  /**
   * Deletes a DNS resolver policy virtual network link. WARNING: This operation cannot be undone.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    DnsResolverPolicyVirtualNetworkLink,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    }
  >;

  /**
   * Lists DNS resolver policy virtual network links.
   */
  list is ArmResourceListByParent<
    DnsResolverPolicyVirtualNetworkLink,
    Parameters = {
      /**
       * The maximum number of results to return. If not specified, returns up to 100 results.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

@@maxLength(DnsResolverPolicyVirtualNetworkLink.name, 80);
@@minLength(DnsResolverPolicyVirtualNetworkLink.name, 1);
@@doc(DnsResolverPolicyVirtualNetworkLink.name,
  "The name of the DNS resolver policy virtual network link for the DNS resolver policy."
);
@@doc(DnsResolverPolicyVirtualNetworkLink.properties,
  "Properties of the DNS resolver policy virtual network link."
);
@@doc(DnsResolverPolicyVirtualNetworkLinks.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(DnsResolverPolicyVirtualNetworkLinks.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
