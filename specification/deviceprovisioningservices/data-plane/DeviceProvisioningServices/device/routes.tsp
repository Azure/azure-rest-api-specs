import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "@typespec/openapi";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace ProvisioningDeviceClient;

interface RuntimeRegistration {
  /**
   * Gets the registration operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving x-ms-long-running-operation extension on polling GET for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  #suppress "@azure-tools/typespec-azure-core/polling-operation-no-status-monitor" "The DPS device API uses a non-standard LRO pattern; status field is on the nested RegistrationOperationStatus body"
  @removed(Versions.v2025_07_01_preview)
  @sharedRoute
  @extension("x-ms-long-running-operation", true)
  @summary("Gets the registration operation status.")
  @route("/{idScope}/registrations/{registrationId}/operations/{operationId}")
  @get
  operationStatusLookup is Azure.Core.Foundations.Operation<
    {
      /**
       * Registration ID.
       */
      @path
      registrationId: string;

      /**
       * Operation ID.
       */
      @path
      operationId: string;

      /** The scope of the DPS instance. */
      @path
      idScope: string;
    },

      | {
          @statusCode _: 200;
          @body body: RegistrationOperationStatus;
        }
      | {
          @statusCode _: 202;

          @header("retry-after")
          retryAfter?: int32;

          @header("Location")
          location?: string;

          @body body: RegistrationOperationStatus;
        },
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Gets the registration operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  #suppress "@azure-tools/typespec-azure-core/polling-operation-no-status-monitor" "The DPS device API uses a non-standard LRO pattern; status field is on the nested RegistrationOperationStatus body"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId for backward compatibility"
  @added(Versions.v2025_07_01_preview)
  @sharedRoute
  @operationId("RuntimeRegistration_OperationStatusLookup")
  @summary("Gets the registration operation status.")
  @route("/{idScope}/registrations/{registrationId}/operations/{operationId}")
  @get
  operationStatusLookupPreview is Azure.Core.Foundations.Operation<
    {
      /**
       * Registration ID.
       */
      @path
      registrationId: string;

      /**
       * Operation ID.
       */
      @path
      operationId: string;

      /** The scope of the DPS instance. */
      @path
      idScope: string;
    },

      | {
          @statusCode _: 200;
          @body body: RegistrationOperationStatus;
        }
      | {
          @statusCode _: 202;

          @header("retry-after")
          retryAfter?: int32;

          @header("Location")
          location?: string;

          @body body: RegistrationOperationStatus;
        },
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Gets the device registration status.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @summary("Gets the device registration status.")
  @route("/{idScope}/registrations/{registrationId}")
  @post
  deviceRegistrationStatusLookup is Azure.Core.Foundations.Operation<
    {
      /**
       * Registration ID.
       */
      @path
      registrationId: string;

      /** The scope of the DPS instance. */
      @path
      idScope: string;

      /**
       * Device registration.
       */
      @bodyRoot
      body: DeviceRegistration;
    },
    DeviceRegistrationResult,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Registers the devices.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving x-ms-long-running-operation extension for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @removed(Versions.v2025_07_01_preview)
  @sharedRoute
  @extension("x-ms-long-running-operation", true)
  @pollingOperation(RuntimeRegistration.operationStatusLookup)
  @summary("Registers the devices.")
  @route("/{idScope}/registrations/{registrationId}/register")
  @put
  registerDevice is Azure.Core.Foundations.Operation<
    {
      /**
       * The registration ID is alphanumeric, lowercase, and may contain hyphens.
       */
      @path
      registrationId: string;

      /** The scope of the DPS instance. */
      @path
      idScope: string;

      /**
       * Device registration request.
       */
      @bodyRoot
      body: DeviceRegistration;
    },

      | {
          @statusCode _: 200;
          @body body: RegistrationOperationStatus;
        }
      | {
          @statusCode _: 202;

          @header("retry-after")
          retryAfter?: int32;

          @header("Location")
          location?: string;

          @body body: RegistrationOperationStatus;
        },
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Registers the devices and optionally issue operational certificates for IoT devices.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from Swagger: preserving operationId and x-ms-long-running-operation extension for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Migration from Swagger: operation name preserved for compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Migration from Swagger: using Foundations.Operation for compatibility"
  @added(Versions.v2025_07_01_preview)
  @sharedRoute
  @extension("x-ms-long-running-operation", true)
  @summary("Registers the devices and optionally issue operational certificates for IoT devices.")
  @pollingOperation(RuntimeRegistration.operationStatusLookupPreview)
  @route("/{idScope}/registrations/{registrationId}/register")
  @put
  registerDeviceAndIssueCertificate is Azure.Core.Foundations.Operation<
    {
      /**
       * The registration ID is alphanumeric, lowercase, and may contain hyphens.
       */
      @path
      registrationId: string;

      /** The scope of the DPS instance. */
      @path
      idScope: string;

      /**
       * Device registration request.
       */
      @bodyRoot
      deviceRegistration: DeviceRegistration;
    },

      | {
          @statusCode _: 200;
          @body body: RegistrationOperationStatus;
        }
      | {
          @statusCode _: 202;

          @header("retry-after")
          retryAfter?: int32;

          @header("Location")
          location?: string;

          @body body: RegistrationOperationStatus;
        },
    {},
    ProvisioningServiceErrorDetails
  >;
}

