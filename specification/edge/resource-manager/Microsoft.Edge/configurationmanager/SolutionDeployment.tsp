import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_06_01)
@doc("Solution Deployment Target Details")
model TargetMetadata {
  @doc("List of capabilities")
  capabilities?: string[];

  @doc("ARM resource IDs of the Targets resources")
  targetIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/Targets";
    }
  ]>[];
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_06_01)
@doc("Solution Template Details")
model SolutionTemplateMetadata {
  @doc("Solution template subscription")
  subscriptionId?: string;

  @doc("Solution template resource group")
  resourceGroupName?: string;

  @doc("Solution template name")
  name: string;

  @doc("Solution template version")
  version: string;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_06_01)
@doc("Solution Deployment Properties")
model SolutionDeploymentProperties {
  @doc("Target properties")
  solutionTemplateProperties: SolutionTemplateMetadata;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("Input field")
  input?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("Output field")
  @visibility(Lifecycle.Read)
  output?: Record<unknown>;

  @doc("Target properties")
  targetProperties: TargetMetadata;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_06_01)
@doc("Solution Template Details for update operations")
model SolutionTemplateMetadataUpdate {
  @doc("Solution template subscription")
  subscriptionId?: string;

  @doc("Solution template resource group")
  resourceGroupName?: string;

  @doc("Solution template name")
  name?: string;

  @doc("Solution template version")
  version?: string;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_06_01)
@doc("The updatable properties of the SolutionDeploymentProperties.")
model SolutionDeploymentUpdateProperties {
  @doc("Target properties")
  solutionTemplateProperties?: SolutionTemplateMetadataUpdate;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("Input field")
  input?: Record<unknown>;

  @doc("Target properties")
  targetProperties?: TargetMetadata;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_06_01)
@doc("The type used for update operations of the SolutionDeployment.")
model SolutionDeploymentUpdate {
  ...ArmTagsProperty;

  @doc("The resource-specific properties for this resource.")
  properties?: SolutionDeploymentUpdateProperties;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_06_01)
@doc("Solution Deployment Resource. Represents a resource to be deployed on the cloud or edge.")
model SolutionDeployment
  is Azure.ResourceManager.TrackedResource<SolutionDeploymentProperties> {
  ...ResourceNameParameter<SolutionDeployment>;
  ...EntityTagProperty;
}

@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_06_01)
@armResourceOperations
interface SolutionDeployments {
  @doc("Get a SolutionDeployment Resource")
  get is ArmResourceRead<SolutionDeployment>;

  @doc("Create or update a SolutionDeployment Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SolutionDeployment>;

  @doc("update a SolutionDeployment Resource")
  update is ArmCustomPatchSync<SolutionDeployment, SolutionDeploymentUpdate>;

  @doc("Delete a SolutionDeployment Resource")
  delete is ArmResourceDeleteWithoutOkAsync<SolutionDeployment>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<SolutionDeployment>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<SolutionDeployment>;
}
