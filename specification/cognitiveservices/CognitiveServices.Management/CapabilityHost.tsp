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
model CapabilityHost
  is Azure.ResourceManager.ProxyResource<CapabilityHostProperties, false> {
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccountCapabilityHosts_Get")
  get is CapabilityHostOps.Read<CapabilityHost>;

  /**
   * Create or update account capabilityHost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccountCapabilityHosts_CreateOrUpdate")
  createOrUpdate is CapabilityHostOps.CreateOrUpdateAsync<CapabilityHost>;

  /**
   * Delete account capabilityHost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccountCapabilityHosts_Delete")
  delete is CapabilityHostOps.DeleteWithoutOkAsync<CapabilityHost>;
}
@armResourceOperations
interface ProjectCapabilityHostOps
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
        accountName: string,

        /** The name of Cognitive Services account's project. */
        @path
        @segment("projects")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        projectName: string,
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
interface ProjectCapabilityHosts {
  /**
   * Get project capabilityHost.
   */
  get is ProjectCapabilityHostOps.Read<CapabilityHost>;

  /**
   * Create or update project capabilityHost.
   */
  createOrUpdate is ProjectCapabilityHostOps.CreateOrUpdateAsync<CapabilityHost>;

  /**
   * Delete project capabilityHost.
   */
  delete is ProjectCapabilityHostOps.DeleteWithoutOkAsync<CapabilityHost>;
}

@@doc(CapabilityHost.name,
  "The name of the capability host associated with the Cognitive Services Resource"
);
@@doc(CapabilityHost.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(CapabilityHosts.createOrUpdate::parameters.resource,
  "CapabilityHost definition."
);
@@doc(ProjectCapabilityHosts.createOrUpdate::parameters.resource,
  "CapabilityHost definition."
);
