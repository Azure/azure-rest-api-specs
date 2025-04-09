import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Azure.Testing.Management;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Workspaces
  extends TrackedResourceOperations<Workspace, WorkspaceProperties> {
  checkNameAvailability is checkGlobalNameAvailability;
}
