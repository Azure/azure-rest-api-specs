import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
@doc("Definition of a DscNode")
@parentResource(AutomationAccount)
model DscNode is ProxyResource<DscNodeProperties> {
  @doc("The node id.")
  @path
  @key("nodeId")
  @segment("nodes")
  name: string;
}

@armResourceOperations
interface DscNodes {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the dsc node identified by node id.")
  @operationId("DscNode_Get")
  get is ArmResourceRead<DscNode>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the dsc node.")
  @operationId("DscNode_Update")
  update is ArmCustomPatchSync<DscNode, DscNodeUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the dsc node identified by node id.")
  @operationId("DscNode_Delete")
  delete is ArmResourceDeleteSync<DscNode>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of dsc nodes.")
  @operationId("DscNode_ListByAutomationAccount")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NodeReports_ListByNode")
  @doc("Retrieve the Dsc node report list by node id.")
  // FIXME: NodeReports_ListByNode could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodes/{nodeId}/reports")
  @get
  listByNode is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NodeReports_Get")
  @doc("Retrieve the Dsc node report data by node id and report id.")
  // FIXME: NodeReports_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodes/{nodeId}/reports/{reportId}")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NodeReports_GetContent")
  @doc("Retrieve the Dsc node reports by node id and report id.")
  // FIXME: NodeReports_GetContent could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodes/{nodeId}/reports/{reportId}/content")
  @get
  getContent is Azure.Core.Foundations.Operation<
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

@@projectedName(DscNodes.update::parameters.properties,
  "json",
  "dscNodeUpdateParameters"
);
@@extension(DscNodes.update::parameters.properties,
  "x-ms-client-name",
  "dscNodeUpdateParameters"
);
@@doc(DscNodes.update::parameters.properties,
  "Parameters supplied to the update dsc node."
);
