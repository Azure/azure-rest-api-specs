import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Account)
model CapabilityHostResource
  is Azure.ResourceManager.ProxyResource<CapabilityHost, false> {
  ...ResourceNameParameter<
    Resource = CapabilityHost,
    KeyName = "capabilityHostName",
    SegmentName = "capabilityHosts",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
  >;
}

@armResourceOperations
interface CapabilityHostOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of Cognitive Services account. */
        @path
        @segment("accounts")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @minLength(2)
        @maxLength(64)
        accountName: string,
      },
      {
        /** The name of the capability host associated with the Cognitive Services Resource */
        @path
        @segment("capabilityHosts")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        capabilityHostName: string,
      }
    > {}

@armResourceOperations
interface CapabilityHosts {
  /**
   * Get account capabilityHost.
   */
  get is CapabilityHostOps.Read<
    CapabilityHostResource,
    Response = ArmResponse<CapabilityHostResource>
  >;

  /**
   * Create or update account capabilityHost.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is CapabilityHostOps.CreateOrUpdateAsync<
    CapabilityHostResource,
    Request = CapabilityHostResource,
    Response = ArmResponse<CapabilityHostResource> | ArmResourceCreatedResponse<
      CapabilityHostResource,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = CapabilityHostResource> & {
        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @header("x-ms-async-operation-timeout")
        @format("duration")
        asyncOperationTimeout: string;
      }
    >
  >;

  /**
   * Delete account capabilityHost.
   */
  delete is CapabilityHostOps.DeleteWithoutOkAsync<
    CapabilityHostResource,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = void> & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("x-ms-async-operation-timeout")
      @format("duration")
      asyncOperationTimeout: string;
    }> | NoContentResponse
  >;

  /**
   * List capabilityHost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccountCapabilityHosts_List")
  list is ArmResourceListByParent<
    CapabilityHostResource,
    Response = ArmResponse<CapabilityHostResourceArmPaginatedResult>
  >;
}

@@doc(CapabilityHostResource.name,
  "The name of the capability host associated with the Cognitive Services Resource"
);
@@doc(CapabilityHostResource.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(CapabilityHosts.createOrUpdate::parameters.resource,
  "CapabilityHost definition."
);
@@doc(ProjectCapabilityHosts.createOrUpdate::parameters.resource,
  "CapabilityHost definition."
);
@@summary(ProjectCapabilityHosts.get, "Get project capabilityHost.");
@@summary(CapabilityHosts.createOrUpdate,
  "Create or update account capabilityHost."
);
@@summary(CapabilityHosts.delete, "Delete account capabilityHost.");
@@summary(ProjectCapabilityHosts.createOrUpdate,
  "Create or update project capabilityHost."
);
@@summary(ProjectCapabilityHosts.delete, "Delete project capabilityHost.");
@@summary(CapabilityHosts.get, "Get account capabilityHost.");
