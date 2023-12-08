import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataProtectionBackup;

interface DataProtectionOperations {
  @summary("Validates if a feature is supported")
  @doc("Validates if a feature is supported")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataProtection/locations/{location}/checkFeatureSupport")
  @post
  CheckFeatureSupport is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @path
      location: string;

      @doc("Feature support request object")
      @body
      content: FeatureValidationRequestBase;
    },
    FeatureValidationResponseBase
  >;
}

interface FetchSecondaryRecoveryPointsOperations {
  @doc("Returns a list of Secondary Recovery Points for a DataSource in a vault, that can be used for Cross Region Restore.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/fetchSecondaryRecoveryPoints")
  @post
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Azure region.")
      @minLength(1)
      @path
      location: string;

      @doc("OData filter options.")
      @query("$filter")
      $filter?: string;

      @doc("skipToken Filter.")
      @query("$skipToken")
      $skipToken?: string;

      @doc("Request body for operation")
      @body
      parameters: FetchSecondaryRPsRequestParameters;
    },
    AzureBackupRecoveryPointResourceList
  >;
}

interface FetchCrossRegionRestoreJobOperations {
  @doc("Fetches the Cross Region Restore Job")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/fetchCrossRegionRestoreJob")
  @post
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the Azure region.")
      @minLength(1)
      @path
      location: string;

      @doc("Request body for operation")
      @body
      parameters: CrossRegionRestoreJobRequest;
    },
    AzureBackupJobResource
  >;
}

interface FetchCrossRegionRestoreJobsOperations {
  @doc("Fetches list of Cross Region Restore job belonging to the vault")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/fetchCrossRegionRestoreJobs")
  @post
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the Azure region.")
      @minLength(1)
      @path
      location: string;

      @doc("OData filter options.")
      @query("$filter")
      $filter?: string;

      @doc("Request body for operation")
      @body
      parameters: CrossRegionRestoreJobsRequest;
    },
    AzureBackupJobResourceList
  >;
}
