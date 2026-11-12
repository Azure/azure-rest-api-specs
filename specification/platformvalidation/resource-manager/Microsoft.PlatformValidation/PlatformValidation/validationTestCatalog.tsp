using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.PlatformValidation;

@doc("Audience visibility of a published catalog item.")
union CatalogAudience {
  @doc("Visible to all customers, including first-party and third-party callers.")
  Public: "Public",

  @doc("Visible only to authorized Microsoft-internal callers.")
  Internal: "Internal",

  string,
}

@doc("Supported data types for a declared test input.")
union ValidationTestInputDataType {
  @doc("String input value.")
  String: "String",

  @doc("Integer input value.")
  Integer: "Integer",

  @doc("Numeric input value.")
  Number: "Number",

  @doc("Boolean input value.")
  Boolean: "Boolean",

  @doc("Object input value.")
  Object: "Object",

  @doc("Array input value.")
  Array: "Array",

  string,
}

@doc("Declared contract for a validation test input parameter.")
model ValidationTestInputDefinition {
  @doc("Description of the declared input parameter.")
  description?: string;

  @doc("The data type expected for this input parameter.")
  type?: ValidationTestInputDataType;

  @doc("Whether this input parameter is required.")
  required?: boolean;

  @doc("Optional default value to use when input is not provided.")
  defaultValue?: string;

  @doc("Allowed values for this input parameter.")
  allowedValues?: string[];
}

@doc("A named declared input parameter for a validation test contract.")
model ValidationTestInput {
  @doc("The input parameter name.")
  name: string;

  @doc("The declared contract for this input parameter.")
  definition: ValidationTestInputDefinition;
}

@doc("""
  Common list query parameters for validation catalog operations. Supports OData
  filtering on fields such as `categoryIds` and `audience`, e.g.
  `$filter=audience eq 'Public'`.
  """)
model ValidationCatalogListQueryParameters {
  @doc("Filter expression used to constrain the returned items.")
  @query("$filter")
  filter?: string;
}

@doc("Validation test catalog entry.")
@subscriptionResource
model ValidationTest is ProxyResource<ValidationTestProperties> {
  ...ResourceNameParameter<
    Resource = ValidationTest,
    KeyName = "validationTestName",
    SegmentName = "validationTests",
    NamePattern = "^[a-zA-Z0-9-]{1,90}$"
  >;
}

