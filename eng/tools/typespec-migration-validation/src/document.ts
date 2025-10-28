import {
  OpenAPI2Document,
  OpenAPI2PathItem,
  HttpMethod,
  OpenAPI2Operation,
  OpenAPI2Schema,
  OpenAPI2Parameter,
  Ref,
  Refable,
  OpenAPI2Response,
  OpenAPI2SchemaProperty,
  OpenAPI2SchemaRefProperty,
} from "@azure-tools/typespec-autorest";
import {
  getOriginalParameter,
  isApiVersionParameter,
  isResourceGroupNameParameter,
  isSubscriptionIdParameter,
} from "./parameter.js";
import { configuration } from "./configuration.js";

let originalDocument: OpenAPI2Document | undefined = undefined;

export function getOriginalDocument(): OpenAPI2Document {
  if (originalDocument === undefined) {
    throw new Error("Original document is not set. Please call processDocument first.");
  }
  return originalDocument;
}

export function processDocument(document: OpenAPI2Document): OpenAPI2Document {
  originalDocument = deepCopy(document);

  const newDocument: OpenAPI2Document = deepCopy(document);
  if (document.schemes) {
    delete newDocument.schemes;
  }
  if (document.host) {
    delete newDocument.host;
  }
  if (document.security) {
    delete newDocument.security;
  }
  if (document.securityDefinitions) {
    delete newDocument.securityDefinitions;
  }
  if (document.tags) {
    delete newDocument.tags;
  }
  if (document.info && document.info["x-typespec-generated"]) {
    delete newDocument.info["x-typespec-generated"];
  }

  for (const route in document.paths) {
    const path = document.paths[route] as OpenAPI2PathItem;
    const processedPath = processPath(path);
    if (configuration.ignorePathCase) {
      const normalizedRoute = route
        .replace(/\/resourcegroups\//i, "/resourceGroups/")
        .replace(/\/subscriptions\//i, "/subscriptions/")
        .split('/')
        .map(segment => {
          if (segment.length === 0) return segment;
          return segment.charAt(0).toLowerCase() + segment.slice(1);
        })
        .join('/');
      delete newDocument.paths[route];
      newDocument.paths[normalizedRoute] = processedPath;
    } else {
      newDocument.paths[route] = processedPath;
    }
  }

  for (const definitionName in document.definitions) {
    const definition = document.definitions[definitionName] as OpenAPI2Schema;
    if (definition.enum) {
      delete newDocument.definitions![definitionName];
      continue;
    }
    const processedDefinition = processDefinition(definition);
    newDocument.definitions ??= {};
    newDocument.definitions[definitionName] = processedDefinition;
  }

  newDocument.parameters = {};
  return newDocument;
}

function processPath(path: OpenAPI2PathItem): OpenAPI2PathItem {
  function isHttpMethod(key: string): key is HttpMethod {
    const httpMethods: HttpMethod[] = [
      "get",
      "put",
      "post",
      "delete",
      "options",
      "head",
      "patch",
      "trace",
    ];
    return httpMethods.includes(key as HttpMethod);
  }

  const newPath: OpenAPI2PathItem = deepCopy(path);
  for (const verb in path) {
    if (isHttpMethod(verb)) {
      const operation = path[verb] as OpenAPI2Operation;
      const processedOperation = processOperation(operation);
      newPath[verb] = processedOperation;
    }
  }

  return newPath;
}

function processOperation(operation: OpenAPI2Operation): OpenAPI2Operation {
  const newOperation = deepCopy(operation);
  let index = newOperation.parameters.findIndex((p) => isApiVersionParameter(p));
  if (index > -1) {
    newOperation.parameters.splice(index, 1);
  }
  index = newOperation.parameters.findIndex((p) => isSubscriptionIdParameter(p));
  if (index > -1) {
    newOperation.parameters.splice(index, 1);
  }
  index = newOperation.parameters.findIndex((p) => isResourceGroupNameParameter(p));
  if (index > -1) {
    newOperation.parameters.splice(index, 1);
  }
  newOperation.parameters = newOperation.parameters.map((p) => processParameter(p));

  for (const response in operation.responses) {
    const responseObject = operation.responses[response] as OpenAPI2Response;
    const processedResponse = processResponse(responseObject);
    newOperation.responses ??= {};
    newOperation.responses[response] = processedResponse;
  }

  if (newOperation["x-ms-long-running-operation"] === false) {
    delete newOperation["x-ms-long-running-operation"];
  }
  if (
    newOperation["x-ms-long-running-operation-options"] &&
    newOperation["x-ms-long-running-operation-options"]["final-state-via"] === "location"
  ) {
    delete newOperation["x-ms-long-running-operation-options"];
  }

  if (newOperation["x-ms-pageable"] && newOperation["x-ms-pageable"]["nextLinkName"] === null) {
    newOperation["x-ms-pageable"]["nextLinkName"] = "nextLink";
  }
  if (newOperation["x-ms-pageable"] && newOperation["x-ms-pageable"]["itemName"] === "value") {
    delete newOperation["x-ms-pageable"]["itemName"];
  }

  if (
    newOperation.produces &&
    ((newOperation.produces.length === 1 && newOperation.produces[0] === "application/json") ||
      newOperation.produces.length === 0)
  ) {
    delete newOperation.produces;
  }
  if (
    newOperation.consumes &&
    ((newOperation.consumes.length === 1 && newOperation.consumes[0] === "application/json") ||
      newOperation.consumes.length === 0)
  ) {
    delete newOperation.consumes;
  }

  if (newOperation.tags) {
    delete newOperation.tags;
  }

  if (newOperation.deprecated === false) {
    delete newOperation.deprecated;
  }

  if (configuration.ignoreDescription) {
    delete newOperation.description;
    delete newOperation.summary;
  }
  return newOperation;
}

function processResponse(response: OpenAPI2Response): OpenAPI2Response {
  const newResponse: OpenAPI2Response = deepCopy(response);
  newResponse.description = "ignore";
  if (newResponse.headers) {
    for (const header in newResponse.headers) {
      if (header === "Retry-After") {
        delete newResponse.headers[header];
      }
    }
  }
  if (newResponse.headers && Object.keys(newResponse.headers).length === 0) {
    delete newResponse.headers;
  }
  return newResponse;
}

function processParameter(parameter: Refable<OpenAPI2Parameter>): Refable<OpenAPI2Parameter> {
  const newParameter: Refable<OpenAPI2Parameter> = deepCopy(parameter);
  if ((parameter as Ref<OpenAPI2Parameter>).$ref) {
    const refPath = (parameter as Ref<OpenAPI2Parameter>).$ref;
    const originalParameter = getOriginalParameter(refPath);
    if (originalParameter) return processParameter(originalParameter);
  } else {
    const inlineParameter = parameter as OpenAPI2Parameter;
    if ((parameter as any).enum && (newParameter as any)["x-ms-enum"]?.["values"]) {
      delete (newParameter as any)["x-ms-enum"]["values"];
    }
    if (configuration.enumNameToCamelCase && (newParameter as any)["x-ms-enum"]?.["name"]) {
      const enumName = (newParameter as any)["x-ms-enum"]["name"] as string;
      const camelCaseName = enumName.charAt(0).toUpperCase() + enumName.slice(1);
      (newParameter as any)["x-ms-enum"]["name"] = camelCaseName;
    }

    for (const key in parameter) {
      if (key === "x-ms-client-flatten") {
        delete (newParameter as any)[key];
      }
      if (key === "required" && inlineParameter[key] !== true) {
        delete (newParameter as any)[key];
      }
      if (key === "description") {
        delete (newParameter as any)[key];
      }
      if (key === "x-ms-parameter-location" && inlineParameter[key] === "method") {
        delete (newParameter as any)[key];
      }
    }
  }
  return newParameter;
}

function processDefinition(definition: OpenAPI2Schema): OpenAPI2Schema {
  const newDefinition: OpenAPI2Schema = deepCopy(definition);
  for (const propertyName in definition.properties) {
    const property = definition.properties[propertyName] as OpenAPI2SchemaProperty;
    const processedProperty = processProperty(property);
    newDefinition.properties ??= {};
    newDefinition.properties[propertyName] = processedProperty;
  }
  processEnumInplace(newDefinition);
  if (newDefinition.additionalProperties === false) {
    delete newDefinition.additionalProperties;
  }

  if (
    (newDefinition.properties || newDefinition.additionalProperties) &&
    newDefinition.type === undefined
  ) {
    newDefinition.type = "object";
  }

  if (newDefinition.allOf) {
    newDefinition.allOf = newDefinition.allOf.map((item) => {
      if ((item as Ref<OpenAPI2Schema>).$ref) {
        const refPath = (item as Ref<OpenAPI2Schema>).$ref;
        if (
          refPath ===
          "../../../../../common-types/resource-management/v3/types.json#/definitions/Resource"
        ) {
          return {
            ...item,
            $ref: "../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource",
          };
        }
      }
      return item;
    });
  }

  if (newDefinition.required) {
    newDefinition.required = newDefinition.required.sort((a, b) => a.localeCompare(b));
  }
  if (configuration.ignoreDescription) {
    delete newDefinition.description;
    if ((newDefinition.items as any)?.description) {
      delete (newDefinition.items as any).description;
    }
  }

  if ((newDefinition as any)["x-ms-azure-resource"]) {
    delete (newDefinition as any)["x-ms-azure-resource"];
  }

  return processPageModel(newDefinition);
}

function processProperty(property: OpenAPI2SchemaProperty): OpenAPI2SchemaProperty {
  function isOpenAPI2SchemaRefProperty(
    prop: OpenAPI2SchemaProperty,
  ): prop is OpenAPI2SchemaRefProperty {
    return (prop as OpenAPI2SchemaRefProperty).$ref !== undefined;
  }

  const newProperty: OpenAPI2SchemaProperty = deepCopy(property);
  const isRef = isOpenAPI2SchemaRefProperty(newProperty);
  if (isRef) {
    const refPath = newProperty.$ref;
    if (refPath.startsWith("#/definitions/")) {
      const definitionName = refPath.substring("#/definitions/".length);
      const originalDefinition = originalDocument?.definitions?.[definitionName];
      if (originalDefinition && originalDefinition.enum) {
        const processedDefinition = processDefinition(originalDefinition);
        for (const key in processedDefinition) {
          (newProperty as any)[key] = (processedDefinition as any)[key as string];
        }
        delete (newProperty as any).$ref;
      } else if (
        originalDefinition?.type &&
        ["boolean", "integer", "number", "string"].includes(originalDefinition.type)
      ) {
        delete (newProperty as any).$ref;
        for (const key in originalDefinition) {
          (newProperty as any)[key] = (originalDefinition as any)[key];
        }
      }
    }
  } else {
    if (newProperty.type === "array" && newProperty.items) {
      const refPath = (newProperty.items as Ref<OpenAPI2Schema>).$ref;
      if (refPath !== undefined) {
        if (refPath.startsWith("#/definitions/")) {
          const definitionName = refPath.substring("#/definitions/".length);
          const originalDefinition = originalDocument?.definitions?.[definitionName];
          if (originalDefinition && originalDefinition.enum) {
            const processedDefinition = processDefinition(originalDefinition);
            for (const key in processedDefinition) {
              (newProperty.items as any)[key] = (processedDefinition as any)[key as string];
            }
            delete (newProperty.items as any).$ref;
          }
        }
      } else {
        processEnumInplace(newProperty.items as OpenAPI2Schema);
      }
    }

    processEnumInplace(newProperty);
    if (
      (newProperty.properties || newProperty.additionalProperties) &&
      newProperty.type === undefined
    ) {
      newProperty.type = "object";
    }
  }

  const identifiers = (newProperty as any)["x-ms-identifiers"];
  if (identifiers && Array.isArray(identifiers) && identifiers.length === 0) {
    delete (newProperty as any)["x-ms-identifiers"];
  }
  if ((newProperty as OpenAPI2Schema).uniqueItems === false) {
    delete (newProperty as OpenAPI2Schema).uniqueItems;
  }
  if (newProperty["x-ms-mutability"]) {
    newProperty["x-ms-mutability"] = newProperty["x-ms-mutability"].sort((a, b) =>
      a.localeCompare(b),
    );
  }
  if ((newProperty as any)["uniqueItems"] === false) {
    delete (newProperty as any)["uniqueItems"];
  }

  if (configuration.ignoreDescription) {
    delete newProperty.description;
    if ((newProperty as any).items?.description) {
      delete (newProperty as any).items?.description;
    }
  }
  return newProperty;
}

function processEnumInplace(enumDefinition: OpenAPI2Schema) {
  if (enumDefinition.enum === undefined) return;

  if (enumDefinition["x-ms-enum"]?.values) {
    delete enumDefinition["x-ms-enum"].values;
  }
  if (configuration.enumNameToCamelCase && enumDefinition["x-ms-enum"]?.name) {
    const enumName = enumDefinition["x-ms-enum"].name as string;
    const camelCaseName = enumName.charAt(0).toUpperCase() + enumName.slice(1);
    enumDefinition["x-ms-enum"].name = camelCaseName;
  }
}

function processPageModel(definition: OpenAPI2Schema): OpenAPI2Schema {
  const newDefinition: OpenAPI2Schema = deepCopy(definition);

  const propertyCount = Object.keys(definition.properties ?? {}).length;
  if (propertyCount !== 2) {
    return newDefinition;
  }

  const valueProperty = definition.properties?.["value"];
  if (!valueProperty || (valueProperty as OpenAPI2Schema).type !== "array") {
    return newDefinition;
  }

  const nextLinkProperty = definition.properties?.["nextLink"];
  if (!nextLinkProperty || (nextLinkProperty as OpenAPI2Schema).type !== "string") {
    return newDefinition;
  }

  newDefinition.description = "[Placeholder] Discription for page model";
  newDefinition.properties!["value"]!.description = "[Placeholder] Discription for value property";
  newDefinition.properties!["nextLink"]!.description =
    "[Placeholder] Discription for nextLink property";
  (newDefinition.properties!["nextLink"] as any)["format"] = "uri";
  if (newDefinition.properties!["nextLink"]?.readOnly) {
    delete newDefinition.properties!["nextLink"]?.readOnly;
  }

  return newDefinition;
}

function deepCopy<T>(value: T): T {
  if (value === null || value === undefined) {
    return value;
  }

  if (typeof value !== "object") {
    return value;
  }

  if (value instanceof Date) {
    return new Date(value.getTime()) as unknown as T;
  }

  if (Array.isArray(value)) {
    return value.map((item) => deepCopy(item)) as unknown as T;
  }

  const result: Record<string, any> = {};
  for (const key in value) {
    if (Object.prototype.hasOwnProperty.call(value, key)) {
      result[key] = deepCopy((value as Record<string, any>)[key]);
    }
  }

  return result as T;
}
