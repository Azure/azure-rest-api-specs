import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Data flow resource type.
 */
@parentResource(Factory)
model DataFlowResource is Azure.ResourceManager.ProxyResource<DataFlow, false> {
  ...ResourceNameParameter<
    Resource = DataFlowResource,
    KeyName = "dataFlowName",
    SegmentName = "dataflows",
    NamePattern = "^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$"
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@tag("dataFlows")
@armResourceOperations(#{ omitTags: true })
interface DataFlowResources {
  /**
   * Gets a data flow.
   */
  @tag("dataFlows")
  get is ArmResourceRead<
    DataFlowResource,
    Parameters = {
      /**
       * ETag of the data flow entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a data flow.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("dataFlows")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataFlowResource,
    Parameters = {
      /**
       * ETag of the data flow entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<DataFlowResource>,
    Error = CloudError
  >;

  /**
   * Deletes a data flow.
   */
  @tag("dataFlows")
  delete is ArmResourceDeleteSync<DataFlowResource, Error = CloudError>;

  /**
   * Lists data flows.
   */
  @tag("dataFlows")
  listByFactory is ArmResourceListByParent<
    DataFlowResource,
    Response = ArmResponse<DataFlowListResponse>,
    Error = CloudError
  >;
}

@@maxLength(DataFlowResource.name, 260);
@@minLength(DataFlowResource.name, 1);
@@doc(DataFlowResource.name, "The data flow name.");
@@doc(DataFlowResource.properties, "Data flow properties.");
@@doc(DataFlowResources.createOrUpdate::parameters.resource,
  "Data flow resource definition."
);
