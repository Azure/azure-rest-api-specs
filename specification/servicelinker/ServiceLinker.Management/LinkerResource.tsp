import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ServiceLinker;
/**
 * Linker of source and target resource
 */
model LinkerResource
  is Azure.ResourceManager.ExtensionResource<LinkerProperties, false> {
  ...ResourceNameParameter<
    Resource = LinkerResource,
    KeyName = "linkerName",
    SegmentName = "linkers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface LinkerResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...LocationParameter,
      },
      KeysOf<ResourceNameParameter<
        Resource = LinkerResource,
        KeyName = "connectorName",
        SegmentName = "connectors",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface LinkerResources {
  /**
   * Returns Connector resource for a given name.
   */
  get is LinkerResourceOps.Read<LinkerResource>;

  /**
   * Create or update Connector resource.
   */
  createOrUpdate is LinkerResourceOps.CreateOrUpdateAsync<LinkerResource>;
  /**
   * Operation to update an existing Connector.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is LinkerResourceOps.CustomPatchAsync<
    LinkerResource,
    PatchModel = LinkerPatch,
    Response = ArmResponse<LinkerResource> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = LinkerResource>> & {
      @bodyRoot
      _: LinkerResource;
    })
  >;

  /**
   * Delete a Connector.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is LinkerResourceOps.DeleteWithoutOkAsync<
    LinkerResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Returns list of connector which connects to the resource, which supports to config the target service during the resource provision.
   */
  list is LinkerResourceOps.List<
    LinkerResource,
    Response = ArmResponse<ResourceList>
  >;

  /**
   * Validate a Connector.
   */
  validate is LinkerResourceOps.ActionAsync<
    LinkerResource,
    void,
    ValidateOperationResult
  >;

  /**
   * Generate configurations for a Connector.
   */
  generateConfigurations is LinkerResourceOps.ActionSync<
    LinkerResource,
    ConfigurationInfo,
    ArmResponse<ConfigurationResult>,
    OptionalRequestBody = true
  >;
}

@armResourceOperations
interface Linker {
  /**
   * Returns Linker resource for a given name.
   */
  get is Extension.Read<Extension.ScopeParameter, LinkerResource>;

  /**
   * Create or update Linker resource.
   */
  createOrUpdate is Extension.CreateOrUpdateAsync<
    Extension.ScopeParameter,
    LinkerResource
  >;

  /**
   * Operation to update an existing Linker.
   */
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchAsync<
    Extension.ScopeParameter,
    LinkerResource,
    PatchModel = LinkerPatch,
    Response = ArmResponse<LinkerResource> | ArmResourceCreatedResponse<
      LinkerResource,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = LinkerResource>
    >
  >;

  /**
   * Delete a Linker.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is Extension.DeleteWithoutOkAsync<
    Extension.ScopeParameter,
    LinkerResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Returns list of Linkers which connects to the resource. which supports to config both application and target service during the resource provision.
   */
  @segment("linkers")
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    LinkerResource,
    Response = ArmResponse<ResourceList>
  >;

  /**
   * Validate a Linker.
   */
  @action("validateLinker")
  validate is Extension.ActionAsync<
    Extension.ScopeParameter,
    LinkerResource,
    void,
    ValidateOperationResult
  >;

  /**
   * list source configurations for a Linker.
   */
  listConfigurations is Extension.ActionSync<
    Extension.ScopeParameter,
    LinkerResource,
    void,
    ArmResponse<ConfigurationResult>
  >;

  /**
   * Generate configurations for a Linker.
   */
  generateConfigurations is Extension.ActionSync<
    Extension.ScopeParameter,
    LinkerResource,
    ConfigurationInfo,
    ArmResponse<ConfigurationResult>,
    OptionalRequestBody = true
  >;
}

@@doc(LinkerResource.name, "The name Linker resource.");
@@doc(LinkerResource.properties, "The properties of the Linker.");
@@doc(LinkerResources.createOrUpdate::parameters.resource,
  "Connector details."
);
@@doc(LinkerResources.update::parameters.properties, "Connector details.");
@@doc(Linker.createOrUpdate::parameters.resource, "Linker details.");
@@doc(Linker.update::parameters.properties, "Linker details.");
@@doc(LinkerResources.generateConfigurations::parameters.body,
  "Connection Info, including format, secret store, etc"
);
@@doc(Linker.generateConfigurations::parameters.body,
  "Connection Info, including format, secret store, etc"
);
