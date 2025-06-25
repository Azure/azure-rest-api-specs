import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./UpdateType.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Edge;

@doc("Stage Specification")
model StageSpecTemplate {
  @doc("Name of Stage")
  name: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("Stage specification")
  specification?: Record<unknown>;

  @doc("Orchestrator type")
  orchestratorType?: OrchestratorType;
}

@doc("Workflow Template Version Properties")
model WorkflowTemplateVersionProperties {
  @doc("Config expressions for this workflow version")
  configurations?: string;

  @Azure.ResourceManager.identifiers(#[])
  @doc("workflow template specification")
  stageSpecTemplate: StageSpecTemplate[];

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Workflow Template Version Resource")
@parentResource(WorkflowTemplate)
@resource("versions")
model WorkflowTemplateVersion
  is Azure.ResourceManager.ProxyResource<WorkflowTemplateVersionProperties> {
  ...ResourceNameParameter<
    WorkflowTemplateVersion,
    NamePattern = "^[0-9]+\\.[0-9]+\\.[0-9]+$"
  >;
  ...EntityTagProperty;
}

@armResourceOperations
interface WorkflowTemplateVersions {
  @doc("Get a Workflow Template Version Resource")
  get is ArmResourceRead<WorkflowTemplateVersion>;

  @doc("Create or update a Workflow Template Version Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WorkflowTemplateVersion,
    {
      ...BaseParameters<WorkflowTemplateVersion>;
      ...VersionUpdateQueryParameters;
    }
  >;

  @doc("update a Workflow Template Version Resource")
  update is ArmResourcePatchSync<
    WorkflowTemplateVersion,
    WorkflowTemplateVersionProperties,
    {
      ...BaseParameters<WorkflowTemplateVersion>;
      ...VersionUpdateQueryParameters;
    }
  >;

  @doc("Delete a Workflow Template Version Resource")
  delete is ArmResourceDeleteWithoutOkAsync<WorkflowTemplateVersion>;

  @doc("List Workflow Template Version Resources")
  listByWorkflowTemplate is ArmResourceListByParent<WorkflowTemplateVersion>;
}
