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
 * Describes a DNS resolver domain list.
 */
model DnsResolverDomainList
  is Azure.ResourceManager.TrackedResource<DnsResolverDomainListProperties> {
  ...ResourceNameParameter<
    Resource = DnsResolverDomainList,
    KeyName = "dnsResolverDomainListName",
    SegmentName = "dnsResolverDomainLists",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9_\\-]*[a-zA-Z0-9])?$"
  >;
  ...Legacy.EntityTagProperty;
}

@armResourceOperations
interface DnsResolverDomainLists {
  /**
   * Gets properties of a DNS resolver domain list.
   */
  get is ArmResourceRead<DnsResolverDomainList>;

  /**
   * Creates or updates a DNS resolver domain list.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DnsResolverDomainList,
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
    LroHeaders = ArmLroLocationHeader<FinalResult = DnsResolverDomainList> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a DNS resolver domain list.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DnsResolverDomainList,
    PatchModel = DnsResolverDomainListPatch,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    }
  >;

  /**
   * Deletes a DNS resolver domain list. WARNING: This operation cannot be undone.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    DnsResolverDomainList,
    Parameters = {
      /**
       * ETag of the resource. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting any concurrent changes.
       */
      @header
      ifMatch?: string;
    }
  >;

  /**
   * Lists DNS resolver domain lists within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    DnsResolverDomainList,
    Parameters = {
      /**
       * The maximum number of results to return. If not specified, returns up to 100 results.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Lists DNS resolver domain lists in all resource groups of a subscription.
   */
  list is ArmListBySubscription<
    DnsResolverDomainList,
    Parameters = {
      /**
       * The maximum number of results to return. If not specified, returns up to 100 results.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Uploads or downloads the list of domains for a DNS Resolver Domain List from a storage link.
   */
  bulk is ArmResourceActionAsync<
    DnsResolverDomainList,
    DnsResolverDomainListBulk,
    DnsResolverDomainList,
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
    }
  >;
}

@@maxLength(DnsResolverDomainList.name, 80);
@@minLength(DnsResolverDomainList.name, 1);
@@doc(DnsResolverDomainList.name, "The name of the DNS resolver domain list.");
@@doc(DnsResolverDomainList.properties,
  "Properties of the DNS resolver domain list."
);
@@doc(DnsResolverDomainLists.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(DnsResolverDomainLists.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
@@doc(DnsResolverDomainLists.bulk::parameters.body,
  "Parameters supplied to the bulk domain list operation."
);
