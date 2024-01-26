import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Batch;

interface LocationOperations {
  /**
   * Gets the Batch service quotas for the specified subscription at the given location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Batch/locations/{locationName}/quotas")
  @get
  getQuotas is Azure.Core.Foundations.Operation<
    {
      /**
       * The region for which to retrieve Batch service quotas.
       */
      @path
      locationName: string;

      /**
       * The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)
       */
      @path
      subscriptionId: string;
    },
    BatchLocationQuota
  >;

  /**
   * Gets the list of Batch supported Virtual Machine VM sizes available at the given location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Batch/locations/{locationName}/virtualMachineSkus")
  @get
  listSupportedVirtualMachineSkus is Azure.Core.Foundations.Operation<
    {
      /**
       * The region for which to retrieve Batch service supported SKUs.
       */
      @path
      locationName: string;

      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;

      /**
       * OData filter expression. Valid properties for filtering are "familyName".
       */
      @query("$filter")
      $filter?: string;

      /**
       * The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)
       */
      @path
      subscriptionId: string;
    },
    SupportedSkusResult
  >;

  /**
   * Gets the list of Batch supported Cloud Service VM sizes available at the given location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Batch/locations/{locationName}/cloudServiceSkus")
  @get
  listSupportedCloudServiceSkus is Azure.Core.Foundations.Operation<
    {
      /**
       * The region for which to retrieve Batch service supported SKUs.
       */
      @path
      locationName: string;

      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;

      /**
       * OData filter expression. Valid properties for filtering are "familyName".
       */
      @query("$filter")
      $filter?: string;

      /**
       * The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)
       */
      @path
      subscriptionId: string;
    },
    SupportedSkusResult
  >;

  /**
   * Checks whether the Batch account name is available in the specified region.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Batch/locations/{locationName}/checkNameAvailability")
  @post
  checkNameAvailability is Azure.Core.Foundations.Operation<
    {
      /**
       * The desired region for the name check.
       */
      @path
      locationName: string;

      /**
       * The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)
       */
      @path
      subscriptionId: string;

      /**
       * Properties needed to check the availability of a name.
       */
      @body
      parameters: CheckNameAvailabilityParameters;
    },
    CheckNameAvailabilityResult
  >;
}
