'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "9a2968f3b7a45f56c155ea1b42bceff8",
"assets/AssetManifest.bin.json": "c124e8f2ed0a3286b3ec03d662946784",
"assets/AssetManifest.json": "3523d226da4ed6fce33127186d183133",
"assets/FontManifest.json": "608a9229248fb049d4529f02f491d88c",
"assets/assets/images/pomo_logo.png": "f238f05dc13803a81395cafff091ee79",
"assets/assets/images/pomo_logo.svg": "e40ddbf9ebc1a2ab0786b0bb5572c268",
"assets/assets/images/pomo_logo_dark.png": "902a01674175f325ff194ffce6a9a45a",
"assets/assets/images/pomo_logo_dark.svg": "78f44d1d6e951e68e86a6d98e428fa30",
"assets/assets/images/pomo_splash.png": "f238f05dc13803a81395cafff091ee79",
"assets/assets/sounds/click.aac": "acde4d89a4315689c8c74a5b294b4a64",
"assets/assets/sounds/ding_dong.aac": "3d204232e10958da6418578dacfb0f40",
"assets/assets/sounds/pop.aac": "ab188dfd11210fc8293ea0d93aaeb7b0",
"assets/fonts/LilitaOne-Regular.ttf": "ce83b4bfa37f53ea2a3fc97088af7181",
"assets/fonts/MajorMonoDisplay-Regular.ttf": "e7acc228230d22332855765872b0a3bf",
"assets/fonts/MaterialIcons-Regular.otf": "fa019abeb2cc77742af86e47d6971e08",
"assets/fonts/RubikMonoOne-Regular.ttf": "f5486d33c22f837e905d600a5407da06",
"assets/packages/window_manager/images/ic_chrome_close.png": "75f4b8ab3608a05461a31fc18d6b47c2",
"assets/packages/window_manager/images/ic_chrome_maximize.png": "af7499d7657c8b69d23b85156b60298c",
"assets/packages/window_manager/images/ic_chrome_minimize.png": "4282cd84cb36edf2efb950ad9269ca62",
"assets/packages/window_manager/images/ic_chrome_unmaximize.png": "4a90c1909cb74e8f0d35794e2f61d8bf",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "7cf55271c6af05e4841d5cbfe4272cc6",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "97c30df063e615f531e285ddf9d1df05",
"icons/Icon-192.png": "cb962430065f58e762f952b986e04f11",
"icons/Icon-512.png": "d9201f7b8de616d21eef3f1cfde25c6a",
"icons/Icon-maskable-192.png": "cb962430065f58e762f952b986e04f11",
"icons/Icon-maskable-512.png": "d9201f7b8de616d21eef3f1cfde25c6a",
"icons/android-icon-144x144.png": "dc75a562a8dc06823f684233eec8bf9d",
"icons/android-icon-192x192.png": "95d23f138cf71536a1c0cfa6fc20bcfe",
"icons/android-icon-36x36.png": "1e0407715508ec6ac4612bdaa0676223",
"icons/android-icon-48x48.png": "361a05dfcc6e6f3e0af2db8e8d6c43ba",
"icons/android-icon-72x72.png": "4cf235ea1180ce155bf4ab06380007aa",
"icons/android-icon-96x96.png": "895c8d59cd3432d228dc7fccbc1ec6dd",
"icons/apple-icon-114x114.png": "fb110b1052602ccaf2a0c646598700b0",
"icons/apple-icon-120x120.png": "d0ab05981de221114c8770f585ac08e7",
"icons/apple-icon-144x144.png": "dc75a562a8dc06823f684233eec8bf9d",
"icons/apple-icon-152x152.png": "e6ace17ad9e1372b4b4d020d3bb3c5e4",
"icons/apple-icon-180x180.png": "7dd16e0a2196cc2d75565727a943b870",
"icons/apple-icon-57x57.png": "1237b298defe8ed68bae73fa587dd9ef",
"icons/apple-icon-60x60.png": "65f4e27ae7d186aa035b16c1e98f269d",
"icons/apple-icon-72x72.png": "4cf235ea1180ce155bf4ab06380007aa",
"icons/apple-icon-76x76.png": "b7be1f3640bc65b6850db6254c9fd2a5",
"icons/apple-icon-precomposed.png": "809142fa3178c1e4f04e810eaa711501",
"icons/apple-icon.png": "809142fa3178c1e4f04e810eaa711501",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/favicon-16x16.png": "7835ca93e621bbffda079aa0d18881c4",
"icons/favicon-32x32.png": "bd16dc23c6b4cbdc285bc542340b35a8",
"icons/favicon-96x96.png": "895c8d59cd3432d228dc7fccbc1ec6dd",
"icons/favicon.ico": "3d6e90617e2c52120d3561c3e95a3119",
"icons/favicon.png": "7a26ea9d4e61122fc023b84e5acdb148",
"icons/manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"icons/ms-icon-144x144.png": "dc75a562a8dc06823f684233eec8bf9d",
"icons/ms-icon-150x150.png": "a99815bcba9f55534890e26700dd852a",
"icons/ms-icon-310x310.png": "7da1db1c7dd805471e9fc4e449f471f1",
"icons/ms-icon-70x70.png": "005fd9fff3600b5b731ad24add525415",
"manifest.json": "0eca155a4be98da2019c517563c521f3",
"splash/img/dark-1x.png": "85cc7ffc3c2ca0d320a85770a7886e25",
"splash/img/dark-2x.png": "41f14d71e8da84f9cc55e0a4f39a0845",
"splash/img/dark-3x.png": "a44ed941f732f6c8e8d461ddbf3b7318",
"splash/img/dark-4x.png": "35021b222a35f836e4a45af58dcffeca",
"splash/img/light-1x.png": "85cc7ffc3c2ca0d320a85770a7886e25",
"splash/img/light-2x.png": "41f14d71e8da84f9cc55e0a4f39a0845",
"splash/img/light-3x.png": "a44ed941f732f6c8e8d461ddbf3b7318",
"splash/img/light-4x.png": "35021b222a35f836e4a45af58dcffeca",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"flutter_bootstrap.js": "11cc8f8ee5a822fa5b82fb12d6f6a325",
"index.html": "1fcbb91dd11ebec22218abb055ee2c33",
"/": "1fcbb91dd11ebec22218abb055ee2c33",
"main.dart.js": "53ed500c8c4d1587195337906135f337",
"version.json": "b077993cfdc84ee766669977355e50e3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
