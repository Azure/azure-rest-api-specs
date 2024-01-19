import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace AzureChangeAnalysisManagementClient;

interface ResourceChangesOperations {
  @summary("List the changes of a resource within the specified time range. Customer data will be masked if the user doesn't have access.")
  @doc("List the changes of a resource within the specified time range. Customer data will be masked if the user doesn't have access.")
  @route("/{resourceId}/providers/Microsoft.ChangeAnalysis/resourceChanges")
  @post
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The identifier of the resource.")
      @path
      resourceId: string;

      @doc("Specifies the start time of the changes request.")
      @query("$startTime")
      $startTime: utcDateTime;

      @doc("Specifies the end time of the changes request.")
      @query("$endTime")
      $endTime: utcDateTime;

      @doc("A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skipToken")
      $skipToken?: string;
    },
    ChangeList
  >;
}

interface ChangesOperations {
  @summary("List the changes of a resource group within the specified time range. Customer data will always be masked.")
  @doc("List the changes of a resource group within the specified time range. Customer data will always be masked.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ChangeAnalysis/changes")
  @get
  listChangesByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Specifies the start time of the changes request.")
      @query("$startTime")
      $startTime: utcDateTime;

      @doc("Specifies the end time of the changes request.")
      @query("$endTime")
      $endTime: utcDateTime;

      @doc("A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skipToken")
      $skipToken?: string;
    },
    ChangeList
  >;

  @summary("List the changes of a subscription within the specified time range. Customer data will always be masked.")
  @doc("List the changes of a subscription within the specified time range. Customer data will always be masked.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ChangeAnalysis/changes")
  @get
  listChangesBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("Specifies the start time of the changes request.")
      @query("$startTime")
      $startTime: utcDateTime;

      @doc("Specifies the end time of the changes request.")
      @query("$endTime")
      $endTime: utcDateTime;

      @doc("A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skipToken")
      $skipToken?: string;
    },
    ChangeList
  >;
}
