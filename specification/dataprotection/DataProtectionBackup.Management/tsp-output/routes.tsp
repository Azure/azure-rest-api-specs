import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataProtection;

interface DataProtectionOperations {
  /**
   * Validates if a feature is supported
   */
  @summary("Validates if a feature is supported")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataProtection/locations/{location}/checkFeatureSupport")
  @post
  checkFeatureSupport is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      @path
      location: string;

      /**
       * Feature support request object
       */
      @body
      content: FeatureValidationRequestBase;
    },
    FeatureValidationResponseBase
  >;
}

interface FetchSecondaryRecoveryPointsOperations {
  /**
   * Returns a list of Secondary Recovery Points for a DataSource in a vault, that can be used for Cross Region Restore.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/fetchSecondaryRecoveryPoints")
  @post
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the Azure region.
       */
      @minLength(1)
      @path
      location: string;

      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;

      /**
       * skipToken Filter.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Request body for operation
       */
      @body
      parameters: FetchSecondaryRPsRequestParameters;
    },
    ResourceListResult<AzureBackupRecoveryPointResource>
  >;
}

interface FetchCrossRegionRestoreJobOperations {
  /**
   * Fetches the Cross Region Restore Job
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/fetchCrossRegionRestoreJob")
  @post
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the Azure region.
       */
      @minLength(1)
      @path
      location: string;

      /**
       * Request body for operation
       */
      @body
      parameters: CrossRegionRestoreJobRequest;
    },
    AzureBackupJobResource
  >;
}

interface FetchCrossRegionRestoreJobsOperations {
  /**
   * Fetches list of Cross Region Restore job belonging to the vault
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/fetchCrossRegionRestoreJobs")
  @post
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the Azure region.
       */
      @minLength(1)
      @path
      location: string;

      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Request body for operation
       */
      @body
      parameters: CrossRegionRestoreJobsRequest;
    },
    ResourceListResult<AzureBackupJobResource>
  >;
}
