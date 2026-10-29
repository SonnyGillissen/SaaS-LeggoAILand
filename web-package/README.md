# LEGO Island – single-folder web package

Static, vanilla HTML5/JS/CSS page that runs the isle-portable WebAssembly build.
Everything (game, assets) is served from the host it runs on; no external services.

## Build the package
    ./build.sh          # creates ./dist

## Deploy
1. Upload the contents of `dist/` to the **web root** of a host (the game requests assets at `/LEGO/...`).
2. Copy your own LEGO Island files into `LEGO/` (see `LEGO/README.txt`). Assets are not included.
3. Open the site over **HTTPS** (or `http://localhost`).

## Server requirements
- Static files only; must support HTTP `Range` requests (all common servers do) and serve `.wasm` as `application/wasm`.
- Needs cross-origin isolation (`COOP: same-origin`, `COEP: require-corp`). If your host can't set headers, `index.html`
  installs `coi-sw.js` automatically and reloads once. `.htaccess` (Apache) and `nginx.conf.example` are included.

## Quick local test
    cd dist && python3 -m http.server 8080   # then open http://localhost:8080

## Storage
Launcher preferences (e.g. mouse lock) use `localStorage`. The game's own config and save games are kept by the
engine in the browser's Origin Private File System (OPFS); the engine would need changes to use localStorage for them.
