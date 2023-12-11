import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AvailabilityGroupListener.tsp";
import "./SqlVmGroup.tsp";
import "./SqlVm.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "SqlVirtualMachineManagementClient",
})
@versioned(Versions)
@doc("The SQL virtual machine management API provides a RESTful set of web APIs that interact with Azure Compute, Network & Storage services to manage your SQL Server virtual machine. The API enables users to create, delete and retrieve a SQL virtual machine, SQL virtual machine group or availability group listener.")
namespace Azure.ResourceManager.SqlVirtualMachine;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_02_01: "2022-02-01",
}
