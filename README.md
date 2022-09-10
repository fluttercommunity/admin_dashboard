# Flutter Community Admin Dashboard

## The Issue
The Flutter Community provides several packages to the community and pub. dev that all differ in regards to maintenance requirements.

The Flutter Community admins struggle to keep up with all of the changes, releases, changelogs, and activities on all packages. Two of the biggest challenges include keeping track of releases, as well as the inability to allow maintainers to trigger package releases on pub. dev without giving them super admin access.

## The solution
We are looking to implement a Flutter Community Dashboard that assists admins by rounding up and providing the admins with information regarding issues, latest activities on repositories, maintainers, level of access and implementing a trigger to build and deploy to pub.dev, and more.
[GitHub Pages](https://pages.github.com/).
## More about the project
This project was initially started as a GSoC'22 project with [@abdelrahmanmagdii](https://github.com/abdelrahmanmagdii) as the mentee and [@mhadaily](https://github.com/mhadaily) as the mentor.  <br />
This entire project was implemented using flutter for the frontend and Firebase used in the backend for authentication purposes (as a single sign-on provider) so that it manages access to github and manages access to specific report pages depending on the access level of the user. <br /> Moreover, the github APIs are not suited to create reports reflecting the repositories' variations over time. Therefore, the firebase backend will also be used to run periodic aggregation APIs and store statistical time variant information so that reports could be created that show the KPI (Key Performance Indicator) variations over time.

## What has been achieved so far
During the GSoC period, we were able to 
1. Initialize firebase and create a github action to deploy to firebase hosting
2. Succesfully implement logging in via github
3. Retrieve and display a list of all the repositories in the flutter community
4. Create a Repository dashboard that displays statistical data regarding the repository
5. Create a sortable table format to be able to display a list of issues/PRs based on the criteria chosen by the user
6. Retrieve and display issues based on criterias chosen by the user
7. Everything regarding the frontend

## What is left
1. Some data regarding the repository dashboard still uses dummy providers, not real data from the github API 
2. Create an algorithm which decides whether a repository's status is RED, ORANGE or GREEN (Indicating whether or not it requires a maintainer/admins attention)
3. Implement a trigger to build and deploy to pub.dev
4. Previously, our application deployed and was hosted succesfully by firebase, but recently an error started occuring to the untouched code where you now face a bug whenever you try to login via Github on only the web version. We are currently still waiting on firebase's documentation to be updated inorder to implement how to login via github on firebase's new version. 
