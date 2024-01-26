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
/**
 * A TestLine resource
 */
@parentResource(CommunicationsGateway)
model TestLine is TrackedResource<TestLineProperties> {
  /**
   * Unique identifier for this test line
   */
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  @key("testLineName")
  @segment("testLines")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface TestLines {
  /**
   * Get a TestLine
   */
  get is ArmResourceRead<TestLine>;

  /**
   * Create a TestLine
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    TestLine,
    BaseParameters<TestLine>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a TestLine
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<TestLine, TestLineUpdate>;

  /**
   * Delete a TestLine
   */
  delete is ArmResourceDeleteAsync<
    TestLine,
    BaseParameters<TestLine>,
    ArmAsyncOperationHeader
  >;

  /**
   * List TestLine resources by CommunicationsGateway
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TestLines_ListByCommunicationsGateway")
  listByCommunicationsGateway is ArmResourceListByParent<TestLine>;
}
