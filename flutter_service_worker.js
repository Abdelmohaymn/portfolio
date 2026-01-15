'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"icons/Icon-512.png": "c6cc55b1a82a818413ad2900e6ea9e79",
"icons/Icon-maskable-512.png": "c6cc55b1a82a818413ad2900e6ea9e79",
"icons/Icon-192.png": "274d17d5af94a9378949b16efd2afc2d",
"icons/Icon-maskable-192.png": "274d17d5af94a9378949b16efd2afc2d",
"manifest.json": "d1dcf7e14c8f56c44af10523ce9df377",
"main.dart.mjs": "62c610271c22264b9d47de7c6ebe78d8",
"index.html": "b216eb8ea4162980324042988dbddcaf",
"/": "b216eb8ea4162980324042988dbddcaf",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "133e76eb8804d7923a25daa840813560",
"assets/assets/icons/email.svg": "c140cdc8f2a13401485e8cdb8255aa71",
"assets/assets/icons/linkedin.svg": "eea835498e376e49a64484b2fcbb4d24",
"assets/assets/icons/github.svg": "76ce01d58035241070e401b342579443",
"assets/assets/icons/apple.svg": "83a5b3aabaf57bcd2c7af13f17e01208",
"assets/assets/icons/whatsapp.svg": "fc88d996eb2f27eef807b3c02f8dd98c",
"assets/assets/icons/google.svg": "76e77859d5f02c759698762b4aa0cb54",
"assets/assets/projects/fast_food_1.png": "b8fc3bd02b522075bd0ab5dc000798f8",
"assets/assets/projects/social_2.png": "7cf89cd6da728ca8baf0fda51d651346",
"assets/assets/projects/fast_food_2.png": "43ad96177ada3b2835cba390916a7999",
"assets/assets/projects/note_1.png": "185420d756f9887d9e1b2b80b287e19f",
"assets/assets/projects/pety_1.png": "a00635d7ddb53bd580a334dd73d2750c",
"assets/assets/projects/tasky_1.png": "8a41e496162d2160bdc41fe1987a0624",
"assets/assets/projects/pety_2.png": "686c55e6f1fe4f70addcf049bfba511b",
"assets/assets/projects/social_3.png": "2064352076cc78fabb49c605e7d1c7d1",
"assets/assets/projects/social_1.png": "052ef7cf1edcee268c073be87019c8b7",
"assets/assets/projects/weather_1.png": "98bdab8323fbd9744538fc792674aa9a",
"assets/assets/projects/fast_food_3.png": "c0e46d1e3f65690ae24c9fa12d8a1ef6",
"assets/assets/projects/fast_food_4.png": "43ad96177ada3b2835cba390916a7999",
"assets/assets/projects/shaghlni_1.png": "08fedc3544d3c386cbd61cb9aec3ee60",
"assets/assets/company/isagha.jpg": "94c20eda41739ef193e6cf97388a14b9",
"assets/assets/company/scaleai.jpg": "67f22d2b0e7ccadb58246cbb89c6aec4",
"assets/assets/company/sherkety.jpeg": "b68e552a45a7bc8c843ff8d763cc17f0",
"assets/assets/company/iti.jpeg": "68c6f35ba610f956642d072814bd8d72",
"assets/assets/projects_logos/pety.png": "f039b6f67bd2be60c09bcfebf6597e03",
"assets/assets/projects_logos/social.png": "d936b642412377673c237871f3bfdc2c",
"assets/assets/projects_logos/weather.png": "909c1ab9885efaf920386aacc0973105",
"assets/assets/projects_logos/shaghlni.png": "2f1f7dec9fd78dc25aad78070b8b8b78",
"assets/assets/projects_logos/ai_cam.png": "ebf581d36a23ef613a012984fac1dc2d",
"assets/assets/projects_logos/tasky.png": "edbf9ad9d2e05539aee46d6376023a7e",
"assets/assets/projects_logos/face_cam.png": "6a85dd4a01387e6fcf8d14cddce8cfeb",
"assets/assets/projects_logos/fast_food.png": "d6c4635bf4e110b4b043a0ab93e45757",
"assets/assets/projects_logos/note.png": "0379a85d4bb60640d50bebe37984401a",
"assets/assets/images/about.jpg": "c7585806b03b101e22d7c0bf944db592",
"assets/assets/images/profile.png": "46faf1a352032e07766c8729a7338bac",
"assets/assets/achievements/mie.png": "7319a6d9908474f566f65e33d784b8c9",
"assets/assets/achievements/ieee.png": "40d2e2b06bd6633d5816bf9f39d428c7",
"assets/assets/achievements/acpc.jpg": "7f1b33d805776aa310facfedd4513b43",
"assets/assets/achievements/comp.png": "b2ce9e6cae91a05a4924aa6acd0a2762",
"assets/assets/achievements/meta_hacker_cup_2025.png": "8bca1adae735ec0c0fc0a8c83aab6f0f",
"assets/assets/achievements/codechef.png": "feb07fb961b1e498a7b31505e7a64ccf",
"assets/assets/achievements/codeforces.jpeg": "88f674d24226258f28562a15e43cbbe4",
"assets/assets/achievements/iot.png": "f3f72f388d066c6b90b53098a3ea6b15",
"assets/assets/achievements/judge.jpg": "ddaa9da6c8ae7054a23b195072e23bd6",
"assets/assets/achievements/leeetcode.png": "305d9fd57e39253b0f5bf5323aaedbbb",
"assets/assets/achievements/mansoura.jpg": "15c7e91df8f84d6d4e4e21b5da15c220",
"assets/assets/cv/Abdelmohaymn_Albashier_CV.pdf": "bd003e0d1b1661914248bb9c22dae9ec",
"assets/fonts/MaterialIcons-Regular.otf": "f9630c665779fc93df4fd3389d6a1a59",
"assets/NOTICES": "b855b433dc385bc8d199a22462fc5187",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "4c695a2bdbca4064ecd9d55e3d7ba83e",
"assets/AssetManifest.json": "1986bc9e9dffee1b1b1cc63175f5e33d",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"favicon.png": "c6cc55b1a82a818413ad2900e6ea9e79",
"main.dart.wasm": "f4ecf939ff7940329c77b3ae5a0a64ad",
"flutter_bootstrap.js": "e772e15087959fb8f740a8cc51d44bdb",
"version.json": "009c9e65172e010890f7f65fde438006",
"main.dart.js": "bebe6810efa081e112bb475d298c435f"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
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
