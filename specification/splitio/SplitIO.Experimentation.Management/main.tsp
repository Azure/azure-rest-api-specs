import "./LiftrBase/main.tsp";

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";

using Azure.ResourceManager;
using LiftrBase;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "SplitIO is a case-sensitive name"
@armProviderNamespace
@service({
  title: "Split.IO Experimentation",
})
@versioned(SplitIO.Experimentation.Versions)
namespace SplitIO.Experimentation;

@doc("Supported API versions for the SplitIO.Experimentation resource provider.")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  v1_preview: "2024-03-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The properties of ExperimentationWorkspace")
model ExperimentationWorkspaceProperties is BaseResourceProperties {
  @doc("Partner ExperimentationWorkspace properties")
  partnerExperimentationWorkspaceProperties?: PartnerExperimentationWorkspaceProperties;
}

@doc("Properties specific to Partner's ExperimentationWorkspace")
model PartnerExperimentationWorkspaceProperties {
  @doc("ExperimentationWorkspace id in partner's system")
  @visibility("read")
  experimentationWorkspaceId?: string;

  @doc("Whether experimentation is enabled")
  experimentationEnabled?: boolean;

  @doc("Access policy for an experimentation workspace")
  accessPolicy?: AccessPolicy;

  @doc("DataSource for an experimentation workspace")
  dataSource?: DataSource;
}

@doc("Access policy for an experimentation workspace")
model AccessPolicy {
  @doc("Application id used for access to the experimentation workspace")
  authApplicationId?: string;
}

@doc("DataSource for an experimentation workspace")
model DataSource {
  @doc("Id in partner's system")
  @visibility("read")
  id?: string;

  @doc("Resource id of the data source")
  resourceId?: string;
}

@doc("A ExperimentationWorkspace Resource by Split.IO")
model ExperimentationWorkspace
  is TrackedResource<ExperimentationWorkspaceProperties> {
  @key("workspaceName")
  @pattern("^[^<>%&:\\?/#]*$")
  @segment("experimentationWorkspaces")
  @maxLength(50)
  @doc("The name of the ExperimentationWorkspace resource")
  @path
  name: string;

  ...ManagedServiceIdentity;
}

@armResourceOperations
interface ExperimentationWorkspaces {
  get is ArmResourceRead<ExperimentationWorkspace>;
  create is ArmResourceCreateOrUpdateAsync<ExperimentationWorkspace>;
  update is ArmResourcePatchAsync<
    ExperimentationWorkspace,
    ExperimentationWorkspaceProperties
  >;
  delete is ArmResourceDeleteAsync<ExperimentationWorkspace>;
  listByResourceGroup is ArmResourceListByParent<ExperimentationWorkspace>;
  listBySubscription is ArmListBySubscription<ExperimentationWorkspace>;
}
