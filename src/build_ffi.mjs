import { build, context } from 'esbuild'
import { Ok, Error } from "./gleam.mjs"

export function bundle_build(entry, namespace, out) {
  const ba = "CREATE OR REPLACE FUNCTION glv8_init() RETURNS void LANGUAGE plv8 AS $function$";
  const fo = `${namespace} = app.exports(); $function$`;
  return new Promise(resolve => {
      build({
        entryPoints: [entry],
        banner: {js: ba},
        footer: {js: fo},
        bundle: true,
        minify: true,
        keepNames: true,
        format: 'iife',
        globalName: 'app',
        outfile: out,
      }).then(function(r){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}

export function copy_build(src, namespace, out) {
  return new Promise(resolve => {
      build({
        entryPoints: [src],
        loader: {'.sql': 'copy'},
        outfile: out,
      }).then(function(r){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}

export function bundle_watch(entry, namespace, out) {
  const ba = "CREATE OR REPLACE FUNCTION glv8_init() RETURNS void LANGUAGE plv8 AS $function$";
  const fo = `${namespace} = app.exports(); $function$`;
  return new Promise(resolve => {
      context({
        entryPoints: [entry],
        banner: {js: ba},
        footer: {js: fo},
        bundle: true,
        minify: true,
        keepNames: true,
        format: 'iife',
        globalName: 'app',
        outfile: out,
      }).then(function(ctx){
        ctx.watch()
        console.log(`watching bundle ${entry}...`)
      }).then(function(){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}

export function copy_watch(src, namespace, out) {
  return new Promise(resolve => {
      context({
        entryPoints: [src],
        loader: {'.sql': 'copy'},
        outfile: out,
      }).then(function(ctx){
        ctx.watch()
        console.log(`watching ${src}...`)
      }).then(function(){
        resolve(new Ok(undefined))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}
