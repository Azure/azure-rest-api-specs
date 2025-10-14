// Copyright (c) 2022 Microsoft Corporation
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

// This file is for docs team learn platform auto refresh.
import { parse } from '@ts-common/commonmark-to-markdown'
import * as fs from 'fs'
import * as path from 'path'
import { getSwaggerFileUnderDefaultTag } from './index.js'
import { getLatestTag, getTagsToSwaggerFilesMapping } from './readme.js'

export interface IService {
  readme_files?: string[]
  exclude_files?: string[]
}

export type SwaggerFileList = {
  stable: string[]
  latest: string[]
}

export const getSwaggerFiles = (rootPath: string, service: IService): SwaggerFileList => {
  const ret: SwaggerFileList = {
    stable: [],
    latest: [],
  }

  if (service.readme_files === undefined) {
    return ret
  }

  for (const readmeFile of service.readme_files) {
    const readmeFileName = path.basename(readmeFile)
    const readmePath = path.join(rootPath, readmeFile)
    if (!fs.existsSync(readmePath)) {
      throw new Error(`Readme file ${readmePath} does not exist.`)
    }
    const readmeContent = fs.readFileSync(readmePath, 'utf-8')
    const readme = parse(readmeContent)
    const inputFiles = getSwaggerFileUnderDefaultTag(readme)

    const excludeFiles = service.exclude_files || []

    // There are some platform issues. For windows, it has different path format. To keep it safe and avoid path issue, I use replace instead of path.relative.
    const latestSwaggerFiles = inputFiles
      .map((it) => readmeFile.replace(readmeFileName, it))
      .filter((it) => !excludeFiles.some((ex) => it.match(ex)))
    ret.latest.push(...latestSwaggerFiles)

    const stableSwaggerFiles = getStableSwaggerFiles(rootPath, readmeFile).filter(
      (it) => !excludeFiles.some((ex) => it.match(ex)),
    )
    ret.stable.push(...stableSwaggerFiles)
  }
  return ret
}

export const getStableSwaggerFiles = (rootPath: string, readmeFilePath: string): string[] => {
  const readmeFullPath = path.join(rootPath, readmeFilePath)
  const mapping = getTagsToSwaggerFilesMapping(readmeFullPath)

  const readmeFileName = path.basename(readmeFilePath)

  const allTags = Array.from(mapping.keys())

  const tag = getLatestTag(allTags, 'stable')

  const inputFiles = (mapping.get(tag) || []).map((f) => readmeFilePath.replace(readmeFileName, f))
  return inputFiles
}
