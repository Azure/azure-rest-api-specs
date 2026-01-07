import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Describes the configuration of a Business Application Agent.
 */
model BusinessApplicationAgentResource
  is Azure.ResourceManager.ProxyResource<AgentProperties, false> {
  ...ResourceNameParameter<
    Resource = BusinessApplicationAgentResource,
    KeyName = "agentResourceName",
    SegmentName = "businessApplicationAgents",
    NamePattern = "^[a-z0-9,-]*$"
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias workspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface BusinessApplicationAgentResources {
  /**
   * Gets Business Application Agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BusinessApplicationAgent_Get")
  get is ArmResourceRead<BusinessApplicationAgentResource>;

  /**
   * Creates or updates the Business Application Agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BusinessApplicationAgents_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<BusinessApplicationAgentResource>;

  /**
   * Delete the Business Application Agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BusinessApplicationAgents_Delete")
  delete is ArmResourceDeleteSync<BusinessApplicationAgentResource>;

  /**
   * Gets all Business Application Agents under the workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BusinessApplicationAgents_List")
  list is ArmResourceListByParent<
    BusinessApplicationAgentResource,
    Parameters = {
      /**
       * Filters the results, based on a Boolean condition. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<BusinessApplicationAgentsList>
  >;
}

@@maxLength(BusinessApplicationAgentResource.name, 63);
@@minLength(BusinessApplicationAgentResource.name, 3);
@@doc(BusinessApplicationAgentResource.name, "Business Application Agent Name");
@@doc(BusinessApplicationAgentResource.properties, "");
@@doc(BusinessApplicationAgentResources.createOrUpdate::parameters.resource,
  "The Business Application Agent"
);
