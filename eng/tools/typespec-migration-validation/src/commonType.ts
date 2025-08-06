import path from 'path';
import { readFileContent } from './helper.js';
import { OpenAPI2Document, OpenAPI2Schema } from '@azure-tools/typespec-autorest';

export function getCommonTypeDefinition(refPath: string): [OpenAPI2Schema, OpenAPI2Document] | undefined {
    const commonTypeInfo = getCommonTypeInfo(refPath);
    if (!commonTypeInfo) {
        return undefined;
    }
    const [filePath, definitionName] = commonTypeInfo;
    const fileContent = readCommonTypeFile(filePath);
    return fileContent.definitions?.[definitionName] ? [fileContent.definitions[definitionName], fileContent] : undefined;
}

function getCommonTypeInfo(refPath: string): [string, string] | undefined {
  const matchResult = refPath.match(/\/common-types\/resource-management\/(v\d)\/(.*)#\/definitions\/(.*)/);
  if (!matchResult) {
    return undefined;
  }
  const [, version, fileName, definitionName] = matchResult;
  return [path.join(process.cwd(), '..', '..', '..', 'specification', 'common-types', 'resource-management', version, fileName), definitionName];
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

export function getDefinitionFromCommonType(definitionName: string): OpenAPI2Schema | undefined {
  for (const filePath in commonTypeFileCache) {
    const fileContent = commonTypeFileCache[filePath];
    if (fileContent.definitions && fileContent.definitions[definitionName]) {
      return fileContent.definitions[definitionName];
    }
  }
  return undefined;
}