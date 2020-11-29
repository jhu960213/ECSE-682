// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access Cloud Firestore.
const admin = require('firebase-admin');
admin.initializeApp();

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });



// set the path to notifications/documentId
// function checkExposure is triggered after a data value is created and inserted into the data base at
// notifications/documentId
exports.checkExposure = functions.firestore.document('/notifications/{documentId}')
    .onUpdate((changed, context) => {

      // e.g. {'name': 'Marie',
      //       'age': 66}
      // get an object representing the documet that changed
      const currentDocumentStruct = changed.after.data()

      // create a current context node and current changed struct for looping
      var currentContext = context
      var currentChanged = changed

      // looping to check the 5 mins time stamps ago
      while(context.timestamp - currentContext.timestamp <= 5) {
        currentContext = currentContext.parent("document")
        currentChanged = currentChanged.parent("document")

        // if the current documment uuid is same as the previous document uuid
        if (currentDocumentStruct.beacon_UUID == currentChanged.after.data().beacon_UUID) {

          // if the major and the minor are the same
          if (currentDocumentStruct.major == currentChanged.after.data().major &&
          currentDocumentStruct.minor == currentChanged.after.data().minor) {

            // if the distance are either immediate or close
            if (currentDocumentStruct.distance == currentChanged.after.data().distance) {

              // if the distance was immediate or near
              if (currentChanged.after.data().distance == "Immediate" || currentChanged.after.data().distance == "Near") {
                currentChanged.after.data().test_result == true;
              }
            }
          }
        }
        print("Examining next parent document!");
      }

      // looping to check 5 min after
      while(currentContext.timestamp - context.timestamp <= 5) {
        currentContext = currentContext.child("document")
        currentChanged = currentChanged.child("document")

        // if the current documment uuid is same as the previous document uuid
        if (currentDocumentStruct.beacon_UUID == currentChanged.after.data().beacon_UUID) {

          // if the major and the minor are the same
          if (currentDocumentStruct.major == currentChanged.after.data().major &&
          currentDocumentStruct.minor == currentChanged.after.data().minor) {

            // if the distance are either immediate or close
            if (currentDocumentStruct.distance == currentChanged.after.data().distance) {

              // if the distance was immediate or near
              if (currentChanged.after.data().distance == "Immediate" || currentChanged.after.data().distance == "Near") {
                currentChanged.after.data().test_result == true;
              }
            }
          }
        }
        print("Examining next child document!");
      }

    });