/**
 * Device-facing ADU (Azure Device Update) integration operations. Added in
 * 2026-11-15-preview. The device selects the endpoint by its own provisioning
 * state: the onboarding/bootstrap fetch before it is provisioned, the
 * regular/operational fetch afterwards. DPS is a thin pass-through to ADR (which
 * forwards to ADU) and does not branch on the update family or parse the manifest.
 */
@added(Versions.v2026_11_15_preview)
interface DeviceUpdate {
  /**
   * Checks for an available device update on the regular / operational path. The
   * device selects this endpoint once it is provisioned.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name mirrors the ADU device contract for pass-through compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Using Foundations.Operation for consistency with the existing DPS device API"
  @summary("Checks for an available device update (regular / operational path).")
  @route("/{idScope}/registrations/{registrationId}/getDeviceUpdate")
  @post
  getDeviceUpdate is Azure.Core.Foundations.Operation<
    {
      /** The registration ID is alphanumeric, lowercase, and may contain hyphens. */
      @path
      registrationId: string;

      /** The scope of the DPS instance. */
      @path
      idScope: string;

      /** Update check request. */
      @bodyRoot
      body: UpdateCheckRequest;
    },
    UpdateCheckResponse,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Checks for an available device update on the onboarding / bootstrap path. The
   * device selects this endpoint before it is provisioned; only the external device
   * identifier is available (no ADR device UUID yet).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name mirrors the ADU device contract for pass-through compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Using Foundations.Operation for consistency with the existing DPS device API"
  @summary("Checks for an available device update (onboarding / bootstrap path).")
  @route("/{idScope}/registrations/{registrationId}/onboarding/getDeviceUpdate")
  @post
  getOnboardingDeviceUpdate is Azure.Core.Foundations.Operation<
    {
      /** The registration ID is alphanumeric, lowercase, and may contain hyphens. */
      @path
      registrationId: string;

      /** The scope of the DPS instance. */
      @path
      idScope: string;

      /** Update check request. */
      @bodyRoot
      body: UpdateCheckRequest;
    },
    UpdateCheckResponse,
    {},
    ProvisioningServiceErrorDetails
  >;

  /**
   * Reports the terminal result of a device update installation. Idempotent on
   * workflowId; ADU routes the report to the correct update family.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name mirrors the ADU device contract for pass-through compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Using Foundations.Operation for consistency with the existing DPS device API"
  @summary("Reports the terminal result of a device update installation.")
  @route("/{idScope}/registrations/{registrationId}/reportDeviceUpdateStatus")
  @post
  reportDeviceUpdateStatus is Azure.Core.Foundations.Operation<
    {
      /** The registration ID is alphanumeric, lowercase, and may contain hyphens. */
      @path
      registrationId: string;

      /** The scope of the DPS instance. */
      @path
      idScope: string;

      /** Status report request. */
      @bodyRoot
      body: ReportStatusRequest;
    },
    ReportDeviceUpdateStatusResult,
    {},
    ProvisioningServiceErrorDetails
  >;
}
