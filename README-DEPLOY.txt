ChatVault Local - free deployment

What this is:
ChatVault Local is a static mobile app. It does not need a server database. When users open it, their chats and files are stored on their own device using browser storage.

Best free host:
Cloudflare Pages is the best fit for this app because it supports static sites, HTTPS, PWA install support, and a generous free plan. Current Cloudflare Pages free limits include 500 builds per month, 20,000 files per site, and 25 MiB maximum single-file asset size.

Important:
Deployment makes the app available at a public URL, but user data is still local to each device. If you open the app on Phone A, that archive is on Phone A. If you open it on Phone B, Phone B has its own archive unless you import a JSON backup.

Cloudflare Pages direct upload:
1. Go to dash.cloudflare.com.
2. Open Workers & Pages.
3. Choose Pages.
4. Create a project.
5. Choose Direct Upload.
6. Upload all files in this folder.
7. Deploy.
8. Open the pages.dev URL on your phone.
9. Use the browser menu and choose Add to Home Screen / Install.

Netlify drag-and-drop:
1. Go to app.netlify.com/drop.
2. Drag this whole folder onto the page.
3. Open the Netlify URL.
4. On your phone, use Add to Home Screen / Install.

GitHub Pages:
1. Create a public GitHub repository.
2. Upload all files in this folder.
3. In repository Settings, open Pages.
4. Deploy from the main branch.
5. Open the github.io URL.

Files required:
index.html
chatvault-local.html
manifest.webmanifest
sw.js
icon.svg
_headers
README-CLOUD-SYNC.txt

Free/unlimited reality:
There is no monthly app server cost and no per-message limit for local use. Usage is limited by each user's device storage and browser storage quota. If you enable cloud sync, usage is also limited by your Firebase free-tier database quotas.
