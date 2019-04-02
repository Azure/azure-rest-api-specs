import * as fs from "@ts-common/fs"
import * as process from "process"
import * as path from "path"
import * as cm from "@ts-common/commonmark-to-markdown"
import * as it from "@ts-common/iterator"
import * as yaml from "js-yaml"
import {  values } from '@ts-common/string-map';

type Code = {
  readonly "input-file"?: ReadonlyArray<string>|string
}

const main = async (specificationsDirectory: string, profilesDirectory: string) => {
  try {
    const list = fs.recursiveReaddir(specificationsDirectory);
    const specs = [];  
    let foundMultiApiReadmes = false;
    for await (const file of list) {
      const f = path.parse(file);
      if (f.base === "readme.enable-multi-api.md") {
        foundMultiApiReadmes = true;
        const content = (await fs.readFile(file)).toString();
        const readMe = cm.parse(content);
        const set = new Set<string>();
        for (const c of cm.iterate(readMe.markDown)) {
          if (
            c.type === "code_block" &&
            c.info !== null &&
            c.info.startsWith("yaml") &&
            c.literal !== null
          ) {
            const y = (yaml.load(c.literal) as Code)["input-file"];
            if (typeof y === "string") {
              set.add(y);
            } else if (it.isArray(y)) {
              for (const i of y) {
                set.add(i);
                specs.push(path.join(f.dir, i));
              }
            }
          }
        }
      }     
    }
    
    if (!foundMultiApiReadmes){
      throw  `Couldn't find any readme.enable-multi-api.md files.`
    }

    const allPaths = await getPaths(specs);
    const profileData = getResources(allPaths);
    const telemetryDir = path.join(profilesDirectory, 'crawl-telemetry.json')
    fs.writeFile(telemetryDir, JSON.stringify(profileData, null, 2));
    console.log(`Telemetry written at ${telemetryDir}`);
    
    const latestProfile = getLatestProfile(profileData.resources);
    const latestProfileMarkDown = cm.markDownExToString(
      { 
        markDown: cm.createNode(
        "document",
        cm.createNode(
          "heading",
          cm.createText("Latest Azure Profile")
        ),
        cm.createNode(
          "block_quote",
          cm.createNode(
            "paragraph",
            cm.createText("see https://aka.ms/autorest")
          )
        ),
          cm.createCodeBlock(
            "yaml ",
            yaml.dump({ "profiles":{"latest": latestProfile} }, { lineWidth: 1000 })
          )
        )
      }
    );

    const latestProfileDir = path.join(profilesDirectory, 'latest-profile.md');
    fs.writeFile(latestProfileDir, latestProfileMarkDown);
    console.log(`Latest profile written at ${latestProfileDir}`);
    console.log('DONE');    
  } catch (e) {
    console.error(e);
  }
}

async function getPaths(specHandles: Array<string>): Promise<Array<PathWithApiVersion>> {
  console.log(`Parsing specs`);
  const result = new Array<PathWithApiVersion>();
  for (const specHandle of specHandles) {
    try {
      const spec = JSON.parse((await fs.readFile(specHandle)).toString());
      if (spec.swagger && spec.info.version) {
        for (const path of Object.entries(spec.paths)) {
          result.push({path: path[0], apiVersion: spec.info.version});
        }   
      }
    }  catch (e) {
      console.error(`Couldn't parse ${specHandle} - ${e}`);
    }          
  }

  return result;   
}

function getResources(pathsWithVersion: Array<PathWithApiVersion>): {
  invalidPaths: Array<PathWithApiVersion>;
  resources: Array<Resource>;
} {
  console.log(`Crawling paths for resources and getting telemetry ...`);
  const result = { resources: new Array<Resource>(), invalidPaths: new Array<PathWithApiVersion>()};
  const providerNamePattern = `microsoft\.[a-z]+(?:\.[a-z]+)?`;
  const parameterPattern = `\{[a-z0-9]+\}`;
  const nonParameterPattern = `[a-z0-9]+`;
  const validPathRegex = new RegExp(`(.*)(\/providers\/${providerNamePattern}(:?\/${nonParameterPattern}|\/${parameterPattern})+\/?$)`, 'gi');
  for (const pathWithVersion of pathsWithVersion) {      
    if (pathWithVersion.path.match(validPathRegex)) {
      const resource = { path: pathWithVersion.path, apiVersion: pathWithVersion.apiVersion, provider: '', name: ''};
      
      // get last /provider/microsoft.<provider>... section. Also, get rid of any possible trailing slash '/'
      const scopedProviderSection =  resource.path.replace(/\/*$/, '').replace(validPathRegex, '$2').split('/');
      resource.provider = scopedProviderSection[2].toLowerCase();
      const resourcesSection = `/${scopedProviderSection.slice(3).join('/')}`;
      const resourceRegex = new RegExp(`\/${nonParameterPattern}\/${nonParameterPattern}|\/${nonParameterPattern}\/${parameterPattern}|^\/${nonParameterPattern}$`, 'gi');
      const resourceMatches = resourcesSection.match(resourceRegex); 
      if (resourceMatches !== null) {
        const resourceNames = resourceMatches.map(each => each.split('/')[1]);    
        resource.name  = resourceNames.join('/');        
      } 

      result.resources.push(resource);
    } else {
      result.invalidPaths.push(pathWithVersion);
    }    
  }

  return result;
}


export function getLatestProfile(allResources: Array<Resource>): Profile { 
  console.log('Constructing latest profile ...')
  allResources.sort((a, b) => {
    return (a.apiVersion > b.apiVersion) ? -1 : (a.apiVersion < b.apiVersion) ? 1 : 0;
  });

  const latestResources: {[uid: string] : Resource } = {};
  for (const resource of allResources) {
    const resourceUid = `${resource.provider}${resource.name}`;
    if (latestResources[resourceUid] === undefined) {
      latestResources[resourceUid] = { apiVersion: resource.apiVersion, name: resource.name, provider: resource.provider.toLowerCase(), path: resource.path  };
    }
  }

  const latestProfile: Profile = {};
  for (const resource of values(latestResources)) {
    latestProfile[resource.provider] = latestProfile[resource.provider] || {};
    latestProfile[resource.provider][resource.apiVersion] = latestProfile[resource.provider][resource.apiVersion] || [];
    latestProfile[resource.provider][resource.apiVersion].push(resource.name);
  }

  for (const apiVersion of values(latestProfile)) {
    for (const resources of values(apiVersion)) {
      resources.sort();
    }
  }

  return latestProfile;
}

interface Resource {
  path: string;
  apiVersion: string;
  provider: string;
  name: string;
}

interface PathWithApiVersion {
  path: string;
  apiVersion: string;
}

interface Profile {
  [resourceProvider: string]: {
    [apiVersion: string]: Array<string>;
  };
}

main(path.join(process.cwd(), "specification"), path.join(process.cwd(), "profiles"));
