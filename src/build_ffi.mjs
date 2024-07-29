import { build, context } from 'esbuild'
import { Ok, Error } from "./gleam.mjs"

export function bundle_build(entry, global, out) {
  return new Promise(resolve => {
      build({
        entryPoints: [entry],
        bundle: true,
        minify: true,
        format: 'iife',
        globalName: global,
        outfile: out,
      }).then(function(r){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}

export function copy_build(src, out) {
  return new Promise(resolve => {
      build({
        entryPoints: [src],
        loader: {'.js': 'copy'},
        outfile: out,
      }).then(function(r){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}
