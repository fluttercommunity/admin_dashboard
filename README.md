# Flutter Community Admin Dashboard

## The Issue
The Flutter Community provides several packages to the community and pub. dev that all differ in regards to maintenance requirements.

The Flutter Community admins struggle to keep up with all of the changes, releases, changelogs, and activities on all packages. Two of the biggest challenges include keeping track of releases, as well as the inability to allow maintainers to trigger package releases on pub. dev without giving them super admin access.
## The solution
We are looking to implement a Flutter Community Dashboard that assists admins by rounding up and providing the admins with information regarding issues, latest activities on repositories, maintainers, level of access and implementing a trigger to build and deploy to pub.dev, and more.

## What has been achieved so far
During the GSoC period, we were able to 
1. Succesfully implement logging in via github
2. Retrieve and display a list of all the repositories in the flutter community
3. Create a Repository dashboard that displays statistical data regarding the dashboard
4. Create a table format to be able to display a list of issues/PRs based on the criteria chosen by the user
5. Retrieve and display issues older than 90 days from a repository

## What is left
1. Some data regarding the repository dashboard still uses dummy providers, not real data from the github API 
2. Create an algorithm which decides whether a repository's status is RED, ORANGE or GREEN (Indicating whether or not it requires a maintainer/admins attention)
3. Implement a trigger to build and deploy to pub.dev
