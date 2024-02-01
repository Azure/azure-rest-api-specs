import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ProgrammableConnectivity;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The provisioning state of a resource.
 */
enum ProvisioningState {
  /**
   * Resource has been created.
   */
  Succeeded,

  /**
   * Resource creation failed.
   */
  Failed,

  /**
   * Resource creation was canceled.
   */
  Canceled,

  /**
   * The resource is being provisioned
   */
  Provisioning,

  /**
   * The resource is updating
   */
  Updating,

  /**
   * The resource is being deleted
   */
  Deleting,

  /**
   * The resource create or update request has been accepted
   */
  Accepted,
}
