import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Qumulo.Storage;

interface OperationsOperations {
  @doc("List the operations for the provider")
  @route("/providers/Qumulo.Storage/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface FileSystemsOperations {
  @doc("List FileSystemResource resources by subscription ID")
  @route("/subscriptions/{subscriptionId}/providers/Qumulo.Storage/fileSystems")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    FileSystemResourceListResult
  >;

  @doc("List FileSystemResource resources by resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Qumulo.Storage/fileSystems")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    FileSystemResourceListResult
  >;

  @doc("Get a FileSystemResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Qumulo.Storage/fileSystems/{fileSystemName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the File System resource")
      @path
      fileSystemName: string;
    },
    FileSystemResource
  >;

  @doc("Create a FileSystemResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Qumulo.Storage/fileSystems/{fileSystemName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the File System resource")
      @path
      fileSystemName: string;

      @doc("Resource create parameters.")
      @body
      resource: FileSystemResource;
    },
    FileSystemResource
  >;

  @doc("Update a FileSystemResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Qumulo.Storage/fileSystems/{fileSystemName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the File System resource")
      @path
      fileSystemName: string;

      @doc("The resource properties to be updated.")
      @body
      properties: FileSystemResourceUpdate;
    },
    FileSystemResource
  >;

  @doc("Delete a FileSystemResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Qumulo.Storage/fileSystems/{fileSystemName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the File System resource")
      @path
      fileSystemName: string;
    },
    void
  >;
}
