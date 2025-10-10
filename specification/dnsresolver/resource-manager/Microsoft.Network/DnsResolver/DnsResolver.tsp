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
 * Describes a DNS resolver.
 */
model DnsResolver
  is Azure.ResourceManager.TrackedResource<DnsResolverProperties, false> {
  ...ResourceNameParameter<
    Resource = DnsResolver,
    KeyName = "dnsResolverName",
    SegmentName = "dnsResolvers",
    NamePattern = ""
  >;
  ...Legacy.EntityTagProperty;
}

@armResourceOperations
interface DnsResolvers {
  /**
   * Gets properties of a DNS resolver.
   */
  get is ArmResourceRead<DnsResolver, Error = CloudError>;

  /**
   * Creates or updates a DNS resolver.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DnsResolver,
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
    Response = ArmResourceUpdatedResponse<DnsResolver> | ArmResourceCreatedResponse<
      DnsResolver,
      ArmLroLocationHeader<FinalResult = DnsResolver> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse,
    Error = CloudError
  >;

  /**
   * Updates a DNS resolver.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DnsResolver,
    PatchModel = DnsResolverPatch,
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
   * Deletes a DNS resolver. WARNING: This operation cannot be undone.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DnsResolver,
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
   * Lists DNS resolvers within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    DnsResolver,
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
   * Lists DNS resolvers in all resource groups of a subscription.
   */
  list is ArmListBySubscription<
    DnsResolver,
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

@@doc(DnsResolver.name, "The name of the DNS resolver.");
@@doc(DnsResolver.properties, "Properties of the DNS resolver.");
@@doc(DnsResolvers.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate operation."
);
@@doc(DnsResolvers.update::parameters.properties,
  "Parameters supplied to the Update operation."
);
