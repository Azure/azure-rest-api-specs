import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed server DNS alias.
 */
@parentResource(ManagedInstance)
model ManagedServerDnsAlias
  is Azure.ResourceManager.ProxyResource<ManagedServerDnsAliasProperties> {
  ...ResourceNameParameter<
    Resource = ManagedServerDnsAlias,
    KeyName = "dnsAliasName",
    SegmentName = "dnsAliases",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ManagedServerDnsAliases {
  /**
   * Gets a server DNS alias.
   */
  get is ArmResourceRead<ManagedServerDnsAlias>;

  /**
   * Creates a managed server DNS alias.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ManagedServerDnsAlias,
    Request = ManagedServerDnsAliasCreation,
    Response = ArmResourceUpdatedResponse<ManagedServerDnsAlias> | ArmResourceCreatedResponse<
      ManagedServerDnsAlias,
      ArmLroLocationHeader<FinalResult = ManagedServerDnsAlias> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes the managed server DNS alias with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedServerDnsAlias,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of managed server DNS aliases for a managed server.
   */
  listByManagedInstance is ArmResourceListByParent<ManagedServerDnsAlias>;

  /**
   * Acquires managed server DNS alias from another managed server.
   */
  acquire is ArmResourceActionAsync<
    ManagedServerDnsAlias,
    ManagedServerDnsAliasAcquisition,
    Response = ManagedServerDnsAlias
  >;
}

@@doc(ManagedServerDnsAlias.name, "");
@@doc(ManagedServerDnsAlias.properties, "Resource properties.");
@@doc(ManagedServerDnsAliases.createOrUpdate::parameters.resource, "");
@@doc(ManagedServerDnsAliases.acquire::parameters.body, "");
