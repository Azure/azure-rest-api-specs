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
/**
 * Definition of a DscNode
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@Azure.ResourceManager.Private.armResourceInternal(DscNodeProperties)
@includeInapplicableMetadataInPayload(false)
model DscNode extends ProxyResourceBase {
  /**
   * The node id.
   */
  @path
  @key("nodeId")
  @segment("nodes")
  name: string;

  /**
   * The properties of a DscNode.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DscNodeProperties;
}

@armResourceOperations
interface DscNodes {
  /**
   * Retrieve the dsc node identified by node id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscNode_Get")
  get is ArmResourceRead<DscNode>;

  /**
   * Update the dsc node.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("DscNode_Update")
  update is ArmCustomPatchSync<DscNode, DscNodeUpdateParameters>;

  /**
   * Delete the dsc node identified by node id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscNode_Delete")
  delete is ArmResourceDeleteSync<DscNode>;

  /**
   * Retrieve a list of dsc nodes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscNode_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    DscNode,
    {
      ...BaseParameters<DscNode>;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of rows to skip.
       */
      @query("$skip")
      $skip?: int32;

      /**
       * The number of rows to take.
       */
      @query("$top")
      $top?: int32;

      /**
       * Return total rows.
       */
      @query("$inlinecount")
      $inlinecount?: string;
    }
  >;

  /**
   * Retrieve the Dsc node report list by node id.
   */
  // FIXME: NodeReports_ListByNode could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NodeReports_ListByNode")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodes/{nodeId}/reports")
  @get
  listByNode is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The parameters supplied to the list operation.
       */
      @path
      nodeId: string;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    DscNodeReportListResult
  >;

  /**
   * Retrieve the Dsc node report data by node id and report id.
   */
  // FIXME: NodeReports_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NodeReports_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodes/{nodeId}/reports/{reportId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The Dsc node id.
       */
      @path
      nodeId: string;

      /**
       * The report id.
       */
      @path
      reportId: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    DscNodeReport
  >;

  /**
   * Retrieve the Dsc node reports by node id and report id.
   */
  // FIXME: NodeReports_GetContent could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NodeReports_GetContent")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodes/{nodeId}/reports/{reportId}/content")
  @get
  getContent is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The Dsc node id.
       */
      @path
      nodeId: string;

      /**
       * The report id.
       */
      @path
      reportId: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
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
