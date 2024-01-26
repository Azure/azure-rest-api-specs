import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AvailabilityGroupListener.tsp";
import "./SqlVirtualMachineGroup.tsp";
import "./SqlVirtualMachine.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * The SQL virtual machine management API provides a RESTful set of web APIs that interact with Azure Compute, Network & Storage services to manage your SQL Server virtual machine. The API enables users to create, delete and retrieve a SQL virtual machine, SQL virtual machine group or availability group listener.
 */
@armProviderNamespace
@service({
  title: "SqlVirtualMachineManagementClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.SqlVirtualMachine;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-02-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_02_01: "2022-02-01",
}
