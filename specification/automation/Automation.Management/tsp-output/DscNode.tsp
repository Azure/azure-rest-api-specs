import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Automation;
@doc("Definition of a DscNode")
@parentResource(AutomationAccount)
model DscNode is ProxyResource<DscNodeProperties> {
  @doc("The node id.")
  @key("nodeId")
  @segment("nodes")
  name: string;
}

@armResourceOperations
@projectedName("client", "DscNode")
interface DscNodes_DscNode {
  @doc("Retrieve the dsc node identified by node id.")
  get is ArmResourceRead<DscNode>;

  @doc("Update the dsc node.")
  update is ArmCustomPatchSync<DscNode, DscNodeUpdateParameters>;

  @doc("Delete the dsc node identified by node id.")
  delete is ArmResourceDeleteSync<DscNode>;

  @doc("Retrieve a list of dsc nodes.")
  listByAutomationAccount is ArmResourceListByParent<
    DscNode,
    {
      ...BaseParameters<DscNode>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;

      @doc("The number of rows to skip.")
      @query("$skip")
      $skip?: int32;

      @doc("The number of rows to take.")
      @query("$top")
      $top?: int32;

      @doc("Return total rows.")
      @query("$inlinecount")
      $inlinecount?: string;
    }
  >;
}

@armResourceOperations
@projectedName("client", "NodeReports")
interface DscNodes_NodeReports {
  @doc("Retrieve the Dsc node report list by node id.")
  // FIXME: NodeReports_ListByNode could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodes/{nodeId}/reports")
  @get
  ListByNode is Azure.Core.Foundations.Operation<
    {
      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The parameters supplied to the list operation.")
      @path
      nodeId: string;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    DscNodeReportListResult
  >;

  @doc("Retrieve the Dsc node report data by node id and report id.")
  // FIXME: NodeReports_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodes/{nodeId}/reports/{reportId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The Dsc node id.")
      @path
      nodeId: string;

      @doc("The report id.")
      @path
      reportId: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    DscNodeReport
  >;

  @doc("Retrieve the Dsc node reports by node id and report id.")
  // FIXME: NodeReports_GetContent could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodes/{nodeId}/reports/{reportId}/content")
  @get
  GetContent is Azure.Core.Foundations.Operation<
    {
      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The Dsc node id.")
      @path
      nodeId: string;

      @doc("The report id.")
      @path
      reportId: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    void
  >;
}
