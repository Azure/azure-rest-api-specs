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
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/dscnodeoperations")
  get is ArmResourceRead<DscNode>;

  /**
   * Update the dsc node.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscNode_Update")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/dscnodeoperations")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<DscNode, PatchModel = DscNodeUpdateParameters>;

  /**
   * Delete the dsc node identified by node id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("DscNode_Delete")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/dscnodeoperations")
  delete is ArmResourceDeleteSync<DscNode, Response = ArmDeletedResponse>;

  /**
   * Retrieve a list of dsc nodes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscNode_ListByAutomationAccount")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/dscnodeoperations")
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
    },
    Response = ArmResponse<DscNodeListResult>
  >;

  /**
   * Retrieve the Dsc node report list by node id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NodeReports_ListByNode")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/dscnodereportoperations")
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
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/dscnodereportoperations")
  @get
  nodeReportsGet is ArmResourceRead<
    DscNode,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<DscNode>,
    Response = ArmResponse<DscNodeReport>,
    Parameters = {
      /**
       * The report id.
       */
      @path
      @segment("reports")
      reportId: string;
    }
  >;

  /**
   * Retrieve the Dsc node reports by node id and report id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NodeReports_GetContent")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/dscnodereportoperations")
  @get
  @action("content")
  getContent is ArmResourceRead<
    DscNode,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<DscNode>,
    Response = ArmResponse<unknown>,
    Parameters = {
      /**
       * The report id.
       */
      @path
      @segment("reports")
      reportId: string;
    }
  >;
}

@@doc(DscNode.name, "The node id.");
@@doc(DscNode.properties, "The properties of a DscNode.");
@@doc(DscNodes.update::parameters.properties,
  "Parameters supplied to the update dsc node."
);
