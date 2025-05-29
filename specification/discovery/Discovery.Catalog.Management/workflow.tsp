import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../Discovery.Management.Shared/all.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Workflow tracked resource")
model Workflow is TrackedResource<WorkflowProperties> {
  ...ResourceNameParameter<Workflow>;
}

@doc("Discovery Workflow list item properties")
model WorkflowProperties {
  ...DiscoveryResourceProperties;
  ...WithDefinitionContent;
}

@armResourceOperations
interface Workflows extends DiscoveryResource<Workflow, WorkflowProperties> {}
