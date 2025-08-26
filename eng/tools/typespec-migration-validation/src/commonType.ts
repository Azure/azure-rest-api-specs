import path from 'path';
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import { readFileContent } from './helper.js';
import { OpenAPI2Document, OpenAPI2Schema } from '@azure-tools/typespec-autorest';
import { isRef } from './compare.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export function getCommonTypeDefinition(refPath: string): [OpenAPI2Schema, OpenAPI2Document] | undefined {
  const commonTypeInfo = getCommonTypeInfo(refPath);
  if (!commonTypeInfo) {
    return undefined;
  }
  const [filePath, definitionName] = commonTypeInfo;
  const fileContent = readCommonTypeFile(filePath);
  const commonTypeDefinition = fileContent.definitions?.[definitionName];
  if (!commonTypeDefinition) {
    return undefined;
  }
  return [resolveCommonTypeDefinition(commonTypeDefinition, fileContent), fileContent];
}

// For all the properties, we need to inline its type if is a reference to another common type, because we cannot resolve it outside the common type file
function resolveCommonTypeDefinition(commonTypeDefinition: OpenAPI2Schema, fileContent: OpenAPI2Document): OpenAPI2Schema {
  for (const property in commonTypeDefinition.properties) {
    const propertySchema = commonTypeDefinition.properties[property];
    if (isRef(propertySchema)) {
      const refPath = propertySchema.$ref;
      if (!refPath.startsWith('#/definitions/')) {
        console.warn(`Reference ${propertySchema.$ref} is not a local definition, skipping.`);
        continue;
      }
      const refDefinitionName = refPath.replace('#/definitions/', '');
      const refDefinitionSchema = fileContent.definitions?.[refDefinitionName];
      commonTypeDefinition.properties[property] = refDefinitionSchema ? resolveCommonTypeDefinition(refDefinitionSchema, fileContent) : propertySchema;
    }
  }
  return commonTypeDefinition;
}

function getCommonTypeInfo(refPath: string): [string, string] | undefined {
  const matchResult = refPath.match(/\/common-types\/resource-management\/(v\d)\/(.*)#\/definitions\/(.*)/);
  if (!matchResult) {
    return undefined;
  }
  const [, version, fileName, definitionName] = matchResult;
  return [path.join(__dirname, '..', '..', '..', '..', '..', 'specification', 'common-types', 'resource-management', version, fileName), definitionName];
}

const commonTypeFileCache: Record<string, OpenAPI2Document> = {};
function readCommonTypeFile(filePath: string): OpenAPI2Document {
  if (commonTypeFileCache[filePath]) {
    return commonTypeFileCache[filePath];
  }
  const fileContent = readFileContent(filePath);
  const jsonContent: OpenAPI2Document = JSON.parse(fileContent);
  commonTypeFileCache[filePath] = jsonContent;
  return jsonContent;
}