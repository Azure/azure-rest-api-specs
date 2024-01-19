import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CommunicationsGateway.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.VoiceServices;
@doc("A TestLine resource")
@parentResource(CommunicationsGateway)
model TestLine is TrackedResource<TestLineProperties> {
  @doc("Unique identifier for this test line")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  @key("testLineName")
  @segment("testLines")
  name: string;
}

@armResourceOperations
interface TestLines {
  @doc("Get a TestLine")
  get is ArmResourceRead<TestLine>;

  @doc("Create a TestLine")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    TestLine,
    BaseParameters<TestLine>,
    ArmAsyncOperationHeader
  >;

  @doc("Update a TestLine")
  update is ArmCustomPatchSync<TestLine, TestLineUpdate>;

  @doc("Delete a TestLine")
  delete is ArmResourceDeleteAsync<
    TestLine,
    BaseParameters<TestLine>,
    ArmAsyncOperationHeader
  >;

  @doc("List TestLine resources by CommunicationsGateway")
  listByCommunicationsGateway is ArmResourceListByParent<TestLine>;
}
