import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceLinker;
/**
 * Linker of source and target resource
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model LinkerResource
  is Azure.ResourceManager.ProxyResource<LinkerProperties, false> {
  ...ResourceNameParameter<
    Resource = LinkerResource,
    KeyName = "connectorName",
    SegmentName = "connectors",
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Connector_Get")
  get is LinkerResourceOps.Read<LinkerResource>;

  /**
   * Create or update Connector resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Connector_CreateOrUpdate")
  createOrUpdate is LinkerResourceOps.CreateOrUpdateAsync<LinkerResource>;

  /**
   * Operation to update an existing Connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("Connector_Update")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Connector_Delete")
  delete is LinkerResourceOps.DeleteWithoutOkAsync<
    LinkerResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Returns list of connector which connects to the resource, which supports to config the target service during the resource provision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Connector_List")
  list is LinkerResourceOps.List<
    LinkerResource,
    Response = ArmResponse<ResourceList>
  >;

  /**
   * Validate a Connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Connector_Validate")
  validate is LinkerResourceOps.ActionAsync<
    LinkerResource,
    void,
    ArmResponse<ValidateOperationResult>
  >;

  /**
   * Generate configurations for a Connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Connector_GenerateConfigurations")
  generateConfigurations is LinkerResourceOps.ActionSync<
    LinkerResource,
    {
      /**
       * Connection Info, including format, secret store, etc
       */
      @bodyRoot
      parameters?: ConfigurationInfo;
    },
    ArmResponse<ConfigurationResult>
  >;
}
@armResourceOperations
interface LinkerOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,

        /** {resourceUri} */
        @path @segment("{resourceUri}") providers: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = LinkerResource,
        KeyName = "linkers",
        SegmentName = "Microsoft.ServiceLinker",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Linker {
  /**
   * Returns Linker resource for a given name.
   */
  get is LinkerOps.Read<
    LinkerResource,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;

      /**
       * The name Linker resource.
       */
      @path
      linkerName: string;
    }
  >;

  /**
   * Create or update Linker resource.
   */
  createOrUpdate is LinkerOps.CreateOrUpdateAsync<
    LinkerResource,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;

      /**
       * The name Linker resource.
       */
      @path
      linkerName: string;
    }
  >;

  /**
   * Operation to update an existing Linker.
   */
  @patch(#{ implicitOptionality: false })
  update is LinkerOps.CustomPatchAsync<
    LinkerResource,
    PatchModel = LinkerPatch,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;

      /**
       * The name Linker resource.
       */
      @path
      linkerName: string;
    },
    Response = ArmResponse<LinkerResource> | ArmResourceCreatedResponse<LinkerResource>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a Linker.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is LinkerOps.DeleteWithoutOkAsync<
    LinkerResource,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;

      /**
       * The name Linker resource.
       */
      @path
      linkerName: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Returns list of Linkers which connects to the resource. which supports to config both application and target service during the resource provision.
   */
  list is LinkerOps.List<
    LinkerResource,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;
    },
    Response = ArmResponse<ResourceList>
  >;

  /**
   * Validate a Linker.
   */
  @action("validateLinker")
  validate is LinkerOps.ActionAsync<
    LinkerResource,
    void,
    ArmResponse<ValidateOperationResult>,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;

      /**
       * The name Linker resource.
       */
      @path
      linkerName: string;
    }
  >;

  /**
   * list source configurations for a Linker.
   */
  listConfigurations is LinkerOps.ActionSync<
    LinkerResource,
    void,
    ArmResponse<ConfigurationResult>,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;

      /**
       * The name Linker resource.
       */
      @path
      linkerName: string;
    }
  >;

  /**
   * Generate configurations for a Linker.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Linkers_GenerateConfigurations")
  generateConfigurations is LinkerOps.ActionSync<
    LinkerResource,
    {
      /**
       * Connection Info, including format, secret store, etc
       */
      @bodyRoot
      parameters?: ConfigurationInfo;
    },
    ArmResponse<ConfigurationResult>,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;

      /**
       * The name Linker resource.
       */
      @path
      linkerName: string;
    }
  >;
}

@@doc(LinkerResource.name, "The name of resource.");
@@doc(LinkerResource.properties, "The properties of the Linker.");
@@doc(LinkerResources.createOrUpdate::parameters.resource,
  "Connector details."
);
@@doc(LinkerResources.update::parameters.properties, "Connector details.");
@@doc(Linker.createOrUpdate::parameters.resource, "Linker details.");
@@doc(Linker.update::parameters.properties, "Linker details.");
