import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Tenant Settings.
 */
@parentResource(ApiManagementServiceResource)
model AccessInformationContract
  is Azure.ResourceManager.ProxyResource<AccessInformationContractProperties> {
  ...ResourceNameParameter<
    Resource = AccessInformationContract,
    KeyName = "accessName",
    SegmentName = "tenant",
    NamePattern = "",
    Type = AccessIdName
  >;
}

@armResourceOperations
interface AccessInformationContractOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,
      },
      {
        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("tenant")
        @key
        configurationName: ConfigurationIdName,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface AccessInformationContracts {
  /**
   * Get tenant access information details without secrets.
   */
  get is ArmResourceRead<
    AccessInformationContract,
    Response = ArmResponse<AccessInformationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Tenant access metadata
   */
  getEntityTag is ArmResourceCheckExistence<
    AccessInformationContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Update tenant access information details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    AccessInformationContract,
    Request = AccessInformationCreateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResourceUpdatedResponse<AccessInformationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Update tenant access information details.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AccessInformationContract,
    PatchModel = AccessInformationUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<AccessInformationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Returns list of access infos - for Git and Management endpoints.
   */
  listByService is ArmResourceListByParent<
    AccessInformationContract,
    Parameters = {
      /**
       * Not used
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<AccessInformationCollection>
  >;

  /**
   * Regenerate primary access key
   */
  regeneratePrimaryKey is ArmResourceActionSync<
    AccessInformationContract,
    void,
    NoContentResponse
  >;

  /**
   * Regenerate secondary access key
   */
  regenerateSecondaryKey is ArmResourceActionSync<
    AccessInformationContract,
    void,
    NoContentResponse
  >;

  /**
   * Get tenant access information details.
   */
  listSecrets is ArmResourceActionSync<
    AccessInformationContract,
    void,
    Response = ArmResponse<AccessInformationSecretsContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Regenerate primary access key for GIT.
   */
  @action("git/regeneratePrimaryKey")
  tenantAccessGitRegeneratePrimaryKey is ArmResourceActionSync<
    AccessInformationContract,
    void,
    NoContentResponse
  >;

  /**
   * Regenerate secondary access key for GIT.
   */
  @action("git/regenerateSecondaryKey")
  tenantAccessGitRegenerateSecondaryKey is ArmResourceActionSync<
    AccessInformationContract,
    void,
    NoContentResponse
  >;

  /**
   * This operation applies changes from the specified Git branch to the configuration database. This is a long running operation and could take several minutes to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs(
    "https://azure.microsoft.com/en-us/documentation/articles/api-management-configuration-repository-git/#to-deploy-any-service-configuration-changes-to-the-api-management-service-instance",
    "To deploy any service configuration changes to the API Management service instance"
  )
  deploy is AccessInformationContractOps.ActionAsync<
    AccessInformationContract,
    Request = DeployConfigurationParameters,
    Result = void,
    Response = ArmResponse<OperationResultContract> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationResultContract> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * This operation creates a commit with the current configuration snapshot to the specified branch in the repository. This is a long running operation and could take several minutes to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs(
    "https://azure.microsoft.com/en-us/documentation/articles/api-management-configuration-repository-git/#to-save-the-service-configuration-to-the-git-repository",
    "To save the service configuration to the Git repository"
  )
  save is AccessInformationContractOps.ActionAsync<
    AccessInformationContract,
    Request = SaveConfigurationParameter,
    Result = void,
    Response = ArmResponse<OperationResultContract> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationResultContract>>
  >;

  /**
   * This operation validates the changes in the specified Git branch. This is a long running operation and could take several minutes to complete.
   */
  validate is AccessInformationContractOps.ActionAsync<
    AccessInformationContract,
    DeployConfigurationParameters,
    Result = void,
    Response = OperationResultContract | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationResultContract>>
  >;

  /**
   * Gets the status of the most recent synchronization between the configuration database and the Git repository.
   */
  @get
  @action("syncState")
  getSyncState is AccessInformationContractOps.ActionSync<
    AccessInformationContract,
    void,
    ArmResponse<TenantConfigurationSyncStateContract>
  >;
}

@@doc(AccessInformationContract.name,
  "The identifier of the Access configuration."
);
@@doc(AccessInformationContract.properties,
  "AccessInformation entity contract properties."
);
@@doc(AccessInformationContracts.create::parameters.resource,
  "Parameters supplied to retrieve the Tenant Access Information."
);
@@doc(AccessInformationContracts.update::parameters.properties,
  "Parameters supplied to retrieve the Tenant Access Information."
);
@@doc(AccessInformationContracts.deploy::parameters.body,
  "Deploy Configuration parameters."
);
@@doc(AccessInformationContracts.save::parameters.body,
  "Save Configuration parameters."
);
@@doc(AccessInformationContracts.validate::parameters.body,
  "Validate Configuration parameters."
);
