'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "b1100583a1b4bc42c6f2952837034789",
"favicon.png": "97c30df063e615f531e285ddf9d1df05",
"assets/AssetManifest.bin.json": "69adac776f49f03f9acbf2699755148e",
"assets/FontManifest.json": "608a9229248fb049d4529f02f491d88c",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/fonts/LilitaOne-Regular.ttf": "ce83b4bfa37f53ea2a3fc97088af7181",
"assets/fonts/RubikMonoOne-Regular.ttf": "f5486d33c22f837e905d600a5407da06",
"assets/fonts/MaterialIcons-Regular.otf": "fa019abeb2cc77742af86e47d6971e08",
"assets/fonts/MajorMonoDisplay-Regular.ttf": "e7acc228230d22332855765872b0a3bf",
"assets/AssetManifest.json": "b341fe4a83430400db3531f71f0c5884",
"assets/packages/window_manager/images/ic_chrome_maximize.png": "af7499d7657c8b69d23b85156b60298c",
"assets/packages/window_manager/images/ic_chrome_close.png": "75f4b8ab3608a05461a31fc18d6b47c2",
"assets/packages/window_manager/images/ic_chrome_minimize.png": "4282cd84cb36edf2efb950ad9269ca62",
"assets/packages/window_manager/images/ic_chrome_unmaximize.png": "4a90c1909cb74e8f0d35794e2f61d8bf",
"assets/assets/sounds/ding_dong.aac": "3d204232e10958da6418578dacfb0f40",
"assets/assets/sounds/click.aac": "acde4d89a4315689c8c74a5b294b4a64",
"assets/assets/sounds/pop.aac": "ab188dfd11210fc8293ea0d93aaeb7b0",
"assets/assets/images/pomo_splash.png": "f238f05dc13803a81395cafff091ee79",
"assets/assets/images/pomo_logo.png": "f238f05dc13803a81395cafff091ee79",
"assets/assets/images/pomo_logo_dark.png": "902a01674175f325ff194ffce6a9a45a",
"assets/assets/images/pomo_logo_dark.svg": "78f44d1d6e951e68e86a6d98e428fa30",
"assets/assets/images/pomo_logo.svg": "e40ddbf9ebc1a2ab0786b0bb5572c268",
"assets/AssetManifest.bin": "37cc1b6a3835bf435402adf00211b335",
"assets/NOTICES": "de479785aa30e062d7c78b3682026d8f",
"splash/img/light-1x.png": "85cc7ffc3c2ca0d320a85770a7886e25",
"splash/img/dark-3x.png": "a44ed941f732f6c8e8d461ddbf3b7318",
"splash/img/dark-4x.png": "35021b222a35f836e4a45af58dcffeca",
"splash/img/light-3x.png": "a44ed941f732f6c8e8d461ddbf3b7318",
"splash/img/light-4x.png": "35021b222a35f836e4a45af58dcffeca",
"splash/img/light-2x.png": "41f14d71e8da84f9cc55e0a4f39a0845",
"splash/img/dark-1x.png": "85cc7ffc3c2ca0d320a85770a7886e25",
"splash/img/dark-2x.png": "41f14d71e8da84f9cc55e0a4f39a0845",
"icons/ms-icon-144x144.png": "dc75a562a8dc06823f684233eec8bf9d",
"icons/apple-icon-152x152.png": "e6ace17ad9e1372b4b4d020d3bb3c5e4",
"icons/apple-icon.png": "809142fa3178c1e4f04e810eaa711501",
"icons/apple-icon-precomposed.png": "809142fa3178c1e4f04e810eaa711501",
"icons/favicon.png": "7a26ea9d4e61122fc023b84e5acdb148",
"icons/ms-icon-150x150.png": "a99815bcba9f55534890e26700dd852a",
"icons/apple-icon-57x57.png": "1237b298defe8ed68bae73fa587dd9ef",
"icons/Icon-maskable-192.png": "cb962430065f58e762f952b986e04f11",
"icons/favicon-16x16.png": "7835ca93e621bbffda079aa0d18881c4",
"icons/android-icon-192x192.png": "95d23f138cf71536a1c0cfa6fc20bcfe",
"icons/android-icon-144x144.png": "dc75a562a8dc06823f684233eec8bf9d",
"icons/apple-icon-72x72.png": "4cf235ea1180ce155bf4ab06380007aa",
"icons/ms-icon-310x310.png": "7da1db1c7dd805471e9fc4e449f471f1",
"icons/Icon-maskable-512.png": "d9201f7b8de616d21eef3f1cfde25c6a",
"icons/apple-icon-60x60.png": "65f4e27ae7d186aa035b16c1e98f269d",
"icons/android-icon-72x72.png": "4cf235ea1180ce155bf4ab06380007aa",
"icons/android-icon-96x96.png": "895c8d59cd3432d228dc7fccbc1ec6dd",
"icons/Icon-512.png": "d9201f7b8de616d21eef3f1cfde25c6a",
"icons/favicon-32x32.png": "bd16dc23c6b4cbdc285bc542340b35a8",
"icons/apple-icon-120x120.png": "d0ab05981de221114c8770f585ac08e7",
"icons/apple-icon-144x144.png": "dc75a562a8dc06823f684233eec8bf9d",
"icons/favicon.ico": "3d6e90617e2c52120d3561c3e95a3119",
"icons/favicon-96x96.png": "895c8d59cd3432d228dc7fccbc1ec6dd",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"icons/android-icon-48x48.png": "361a05dfcc6e6f3e0af2db8e8d6c43ba",
"icons/ms-icon-70x70.png": "005fd9fff3600b5b731ad24add525415",
"icons/apple-icon-114x114.png": "fb110b1052602ccaf2a0c646598700b0",
"icons/apple-icon-76x76.png": "b7be1f3640bc65b6850db6254c9fd2a5",
"icons/apple-icon-180x180.png": "7dd16e0a2196cc2d75565727a943b870",
"icons/android-icon-36x36.png": "1e0407715508ec6ac4612bdaa0676223",
"icons/Icon-192.png": "cb962430065f58e762f952b986e04f11",
"manifest.json": "0eca155a4be98da2019c517563c521f3",
"main.dart.js": "64d077347b942f4d61aaa23695fffad2",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"index.html": "48df1ace84e89927bfa1d7b694eef7d5",
"/": "48df1ace84e89927bfa1d7b694eef7d5",
"version.json": "2e9bc9bbd545fbee7b459f1e1e8a8f72"};
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
