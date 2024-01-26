import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.VoiceServices;
/**
 * A CommunicationsGateway resource
 */
model CommunicationsGateway
  is TrackedResource<CommunicationsGatewayProperties> {
  /**
   * Unique identifier for this deployment
   */
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  @key("communicationsGatewayName")
  @segment("communicationsGateways")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface CommunicationsGateways {
  /**
   * Get a CommunicationsGateway
   */
  get is ArmResourceRead<CommunicationsGateway>;

  /**
   * Create a CommunicationsGateway
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CommunicationsGateway,
    BaseParameters<CommunicationsGateway>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a CommunicationsGateway
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    CommunicationsGateway,
    CommunicationsGatewayUpdate
  >;

  /**
   * Delete a CommunicationsGateway
   */
  delete is ArmResourceDeleteAsync<
    CommunicationsGateway,
    BaseParameters<CommunicationsGateway>,
    ArmAsyncOperationHeader
  >;

  /**
   * List CommunicationsGateway resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CommunicationsGateways_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<CommunicationsGateway>;

  /**
   * List CommunicationsGateway resources by subscription ID
   */
  listBySubscription is ArmListBySubscription<CommunicationsGateway>;
}
