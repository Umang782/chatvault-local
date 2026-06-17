ChatVault Local - cloud sync setup

Truth first:
Cloud sync cannot be truly unlimited forever because cloud database and storage have quotas. This setup uses Firebase Spark because it has a no-cost plan with no payment method required. Current Firebase Spark limits include Firestore 1 GiB stored data, 20K writes/day, 50K reads/day, and 10 GiB/month egress. Firebase Hosting also has no-cost limits. This is enough for personal use and small use, but not infinite.

What sync does:
The app encrypts your full archive in the browser using your sync password, then uploads one encrypted backup document to Firebase Firestore. Your password is not uploaded. Use the same Firebase config, Vault ID, and sync password on another phone to pull the same archive.

Step 1 - Create Firebase project:
1. Open https://console.firebase.google.com
2. Click Add project.
3. Project name: chatvault-local
4. Google Analytics: you can turn it off.
5. Create project.

Step 2 - Create web app config:
1. Inside Firebase project, click the web icon: </>.
2. App nickname: ChatVault.
3. Do not set up Firebase Hosting unless you want to.
4. Click Register app.
5. Copy the firebaseConfig object. It looks like:

{
  "apiKey": "...",
  "authDomain": "...firebaseapp.com",
  "projectId": "...",
  "storageBucket": "...firebasestorage.app",
  "messagingSenderId": "...",
  "appId": "..."
}

Step 3 - Enable anonymous sign-in:
1. In Firebase, open Build > Authentication.
2. Click Get started.
3. Open Sign-in method.
4. Enable Anonymous.
5. Save.

Step 4 - Create Firestore:
1. In Firebase, open Build > Firestore Database.
2. Click Create database.
3. Choose a region near you.
4. Start in production mode.
5. Create.

Step 5 - Add Firestore rules:
1. Open Firestore Database > Rules.
2. Replace rules with:

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /vaults/{vaultId} {
      allow read, write: if request.auth != null;
    }
  }
}

3. Publish.

Step 6 - Connect inside ChatVault:
1. Open your deployed ChatVault app.
2. Tap Tools.
3. Paste the Firebase config JSON.
4. Enter a Vault ID. Use something hard to guess, for example:
   arvin-vault-7gK92p-private
5. Enter a strong sync password.
6. Tap Connect.
7. Tap Push Now on your main device.

Step 7 - Use another phone:
1. Open the same ChatVault URL on the second phone.
2. Tap Tools.
3. Paste the same Firebase config JSON.
4. Enter the same Vault ID.
5. Enter the same sync password.
6. Tap Connect.
7. Tap Pull.

Important:
- If two phones edit at the same time, the newest pushed full archive can overwrite the older cloud copy.
- Export All JSON regularly for backup.
- Do not forget your sync password. The cloud copy cannot be decrypted without it.
