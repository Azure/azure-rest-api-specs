import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains information about a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(BatchAccount)
model PrivateLinkResource extends AzureProxyResource {
  properties?: PrivateLinkResourceProperties;
}

alias PrivateLinkResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<PrivateLinkResource>;

    /** The name of the Batch account. */
    @path
    @segment("batchAccounts")
    @key
    @pattern("^[a-zA-Z0-9]+$")
    @maxLength(24)
    @minLength(3)
    accountName: string;
  },
  {
    /** The private link resource name. This must be unique within the account. */
    @path
    @segment("privateLinkResources")
    @key
    @pattern("^[a-zA-Z0-9_-]+\\.?[a-fA-F0-9-]*$")
    @maxLength(101)
    @minLength(1)
    privateLinkResourceName: string;
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets information about the specified private link resource.
   */
  get is PrivateLinkResourceOps.Read<PrivateLinkResource>;

  /**
   * Lists all of the private link resources in the specified account.
   */
  listByBatchAccount is PrivateLinkResourceOps.List<
    PrivateLinkResource,
    Parameters = {
      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    },
    Response = ArmResponse<ListPrivateLinkResourcesResult>
  >;
}

@@doc(PrivateLinkResource.properties,
  "The properties associated with the private link resource."
);
