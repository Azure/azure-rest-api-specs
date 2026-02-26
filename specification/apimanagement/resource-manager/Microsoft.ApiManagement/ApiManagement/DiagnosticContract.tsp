import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Diagnostic details.
 */
@parentResource(ApiContract)
model DiagnosticContract
  is Azure.ResourceManager.ProxyResource<DiagnosticContractProperties> {
  ...ResourceNameParameter<
    Resource = DiagnosticContract,
    KeyName = "diagnosticId",
    SegmentName = "diagnostics",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface DiagnosticContractOps
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

        /** API identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apis")
        @key
        @minLength(1)
        @maxLength(80)
        apiId: string,
      },
      {
        /** Diagnostic identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("diagnostics")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        diagnosticId: string,
      }
    > {}

@armResourceOperations
interface DiagnosticContracts {
  /**
   * Gets the details of the Diagnostic for an API specified by its identifier.
   */
  get is DiagnosticContractOps.Read<
    DiagnosticContract,
    Response = ArmResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Diagnostic for an API specified by its identifier.
   */
  getEntityTag is DiagnosticContractOps.CheckExistence<
    DiagnosticContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new Diagnostic for an API or updates an existing one.
   */
  createOrUpdate is DiagnosticContractOps.CreateOrUpdateSync<
    DiagnosticContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the Diagnostic for an API specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is DiagnosticContractOps.CustomPatchSync<
    DiagnosticContract,
    PatchModel = DiagnosticContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the specified Diagnostic from an API.
   */
  delete is DiagnosticContractOps.DeleteSync<
    DiagnosticContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists all diagnostics of an API.
   */
  listByService is DiagnosticContractOps.List<
    DiagnosticContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @query("$skip")
      @minValue(0)
      $skip?: int32;
    },
    Response = ArmResponse<DiagnosticCollection>
  >;
}
@armResourceOperations
interface DiagnosticOps
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
        /** Diagnostic identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("diagnostics")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        diagnosticId: string,
      }
    > {}

@armResourceOperations
interface Diagnostic {
  /**
   * Gets the details of the Diagnostic specified by its identifier.
   */
  get is DiagnosticOps.Read<
    DiagnosticContract,
    Response = ArmResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Diagnostic specified by its identifier.
   */
  getEntityTag is DiagnosticOps.CheckExistence<
    DiagnosticContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new Diagnostic or updates an existing one.
   */
  createOrUpdate is DiagnosticOps.CreateOrUpdateSync<
    DiagnosticContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the Diagnostic specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is DiagnosticOps.CustomPatchSync<
    DiagnosticContract,
    PatchModel = DiagnosticContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the specified Diagnostic.
   */
  delete is DiagnosticOps.DeleteSync<
    DiagnosticContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists all diagnostics of the API Management service instance.
   */
  listByService is DiagnosticOps.List<
    DiagnosticContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<DiagnosticCollection>
  >;
}
@armResourceOperations
interface WorkspaceDiagnosticOps
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

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        workspaceId: string,
      },
      {
        /** Diagnostic identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("diagnostics")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        diagnosticId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceDiagnostic {
  /**
   * Gets the details of the Diagnostic specified by its identifier.
   */
  get is WorkspaceDiagnosticOps.Read<
    DiagnosticContract,
    Response = ArmResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Diagnostic specified by its identifier.
   */
  getEntityTag is WorkspaceDiagnosticOps.CheckExistence<
    DiagnosticContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new Diagnostic or updates an existing one.
   */
  createOrUpdate is WorkspaceDiagnosticOps.CreateOrUpdateSync<
    DiagnosticContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the Diagnostic specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is WorkspaceDiagnosticOps.CustomPatchSync<
    DiagnosticContract,
    PatchModel = DiagnosticUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the specified Diagnostic.
   */
  delete is WorkspaceDiagnosticOps.DeleteSync<
    DiagnosticContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists all diagnostics in the specified workspace.
   */
  listByWorkspace is WorkspaceDiagnosticOps.List<
    DiagnosticContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<DiagnosticCollection>
  >;
}
@armResourceOperations
interface WorkspaceApiDiagnosticOps
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

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        workspaceId: string,

        /** API identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apis")
        @key
        @minLength(1)
        @maxLength(80)
        apiId: string,
      },
      {
        /** Diagnostic identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("diagnostics")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        diagnosticId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceApiDiagnostic {
  /**
   * Gets the details of the Diagnostic for an API specified by its identifier.
   */
  get is WorkspaceApiDiagnosticOps.Read<
    DiagnosticContract,
    Response = ArmResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Diagnostic for an API specified by its identifier.
   */
  getEntityTag is WorkspaceApiDiagnosticOps.CheckExistence<
    DiagnosticContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new Diagnostic for an API or updates an existing one.
   */
  createOrUpdate is WorkspaceApiDiagnosticOps.CreateOrUpdateSync<
    DiagnosticContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the Diagnostic for an API specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is WorkspaceApiDiagnosticOps.CustomPatchSync<
    DiagnosticContract,
    PatchModel = DiagnosticUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<DiagnosticContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the specified Diagnostic from an API.
   */
  delete is WorkspaceApiDiagnosticOps.DeleteSync<
    DiagnosticContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists all diagnostics of an API.
   */
  listByWorkspace is WorkspaceApiDiagnosticOps.List<
    DiagnosticContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<DiagnosticCollection>
  >;
}

@@maxLength(DiagnosticContract.name, 80);
@@minLength(DiagnosticContract.name, 1);
@@doc(DiagnosticContract.name,
  "Diagnostic identifier. Must be unique in the current API Management service instance."
);
@@doc(DiagnosticContract.properties, "Diagnostic entity contract properties.");
@@doc(DiagnosticContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(DiagnosticContracts.update::parameters.properties,
  "Diagnostic Update parameters."
);
@@doc(Diagnostic.createOrUpdate::parameters.resource, "Create parameters.");
@@doc(Diagnostic.update::parameters.properties,
  "Diagnostic Update parameters."
);
@@doc(WorkspaceDiagnostic.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(WorkspaceDiagnostic.update::parameters.properties,
  "Diagnostic Update parameters."
);
@@doc(WorkspaceApiDiagnostic.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(WorkspaceApiDiagnostic.update::parameters.properties,
  "Diagnostic Update parameters."
);
