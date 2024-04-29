# VoiceBite

An iOS recipe application, that uses Automatic Speech Recognition to guide users through step-by-step recipe walkthroughs. 

## Description

VoiceBite is an iOS recipe application made for my Final Year Project for my Computer Science Bsc degree. It allows users to browse through a selection of recipes and complete a recipe walkthrough that they can control using voice commands. The instructions during walkthroughs are read aloud using Text-To-Speech. Users must create an account using valid details which can be logged into and signed out of with ease, and also delete their account. They can also view a tutorial, that lists the available voice commands. Users can set preferences for their theme and Text-To-Speech language through the settings page.

### Dependencies

- XCode 14.2
- Swift 5.7.2
- iOS 15.4 or higher 
- Computer running MacOS
- A free apple developer account
- Firebase SDK for user authentication and data management -> FirebaseAuth, FirebaseFirestore and FirebaseFirestoreSwift + a google account

### Installing
- Install the dependencies

XCode
<ol>
<li> Navigate to <a href="https://developer.apple.com/download/all/"> and sign into your Apple Developer account. </li>
<li> Download the .xip file for XCode 14.2. </li>
<li> Once the download is complete, click on the file and agree to the terms and conditions. </li>
<li> Open the project files through XCode </li>
</ol>

Firebase
<ol>
<li> Login to a google account </li>
<li> Navigate to <a href="https://console.firebase.google.com/u/0/"> and create a  </li>
<li> Download the .xip file for XCode 14.2. </li>
<li> Once the download is complete, click on the file and agree to the terms and conditions. </li>
<li> Open the project files through XCode </li>
</ol>

Build
<ol>
<li> Open the project files in XCode </li>
<li> Change XCode simulator to iPhone 13 Pro running iOS 15.5 </li>
<li> Go to product in the top bar and click run </li>
<li> User account used for testing: aoe@email.com, Password1, all other accounts have been deleted from Firestore </li?
<ol>

## Bugs

- If using iOS 16 Text-To-Speech is not functional.
- Darkmode sometimes only updates when you visit the settings page.
- Wait for instructions to be read out before attempting voice commands.

## Acknowledgments

The following images are used in VoiceBite:
Image by <a href="https://www.freepik.com/free-photo/penne-pasta-with-pesto-sauce-zucchini-green-peas-basil-italian-food-top-view-flat-lay_7676329.htm#query=pasta&position=4&from_view=search&track=sph&uuid=ef623c77-f737-4b79-9a51-a73b25afca63">Freepik</a>

Image by <a href="https://www.freepik.com/free-photo/boiling-hot-water-arrangement_18004822.htm#fromView=search&page=1&position=2&uuid=d4ad8e38-335a-4f11-9a45-a951208e9f74">Freepik</a>

Image by <a href="https://www.freepik.com/free-photo/close-up-hand-holding-smoothie-bottle_13185555.htm#fromView=search&page=1&position=0&uuid=1a9421ff-00e9-4df3-9344-ff8453f3f763">Freepik</a>

Image by <a href="https://www.freepik.com/free-photo/plate-with-omlette-table_9094872.htm#fromView=search&page=1&position=5&uuid=c9bb378b-d30b-470c-85e1-c3ba5b04dca6">Freepik</a>

Image by <a href="https://www.freepik.com/free-photo/yellow-still-life-egg_4635718.htm#fromView=search&page=1&position=0&uuid=c820fcad-8a26-4744-9332-805529f7dfef">Freepik</a>

Image by <a href="https://www.freepik.com/free-photo/yellow-still-life-egg_4635718.htm#fromView=search&page=1&position=0&uuid=c820fcad-8a26-4744-9332-805529f7dfef">Freepik</a>

Image by <a href="https://www.freepik.com/free-photo/female-hand-holding-broken-egg-black-surface_13331400.htm#fromView=search&page=1&position=3&uuid=5f1e75a4-c7df-4eac-bb20-c9f881bb2484">azerbaijan_stockers</a>


Image by <a href="https://www.freepik.com/free-vector/flat-chandeleur-illustration_22112263.htm#fromView=search&page=1&position=51&uuid=ced4ff20-98bb-4d65-8ec4-7bee55e6bba8">Freepik</a>

Image by <a href="https://www.freepik.com/free-vector/flat-chandeleur-illustration_22112263.htm#fromView=search&page=1&position=51&uuid=ced4ff20-98bb-4d65-8ec4-7bee55e6bba8">Freepik</a>

The recipes included in the recipe manager were inspired by the following:
- https://www.bbcgoodfood.com/recipes/basic-omelette
- https://www.bbcgoodfood.com/recipes/classic-pesto
- https://www.bbcgoodfood.com/recipes/easy-pancakes
