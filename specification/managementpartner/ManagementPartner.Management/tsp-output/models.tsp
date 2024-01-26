import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagementPartner;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * this is the management partner state: Active or Deleted
 */
enum ManagementPartnerState {
  Active,
  Deleted,
}

/**
 * this is the management partner properties
 */
model PartnerProperties {
  /**
   * This is the partner id
   */
  partnerId?: string;

  /**
   * This is the partner name
   */
  partnerName?: string;

  /**
   * This is the tenant id.
   */
  tenantId?: string;

  /**
   * This is the object id.
   */
  objectId?: string;

  /**
   * This is the version.
   */
  version?: int32;

  /**
   * This is the DateTime when the partner was updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTime?: utcDateTime;

  /**
   * This is the DateTime when the partner was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * This is the partner state
   */
  @extension("x-ms-client-flatten", true)
  state?: ManagementPartnerState;
}

/**
 * this is the management partner operations error
 */
@error
model Error {
  /**
   * this is the ExtendedErrorInfo property
   */
  error?: ExtendedErrorInfo;

  /**
   * this is the error response code
   */
  code?: string;

  /**
   * this is the extended error info message
   */
  message?: string;
}

/**
 * this is the extended error info
 */
model ExtendedErrorInfo {
  /**
   * this is the error response code
   */
  code?: string;

  /**
   * this is the extended error info message
   */
  message?: string;
}

/**
 * this is the management partner operations response
 */
model OperationResponse {
  /**
   * this is the operation response name
   */
  name?: string;

  /**
   * this is the operation display
   */
  display?: OperationDisplay;

  /**
   * the is operation response origin information
   */
  origin?: string;
}
