// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import * as format from '@azure/swagger-validation-common'
import * as jsonParser from '@ts-common/json-parser'

type ErrorMessage =
  | 'The example JSON file is not referenced from the swagger file.'
  | 'The swagger JSON file is not referenced from the readme file.'
  | 'The `readme.md` is not an AutoRest markdown file.'
  | 'The JSON file is not found but it is referenced from the readme file.'
  | 'The JSON file has a circular reference.'
  | 'The file is not a valid JSON file.'
  | 'Can not find readme.md in the folder. If no readme.md file, it will block SDK generation.'
  | 'The API version of the swagger is inconsistent with its file path.'
  | 'The default tag contains multiple API versions swaggers.'
  | 'The management plane swagger JSON file does not match its folder path. Make sure management plane swagger located in resource-manager folder'
  | 'The default tag should contain all APIs. The API path `{0}` is not in the default tag. Please make sure the missing API swaggers are in the default tag.'
  | 'The default tag does not contains the latest API version. Please make sure the latest api version swaggers are in the default tag.'
  | 'The readme file has more than one default tag.'
  | 'TypeSpec file is not allowed in resource-manager or data-plane folder.'

export interface IErrorBase {
  readonly level: 'Warning' | 'Error' | 'Info'
  readonly path: string
}

export type JsonParseError = {
  readonly code: 'JSON_PARSE'
  readonly message: ErrorMessage
  readonly error: jsonParser.ParseError
} & IErrorBase

export type NotAutoRestMarkDown = {
  readonly code: 'NOT_AUTOREST_MARKDOWN'
  readonly message: ErrorMessage
  readonly readMeUrl: string
  readonly helpUrl: string
} & IErrorBase

export type MultipleApiVersion = {
  readonly code: 'MULTIPLE_API_VERSION'
  readonly message: ErrorMessage
  readonly readMeUrl: string
  readonly tag: string | undefined
} & IErrorBase

export type MultipleDefaultTags = {
  readonly code: 'MULTIPLE_DEFAULT_TAGS'
  readonly message: ErrorMessage
  readonly readMeUrl: string
  readonly tags: string[]
} & IErrorBase

export type MissingLatestApiInDefaultTag = {
  readonly code: 'MISSING_APIS_IN_DEFAULT_TAG' | 'NOT_LATEST_API_VERSION_IN_DEFAULT_TAG'
  readonly message: ErrorMessage
  readonly readMeUrl: string
  readonly tag: string
  readonly jsonUrl: string
  readonly apiPath: string
} & IErrorBase

export type FileError = {
  readonly code:
    | 'NO_JSON_FILE_FOUND'
    | 'UNREFERENCED_JSON_FILE'
    | 'CIRCULAR_REFERENCE'
    | 'INCONSISTENT_API_VERSION'
    | 'INVALID_FILE_LOCATION'
    | 'INVALID_TYPESPEC_LOCATION'
  readonly message: ErrorMessage
  readonly readMeUrl: string
  readonly jsonUrl: string
} & IErrorBase

export type MissingReadmeError = {
  readonly code: 'MISSING_README'
  readonly message: ErrorMessage
  readonly folderUrl: string
} & IErrorBase

export type TypeSpecFileError = {
  readonly code: 'INVALID_TYPESPEC_LOCATION'
  readonly message: ErrorMessage
} & IErrorBase

export const getPathInfoFromError = (error: Error): format.JsonPath[] => {
  switch (error.code) {
    case 'JSON_PARSE':
      return [{ tag: 'json', path: JSON.stringify(error.error) }]
    case 'NOT_AUTOREST_MARKDOWN':
      return [
        { tag: 'readme', path: format.blobHref(format.getRelativeSwaggerPathToRepo(error.readMeUrl)) },
        { tag: 'helpUrl', path: error.helpUrl },
      ]
    case 'NO_JSON_FILE_FOUND':
    case 'UNREFERENCED_JSON_FILE':
    case 'CIRCULAR_REFERENCE':
    case 'INCONSISTENT_API_VERSION':
      return [
        { tag: 'readme', path: format.blobHref(format.getRelativeSwaggerPathToRepo(error.readMeUrl)) },
        { tag: 'json', path: format.blobHref(format.getRelativeSwaggerPathToRepo(error.jsonUrl)) },
      ]
    case 'MULTIPLE_API_VERSION':
      return [
        { tag: 'readme', path: format.blobHref(format.getRelativeSwaggerPathToRepo(error.readMeUrl)) },
        {
          tag: 'tag',
          path: format.blobHref(format.getRelativeSwaggerPathToRepo(`${error.readMeUrl}#tag-${error.tag}`)),
        },
      ]
    case 'MISSING_README':
      return [{ tag: 'folder', path: format.blobHref(format.getRelativeSwaggerPathToRepo(error.folderUrl)) }]

    case 'MISSING_APIS_IN_DEFAULT_TAG':
      return [
        { tag: 'readme', path: format.blobHref(format.getRelativeSwaggerPathToRepo(error.readMeUrl)) },
        { tag: 'json', path: format.blobHref(format.getRelativeSwaggerPathToRepo(error.jsonUrl)) },
      ]
    case 'NOT_LATEST_API_VERSION_IN_DEFAULT_TAG':
      return [
        { tag: 'readme', path: format.blobHref(format.getRelativeSwaggerPathToRepo(error.readMeUrl)) },
        { tag: 'json', path: format.blobHref(format.getRelativeSwaggerPathToRepo(error.jsonUrl)) },
      ]
    case 'MULTIPLE_DEFAULT_TAGS':
      return [{ tag: 'readme', path: format.blobHref(format.getRelativeSwaggerPathToRepo(error.readMeUrl)) }]
    case 'INVALID_TYPESPEC_LOCATION':
      return [{ tag: 'path', path: format.blobHref(format.getRelativeSwaggerPathToRepo(error.path)) }]
    default:
      return []
  }
}

export type Error =
  | JsonParseError
  | FileError
  | NotAutoRestMarkDown
  | MissingReadmeError
  | MultipleApiVersion
  | MissingLatestApiInDefaultTag
  | MultipleDefaultTags
  | TypeSpecFileError
