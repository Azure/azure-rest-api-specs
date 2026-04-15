import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace WorkbookTemplatesApi;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * WorkbookTemplate list result.
 */
model WorkbookTemplatesListResult {
  /**
   * An array of workbook templates.
   */
  @pageItems
  value?: WorkbookTemplate[];

  /**
   * The URL to get the next page of results.
   */
  @nextLink
  nextLink?: url;
}

/**
 * Properties that contain a workbook template.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkbookTemplateProperties {
  /**
   * Priority of the template. Determines which template to open when a workbook gallery is opened in viewer mode.
   */
  priority?: int32;

  /**
   * Information about the author of the workbook template.
   */
  author?: string;

  /**
   * Valid JSON object containing workbook template payload.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  templateData: unknown;

  /**
   * Workbook galleries supported by the template.
   */
  @identifiers(#["name", "type"])
  galleries: WorkbookTemplateGallery[];

  /**
   * Key value pair of localized gallery. Each key is the locale code of languages supported by the Azure portal.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  localized?: Record<WorkbookTemplateLocalizedGallery[]>;
}

/**
 * Gallery information for a workbook template.
 */
model WorkbookTemplateGallery {
  /**
   * Name of the workbook template in the gallery.
   */
  name?: string;

  /**
   * Category for the gallery.
   */
  category?: string;

  /**
   * Type of workbook supported by the workbook template.
   */
  type?: string;

  /**
   * Order of the template within the gallery.
   */
  order?: int32;

  /**
   * Azure resource type supported by the gallery.
   */
  resourceType?: string;
}

/**
 * Localized template data and gallery information.
 */
model WorkbookTemplateLocalizedGallery {
  /**
   * Valid JSON object containing workbook template payload.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  templateData?: unknown;

  /**
   * Workbook galleries supported by the template.
   */
  @identifiers(#["name", "type"])
  galleries?: WorkbookTemplateGallery[];
}

/**
 * Error Field contract.
 */
model WorkbookTemplateErrorFieldContract {
  /**
   * Property level error code.
   */
  code?: string;

  /**
   * Human-readable representation of property-level error.
   */
  message?: string;

  /**
   * Property name.
   */
  target?: string;
}

/**
 * Error message body that will indicate why the operation failed.
 */
model WorkbookTemplateErrorBody {
  /**
   * Service-defined error code. This code serves as a sub-status for the HTTP error code specified in the response.
   */
  code?: string;

  /**
   * Human-readable representation of the error.
   */
  message?: string;

  /**
   * The list of invalid fields send in request, in case of validation error.
   */
  @identifiers(#["message", "target"])
  details?: WorkbookTemplateErrorFieldContract[];
}

/**
 * Error message that will indicate why the operation failed.
 */
@error
model WorkbookTemplateError {
  /**
   * Error message object that will indicate why the operation failed.
   */
  error?: WorkbookTemplateErrorBody;
}

/**
 * The parameters that can be provided when updating workbook template.
 */
model WorkbookTemplateUpdateParameters {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Metadata describing a workbook for an Azure resource.
   */
  properties?: WorkbookTemplateProperties;
}
