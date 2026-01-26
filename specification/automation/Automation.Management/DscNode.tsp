import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of a DscNode
 */
@parentResource(AutomationAccount)
model DscNode is Azure.ResourceManager.ProxyResource<DscNodeProperties> {
  ...ResourceNameParameter<
    Resource = DscNode,
    KeyName = "nodeId",
    SegmentName = "nodes",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DscNodes {
  /**
   * Retrieve the dsc node identified by node id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscNode_Get")
  get is ArmResourceRead<DscNode>;

  /**
   * Update the dsc node.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscNode_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<DscNode, PatchModel = DscNodeUpdateParameters>;

  /**
   * Delete the dsc node identified by node id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("DscNode_Delete")
  delete is ArmResourceDeleteSync<DscNode, Response = ArmDeletedResponse>;

  /**
   * Retrieve a list of dsc nodes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscNode_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    DscNode,
    Parameters = {
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NodeReports_ListByNode")
  @list
  @get
  @action("reports")
  listByNode is ArmResourceActionSync<
    DscNode,
    void,
    ArmResponse<DscNodeReportListResult>,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Retrieve the Dsc node report data by node id and report id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NodeReports_Get")
  @get
  @action("{reportId}")
  nodeReportsGet is ArmResourceActionSync<
    DscNode,
    void,
    ArmResponse<DscNodeReport>,
    Parameters = {
      /**
       * The report id.
       */
      @path
      reportId: string;
    }
  >;

  /**
   * Retrieve the Dsc node reports by node id and report id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NodeReports_GetContent")
  @get
  @action("content")
  getContent is ArmResourceActionSync<
    DscNode,
    void,
    ArmResponse<unknown>,
    Parameters = {
      /**
       * The report id.
       */
      @path
      reportId: string;
    }
  >;
}

@@doc(DscNode.name, "The node id.");
@@doc(DscNode.properties, "The properties of a DscNode.");
@@doc(DscNodes.update::parameters.properties,
  "Parameters supplied to the update dsc node."
);
