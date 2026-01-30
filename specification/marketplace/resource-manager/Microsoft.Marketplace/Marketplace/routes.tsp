// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Marketplace;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PrivateStoreCollectionOperationGroup {
  /**
   * Delete Private store collection. This is a workaround.
   */
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}")
  @post
  post(
    ...ApiVersionParameter,

    /**
     * The store ID - must use the tenant ID
     */
    @path
    privateStoreId: string,

    /**
     * The collection ID
     */
    @path
    collectionId: string,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @bodyRoot
    payload?: Operation,
  ): OkResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PrivateStoreCollectionOfferOperationGroup {
  /**
   * Delete Private store offer. This is a workaround.
   */
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/offers/{offerId}")
  @post
  post(
    ...ApiVersionParameter,

    /**
     * The store ID - must use the tenant ID
     */
    @path
    privateStoreId: string,

    /**
     * The collection ID
     */
    @path
    collectionId: string,

    /**
     * The offer ID to update or delete
     */
    @path
    offerId: string,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @bodyRoot
    payload?: Operation,
  ): OkResponse | ErrorResponse;
}
