<!-- PROJECT LOGO -->
<br />
<p align="center">
  <h1 align="center"><strong>New Parent</strong></h1>

  <p align="center">
  <strong><em>The ultimate baby monitor! </em></strong>This mobile app helps new parents keep track of all their newborn baby's needs, milestones, and reminders in one place!
  <br>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ul>
    <li><a href="#mvp-minimum-viable-product">MVP</a></li>
    <li><a href="#stretch-goals">Stretch Goals</a></li>
    <li><a href="#tech-stack">Tech Stack</a></li>
    <li><a href="#dependencies">Dependencies</a></li>
    <li><a href="#github-cheat-sheet">Github Cheat Sheet</a></li>
    <li><a href="#resources">Resources</a></li>
  </ul>
</details>



<!-- ABOUT THE PROJECT -->
## MVP (Minimum Viable Product)
- A profile for your baby 
  - Name
  - The age (will automatically be calculated based off of the entry of the birth date)
  - Height and weight
  - An average activity schedule will generate a calendar based on more generic activities (feeding, sleeping) and allow the user 
    to  add more specific activities for the baby
  - A list of any known allergies
  - A routines page of routines that the baby may be used to (changing, eating, sleeping, washing, etc.)

- Allow the user to add reminders for any specific activities or reminders, when adding activities or need to reorder.
- An organized google search for products based on price and ratings, in an easy to view form. Includes purchase history and 
  suggests a reminder for when to get the next purchase.
- Make desired parts of the baby profile shareable across email, text, etc.

## Stretch Goals
- Allow babysitters and nannies create user profiles in order to easily access baby profiles and critical information
- Allow parents to create user profiles

## Tech Stack
- Frontend
  - Flutter
- Backend
  - Dart
  - Custom Search
    - Will allow users to only see filtered down, relevant search results.
  - Calendar
    - Google has a Calendar API set up to create and add to events, but not tons of customization.
    - Otherwise we can develop a full calendar system through Flutter, it will just be a bit complex.
- Database
  - Firebase

## Dependencies
- VS Code
- Git Bash

## Github Cheat Sheet
(Thanks Emily ^-^)

General Use

| Command | Description |
| ------ | ------ |
| cd "Parenting" | Change directories over to our repository |
| git branch | Lists branches for you |
| git branch "branch name" | Makes new branch |
| git checkout "branch name" | Switch to branch |
| git checkout -b "branch name" | Same as 2 previous commands together |
| git add . | Finds all changed files |
| git commit -m "Testing123" | Commit with message |
| git push origin "branch" | Push to branch |
| git pull origin "branch" | Pull updates from a specific branch |

## Resources
  - ___Tutorials___
    - [Flutter](https://www.youtube.com/watch?v=pTJJsmejUOQ)
    - [Firebase](https://www.youtube.com/watch?v=LnpGU8vj7TI)
    - Feel free to find tutorials that work for you! This is just a starting list.
   - ___General___
      - [How to be successful in ACM Projects](https://docs.google.com/document/d/18Zi3DrKG5e6g5Bojr8iqxIu6VIGl86YBSFlsnJnlM88/edit?usp=sharing)
      -	[How to WIN ACM Projects](https://www.youtube.com/watch?v=dQw4w9WgXcQ)
      -	[Overview of making API calls](https://snipcart.com/blog/apis-integration-usage-benefits)
      - [Professor Cole's How to Program (and the "yellow pad" technique)](https://personal.utdallas.edu/~jxc064000/HowToProgram.html)
      - [GitHub Cheatsheet PDF](https://www.atlassian.com/dam/jcr:8132028b-024f-4b6b-953e-e68fcce0c5fa/atlassian-git-cheatsheet.pdf)
      - [Common GitHub Commands](https://education.github.com/git-cheat-sheet-education.pdf)


