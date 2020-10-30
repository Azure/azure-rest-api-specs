# Semantic and Model Violations Reference
This document lists the set of automated rules that can be validated against swagger spec by running [OAV](https://github.com/Azure/oav) tool. This document also have some *tips for the fix*. Most of the time, the error information has the position of violations in swagger. If the error is internal error and doesn't have much meaningful infomation toward the fix, please create an issue [here](https://github.com/azure/oav/issues).

### Validation Errors

| Code | Id |
| --- | --- |
| [INVALID_REFERENCE](#INVALID_REFERENCE) | |
| [CIRCULAR_INHERITANCE](#CIRCULAR_INHERITANCE) | |
| [DUPLICATE_PARAMETER](#DUPLICATE_PARAMETER) | |
| [EMPTY_PATH_PARAMETER_DECLARATION](#EMPTY_PATH_PARAMETER_DECLARATION) | |
| [DUPLICATE_OPERATIONID](#DUPLICATE_OPERATIONID) | |
| [MULTIPLE_BODY_PARAMETERS](#MULTIPLE_BODY_PARAMETERS) | |
| [INVALID_PARAMETER_COMBINATION](#INVALID_PARAMETER_COMBINATION) | |
| [MISSING_PATH_PARAMETER_DEFINITION](#MISSING_PATH_PARAMETER_DEFINITION) | |
| [MISSING_PATH_PARAMETER_DECLARATION](#MISSING_PATH_PARAMETER_DECLARATION) | |
| [INVALID_CONTENT_TYPE](#INVALID_CONTENT_TYPE) | |
| [INVALID_FORMAT](#INVALID_FORMAT) | |
| [INVALID_TYPE](#INVALID_TYPE) | |
| [ENUM_CASE_MISMATCH](#ENUM_CASE_MISMATCH) | |
| [ENUM_MISMATCH](#ENUM_MISMATCH) | |
| [ANY_OF_MISSING](#ANY_OF_MISSING) | |
| [ONE_OF_MISSING](#ONE_OF_MISSING) | |
| [ONE_OF_MULTIPLE](#ONE_OF_MULTIPLE) | |
| [NOT_PASSED](#NOT_PASSED) | |
| [ARRAY_LENGTH_SHORT](#ARRAY_LENGTH_SHORT) | |
| [ARRAY_LENGTH_LONG](#ARRAY_LENGTH_LONG) | |
| [ARRAY_UNIQUE](#ARRAY_UNIQUE) | |
| [ARRAY_ADDITIONAL_ITEMS](#ARRAY_ADDITIONAL_ITEMS) | |
| [MULTIPLE_OF](#MULTIPLE_OF) | |
| [MINIMUM](#MINIMUM) | |
| [MINIMUM_EXCLUSIVE](#MINIMUM_EXCLUSIVE) | |
| [MAXIMUM](#MAXIMUM) | |
| [MAXIMUM_EXCLUSIVE](#MAXIMUM_EXCLUSIVE) | |
| [OBJECT_PROPERTIES_MINIMUM](#OBJECT_PROPERTIES_MINIMUM) | |
| [OBJECT_PROPERTIES_MAXIMUM](#OBJECT_PROPERTIES_MAXIMUM) | |
| [OBJECT_MISSING_REQUIRED_PROPERTY_DEFINITION](#OBJECT_MISSING_REQUIRED_PROPERTY_DEFINITION) | |
| [OBJECT_MISSING_REQUIRED_PROPERTY](#OBJECT_MISSING_REQUIRED_PROPERTY) | |
| [OBJECT_ADDITIONAL_PROPERTIES](#OBJECT_ADDITIONAL_PROPERTIES) | |
| [OBJECT_DEPENDENCY_KEY](#OBJECT_DEPENDENCY_KEY) | |
| [MIN_LENGTH](#MIN_LENGTH) | |
| [MAX_LENGTH](#MAX_LENGTH) | |
| [PATTERN](#PATTERN) | |
| [KEYWORD_TYPE_EXPECTED](#KEYWORD_TYPE_EXPECTED) | |
| [KEYWORD_UNDEFINED_STRICT](#KEYWORD_UNDEFINED_STRICT) | |
| [KEYWORD_UNEXPECTED](#KEYWORD_UNEXPECTED) | |
| [KEYWORD_MUST_BE](#KEYWORD_MUST_BE) | |
| [KEYWORD_DEPENDENCY](#KEYWORD_DEPENDENCY) | |
| [KEYWORD_PATTERN](#KEYWORD_PATTERN) | |
| [KEYWORD_VALUE_TYPE](#KEYWORD_VALUE_TYPE) | |
| [UNKNOWN_FORMAT](#UNKNOWN_FORMAT) | |
| [CUSTOM_MODE_FORCE_PROPERTIES](#CUSTOM_MODE_FORCE_PROPERTIES) | |
| [REF_UNRESOLVED](#REF_UNRESOLVED) | |
| [UNRESOLVABLE_REFERENCE](#UNRESOLVABLE_REFERENCE) | |
| [SCHEMA_NOT_REACHABLE](#SCHEMA_NOT_REACHABLE) | |
| [SCHEMA_NOT_AN_OBJECT](#SCHEMA_NOT_AN_OBJECT) | |
| [ASYNC_TIMEOUT](#ASYNC_TIMEOUT) | |
| [PARENT_SCHEMA_VALIDATION_FAILED](#PARENT_SCHEMA_VALIDATION_FAILED) | |
| [REMOTE_NOT_VALID](#REMOTE_NOT_VALID) | |
| [INVALID_REQUEST_PARAMETER](#INVALID_REQUEST_PARAMETER) | |
| [INVALID_RESPONSE_CODE](#INVALID_RESPONSE_CODE) | |
| [INVALID_RESPONSE_BODY](#INVALID_RESPONSE_BODY) | |
| [MISSING_REQUIRED_PARAMETER](#MISSING_REQUIRED_PARAMETER) | |
| [KEYWORD_TYPE_EXPECTED](#KEYWORD_TYPE_EXPECTED) | |
| [READONLY_PROPERTY_NOT_ALLOWED_IN_REQUEST](#READONLY_PROPERTY_NOT_ALLOWED_IN_REQUEST) | |
| [SCHEMA_VALIDATION_FAILED](#SCHEMA_VALIDATION_FAILED) | |
| [DISCRIMINATOR_VALUE_NOT_FOUND](#DISCRIMINATOR_VALUE_NOT_FOUND) |  |
| [DISCRIMINATOR_NOT_REQUIRED](#DISCRIMINATOR_NOT_REQUIRED) | [OAV131](#DISCRIMINATOR_NOT_REQUIRED) |
| [RESPONSE_BODY_NOT_IN_EXAMPLE](#RESPONSE_BODY_NOT_IN_EXAMPLE) | [OAV130](#RESPONSE_BODY_NOT_IN_EXAMPLE) |
| [DOUBLE_FORWARD_SLASHES_IN_URL](#DOUBLE_FORWARD_SLASHES_IN_URL) | [OAV129](#DOUBLE_FORWARD_SLASHES_IN_URL) |
| [OPERATION_NOT_FOUND_IN_CACHE_WITH_PROVIDER](#OPERATION_NOT_FOUND_IN_CACHE_WITH_PROVIDER) | [OAV128](#OPERATION_NOT_FOUND_IN_CACHE_WITH_PROVIDER) |
| [OPERATION_NOT_FOUND_IN_CACHE_WITH_API](#OPERATION_NOT_FOUND_IN_CACHE_WITH_API) | [OAV127](#OPERATION_NOT_FOUND_IN_CACHE_WITH_API) |
| [OPERATION_NOT_FOUND_IN_CACHE_WITH_VERB](#OPERATION_NOT_FOUND_IN_CACHE_WITH_VERB) | [OAV126](#OPERATION_NOT_FOUND_IN_CACHE_WITH_VERB) |
| [OPERATION_NOT_FOUND_IN_CACHE](#OPERATION_NOT_FOUND_IN_CACHE)] | [OAV125](#OPERATION_NOT_FOUND_IN_CACHE) |
| [PATH_NOT_FOUND_IN_REQUEST_URL](#PATH_NOT_FOUND_IN_REQUEST_URL) | [OAV124](#PATH_NOT_FOUND_IN_REQUEST_URL) |
| [POTENTIAL_OPERATION_SEARCH_ERROR](#POTENTIAL_OPERATION_SEARCH_ERROR) | [OAV123](#POTENTIAL_OPERATION_SEARCH_ERROR) |
| [INCORRECT_INPUT](#INCORRECT_INPUT) | [OAV122](#INCORRECT_INPUT) |
| [MULTIPLE_OPERATIONS_FOUND](#MULTIPLE_OPERATIONS_FOUND) | [OAV120](#MULTIPLE_OPERATIONS_FOUND) |
| [SEMANTIC_VALIDATION_ERROR](#SEMANTIC_VALIDATION_ERROR) | [OAV119](#SEMANTIC_VALIDATION_ERROR) |
| [CONSTRAINT_VALIDATION_ERROR](#CONSTRAINT_VALIDATION_ERROR) | [OAV117](#CONSTRAINT_VALIDATION_ERROR) |
| [RESPONSE_SCHEMA_NOT_IN_SPEC](#RESPONSE_SCHEMA_NOT_IN_SPEC) | [OAV113](#RESPONSE_SCHEMA_NOT_IN_SPEC) |
| [RESPONSE_STATUS_CODE_NOT_IN_SPEC](#RESPONSE_STATUS_CODE_NOT_IN_SPEC) | [OAV112](#RESPONSE_STATUS_CODE_NOT_IN_SPEC) |
| [RESPONSE_VALIDATION_ERROR](#RESPONSE_VALIDATION_ERROR) | [OAV108](#RESPONSE_VALIDATION_ERROR) |
| [X-MS-EXAMPLE_NOTFOUND_ERROR](#X-MS-EXAMPLE_NOTFOUND_ERROR) | [OAV107](#X-MS-EXAMPLE_NOTFOUND_ERROR) |
| [ERROR_IN_PREPARING_REQUEST](#ERROR_IN_PREPARING_REQUEST) | [OAV106](#ERROR_IN_PREPARING_REQUEST) |
| [REQUIRED_PARAMETER_EXAMPLE_NOT_FOUND](#REQUIRED_PARAMETER_EXAMPLE_NOT_FOUND) | [OAV105](#REQUIRED_PARAMETER_EXAMPLE_NOT_FOUND) |
| [JSON_PARSING_ERROR](#JSON_PARSING_ERROR) | [OAV104](#JSON_PARSING_ERROR) |
| [RESOLVE_SPEC_ERROR](#RESOLVE_SPEC_ERROR) | [OAV102](#RESOLVE_SPEC_ERROR) |
| [INTERNAL_ERROR](#INTERNAL_ERROR) | [OAV100](#INTERNAL_ERROR) |
| [REQUEST_VALIDATION_ERROR](#REQUEST_VALIDATION_ERROR) | [OAV109](#REQUEST_VALIDATION_ERROR) |
| [RESPONSE_STATUS_CODE_NOT_IN_EXAMPLE](#RESPONSE_STATUS_CODE_NOT_IN_EXAMPLE) | [OAV111](#RESPONSE_STATUS_CODE_NOT_IN_EXAMPLE) |
| [ROUNDTRIP_INCONSISTENT_PROPERTY](#ROUNDTRIP_INCONSISTENT_PROPERTY) | |
| [ROUNDTRIP_MISSING_PROPERTY](#ROUNDTRIP_MISSING_PROPERTY) | |
| [ROUNDTRIP_ADDITIONAL_PROPERTY](#ROUNDTRIP_ADDITIONAL_PROPERTY) | |


### Validation Warnings

| Code | Id |
| --- | --- |
| [UNUSED_DEFINITION](#UNUSED_DEFINITION) | |


## Rule Descriptions

### <a name="INTERNAL_ERROR" />INTERNAL_ERROR 

**Output Message**: none.

**Description**: All the errors without error code are clarified as internal_error.

**How to fix the violation**: See the inner error details for the fix.

### <a name="INVALID_CONTENT_TYPE" />INVALID_CONTENT_TYPE 

**Output Message**: Invalid Content-Type {0}. These are supported: {1}.

**Description**: The request/response doesn't have allowed content-type.

**How to fix the violation**: Fix the content-type as one of the supported values.

### <a name="MISSING_PATH_PARAMETER_DECLARATION" />MISSING_PATH_PARAMETER_DECLARATION 

**Output Message**: Path parameter is defined but is not declared: {0}.

**Description**: It cannot find the declaration of this path parameter in operation.

**How to fix the violation**: Add the declaration or remove the definition of this parameter.

### <a name="MISSING_PATH_PARAMETER_DEFINITION" />MISSING_PATH_PARAMETER_DEFINITION 

**Output Message**: Path parameter is declared but is not defined: {0}.

**Description**: It cannot find the definition of this path parameter.

**How to fix the violation**: Add the detail definition for this path parameter.

### <a name="INVALID_PARAMETER_COMBINATION" />INVALID_PARAMETER_COMBINATION 

**Output Message**: Operation cannot have a body parameter and a formData parameter.

**Description**: Body parameter and formData parameter are mutually exclusive.

**How to fix the violation**: Remove one of these two parameters.

### <a name="MULTIPLE_BODY_PARAMETERS" />MULTIPLE_BODY_PARAMETERS 

**Output Message**: Operation cannot have multiple body parameters.

**Description**: There're multiple body parameters defined for an operation.

**How to fix the violation**: Remove one of body parameter from this operation.

### <a name="DUPLICATE_OPERATIONID" />DUPLICATE_OPERATIONID 

**Output Message**: Cannot have multiple operations with the same operationId: {0}.

**Description**: There're duplicated operation ids defined.

**How to fix the violation**: Rename one of the operation id.

### <a name="EQUIVALENT_PATH" />EQUIVALENT_PATH 

**Output Message**: Equivalent path already exists: {0}.

**Description**: There're equivalent paths defined.

**How to fix the violation**: Remove one of the equivalent paths or rename it.

### <a name="EMPTY_PATH_PARAMETER_DECLARATION" />EMPTY_PATH_PARAMETER_DECLARATION 

**Output Message**: Path parameter declaration cannot be empty: {0}.

**Description**: The definition for a path parameter is empty.

**How to fix the violation**: Add the detail definition or remove this parameter from path.

### <a name="DUPLICATE_PARAMETER" />DUPLICATE_PARAMETER 

**Output Message**: Operation cannot have duplicate parameters: {0}.

**Description**: There're duplicated parameters defined for this operation.

**How to fix the violation**: Remove the duplicated parameter.

### <a name="CIRCULAR_INHERITANCE" />CIRCULAR_INHERITANCE 

**Output Message**: Schema object inherits from itself: {0}.

**Description**: The definition references itself.

**How to fix the violation**: Break the circular definition reference.

### <a name="INVALID_REFERENCE" />INVALID_REFERENCE 

**Output Message**: Missing required property definition: {0}.

**Description**: The definition of a required property is missing.

**How to fix the violation**: Add the definition for the required property.

### <a name="INVALID_REFERENCE" />INVALID_REFERENCE 

**Output Message**: xxx | Invalid JSON Reference.

**Description**: The value of $ref is invalid.

**How to fix the violation**: Fix the $ref as per the error details.

### <a name="SCHEMA_VALIDATION_FAILED" />SCHEMA_VALIDATION_FAILED 

**Output Message**: Value failed JSON Schema validation.

**Description**: The parameter value doesn't pass schema validation.

**How to fix the violation**: Look into the inner errors to fix the value.

### <a name="MISSING_REQUIRED_PARAMETER" />MISSING_REQUIRED_PARAMETER 

**Output Message**: Value is required but was not provided.

**Description**: Missing required value in example.

**How to fix the violation**: Add the required value in example.

### <a name="REMOTE_NOT_VALID" />REMOTE_NOT_VALID

**Output Message**: Remote reference didn't compile successfully: {0}.

**Description**: The remote schema reference fails to load and compile.

**How to fix the violation**: It could be incorrect reference uri or network issue.

### <a name="PARENT_SCHEMA_VALIDATION_FAILED" />PARENT_SCHEMA_VALIDATION_FAILED

**Output Message**: Schema failed to validate against its parent schema, see inner errors for details.

**Description**: The schema fails to validate against its parent schema.

**How to fix the violation**: Fix the schema by comparing against parent schema.

### <a name="PARENT_SCHEMA_VALIDATION_FAILED" />PARENT_SCHEMA_VALIDATION_FAILED

**Output Message**: Schema failed to validate against its parent schema, see inner errors for details.

**Description**: The schema fails to validate against its parent schema.

**How to fix the violation**: Fix the schema by comparing against parent schema.

### <a name="SCHEMA_NOT_AN_OBJECT" />SCHEMA_NOT_AN_OBJECT

**Output Message**: Schema is not an object: {0}.

**Description**: The schema type is expected to be `object`.

**How to fix the violation**: Correct the schema type.

### <a name="ASYNC_TIMEOUT" />ASYNC_TIMEOUT

**Output Message**: {0} asynchronous task(s) have timed out after {1} ms.

**Description**: The operation fails by time out issue.

**How to fix the violation**: Retry.

### <a name="SCHEMA_NOT_REACHABLE" />SCHEMA_NOT_REACHABLE

**Output Message**: Validator was not able to read schema with uri: {0}.

**Description**: It fails to load the remote schema.

**How to fix the violation**: Fix the uri of remote schema or network issue.

### <a name="UNRESOLVABLE_REFERENCE" />UNRESOLVABLE_REFERENCE

**Output Message**: Reference could not be resolved: {0}.

**Description**: It fails to resolve the reference uri of a remote schema.

**How to fix the violation**: Fix the uri.

### <a name="REF_UNRESOLVED" />REF_UNRESOLVED

**Output Message**: Reference has not been resolved during compilation: {0}.

**Description**: It fails to resolve the reference.

**How to fix the violation**: Maybe need to fix the format of the reference.

### <a name="CUSTOM_MODE_FORCE_PROPERTIES" />CUSTOM_MODE_FORCE_PROPERTIES

**Output Message**: {0} must define at least one property if present.

**Description**: It force a type must have properties.

**How to fix the violation**: Add at least one property for this type.

### <a name="UNKNOWN_FORMAT" />UNKNOWN_FORMAT

**Output Message**: There is no validation function for format '{0}'.

**Description**: It doesnot support this format validation.

**How to fix the violation**: Use another format or raise an design issue.

### <a name="KEYWORD_VALUE_TYPE" />KEYWORD_VALUE_TYPE

**Output Message**: Each element of keyword '{0}' array must be a '{1}'.

**Description**: The value does not match the defined type.

**How to fix the violation**: Fix the value to match the type.

### <a name="KEYWORD_PATTERN" />KEYWORD_PATTERN

**Output Message**: Keyword '{0}' is not a valid RegExp pattern: {1}'.

**Description**: The value does not match the defined pattern.

**How to fix the violation**: Fix the value to match the pattern.

### <a name="KEYWORD_DEPENDENCY" />KEYWORD_DEPENDENCY

**Output Message**: Keyword '{0}' requires keyword '{1}'.

**Description**: Some keywords have dependent keywords which have to be defined as well.

**How to fix the violation**: Add the dependent keyword definition.

### <a name="KEYWORD_MUST_BE" />KEYWORD_MUST_BE

**Output Message**: Keyword '{0}' must be {1}.

**Description**: The value of keyword should be strictly correct.

**How to fix the violation**: The error info has the position of swagger, look for the position in swagger and fix the value.

### <a name="KEYWORD_UNEXPECTED" />KEYWORD_UNEXPECTED

**Output Message**: Keyword '{0}' is not expected to appear in the schema.

**Description**: The schema doesn't allow extra keywords.

**How to fix the violation**: The error info has the position of swagger, look for the position in swagger and remove the keyword.

### <a name="KEYWORD_UNDEFINED_STRICT" />KEYWORD_UNDEFINED_STRICT

**Output Message**: Keyword '{0}' must be defined in strict mode'.

**Description**: The array items should have additionalItems defined in swagger.

**How to fix the violation**: The error info has the position of swagger, look for the position in swagger and fix the array items.

### <a name="KEYWORD_TYPE_EXPECTED" />KEYWORD_TYPE_EXPECTED

**Output Message**: Keyword '{0}' is expected to be of type '{1}'.

**Description**: The value of the keyword in swagger should be the specific type.

**How to fix the violation**: The error info has the position of swagger, look for the position in swagger and fix the value type of keyword.

### <a name="KEYWORD_TYPE_EXPECTED" />KEYWORD_TYPE_EXPECTED

**Output Message**: Keyword '{0}' is expected to be of type '{1}'.

**Description**: The value of the keyword in swagger should be the specific type.

**How to fix the violation**: Fix the value type of keyword.

### <a name="PATTERN" />PATTERN

**Output Message**: String does not match pattern {0}: {1}.

**Description**: The provided string doesn't match defined pattern.

**How to fix the violation**: The error info has the position of swagger, look for the position in swagger and fix the string value.

### <a name="MAX_LENGTH" />MAX_LENGTH 

**Output Message**: String is too long ({0} chars), maximum {1}.

**Description**: The provided string is greater than maximum length.

**How to fix the violation**: The error info has the position of swagger, look for the position in swagger and fix the string value.

### <a name="MIN_LENGTH" />MIN_LENGTH 

**Output Message**: String is too short ({0} chars), minimum {1}.

**Description**: The provided string is less than minimum length.

**How to fix the violation**: The error info has the position of swagger, look for the position in swagger and fix the string value.

### <a name="OBJECT_DEPENDENCY_KEY" />OBJECT_DEPENDENCY_KEY 

**Output Message**: Dependency failed - key must exist: {0} (due to key: {1}).

**Description**: The dependency value is an array, the object should have all the values in the array defined as property.  

**How to fix the violation**: Add the key {1} as property to the object.

### <a name="OBJECT_PROPERTIES_MAXIMUM" />OBJECT_PROPERTIES_MAXIMUM 

**Output Message**: Too many properties defined ({0}), maximum {1}.

**Description**: The provided properties amount of a type is greater than the defined maximum properties amount.  

**How to fix the violation**: Delete some properties to meet the maximum requirement.

### <a name="OBJECT_PROPERTIES_MINIMUM" />OBJECT_PROPERTIES_MINIMUM 

**Output Message**: Too few properties defined ({0}), minimum {1}.

**Description**: The provided properties amount of a type is less than the defined minimum properties amount.  

**How to fix the violation**: Add more properties to meet the minimum requirement.

### <a name="MAXIMUM_EXCLUSIVE" />MAXIMUM_EXCLUSIVE 

**Output Message**: Value {0} is equal or greater than exclusive maximum {1}.

**Description**: The value provided is greater than or equal to the defined maximum value.  

**How to fix the violation**: The error info has the position of swagger, look for the position in swagger and fix the value.

### <a name="MAXIMUM" />MAXIMUM 

**Output Message**: Value {0} is greater than maximum {1}.

**Description**: The value provided is greater than the defined maximum value.  

**How to fix the violation**: The error info has the position of swagger, look for the position in swagger and fix the value.

### <a name="MINIMUM_EXCLUSIVE" />MINIMUM_EXCLUSIVE 

**Output Message**: Value {0} is equal or less than exclusive minimum {1}.

**Description**: The value provided is less than or equal to defined minimum value.  

**How to fix the violation**: The error info has the position of swagger, look for the position in swagger and fix the value.

### <a name="MULTIPLE_OF" />MULTIPLE_OF 

**Output Message**: Value {0} is not a multiple of {1}.

**Description**: The value provided isn't a multiple of defined value.  

**How to fix the violation**: The error info has the position of swagger, look for the position in swagger and fix the value.

### <a name="MINIMUM" />MINIMUM 

**Output Message**: Value {0} is less than minimum {1}.

**Description**: The value provided is less than the defined minimum value.  

**How to fix the violation**: The error info has the position of swagger, look for the position in swagger and fix the value.

### <a name="ARRAY_ADDITIONAL_ITEMS" />ARRAY_ADDITIONAL_ITEMS 

**Output Message**: Additional items not allowed.

**Description**: The size of array is more than the array items length in schema.  

**How to fix the violation**: Make the size of array less than or equal to the array items length in schema.

### <a name="ARRAY_UNIQUE" />ARRAY_UNIQUE 

**Output Message**: Array items are not unique (indexes {0} and {1}).

**Description**: Array items doesn't match the schema of `uniqueItems = true`.  

**How to fix the violation**: Make array items unique.

### <a name="ARRAY_LENGTH_LONG" />ARRAY_LENGTH_LONG 

**Output Message**: Array is too long ({0}), maximum {1}.

**Description**: Array items is too much.  

**How to fix the violation**: Make array items less than maximum number.

### <a name="ARRAY_LENGTH_SHORT" />ARRAY_LENGTH_SHORT 

**Output Message**: Array is too short ({0}), minimum {1}.

**Description**: Array items is too little.  

**How to fix the violation**: Make array have at least minimum item.

### <a name="NOT_PASSED" />NOT_PASSED 

**Output Message**: Data matches schema from 'not'.

**Description**: Data is valid for the schema but it should not be valid because the `not` keyword.  

**How to fix the violation**: See inner errors for the detail issue and fix the data to not match the schema.

### <a name="ONE_OF_MULTIPLE" />ONE_OF_MULTIPLE 

**Output Message**: Data is valid against more than one schema from 'oneOf'.

**Description**: Data is valid for more than one sub-schemas.  

**How to fix the violation**: See inner errors for the detail issue and fix the data to match only one sub-schema.

### <a name="ONE_OF_MISSING" />ONE_OF_MISSING 

**Output Message**: Data does not match any schemas from 'oneOf'.

**Description**: None of the sub-schemas passes the validation.  

**How to fix the violation**: See inner errors for the detail issue.

### <a name="ANY_OF_MISSING" />ANY_OF_MISSING 

**Output Message**: Data does not match any schemas from 'anyOf'.

**Description**: None of the sub-schemas passes the validation.  

**How to fix the violation**: See inner errors for the detail issue.

### <a name="REQUEST_VALIDATION_ERROR" />REQUEST_VALIDATION_ERROR 

**Output Message**: Found errors in validating the request for x-ms-example {0} in operation {1}.

**Description**: Validate the request of each x-ms-example.  

**How to fix the violation**: The request parameter defined in example should match with the swagger spec.

### <a name="RESPONSE_STATUS_CODE_NOT_IN_EXAMPLE" />RESPONSE_STATUS_CODE_NOT_IN_EXAMPLE 

**Output Message**: Following response status codes {0} for operation {1} were present in the swagger spec, however they were not present in x-ms-examples. Please provide them.

**Description**: All the response cases with different response code should have correspondent response defined in example.   

**How to fix the violation**: Add them to example if they are not present.

### <a name="INVALID_REQUEST_PARAMETER" />INVALID_REQUEST_PARAMETER 

**Output Message**: Invalid parameter ({0}): Value failed JSON Schema validation.

**Description**: There's error in the request parameter validation.

**How to fix the violation**: Check the inner errors for the fix solution.

### <a name="INVALID_RESPONSE_CODE" />INVALID_RESPONSE_CODE 

**Output Message**: This operation does not have a defined {0} response code.

**Description**: There's extra response code defined in example file.

**How to fix the violation**: Remove extra response code definition in example or correct it.

### <a name="INVALID_RESPONSE_BODY" />INVALID_RESPONSE_BODY

**Output Message**:Body is required in response but not provided

**Description**: Body schema is defined in swagger but body is not found in example or traffic.

**How to fix the violation**: Add response body.


### <a name="KEYWORD_TYPE_EXPECTED" />KEYWORD_TYPE_EXPECTED 

**Output Message**: Keyword 'type' is expected to be of type 'array,boolean,integer,number,null,object,string'.

**Description**: According to Json schema spec, the allowed value for [type](http://json-schema.org/latest/json-schema-validation.html#rfc.section.6.1.1) is 'array,boolean,integer,number,null,object,string'.

**How to fix the violation**: Set the value of type to one of the values above.

### <a name="OBJECT_ADDITIONAL_PROPERTIES" />OBJECT_ADDITIONAL_PROPERTIES 

**Output Message**: Additional properties not allowed:{0}.

**Description**: Additional property {0} defined in example but not defined in swagger spec. It could be the property name does not match exactly.

**How to fix the violation**: The error info has the position of swagger. Look for the violation location of the swagger, ensure the property name specified in example appears exact the same in the definition or remove this property from example if it's not defined in swagger spec. Remind all the characters are case sensitive.


### <a name="INVALID_FORMAT" />INVALID_FORMAT 

**Output Message**: Object didn't pass validation for format {0}:{1}.

**Description**: The format provided for the param {0} is {1} which is not allowed format.

**How to fix the violation**: The error info has the position of swagger. Look for the violation location of the swagger, correct the format of the param. e.g. error info containing params: [ 'int32', '2'] means the param type is `int32`, so the format should be number `2` instead of string '2'.

### <a name="INVALID_TYPE" />INVALID_TYPE 

**Output Message**: Expected type {0} but found type {1}.

**Description**: The type provided for the property doesn't match to the defined type.

**How to fix the violation**: Correct the type defined in example file. Sometimes this could be false positive when it peers with other errors which belongs to same parent `ANY_OF_MISSING` error or `ONE_OF_MISSING` error, in this case this error can be ignored and just fix other peer errors eventually this error will be cleared out automatically.

### <a name="ENUM_CASE_MISMATCH" />ENUM_CASE_MISMATCH 

**Output Message**: Enum does not match case for:{0}.

**Description**: The enum value provided in exmaple doesn't match the case of an allowed value.

**How to fix the violation**: The error info has the position of swagger. Look for the violation location of the swagger, correct the value case in example.

### <a name="ENUM_MISMATCH" />ENUM_MISMATCH 

**Output Message**: Enum does not match case for:{0}.

**Description**: The enum value provided in exmaple doesn't match the case of an allowed value.

**How to fix the violation**: The error info has the position of swagger. Look for the violation location of the swagger, correct the value case in example.

### <a name="READONLY_PROPERTY_NOT_ALLOWED_IN_REQUEST" />READONLY_PROPERTY_NOT_ALLOWED_IN_REQUEST 

**Output Message**: ReadOnly property `{0}: {1}`, cannot be sent in the request.

**Description**: The value of a readonly property is managed exclusively by the owning authority and cannot be supplied in request.

**How to fix the violation**: Remove the readonly property from the request parameters in example.

### <a name="OBJECT_MISSING_REQUIRED_PROPERTY" />OBJECT_MISSING_REQUIRED_PROPERTY 

**Output Message**: Missing required property: {0}.

**Description**: The property {0} is required and has to provide in request or response of example.

**How to fix the violation**: Provide the requried property in example or remove this property from the required list of the definition in swagger spec. Or add items property if the type is array.

### <a name="DISCRIMINATOR_VALUE_NOT_FOUND" />DISCRIMINATOR_VALUE_NOT_FOUND

**Output Message**: Discriminator value "{0}" not found

**Description**: The property used as discriminator has a value {0} but it's not found in swagger spec.

**How to fix the violation**: Add the model that has the discriminator value or fix the discriminator value. The discriminator value could be specified by model name in definitions or by "x-ms-discriminator-value".


### <a name="DISCRIMINATOR_NOT_REQUIRED" />DISCRIMINATOR_NOT_REQUIRED 

**Output Message**: discriminator must be a required property.

**Description**: The property used as discriminator must be a required property, otherwise it cannot be resolved correctly.

**How to fix the violation**: Set the property as required property in swagger.

### <a name="RESPONSE_BODY_NOT_IN_EXAMPLE" />RESPONSE_BODY_NOT_IN_EXAMPLE 

**Output Message**: Response statusCode {0} for operation {1} has no response body provided in the example, however the response does have a "schema" defined in the swagger spec.

**Description**: It should have response body provided in exmaple even empty when it has schema defined for this response in swagger.

**How to fix the violation**: Add the response body in example which could be empty value {}.

### <a name="DOUBLE_FORWARD_SLASHES_IN_URL" />DOUBLE_FORWARD_SLASHES_IN_URL 

**Output Message**: In operation {0}, example for parameter {1}: {2} starts with a forward slash and the path template: {3} contains a forward slash before the parameter starts. This will cause double forward slashes in the request url. Thus making it incorrect. Please rectify the example.

**Description**: There's two forward slashes before this parameter.

**How to fix the violation**: Remove one of it from path or parameter.

### <a name="OPERATION_NOT_FOUND_IN_CACHE_WITH_PROVIDER" />OPERATION_NOT_FOUND_IN_CACHE_WITH_PROVIDER 

**Output Message**: Could not find provider {0} in the cache.

**Description**: There's none matched resouce provider in the cache.

**How to fix the violation**: Fix resouce provider.

### <a name="OPERATION_NOT_FOUND_IN_CACHE_WITH_VERB" />OPERATION_NOT_FOUND_IN_CACHE_WITH_VERB 

**Output Message**: Could not find any methods with verb {0} for api-version {1 }and provider {2} in the cache.

### <a name="OPERATION_NOT_FOUND_IN_CACHE_WITH_API" />OPERATION_NOT_FOUND_IN_CACHE_WITH_API 

**Output Message**: Could not find exact api-version {0} for provider {1} in the cache.

**Description**: There's none api methods based on api-version and resouce provider.

**How to fix the violation**: Fix api-version or resouce provider.

### <a name="OPERATION_NOT_FOUND_IN_CACHE_WITH_VERB" />OPERATION_NOT_FOUND_IN_CACHE_WITH_VERB 

**Output Message**: Could not find any methods with verb {0} for api-version {1 }and provider {2} in the cache.

**Description**: It fails to search for any matched api method based on verb, api-version and resouce provider.

**How to fix the violation**: Fix the verb, api-version or resouce provider.

### <a name="OPERATION_NOT_FOUND_IN_CACHE" />OPERATION_NOT_FOUND_IN_CACHE 

**Output Message**: Could not find best match operation for verb {0} for api-version {1} and provider {2} in the cache.

**Description**: It fails to search for any matched operation based on verb, api-version, path and resouce provider.

**How to fix the violation**: Fix the verb, api-version, path or resouce provider.

### <a name="PATH_NOT_FOUND_IN_REQUEST_URL" />PATH_NOT_FOUND_IN_REQUEST_URL 

**Output Message**: Could not find path from requestUrl: {0}.

**Description**: It fails to search for the matched path in swagger based on the HTTP url.

**How to fix the violation**: Fix the path.

### <a name="POTENTIAL_OPERATION_SEARCH_ERROR" />POTENTIAL_OPERATION_SEARCH_ERROR 

**Output Message**: An error occurred while trying to search for potential operations: {0}.

**Description**: It fails to search for the matched operation in swagger based on the HTTP url and method.

**How to fix the violation**: Fix the url or http method.

### <a name="INCORRECT_INPUT" />INCORRECT_INPUT 

**Output Message**: requestResponseObj cannot be null or undefined and must be of type "object" | Found errors {0} in the provided input {1}.

**Description**: The input request/response has issues when running live validation.

**How to fix the violation**: See inner detail errors toward the fix.

### <a name="MULTIPLE_OPERATIONS_FOUND" />MULTIPLE_OPERATIONS_FOUND 

**Output Message**: Found multiple matching operations with operationIds {0} for request url {1} with HTTP Method {2}.

**Description**: There're duplicated operations defined with same operationId.

**How to fix the violation**: Make the operationId as unique across the swagger.

### <a name="SEMANTIC_VALIDATION_ERROR" />SEMANTIC_VALIDATION_ERROR 

**Output Message**: The spec {0} has semantic validation errors.

**Description**: There're errors when run semantic validation against this spec.

**How to fix the violation**: See inner detail errors toward the fix.

### <a name="RESPONSE_SCHEMA_NOT_IN_SPEC" />RESPONSE_SCHEMA_NOT_IN_SPEC 

**Output Message**: Response statusCode {0} for operation {1} has response body provided in the example, however the response does not have a "schema" defined in the swagger spec.

**Description**: Every type of response provided in example should have correspondent definition in swagger spec.

**How to fix the violation**: Add the missing schema definition in swagger spec.

### <a name="RESPONSE_STATUS_CODE_NOT_IN_SPEC" />RESPONSE_STATUS_CODE_NOT_IN_SPEC 

**Output Message**: Response statusCode {0} for operation {1} is provided in exampleResponseValue, however it is not present in the swagger spec.

**Description**: Every type of response provided in example should have correspondent definition in swagger spec.

**How to fix the violation**: Add the missing status code definition in swagger spec or remove the unmatched status code part from example.

### <a name="RESPONSE_VALIDATION_ERROR" />RESPONSE_VALIDATION_ERROR 

**Output Message**: Found errors in validating the response with statusCode {} ...

**Description**: Found errors when validate the response defined in example.

**How to fix the violation**: See inner details for the violations and fix.

### <a name="X-MS-EXAMPLE_NOTFOUND_ERROR" />X-MS-EXAMPLE_NOTFOUND_ERROR 

**Output Message**: x-ms-example not found in {0}.

**Description**: Each operation should have example defined.

**How to fix the violation**: Add `x-ms-example` declaration for this operation.

### <a name="ERROR_IN_PREPARING_REQUEST" />ERROR_IN_PREPARING_REQUEST 

**Description**: Error when preparing the request for validation.

**How to fix the violation**: Fix by the inner error details or raise an issue at [oav](https://github.com/azure/oav/issues).

### <a name="REQUIRED_PARAMETER_EXAMPLE_NOT_FOUND" />REQUIRED_PARAMETER_EXAMPLE_NOT_FOUND 

**Output Message**: In operation {0}, parameter {1} is required in the swagger spec but is not present in the provided example parameter values.

**Description**: Required parameter is not provided in example.

**How to fix the violation**: Add the requried parameter in example.

### <a name="RESOLVE_SPEC_ERROR" />RESOLVE_SPEC_ERROR 

**Description**: Error happens when try to resolve the swagger.

**How to fix the violation**: See the inner error details for the fix.

### <a name="JSON_PARSING_ERROR" />JSON_PARSING_ERROR 

**Description**: Error happens when try to parse the JSON.

**How to fix the violation**: See the inner error details for the fix.


### <a name="UNUSED_DEFINITION" />UNUSED_DEFINITION 

**Output Message**: Definition is not used: {0}.

**Description**: There's none reference to this definition.

**How to fix the violation**: Remove this definition if it's not used.


### <a name="ROUNDTRIP_INCONSISTENT_PROPERTY" />ROUNDTRIP_INCONSISTENT_PROPERTY

**Output Message**: The property’s value in the GET response is different from what was set in the preceding PUT request. If it is a read-only property, update the swagger definition for this property to mark it as "readOnly": true. Alternatively, keep the property in the GET schema but remove it from the PUT schema. If the property has a default value, update the Swagger definition for this property to mark it with "default": <default value> annotation.

**Description**: The property’s value in the GET response is different from what was set in the preceding PUT request. This usually happens when the property is read-only so it's value cannot be changed. It is also possible that the property has a default value, and it is set to that value when a null value is included in the PUT request.

**How to fix the violation**: If the property is a read-only, update the swagger definition for this property to mark it as "readOnly": true. Alternatively, keep the property in the GET schema but remove it from the PUT schema. If the property has a default value, update the Swagger definition for this property to mark it with "default": <default value> annotation.

### <a name="ROUNDTRIP_MISSING_PROPERTY" />ROUNDTRIP_MISSING_PROPERTY

**Output Message**: The property is present in the PUT request but is either never returned in the GET response or is returned with a null value. If this is a property that carries a secret such as a password, update the Swagger definition to mark it with the "x-ms-secret": true annotation.

**Description**: The property is present in the PUT request, but in the subsequent GET response, it is either never returned or is returned with a null value, which means the property is write-only and is likely to carry a secret.

**How to fix the violation**: Mark the property definition with the "x-ms-secret": true annotation if the property is a secret.


### <a name="ROUNDTRIP_ADDITIONAL_PROPERTY" />ROUNDTRIP_ADDITIONAL_PROPERTY

**Output Message**: The property is returned in the GET response, but it is not declared in the PUT request. If it is a read-only property, update the swagger definition for this property to mark it as \"readOnly\": true. Alternatively, keep the property in the GET schema but remove it from the PUT schema. If the property has a default value, update the Swagger definition for this property to mark it with \"default\": <default value> annotation.

**Description**: The property was not in the PUT request, but it is returned in the subsequent GET response. This implies that the property is read-only or has a default value.

**How to fix the violation**: If the property is a read-only, update the swagger definition for this property to mark it as "readOnly": true. Alternatively, keep the property in the GET schema but remove it from the PUT schema. If the property has a default value, update the Swagger definition for this property to mark it with "default": <default value> annotation.