@doc("Validation test catalog properties.")
model ValidationTestProperties {
  @doc("Display name of the validation test.")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Validation test description.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Audience visibility of this validation test.")
  @visibility(Lifecycle.Read)
  audience?: CatalogAudience;

  @doc("Provisioning state of the validation test catalog resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("The names of the validation test categories (ValidationTestCategory resource names, not ARM resource IDs) associated with this test.")
  @visibility(Lifecycle.Read)
  categoryIds?: string[];

  @doc("""
    Owners of the validation test definition, expressed as team or distribution list aliases.
    Individual user aliases and directory object identifiers are not published in this field.
    Only catalog publishers(limited to microsoft internal only) set this value through an internal publishing process; end users of the validation
    service consume catalog entries read-only through Get/List and cannot modify it.
    """)
  @visibility(Lifecycle.Read)
  owners?: string[];

  @doc("Declared input contract for this validation test.")
  @visibility(Lifecycle.Read)
  inputs?: ValidationTestInput[];

  @doc("URI of the location where the test artifact is stored.")
  @visibility(Lifecycle.Read)
  testStoreUri?: url;

  @doc("The resource ID of the current immutable version snapshot.")
  @visibility(Lifecycle.Read)
  currentVersion?: armResourceIdentifier<[
    {
      type: "Microsoft.PlatformValidation/validationTests/versions";
    }
  ]>;

  @doc("The resource ID of the latest published version snapshot.")
  @visibility(Lifecycle.Read)
  latestPublishedVersion?: armResourceIdentifier<[
    {
      type: "Microsoft.PlatformValidation/validationTests/versions";
    }
  ]>;

  @doc("Timestamp of the last version publication.")
  @visibility(Lifecycle.Read)
  lastPublishedAt?: utcDateTime;
}

@doc("Validation test version catalog properties.")
model ValidationTestVersionProperties {
  @doc("Display name of the validation test version.")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Validation test description.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Audience visibility of this validation test version.")
  @visibility(Lifecycle.Read)
  audience?: CatalogAudience;

  @doc("Provisioning state of the validation test version catalog resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("The names of the validation test categories (ValidationTestCategory resource names, not ARM resource IDs) associated with this test version.")
  @visibility(Lifecycle.Read)
  categoryIds?: string[];

  @doc("""
    Owners of the validation test version definition, expressed as team or distribution list aliases.
    Individual user aliases and directory object identifiers are not published in this field.
    Only catalog publishers set this value through an internal publishing process; end users of the validation
    service consume catalog entries read-only through Get/List and cannot modify it.
    """)
  @visibility(Lifecycle.Read)
  owners?: string[];

  @doc("Declared input contract for this validation test version.")
  @visibility(Lifecycle.Read)
  inputs?: ValidationTestInput[];

  @doc("SHA-256 hash of the version content used for integrity and deduplication.")
  @pattern("^[A-Fa-f0-9]{64}$")
  @visibility(Lifecycle.Read)
  contentHash?: string;

  @doc("URI of the location where the test artifact is stored.")
  @visibility(Lifecycle.Read)
  testStoreUri?: url;
}

@doc("Validation test version catalog entry.")
@parentResource(ValidationTest)
model ValidationTestVersion is ProxyResource<ValidationTestVersionProperties> {
  ...ResourceNameParameter<
    Resource = ValidationTestVersion,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = "^[a-zA-Z0-9._-]{1,64}$"
  >;
}

@doc("Validation test category catalog entry.")
@subscriptionResource
model ValidationTestCategory
  is ProxyResource<ValidationTestCategoryProperties> {
  ...ResourceNameParameter<
    Resource = ValidationTestCategory,
    KeyName = "validationTestCategoryName",
    SegmentName = "validationTestCategories",
    NamePattern = "^[a-zA-Z0-9-]{1,90}$"
  >;
}

@doc("Validation test category properties.")
model ValidationTestCategoryProperties {
  @doc("Display name of the validation test category.")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Validation test category description.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Audience visibility of this validation test category.")
  @visibility(Lifecycle.Read)
  audience?: CatalogAudience;

  @doc("Provisioning state of the validation test category catalog resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("""
    Parent validation test category id. Categories form a two-level hierarchy only:
    a top-level category leaves this unset, and a sub-category sets this to its
    top-level parent's category id. Sub-categories cannot themselves have sub-categories,
    and a category must not reference itself as its own parent.
    """)
  @visibility(Lifecycle.Read)
  parentCategoryId?: string;

  @doc("""
    Owners of the validation test category, expressed as team or distribution list aliases.
    Individual user aliases and directory object identifiers are not published in this field.
    Only catalog publishers set this value through an internal publishing process; end users of the validation
    service consume catalog entries read-only through Get/List and cannot modify it.
    """)
  @visibility(Lifecycle.Read)
  owners?: string[];
}

@armResourceOperations
@tag("Validation Test Interfaces")
interface ValidationTests {
  @doc("Get a validation test catalog entry")
  get is ArmResourceRead<ValidationTest>;

  @doc("List validation test catalog entries for a subscription")
  listBySubscription is ArmListBySubscription<
    ValidationTest,
    Parameters = ValidationCatalogListQueryParameters
  >;
}

@armResourceOperations(ValidationTestVersion)
@tag("Validation Test Version Interfaces")
interface ValidationTestVersions {
  @doc("Get a validation test version catalog entry")
  get is ArmResourceRead<ValidationTestVersion>;

  @doc("List validation test version catalog entries")
  list is ArmResourceListByParent<
    ValidationTestVersion,
    Parameters = ValidationCatalogListQueryParameters
  >;
}

@armResourceOperations
@tag("Validation Test Category Interfaces")
interface ValidationTestCategories {
  @doc("Get a validation test category catalog entry")
  get is ArmResourceRead<ValidationTestCategory>;

  @doc("List validation test category catalog entries for a subscription")
  listBySubscription is ArmListBySubscription<
    ValidationTestCategory,
    Parameters = ValidationCatalogListQueryParameters
  >;
}
