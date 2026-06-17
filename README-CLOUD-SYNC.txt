ChatVault Local - cloud sync setup

Truth first:
Cloud sync cannot be truly unlimited forever because cloud database and storage have quotas. This setup uses Firebase Spark because it has a no-cost plan with no payment method required. Current Firebase Spark limits include Firestore 1 GiB stored data, 20K writes/day, 50K reads/day, and 10 GiB/month egress. Firebase Hosting also has no-cost limits. This is enough for personal use and small use, but not infinite.

What sync does:
The app encrypts your archive text in the browser using your sync password, then uploads one encrypted backup document to Firebase Firestore. It can also encrypt photos/files in the browser and upload them to Firebase Storage. Your sync password is not uploaded.

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

Step 6 - Enable Firebase Storage:
1. In Firebase, open Build > Storage.
2. Click Get started.
3. Choose the same region as your project when possible.
4. Start in production mode.
5. Create.

Step 7 - Add Storage rules:
1. Open Storage > Rules.
2. Replace rules with:

rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /vaults/{vaultId}/media/{fileName} {
      allow read: if request.auth != null;
      allow write: if request.auth != null
        && request.resource.size < 10 * 1024 * 1024;
    }
  }
}

3. Publish.

Step 8 - Connect inside ChatVault:
1. Open your deployed ChatVault app.
2. Tap Tools.
3. Paste the Firebase config JSON.
4. Enter a Vault ID. Use something hard to guess, for example:
   arvin-vault-7gK92p-private
5. Enter a strong sync password.
6. Tap Connect.
7. Tap Push Now on your main device.
8. Tap Upload Media if you want photos/files copied to Firebase Storage.

Step 9 - Use another phone:
1. Open the same ChatVault URL on the second phone.
2. Tap Tools.
3. Paste the same Firebase config JSON.
4. Enter the same Vault ID.
5. Enter the same sync password.
6. Tap Connect.
7. Tap Pull.
8. Tap Download Media to restore encrypted photos/files.

Important:
- If two phones edit at the same time, the newest pushed full archive can overwrite the older cloud copy.
- Export All JSON regularly for backup.
- Use Export ZIP with Media when you need an offline full backup with photos, audio, video, and documents.
- Firebase free limits are real limits. 5,000 photos is only realistic when photos are compressed small enough to fit your Firebase Storage quota.
- Do not forget your sync password. The cloud copy cannot be decrypted without it.
